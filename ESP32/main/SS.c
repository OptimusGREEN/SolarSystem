// Solar System ESP32 app
// Copyright © 2019 Adrian Kennard, Andrews & Arnold Ltd. See LICENCE file for details. GPL 3.0
static const char __attribute__((unused)) TAG[] = "SS";

#include "SS.h"
#include <driver/gpio.h>
#include "slaves.h"
#ifdef  CONFIG_REVK_MESH
#include <esp_mesh.h>
#endif

#ifdef	CONFIG_REVK_APCONFIG
#warning	You do not want door controller running CONFIG_REVK_APCONFIG
#endif

#ifndef	CONFIG_ESP_TLS_SERVER
#error	CONFIG_ESP_TLS_SERVER needed
#endif

// Common
static const char *port_inuse[MAX_PORT];

#define modules		\
	m(input)	\
	m(output)	\
	m(ranger)	\
	m(keypad)	\
	m(door)		\
	m(nfc)		\

// Other settings
#define settings  	\
  	io(tamper) 	\
	s(name)		\
	area(area)	\
	b(iotstatedoor)	\
	b(iotstateinput)\
	b(iotstateoutput)\
	b(iotstatefault)\
	b(iotstatetamper)\
	b(iotstatesystem)\
	b(ioteventfob)	\
	sa(slave,MAX_SLAVE) \


#define io(n) static uint8_t n;
#define area(n) area_t n;
#define	s(n) char *n;
#define	sa(n,a) char *n[a];
#define b(n) uint8_t n;
#define bd(n,d)         static revk_bindata_t *n;
settings
#undef io
#undef area
#undef s
#undef sa
#undef bd
#undef b
#define port_mask(p) ((p)&63)
#define BITFIELDS "-"
#define PORT_INV 0x40
static esp_reset_reason_t reason = -1;  // Restart reason

const char *controller_fault = NULL;
const char *controller_tamper = NULL;
#ifdef	CONFIG_REVK_MESH
const char *mesh_fault = NULL;
const char *mesh_tamper = NULL;
#endif

static void status_report(int force)
{                               // Report status change
   static char *lastfault = NULL;
   int faults = 0;
   static char *lasttamper = NULL;
   int tampers = 0;
   {                            // Faults
      jo_t j = jo_object_alloc();
#define m(n) extern const char *n##_fault;if(n##_fault){jo_string(j,#n,n##_fault);faults++;}
      modules m(controller)
#ifdef	CONFIG_REVK_MESH
       m(mesh)
#endif
#undef m
      if (!faults && force && reason >= 0)
      {
         const char *r = NULL;
         if (reason == ESP_RST_POWERON)
            r = "Power on";
         else if (reason == ESP_RST_INT_WDT)
            r = "Int watchdog";
         else if (reason == ESP_RST_TASK_WDT)
            r = "Watchdog";
         else if (reason == ESP_RST_PANIC)
            r = "Panic";
         else if (reason == ESP_RST_BROWNOUT)
            r = "Brownout";
         else
            r = "Restart";
         if (r)
         {
            jo_t j = jo_object_alloc();
            jo_string(j, "controller", r);
            revk_event("warning", &j);
         }
         reason = -1;           // Just once
      }
      const char *fault = jo_rewind(j);
      if (strcmp(fault ? : "", lastfault ? : "") || force)
      {
         if (lastfault)
            free(lastfault);
         lastfault = strdup(fault);
         revk_state_copy("fault", &j, iotstatefault);
      }
      jo_free(&j);              // safe to call even if freed by revk_state
   }
   {                            // Tampers
      jo_t j = jo_object_alloc();
#define m(n) extern const char *n##_tamper;if(n##_tamper){jo_string(j,#n,n##_tamper);tampers++;}
      modules m(controller)
#ifdef	CONFIG_REVK_MESH
       m(mesh)
#endif
#undef m
      const char *tamper = jo_rewind(j);
      if (strcmp(tamper ? : "", lasttamper ? : "") || force)
      {
         if (lasttamper)
            free(lasttamper);
         lasttamper = strdup(tamper);
         revk_state_copy("tamper", &j, iotstatetamper);
      }
      jo_free(&j);              // safe to call even if freed by revk_state
   }
   if (tampers)
      revk_blink(1, 1, "R-");
   else if (faults)
      revk_blink(1, 5, "M-");
#ifdef	CONFIG_REVK_MESH
   else if (esp_mesh_is_root())
      revk_blink(1, 5, "G-");
#endif
   else if (revk_offline())
      revk_blink(1, 5, "C-");
   else
      revk_blink(0, 0, "RYGCBM");
}

// External
const char *port_check(int p, const char *module, int in)
{                               // Check port is OK
   if (p < 0 || p >= MAX_PORT || !GPIO_IS_VALID_GPIO(p))
   {
      jo_t j = jo_object_alloc();
      jo_string(j, "description", "Port not valid");
      jo_string(j, "module", module);
      jo_int(j, "port", p);
      revk_error("port", &j);
      if (p < 0 || p >= MAX_PORT)
         return "Bad GPIO port number";
      return "Invalid GPIO port";
   }
   if (!in && !GPIO_IS_VALID_OUTPUT_GPIO(p))
   {
      jo_t j = jo_object_alloc();
      jo_string(j, "description", "Port not valid for output");
      jo_string(j, "module", module);
      jo_int(j, "port", p);
      revk_error("port", &j);
      return "Bad GPIO for output";
   }
   if (port_inuse[p])
   {
      jo_t j = jo_object_alloc();
      jo_string(j, "description", "Port clash");
      jo_string(j, "module", module);
      jo_string(j, "clash", port_inuse[p]);
      revk_error("port", &j);
      return "GPIO clash";
   }
   port_inuse[p] = module;
   return NULL;                 // OK
}

#ifdef  CONFIG_REVK_MESH
// Alarm state
#define i(x)	area_t report_##x=0;area_t state_##x=0; // Input
#define c(x)	area_t report_##x=0;area_t control_##x=0;       // Control
#define s(x)	area_t state_##x=0;     // System
#include "states.m"
#endif

#ifdef  CONFIG_REVK_MESH
static void store_area(jo_t j, const char *name, area_t val)
{
   char set[sizeof(area_t) * 8 + 1] = "",
       *p = set;
   for (int b = 0; AREAS[b]; b++)
      if (val & (1ULL << (sizeof(area_t) * 8 - b - 1)))
         *p++ = AREAS[b];
   *p = 0;
   if (p > set)
      jo_string(j, name, set);
}

static area_t parse_area(jo_t j)
{                               // At the tag
   if (jo_next(j) != JO_STRING)
      return 0;
   area_t a = 0;
   char val[sizeof(area_t) * 8 + 1];
   jo_strncpy(j, val, sizeof(val));
   for (char *p = val; *p; p++)
   {
      char *d = strchr(AREAS, *p);
      if (d)
         a |= (1ULL << (sizeof(area_t) * 8 - 1 - (d - AREAS)));
   }
   return a;
}
#endif

#ifdef  CONFIG_REVK_MESH
const char *system_makereport(jo_t j)
{                               // Alarm state - make a report to the controller of our inputs
#define i(x) area_t x=0;
#include "states.m"
   // Inputs
#define i(x) extern area_t input_latch_##x,input_now_##x;x=input_latch_##x;input_latch_##x=input_now_##x;
#include "states.m"
   // Extras
   if (controller_fault && strcmp(controller_fault, "{}"))
      fault |= area;
   if (controller_tamper && strcmp(controller_tamper, "{}"))
      tamper |= area;
#define i(x) store_area(j,#x,x);
#define c(x) store_area(j,#x,control_##x);
#include "states.m"
   return NULL;
}
#endif

#ifdef  CONFIG_REVK_MESH
const char *system_makesummary(jo_t j)
{                               // Alarm state - finish processing reports we have received, and make a summary of output state for all devices
#define i(x) state_##x=report_##x;      // Set aggregate states anyway (done by summary anyway)
#include "states.m"

   // Make system states  
   // TODO timers?
   state_alarm = (state_armed & state_presence);
   state_tampered |= report_tamper;
   state_faulted |= report_fault;
   state_alarmed |= state_alarm;
   state_prearm = report_arm;
   state_armed |= (report_arm & ~state_presence);
   state_armed &= ~report_unarm;
   state_alarmed &= ~report_unalarm;
   state_tampered &= ~report_untamper;
   state_faulted &= ~report_unfault;

   // Send summary
#define i(x) store_area(j,#x,state_##x);report_##x=0;
#define s(x) store_area(j,#x,state_##x);
#include "states.m"
   return NULL;
}
#endif

#ifdef  CONFIG_REVK_MESH
const char *system_report(const char *device, jo_t j)
{                               // Alarm state - process a report from a device
   jo_rewind(j);
   jo_type_t t;
   while ((t = jo_next(j)))
   {
      if (t == JO_TAG)
      {
#define i(x) if(!jo_strcmp(j,#x))report_##x=parse_area(j);
#define c(x) i(x)
#include "states.m"
      }
   }
   return NULL;
}
#endif

#ifdef  CONFIG_REVK_MESH
const char *system_summary(jo_t j)
{                               // Alarm state - process summary of output states
   if (esp_mesh_is_root())
   {
      if (iotstatesystem)
      {
         jo_t c = jo_copy(j);
         revk_state_copy("system", &c, -1);
      }
      return NULL;
   } else
   {
      jo_rewind(j);
      jo_type_t t;
      while ((t = jo_next(j)))
      {
         if (t == JO_TAG)
         {
#define i(x) if(!jo_strcmp(j,#x))state_##x=parse_area(j);
#define s(x) i(x)
#include "states.m"
         }
      }
   }
   // Clear request bits
   control_arm &= ~state_armed;
   control_unarm &= state_armed;
   control_unfault &= state_faulted;
   control_unalarm &= state_alarmed;
   control_untamper &= state_tampered;
   // TODO Poke outputs maybe


   return NULL;
}
#endif

const char *app_callback(int client, const char *prefix, const char *target, const char *suffix, jo_t j)
{
   const char *e = NULL;
#ifdef  CONFIG_REVK_MESH
   if (!client && prefix && !strcmp(prefix, "mesh") && suffix)
   {                            // Note, some of these fill in j and used by library
      if (!strcmp(suffix, "makereport"))
         return system_makereport(j);
      else if (!strcmp(suffix, "makesummary"))
         return system_makesummary(j);
      else if (!strcmp(suffix, "report"))
         return system_report(target, j);
      else if (!strcmp(suffix, "summary"))
         return system_summary(j);
      // Note there are several more we could use
      return NULL;
   }
#endif
   if (client || !prefix || target || strcmp(prefix, prefixcommand))
      return NULL;              // Not for us or not a command from main MQTT
#define m(x) extern const char * x##_command(const char *,jo_t); jo_rewind(j);if(!e)e=x##_command(suffix,j);
   modules;
#undef m
   if (!strcmp(suffix, "connect"))
   {
      status_report(1);
      status_report(0);
   }
   return e;
}

#ifdef	CONFIG_LWMQTT_SERVER
static lwmqtt_t mqtt_relay = NULL;
static lwmqtt_t mqtt_slaves[MAX_SLAVE] = { };

static lwmqtt_t iot_relay = NULL;
static lwmqtt_t iot_slaves[MAX_SLAVE] = { };

void relay_rx(lwmqtt_t parent, lwmqtt_t * slaves, void *arg, char *topic, unsigned short len, unsigned char *payload)
{
   lwmqtt_t child = arg;
   // TODO client list maintenance
   // TODO subscribe pass on
   // TODO unsubscribe on disconnect - multiple if child is a relay
   // TODO mutex to protect lists
   // TODO
}

void mqtt_relay_rx(void *arg, char *topic, unsigned short len, unsigned char *payload)
{
   relay_rx(revk_mqtt(), mqtt_slaves, arg, topic, len, payload);
}

void iot_relay_rx(void *arg, char *topic, unsigned short len, unsigned char *payload)
{
   relay_rx(iot, iot_slaves, arg, topic, len, payload);
}

void sntp_dummy_task(void *pvParameters)
{                               // We know IPv4 local
   pvParameters = pvParameters;
   struct sockaddr_in dst = {
      .sin_addr.s_addr = htonl(INADDR_ANY),
      .sin_family = AF_INET,
      .sin_port = htons(123),
   };
   int sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
   if (bind(sock, (void *) &dst, sizeof(dst)) < 0)
   {
      ESP_LOGE(TAG, "SNTP bind failed");
      return;
   }
   while (1)
   {
      unsigned char buf[48];
      struct sockaddr_in addr;
      socklen_t addrlen = sizeof(addr);
      int len = recvfrom(sock, buf, sizeof(buf), 0, (void *) &addr, &addrlen);
      if (len != 48 || *buf != 0x23)
         continue;              // We expect the SNTP from ESP IDF which is really simple
      uint32_t now = time(0);
      if (now < 1000000000)
         continue;              // We don't know time
      buf[0] = 0x24;            // Server
      buf[1] = 15;              // Not very accurate
      buf[2] = 12;              // Poll
      buf[3] = 0;               // Second
      now += 2208988800UL;
      *(uint32_t *) (buf + 16) = htonl(now);
      *(uint32_t *) (buf + 24) = htonl(now);
      *(uint32_t *) (buf + 32) = htonl(now);
      *(uint32_t *) (buf + 40) = htonl(now);
      sendto(sock, buf, len, 0, (void *) &addr, addrlen);
   }
}

void relay_init(void)
{                               // relay mode tasks and so on...
   if (mqtt_relay)
      return;                   // Already running
   extern revk_bindata_t *mqttcert;
   extern uint16_t mqttport;
   extern revk_bindata_t *clientkey;
   extern revk_bindata_t *clientcert;
   // Make simple SNTP handler
   revk_task("SNTP", sntp_dummy_task, NULL);
   // Make IoT relay
   lwmqtt_server_config_t config = {
      .callback = iot_relay_rx,
   };
   iot_relay = lwmqtt_server(&config);
   // Make MQTT relay
   lwmqtt_server_config_t config = {
      .callback = mqtt_relay_rx,
      .port = mqttport,
   };
   if (mqttcert->len)
   {
      config.ca_cert_ref = 1;   // No need to copy
      config.ca_cert_buf = (void *) mqttcert->data;
      config.ca_cert_bytes = mqttcert->len;
   }
   if (clientkey->len && clientcert->len)
   {
      config.server_cert_ref = 1;       // No need to copy
      config.server_cert_buf = (void *) clientcert->data;
      config.server_cert_bytes = clientcert->len;
      config.server_key_ref = 1;        // No need to copy
      config.server_key_buf = (void *) clientkey->data;
      config.server_key_bytes = clientkey->len;
   }
   mqtt_relay = lwmqtt_server(&config);
}
#endif

uint8_t iotcopy;                // group heading
void app_main()
{
   reason = esp_reset_reason();
   revk_init(&app_callback);
   revk_register("iot", 0, 0, &iotcopy, "true", SETTING_BOOLEAN | SETTING_SECRET);      // iot group
#define io(n) revk_register(#n,0,sizeof(n),&n,BITFIELDS,SETTING_SET|SETTING_BITFIELD);
#define s(n) revk_register(#n,0,0,&n,NULL,0);
#define sa(n,a) revk_register(#n,a,0,&n,NULL,0);
#define area(n) revk_register(#n,0,sizeof(n),&n,AREAS,SETTING_BITFIELD);
#define bd(n,d)         revk_register(#n,0,0,&n,d,SETTING_BINDATA);
#define b(n)          revk_register(#n,0,1,&n,NULL,SETTING_BOOLEAN);
   settings
#undef io
#undef area
#undef s
#undef sa
#undef bd
#undef b
   int p;
   for (p = 6; p <= 11; p++)
      port_check(p, "Flash", 0);        // Flash chip uses 6-11
#define m(x) extern void x##_init(void); x##_init();
   modules;
#undef m
#ifdef CONFIG_LWMQTT_SERVER
   if (*slave[0])
      relay_init();
#endif
   // Main loop, if needed
   if (!tamper)
      return;                   // Not tamper checking, nothing to do.
   if (tamper)
   {
      port_check(port_mask(tamper), "Tamper", 1);
      gpio_reset_pin(port_mask(tamper));
      gpio_set_direction(port_mask(tamper), GPIO_MODE_INPUT);
      gpio_set_pull_mode(port_mask(tamper), GPIO_PULLUP_ONLY);
   }
   while (1)
   {                            // Tamper
      if (tamper)
      {
         if (gpio_get_level(port_mask(tamper)) ^ ((tamper & PORT_INV) ? 1 : 0))
         {
            if (!controller_tamper)
               status(controller_tamper = "Main board tamper switch");
         } else
         {
            if (controller_tamper)
               status(controller_tamper = NULL);
         }
      }
      usleep(100000);
   }
}

void status(const char *ignored)
{
   ignored = ignored;
   status_report(0);
}

uint8_t bcdutctime(time_t now, uint8_t datetime[7])
{
   if (!now)
      now = time(0);
   struct tm *t;
   t = gmtime(&now);
   int v = t->tm_year + 1900;
   datetime[0] = (v / 1000) * 16 + (v / 100 % 10);
   datetime[1] = (v / 10 % 10) * 16 + (v % 10);
   v = t->tm_mon + 1;
   datetime[2] = (v / 10) * 16 + (v % 10);
   v = t->tm_mday;
   datetime[3] = (v / 10) * 16 + (v % 10);
   v = t->tm_hour;
   datetime[4] = (v / 10) * 16 + (v % 10);
   v = t->tm_min;
   datetime[5] = (v / 10) * 16 + (v % 10);
   v = t->tm_sec;
   datetime[6] = (v / 10) * 16 + (v % 10);
   return t->tm_wday;
}

uint8_t bcdlocaltime(time_t now, uint8_t datetime[7])
{
   if (!now)
      now = time(0);
   struct tm *t;
   t = localtime(&now);
   int v = t->tm_year + 1900;
   datetime[0] = (v / 1000) * 16 + (v / 100 % 10);
   datetime[1] = (v / 10 % 10) * 16 + (v % 10);
   v = t->tm_mon + 1;
   datetime[2] = (v / 10) * 16 + (v % 10);
   v = t->tm_mday;
   datetime[3] = (v / 10) * 16 + (v % 10);
   v = t->tm_hour;
   datetime[4] = (v / 10) * 16 + (v % 10);
   v = t->tm_min;
   datetime[5] = (v / 10) * 16 + (v % 10);
   v = t->tm_sec;
   datetime[6] = (v / 10) * 16 + (v % 10);
   return t->tm_wday;
}
