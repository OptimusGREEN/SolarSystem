// GPS time reference
// Copyright © 2019-22 Adrian Kennard, Andrews & Arnold Ltd. See LICENCE file for details. GPL 3.0
static const char TAG[] = "gps";
#include "SS.h"

#include "desfireaes.h"
#include "alarm.h"
#include "gps.h"
#include <driver/uart.h>
#include <driver/gpio.h>

#define port_mask(p) ((p)&0x3F)
#define	BITFIELDS "-"
#define PORT_INV 0x40
#define GPIO_INV 0x80           // No SETTING bit

// Other settings
#define settings  \
  io(gpstx) \
  io(gpsrx) \
  io(gpstick) \
  u8(gpsuart,2) \

#define i8(n,d) int8_t n;
#define io(n) uint8_t n;
#define gpio(n) uint8_t n;
#define u8(n,d) uint8_t n;
#define u16(n,d) uint16_t n;
#define b(n,l) uint8_t n[l];
#define bap(n,l,a) uint8_t n[a][l];
#define u1(n) uint8_t n;
#define t(n,d) const char*n=NULL;
settings
#undef t
#undef i8
#undef io
#undef gpio
#undef u8
#undef u16
#undef b
#undef bap
#undef u1
unsigned char gpslocked = 0;    // Do we have a current time lock
unsigned char gpsfixed = 0;     // Do we have a location lock
double gpslat = 0,
    gpslon = 0;

void gps_send_status(void)
{
   jo_t j = jo_make(NULL);
   if (gpsfixed)
   {
      jo_litf(j, "lat", "%lf", gpslat);
      jo_litf(j, "lon", "%lf", gpslon);
   }
   alarm_event(gpsfixed ? "fix" : gpslocked ? "clock" : "lost", &j, -1);
}

static void nmea(char *data)
{
   if (*data != '$' || data[1] != 'G' || !data[2] || strncmp(data + 3, "RMC", 3))
      return;                   // Recommended Minimum Position Data
   //ESP_LOGI(TAG, "%s", data);
   logical_gpio &= ~logical_GPSFault;   // No fault, does not mean locked though
   char *f[13];
   int n = 0;
   char *p = data;
   while (*p && n < sizeof(f) / sizeof(*f))
   {
      while (*p && *p != ',')
         p++;
      if (*p != ',')
         break;
      *p++ = 0;
      f[n++] = p;
   }
   if (n < 13)
   {
      ESP_LOGE(TAG, "NMEA fields %d", n);
      return;
   }
   char status = 0;
   if (*f[11] != 'N' && strlen(f[2]) > 5 && strlen(f[4]) > 6)
   {
      double lat = (f[2][0] - '0') * 10 + (f[2][1] - '0') + strtod(f[2] + 2, NULL) / 60.0;
      if (*f[3] == 'S')
         lat = 0 - lat;
      double lon = (f[4][0] - '0') * 100 + (f[4][1] - '0') * 10 + (f[4][2] - '0') + strtod(f[4] + 3, NULL) / 60.0;
      if (*f[5] == 'W')
         lon = 0 - lon;
      if (lat - gpslat > 1 || gpslat - lat > 1 || lon - gpslon > 1 || gpslon - lon > 1)
         gpsfixed = 0;
      if (!gpsfixed)
      {
         gpslat = lat;
         gpslon = lon;
         gpsfixed = 1;
         status = 1;
      }
      //ESP_LOGI(TAG, "Fix %lf %lf", lat, lon);
   }
   if (strlen(f[0]) >= 6 && strlen(f[8]) == 6 && (*f[1] == 'A' || f[8][4] != '8'))      // 1980 is no good
   {                            // Time
      struct tm tm = { };
      tm.tm_year = 100 + (f[8][4] - '0') * 10 + (f[8][5] - '0');
      tm.tm_mon = (f[8][2] - '0') * 10 + (f[8][3] - '0') - 1;
      tm.tm_mday = (f[8][0] - '0') * 10 + (f[8][1] - '0');
      tm.tm_hour = (f[0][0] - '0') * 10 + (f[0][1] - '0');
      tm.tm_min = (f[0][2] - '0') * 10 + (f[0][3] - '0');
      tm.tm_sec = (f[0][4] - '0') * 10 + (f[0][5] - '0');
      int usec = 0,
          m = 100000;
      if (strlen(f[0]) > 6 && f[0][6] == '.')
      {
         p = f[0] + 7;
         while (*p && m)
         {
            usec = m * (*p++ - '0');
            m /= 10;
         }
      }
      // TODO needs to be timegm but not seeing that in the ESP IDF
      time_t new = mktime(&tm),
          was = time(0);
      if (new - was > 10 || was - new > 10)
         gpslocked = 0;
      struct timeval tv = { new, usec };
      if (settimeofday(&tv, NULL))
         ESP_LOGE(TAG, "Time set %d failed", (int) new);
      else if (!gpslocked)
      {
         status = 1;
         gpslocked = 1;
      }
      //ESP_LOGI(TAG, "Clock %04d-%02d-%02d %02d:%02d:%02d.%06d", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec, usec);
   }
   if (status)
      gps_send_status();
}

static void task(void *pvParameters)
{
   pvParameters = pvParameters;
   uint8_t buf[200],
   *p = buf;
   uint64_t timeout = esp_timer_get_time() + 10000000;
   while (1)
   {                            // Get line(s), the timeout should mean we see one or more whole lines typically
      esp_task_wdt_reset();
      int l = 0;
      if (p < buf + sizeof(buf))
         l = uart_read_bytes(gpsuart, p, buf + sizeof(buf) - p, 100 / portTICK_PERIOD_MS);
      if (l <= 0)
      {                         // Timeout
         p = buf;               // Start of line again
         if (timeout < esp_timer_get_time())
         {
            ESP_LOGE(TAG, "GPS timeout");
            logical_gpio |= logical_GPSFault;   // Timeout
            if (gpslocked || gpsfixed)
            {
               gpslocked = 0;
               gpsfixed = 0;
               gps_send_status();
            }
         }
         continue;
      }
      uint8_t *e = p + l;
      p = buf;
      while (p < e)
      {
         uint8_t *l = p;
         while (l < e && *l >= ' ')
            l++;
         if (l == e)
            break;
         if (*p == '$' && (l - p) >= 4 && l[-3] == '*' && isxdigit(l[-2]) && isxdigit(l[-1]))
         {                      // Checksum
            uint8_t c = 0,
                *x;
            for (x = p + 1; x < l - 3; x++)
               c ^= *x;
            if (((c >> 4) > 9 ? 7 : 0) + (c >> 4) + '0' != l[-2] || ((c & 0xF) > 9 ? 7 : 0) + (c & 0xF) + '0' != l[-1])
            {
               ESP_LOGE(TAG, "[%.*s] (%02X)", l - p, p, c);
            } else
            {                   // Process line
               timeout = esp_timer_get_time() + 60000000;
               l[-3] = 0;
               nmea((char *) p);
            }
         } else if (l > p)
            ESP_LOGE(TAG, "[%.*s]", l - p, p);
         while (l < e && *l < ' ')
            l++;
         p = l;
      }
      if (p < e && (e - p) < sizeof(buf))
      {                         // Partial line
         memmove(buf, p, e - p);
         p = buf + (e - p);
         continue;
      }
      p = buf;                  // Start from scratch
   }
}

const char *gps_command(const char *tag, jo_t j)
{
   if (!gpstx || !gpsrx)
      return NULL;              // Not running
   return NULL;
}

void gps_boot(void)
{
   revk_register("gps", 0, sizeof(gpstx), &gpstx, BITFIELDS, SETTING_SET | SETTING_BITFIELD | SETTING_SECRET);  // parent setting
#define i8(n,d) revk_register(#n,0,sizeof(n),&n,#d,SETTING_SIGNED);
#define io(n) revk_register(#n,0,sizeof(n),&n,BITFIELDS,SETTING_SET|SETTING_BITFIELD);
#define gpio(n) revk_register(#n,0,sizeof(n),&n,BITFIELDS,SETTING_BITFIELD);
#define u8(n,d) revk_register(#n,0,sizeof(n),&n,#d,0);
#define u16(n,d) revk_register(#n,0,sizeof(n),&n,#d,0);
#define b(n,l) revk_register(#n,0,sizeof(n),n,NULL,SETTING_BINDATA|SETTING_HEX);
#define bap(n,l,a) revk_register(#n,a,sizeof(n[0]),n,NULL,SETTING_BINDATA|SETTING_HEX|SETTING_SECRET);
#define u1(n) revk_register(#n,0,sizeof(n),&n,NULL,SETTING_BOOLEAN);
#define t(n,d) revk_register(#n,0,0,&n,d,0);
   settings
#undef t
#undef io
#undef gpio
#undef i8
#undef u8
#undef u16
#undef b
#undef bap
#undef u1
       if (gpstx && gpsrx)
   {
      const char *e = port_check(port_mask(gpstx), TAG, 0);
      if (!e)
         e = port_check(port_mask(gpsrx), TAG, 1);
      if (!e)
         e = port_check(port_mask(gpstick), TAG, 1);
      if (e)
         logical_gpio |= logical_GPSFault;
      else
      {
         esp_err_t err = 0;
         uart_config_t uart_config = {
            .baud_rate = 9600,
            .data_bits = UART_DATA_8_BITS,
            .parity = UART_PARITY_DISABLE,
            .stop_bits = UART_STOP_BITS_1,
            .flow_ctrl = UART_HW_FLOWCTRL_DISABLE,
         };
         if (!err)
            err = uart_param_config(gpsuart, &uart_config);
         if (!err)
            err = uart_set_pin(gpsuart, port_mask(gpstx), port_mask(gpsrx), -1, -1);
         if (!err && !uart_is_driver_installed(gpsuart))
         {
            ESP_LOGI(TAG, "Installing GPS UART driver %d", gpsuart);
            err = uart_driver_install(gpsuart, 256, 0, 0, NULL, 0);
         }
         if (err)
            ESP_LOGE(TAG, "GPS UART fail %s", esp_err_to_name(err));
      }
   } else if (gpsrx || gpstx)
      logical_gpio |= logical_GPSFault;
}

void gps_start(void)
{
   if (gpstx && gpsrx)
      revk_task(TAG, task, NULL);
}
