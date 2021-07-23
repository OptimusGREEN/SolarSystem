// Alarm management
// Copyright © 2019-21 Adrian Kennard, Andrews & Arnold Ltd. See LICENCE file for details. GPL 3.0
static const char __attribute__((unused)) TAG[] = "alarm";
#include "SS.h"
#include "desfireaes.h"
#include "alarm.h"
#include "nfc.h"
#include "door.h"
#include "input.h"
#include "output.h"
#include <esp_mesh.h>
#include <esp_http_client.h>
#ifdef  CONFIG_MBEDTLS_CERTIFICATE_BUNDLE
#include "esp_crt_bundle.h"
#endif
#include "freertos/semphr.h"
const char *alarm_fault = NULL;
const char *alarm_tamper = NULL;

// Alarm control

#define i(x,c) area_t state_##x;        // system wide aggregated input states
#define c(x) area_t control_##x;        // local control flags
#define s(x,c) area_t state_##x;        // system wide calculated states
#include "states.m"

area_t latch_fault = 0;         // System settings from other modules
area_t live_fault = 0;          // System settings from other modules
area_t latch_tamper = 0;        // System settings from other modules
area_t live_tamper = 0;         // System settings from other modules
area_t latch_warning = 0;       // System settings from other modules
area_t live_warning = 0;        // System settings from other modules
area_t latch_presence = 0;      // System settings from other modules
area_t live_presence = 0;       // System settings from other modules

static SemaphoreHandle_t node_mutex = NULL;

typedef struct node_s {
   mac_t mac;
   uint8_t online:1;            // Is on line
   uint8_t missed:1;            // Has missed a report
   uint8_t reported:1;          // Has reported
} node_t;
static node_t *node = NULL;
static int nodes = 0;
static int nodes_online = 0;
static int nodes_reported = 0;
int64_t summary_next = 0;       // Send summary cycle
int64_t report_next = 0;        // Send report cycle

#define settings		\
	area(areawarning)	\
	area(areafault)		\
	area(areatamper)	\
	area(areaenter)		\
	area(deadlock)		\
	area(areaarm)		\
	area(areastrongarm)	\
	area(areabell)		\
	area(areadisarm)	\
	area(areadeadlock)	\
	area(arealed)		\
	area(areakeypad)	\
	area(engineer)		\
	area(armed)		\
	u16(armcancel)		\
	u16(alarmdelay)		\
	u16(alarmhold)		\
        u8(meshcycle,3)		\
        u8(meshwarmup,30)	\
	area(smsarm)		\
	area(smsdisarm)		\
	area(smsarmfail)	\
	area(smsalarm)		\
	area(smspanic)		\
	arean(mixand,MAX_MIX)	\
	arean(mixset,MAX_MIX)	\
	sn(mixarm,MAX_MIX)	\
	sn(mixdisarm,MAX_MIX)	\

#define area(n) area_t n;
#define arean(n,q) area_t n[q];
#define s(n,d) char *n;
#define sn(n,q) char *n[q];
#define u16(n) uint16_t n;
#define u8(n,d) uint16_t n;
settings
#undef area
#undef arean
#undef s
#undef sn
#undef u16
#undef u8
static void task(void *pvParameters);
static void node_online(const mac_t mac);
static void sms_event(const char *tag, jo_t);
static void set_outputs(void);

const char *alarm_command(const char *tag, jo_t j)
{
   if (!strcmp(tag, "connect"))
   {
      if (esp_mesh_is_root())
         for (int i = 0; i < nodes; i++)
            if (node[i].online)
               node_online(node[i].mac);
      return NULL;
   }
   if (!strcmp(tag, "arm"))
   {
      jo_t e = jo_make("Remote");
      alarm_arm(jo_read_area(j), &e);
      return "";
   }
   if (!strcmp(tag, "disarm"))
   {
      jo_t e = jo_make("Remote");
      alarm_disarm(jo_read_area(j), &e);
      return "";
   }
   return NULL;
}

area_t alarm_armed(void)
{                               // What areas are, in effect, armed
   return (state_armed | control_arm | control_strongarm) & ~control_disarm;
}

void alarm_arm(area_t a, jo_t * jp)
{                               // Arm
   if (!(a & ~alarm_armed()))
   {
      jo_free(jp);
      return;                   // All armed
   }
   jo_t j = NULL;
   if (jp)
   {
      j = *jp;
      *jp = NULL;
   }
   if (!j)
      j = jo_make(NULL);
   ESP_LOGD(TAG, "Arm %X", a);
   control_arm |= a;
   control_disarm &= ~a;
   door_check();
   jo_area(j, "areas", a);
   if (smsarm & a)
      sms_event("Armed", j);
   revk_event_clients("arm", &j, 1 | (ioteventarm << 1));
}

void alarm_strongarm(area_t a, jo_t * jp)
{                               // Strong arm
   if (!(a & ~((state_armed | control_strongarm) & ~control_disarm)))   // Not using alarm_armed as that includes what we are trying, and failing, to control_arm
   {
      jo_free(jp);
      return;                   // All armed
   }
   jo_t j = NULL;
   if (jp)
   {
      j = *jp;
      *jp = NULL;
   }
   if (!j)
      j = jo_make(NULL);
   ESP_LOGD(TAG, "Strong arm %X", a);
   control_strongarm |= a;
   control_disarm &= ~a;
   door_check();
   jo_area(j, "areas", a);
   if (smsarm & a)
      sms_event("Strong armed", j);
   revk_event_clients("strongarm", &j, 1 | (ioteventarm << 1));
}

void alarm_disarm(area_t a, jo_t * jp)
{                               // Disarm
   if (!(a & alarm_armed()))
   {
      jo_free(jp);
      return;                   // Not armed
   }
   jo_t j = NULL;
   if (jp)
   {
      j = *jp;
      *jp = NULL;
   }
   if (!j)
      j = jo_make(NULL);
   ESP_LOGD(TAG, "Disarm %X", a);
   control_arm &= ~a;
   control_strongarm &= ~a;
   control_disarm |= a;
   door_check();
   jo_area(j, "areas", a);
   if (smsdisarm & a)
      sms_event("Disarmed", j);
   revk_event_clients("disarm", &j, 1 | (ioteventarm << 1));
}

void alarm_boot(void)
{
   node_mutex = xSemaphoreCreateBinary();
   xSemaphoreGive(node_mutex);
   revk_register("area", 0, sizeof(areafault), &areafault, AREAS, SETTING_BITFIELD | SETTING_LIVE | SETTING_SECRET);    // Will control if shown in dump!
   revk_register("sms", 0, sizeof(smsalarm), &smsalarm, AREAS, SETTING_BITFIELD | SETTING_LIVE | SETTING_SECRET);
   revk_register("mix", sizeof(mixand) / sizeof(*mixand), sizeof(*mixand), &mixand, AREAS, SETTING_BITFIELD | SETTING_LIVE | SETTING_SECRET);
#define area(n) revk_register(#n,0,sizeof(n),&n,AREAS,SETTING_BITFIELD|SETTING_LIVE);
#define arean(n,q) revk_register(#n,q,sizeof(*n),&n,AREAS,SETTING_BITFIELD|SETTING_LIVE);
#define s(n,d) revk_register(#n,0,0,&n,#d,SETTING_LIVE);
#define sn(n,q) revk_register(#n,q,0,&n,NULL,SETTING_LIVE);
#define u16(n) revk_register(#n,0,sizeof(n),&n,NULL,SETTING_LIVE);
#define u8(n,d) revk_register(#n,0,sizeof(n),&n,#d,SETTING_LIVE);
   settings;
#undef area
#undef arean
#undef s
#undef sn
#undef u16
#undef u8
   // Pick up flash stored state to get started
   state_armed = armed;
   state_engineer = engineer;
   set_outputs();               // Ensure output states set so when output starts it knows expected state
}

void alarm_start(void)
{
   revk_task(TAG, task, NULL);
}

// JSON functions
void jo_area(jo_t j, const char *tag, area_t area)
{                               // Store area
   char set[sizeof(area_t) * 8 + 1] = "",
       *p = set;
   for (int b = 0; AREAS[b]; b++)
      if (area & (1ULL << (sizeof(area_t) * 8 - b - 1)))
         *p++ = AREAS[b];
   *p = 0;
   if (p > set)
      jo_string(j, tag, set);
}

area_t jo_read_area(jo_t j)
{                               // Read area
   if (jo_here(j) != JO_STRING)
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

static int mesh_find_child(const mac_t mac, char insert)
{
   xSemaphoreTake(node_mutex, portMAX_DELAY);
   int l = 0,
       m = 0,
       h = nodes - 1,
       d = -1;
   while (l <= h)
   {
      m = (l + h) / 2;
      d = memcmp(mac, node[m].mac, 6);
      if (d < 0)
         h = m - 1;
      else if (d > 0)
         l = m + 1;
      else
         break;
   }
   if (d)
   {
      m = -1;                   // Not found
      if (insert)
      {
         if (nodes >= meshmax)
            ESP_LOGE(TAG, "Too many children (%d)", nodes);
         else
         {                      // Insert
            m = l;
            ESP_LOGD(TAG, "Added leaf %02X%02X%02X%02X%02X%02X at %d/%d", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5], m, nodes + 1);
            if (m < nodes)
               memmove(&node[m + 1], &node[m], (nodes - m) * sizeof(node_t));
            nodes++;
            memset(&node[m], 0, sizeof(node_t));
            memcpy(node[m].mac, mac, 6);
         }
      }
   }
   xSemaphoreGive(node_mutex);
   return m;
}

const char *mesh_make_report(jo_t j)
{                               // Make the report from leaf to root for out states...
#define i(x,c) area_t x=0;      // what we are going to send
#include "states.m"
   {                            // Inputs
      input_t latch = input_latch;
      input_latch = 0;
      input_t flip = input_flip;
      input_flip = 0;
      for (int i = 0; i < MAXINPUT; i++)
      {
         if ((latch | input_stable) & (1ULL << i))
         {                      // State is active (or has been, even if briefly)
#define i(x,c) x|=input##x[i];
#include "states.m"
         }
         if (flip & (1ULL << i))
         {                      // State has changed, so causes presence and event logging
            if ((inputpresence[i] | inputaccess[i] | inputtamper[i]) & (state_armed | state_prearm))
            {                   // Event log
               jo_t e = jo_make(NULL);
               jo_string(e, "input", inputname[i]);
               if (inputpresence[i] & (state_armed | state_prearm))
                  jo_bool(e, "presence", (input_stable >> i) & 1);
               if (inputaccess[i] & (state_armed | state_prearm))
                  jo_bool(e, "access", (input_stable >> i) & 1);
               if (inputtamper[i] & (state_armed | state_prearm))
                  jo_bool(e, "tamper", (input_stable >> i) & 1);
               revk_event_clients("trigger", &e, 1 | (ioteventarm << 1));
            }
            presence |= inputtamper[i];
            presence |= inputaccess[i];
         }
      }
   }
   // Extras
   char bell = bell_latch;
   bell_latch = 0;
   if (bell)
      doorbell |= areabell;
   // Latched from local fault or tamper
   area_t latch = latch_warning;
   latch_warning = 0;
   warning |= latch | live_warning;

   latch = latch_fault;
   latch_fault = 0;
   fault |= latch | live_fault;

   latch = latch_tamper;
   latch_tamper = 0;
   tamper |= latch | live_tamper;

   latch = latch_presence;
   latch_presence = 0;
   presence |= latch | live_presence;;
#define i(x,c) jo_area(j,#x,x);
#define c(x) jo_area(j,#x,control_##x);
#include "states.m"
   return NULL;
}

#define c(x) static area_t report_##x=0;        // The collated reports
#define i(x,l) c(x)
#include "states.m"

static void node_offline(const mac_t mac)
{
   // TODO
}

static void node_online(const mac_t mac)
{
   if (memcmp(mac, revk_mac, 6))
   {
      revk_send_sub(0, mac);
      revk_send_sub(1, mac);
      jo_t j = jo_object_alloc();
      jo_null(j, "connect");
      revk_mesh_send_json(mac, &j);
   }
}

static void mesh_now_root(void)
{
   // TODO
}

static void mesh_now_leaf(void)
{
   // TODO
}

static int check_online(const char *target)
{
   if (!target || strlen(target) != 12)
      return -1;
   mac_t mac;
   for (int n = 0; n < sizeof(mac); n++)
      mac[n] = (((target[n * 2] & 0xF) + (target[n * 2] > '9' ? 9 : 0)) << 4) + ((target[1 + n * 2] & 0xF) + (target[1 + n * 2] > '9' ? 9 : 0));
   int child = mesh_find_child(mac, 1);
   if (child < 0)
      return child;
   if (!node[child].online)
   {                            // Is there risk of a race in any way? mutex?
      node[child].online = 1;
      node[child].missed = 0;
      node[child].reported = 0;
      nodes_online++;
      node_online(mac);
   }
   return child;
}

static area_t andset(area_t a)
{                               // Mix and set
   for (int s = 0; s < MAX_MIX; s++)
   {
      if (mixand[s] & ~a)
         a &= ~mixset[s];
      else
         a |= mixset[s];
   }
   return a;
}

static void mesh_make_summary(jo_t j)
{                               // Process reports received, and make summary
   jo_int(j, "nodes", nodes);
   if (nodes_online < nodes)
      jo_int(j, "offline", nodes - nodes_online);
   if (nodes < meshmax)
      jo_int(j, "missing", meshmax - nodes);
#define i(x,c) state_##x=report_##x;    // Set aggregate states anyway (done by summary anyway)
#include "states.m"
   // Make system states
   // simple latched states - cleared by re-arming
   state_tampered = ((state_tampered & ~report_arm) | report_tamper);
   state_faulted = ((state_faulted & ~report_arm) | report_fault);
   state_alarmed = ((state_alarmed & ~report_arm) | state_alarm);
   // arming normally holds off for presence (obviously) but also tamper and access - forcing armed is possible
   state_armed = andset((state_armed | report_strongarm | (report_arm & ~state_presence & ~(state_tamper & ~engineer) & ~state_access)) & ~report_disarm);
   // prearm if any not armed yet
   state_prearm = andset(report_arm & ~state_armed);
   // Alarm based only on presence, but change of tamper or access trips presence anyway. Basically you can force arm with tamper and access
   state_prealarm = (((state_prealarm | state_presence) & state_armed) & ~state_alarm);
   static uint16_t timer1 = 0;  // Pre alarm timer - ideally per area, but this will be fine
   if (!state_prealarm)
      timer1 = 0;
   else if (!alarmdelay || (timer1 += meshcycle) > alarmdelay)
      state_alarm = ((state_alarm | state_prealarm) & state_armed);
   state_alarm &= state_armed;
   static uint16_t timer2 = 0;  // Post alarm timer - ideally per area, but this will be fine
   if (state_prealarm)
      timer2 = 0;
   else if (alarmhold && (timer2 += meshcycle) > alarmhold)
      state_alarm = 0;
   // Fixed
   state_engineer = engineer;   // From flash - could be changed live though, so set here
   // Send summary
#define i(x,c) jo_area(j,#x,state_##x);report_##x=0;
#define c(x) report_##x=0;
#define s(x,c) jo_area(j,#x,state_##x);
#include "states.m"
}

static void mesh_handle_report(const char *target, jo_t j)
{                               // Alarm state - process a report from a device - aggregate them
   int child = check_online(target);
   if (child < 0)
      return;
   if (node[child].reported)
      return;                   // Odd
   node[child].missed = 0;
   node[child].reported = 1;
   nodes_reported++;
   jo_rewind(j);
   jo_type_t t;
   while ((t = jo_next(j)))
   {
      if (t == JO_TAG)
      {
#define c(x) if(!jo_strcmp(j,#x)){jo_next(j);report_##x|=jo_read_area(j);} else
#define i(x,l) c(x)
#include "states.m"
         {                      // Unknown?
         }
      }
   }
}

static void set_outputs(void)
{                               // Outputs set based on state
   output_t forced = 0;
   for (int i = 0; i < MAXOUTPUT; i++)
   {
#define i(x,c) if(output##x[i]&state_##x)forced|=(1ULL<<i);
#define s(x,c) i(x,c)
#include "states.m"
   }
   output_forced = forced;
}

static void mesh_handle_summary(const char *target, jo_t j)
{                               // Alarm state - process summary of output states
   report_next = esp_timer_get_time() + 1000000LL * meshcycle / 4 + 1000000LL * meshcycle * esp_random() / (1ULL << 32) / 2;    // Fit in reports
   check_online(target);
   if (esp_mesh_is_root())
   {                            // We are root, so we have updated anyway, but let's report to IoT
      const char *json = jo_rewind(j);
      if (json)
      {
         uint32_t now = uptime();
         static unsigned int last_crc = 0;      // using a CRC is a lot less memory than a copy of this or of the states
         unsigned int crc = 0;
         char *comma = strchr(json, ',');       // Skip time as that changes every time, duh
         if (comma)
            crc = df_crc(strlen(comma), (void *) comma);
         if (last_crc != crc || now > summary_next)
         {                      // Changed
            summary_next = now + 3600;
            last_crc = crc;
            revk_mqtt_send_payload_clients("state", 1, "system", json, 1 | (iotstatesystem << 1));
         }
      }
   } else
   {                            // We are leaf, get the data
#define i(x,c) area_t x=0;      // Zero if not specified
#define s(x,c) i(x,c)
#include "states.m"
      jo_rewind(j);
      jo_type_t t;
      while ((t = jo_next(j)))
      {
         if (t == JO_TAG)
         {
            if (!jo_strcmp(j, "summary"))
            {
               jo_next(j);
               if (jo_here(j) == JO_STRING)
               {                // Oddly time() is strange so using int32_t for now - fix before 2038 maybe :-)
                  int32_t new = jo_read_datetime(j);
                  if (new > 1000000000)
                  {
                     int32_t now = time(0);
                     int32_t diff = now - new;
                     if (diff > 60 || diff < -60)
                     {          // Big change
                        if (now > 1000000000 && diff < -300)
                        {
                           ESP_LOGE(TAG, "Replay attack? %d", diff);
                           return;
                        }
                        struct timeval tv = { new, 0 };
                        if (settimeofday(&tv, NULL))
                           ESP_LOGE(TAG, "Time set %d failed", new);
                     } else if (diff)
                     {
                        struct timeval delta = { diff, 0 };
                        adjtime(&delta, NULL);
                     }
                  }
               }
            } else
#define i(x,c) if(!jo_strcmp(j,#x)){jo_next(j);x=jo_read_area(j);} else
#define s(x,c) i(x,c)
#include "states.m"
            {                   // Unknown?
            }
         }
      }
#define i(x,c) state_##x=x;
#define s(x,c) i(x,c)
#include "states.m"
   }
   // Clear control bits when actioned
   control_arm &= ~state_armed;
   control_strongarm &= ~state_armed;
   control_disarm &= state_armed;
   static uint16_t timer = 0;
   if (!control_arm)
      timer = 0;
   else if (armcancel && (timer += meshcycle) > armcancel)
   {                            // Cancel arming (ideally per area, but this is good enough)
      if (smsarmfail & control_arm)
      {
         jo_t j = jo_make(NULL);
         jo_area(j, "areas", control_arm);
         sms_event("Arm failed", j);
         revk_event_clients("armfail", &j, 1 | (ioteventarm << 1));
      }
      control_arm = 0;
      door_check();
   }
   set_outputs();

   // Store armed state
   static area_t lastarmed = -1;
   if (lastarmed != state_armed)
   {
      jo_t j = jo_object_alloc();
      if (state_armed)
         jo_area(j, "armed", state_armed);
      else
         jo_string(j, "armed", "");
      revk_setting(j);
      jo_free(&j);
      door_check();
      for (int s = 0; s < MAX_MIX; s++)
         if (*mixarm[s] && !(mixand[s] & ~state_armed) && (mixand[s] & ~lastarmed))
            revk_mqtt_send_str_clients(mixarm[s], 0, 2);
         else if (*mixdisarm[s] && (mixand[s] & ~state_armed) && !(mixand[s] & ~lastarmed))
            revk_mqtt_send_str_clients(mixdisarm[s], 0, 2);
      lastarmed = state_armed;
   }
   static area_t lastalarm = -1;
   if (lastalarm != state_alarm)
   {
      if (esp_mesh_is_root() && smsalarm & (state_alarm & ~lastalarm))
      {
         jo_t j = jo_make("System");
         jo_area(j, "areas", state_alarm & ~lastalarm);
         sms_event("Alarm!", j);
         jo_free(&j);

      }
      lastalarm = state_alarm;
   }
   static area_t lastpanic = -1;
   if (lastpanic != state_panic)
   {
      if (esp_mesh_is_root() && smspanic & (state_panic & ~lastpanic))
      {
         jo_t j = jo_make("System");
         jo_area(j, "areas", state_panic & ~lastpanic);
         sms_event("Panic", j);
         jo_free(&j);

      }
      lastpanic = state_panic;
   }
}

static void task(void *pvParameters)
{                               // 
   esp_task_wdt_add(NULL);
   pvParameters = pvParameters;
   uint32_t isroot = 0;
   int wasonline = 0;
   node = malloc(sizeof(*node) * meshmax);
   mesh_find_child(revk_mac, 1);        // We count as a child
   node[0].online = 1;          // Us
   nodes_online++;
   while (1)
   {
      esp_task_wdt_reset();
      {                         // Set LED mode
         int r = 1;
         if ((isroot && !revk_offline() && nodes_online == meshmax) || (!isroot && esp_mesh_is_device_active()))
            r = 3;
         const char *led = "G";
#define i(x,c) if((state_##x&(arealed?:(area_t)-1))&&*#c)led=#c;
#define s(x,c) i(x,c)
#include "states.m"
         revk_blink(r, r, led);
      }
      // Waiting
      uint64_t now = esp_timer_get_time();
      if (!esp_mesh_is_device_active())
      {
         sleep(1);
         continue;
      }
      int64_t next = report_next;
      if (isroot && summary_next < report_next)
         next = summary_next;
      if (next > now + 1000000LL * meshcycle / 4)
         next = now + 1000000LL * meshcycle / 4;        // Max time we wait, as we can change the waiting on rx of summary
      if (next > now)
      {
         usleep(next - now);
         now = next;
      }
      // Periodic
      if (isroot && summary_next <= now)
      {                         // Summary reporting cycle
         summary_next = now + 1000000LL * meshcycle * 3;
         // Check off line
         for (int n = 0; n < nodes; n++)
            if (!node[n].reported && node[n].online)
            {                   // Gone off line
               if (!node[n].missed)
                  node[n].missed = 1;   // Allow one missed report
               else
               {
                  node[n].online = 0;
                  nodes_online--;
                  if (!memcmp(node[n].mac, revk_mac, 6))
                  {             // Should not happen
                     ESP_LOGE(TAG, "Self offline");
                     continue;
                  }
                  char mac[13];
                  sprintf(mac, "%02X%02X%02X%02X%02X%02X", node[n].mac[0], node[n].mac[1], node[n].mac[2], node[n].mac[3], node[n].mac[4], node[n].mac[5]);
                  revk_send_unsub(0, node[n].mac);
                  revk_send_unsub(1, node[n].mac);
                  char *topic;  // Tell IoT
                  asprintf(&topic, "state/%s/%s", mac, appname);
                  revk_mqtt_send_raw(topic, 1, "{\"up\":false}", -1);
                  free(topic);
                  node_offline(node[n].mac);
               }
            }
         if (nodes_reported >= nodes_online)
         {                      // We have a full set, make a report - the off line logic means we may miss a report if a device goes off line
            // Clear reports
            for (int n = 0; n < nodes; n++)
               node[n].reported = 0;
            nodes_reported = 0;
            jo_t j = jo_object_alloc();
            jo_datetime(j, "summary", time(0));
            mesh_make_summary(j);
            const mac_t addr = { 255, 255, 255, 255, 255, 255 };
            revk_mesh_send_json(addr, &j);
         } else
            ESP_LOGI(TAG, "Missed report %d/%d", nodes_reported, nodes_online);
      }
      if (report_next <= now)
      {                         // Periodic send to root - even to self
         report_next = now + 1000000LL * meshcycle;
         jo_t j = jo_object_alloc();
         jo_datetime(j, "report", time(0));
         mesh_make_report(j);
         revk_mesh_send_json(NULL, &j);
      }
      if (esp_mesh_is_root())
      {
         if (!isroot)
         {                      // We have become root
            mesh_now_root();
            isroot = uptime();
            wasonline = 0;
            // Clear down
            for (int i = 0; i < nodes; i++)
            {
               node[i].online = (memcmp(node[i].mac, revk_mac, 6) ? 0 : 1);     // All that are not us
               node[i].missed = 0;
               node[i].reported = 0;
            }
            nodes_online = 1;   // Us
            nodes_reported = 0;
            revk_mqtt_init();
            report_next = 0;    // Send report from us to us
            summary_next = now + 1000000LL * meshcycle * 3;     // Start reporting cycle
         }
         if (uptime() - isroot > meshwarmup)
         {                      // Checking was have quorum / full house
            if (wasonline != nodes_online)
            {
               wasonline = nodes_online;
               if (nodes_online <= meshmax / 2)
               {                // too few - force restart of mesh
                  // TODO
#if 0                           // TODO some sort of back off?
                  revk_wifi_close();
                  mesh_init();
#endif
               } else if (nodes_online < meshmax)
               {                // Missing devices
                  // TODO
               } else
               {                // All on line
                  // TODO
               }
            }
         }
      } else
      {
         if (isroot)
         {                      // We are no longer root
            revk_mqtt_close("Not root");
            freez(node);
            mesh_now_leaf();
         }
      }
   }
}

void alarm_rx(const char *target, jo_t j)
{
   ESP_LOGD(TAG, "Rx JSON %s %s", target, jo_rewind(j) ? : "?");
   if (jo_here(j) != JO_OBJECT)
      return;
   jo_next(j);
   if (jo_here(j) != JO_TAG)
      return;
   if (!jo_strcmp(j, "report"))
   {
      mesh_handle_report(target, j);
      return;
   }
   if (!jo_strcmp(j, "summary"))
   {
      mesh_handle_summary(target, j);
      return;
   }
   if (!jo_strcmp(j, "connect"))
   {
      revk_command("status", NULL);     // For up message
      app_callback(0, prefixcommand, NULL, "connect", j);
      return;
   }
}

void send_sms(const char *fmt, ...)
{
   char *v = NULL;
   va_list ap;
   va_start(ap, fmt);
   vasprintf(&v, fmt, ap);
   va_end(ap);
   jo_t j = jo_object_alloc();
   jo_string(j, "message", v);
   free(v);
   revk_mqtt_send("sms", 1, NULL, &j);
}

static void sms_event(const char *tag, jo_t j)
{
   char areas[sizeof(area_t) * 8 + 1] = "";
   char ts[21] = "";
   char id[15] = "";
   char node[30] = "";
   char name[30] = "";
   char reason[20] = "";
   jo_rewind(j);
   jo_type_t t;
   while ((t = jo_next(j)))
      if (t == JO_TAG)
      {
         if (!jo_strcmp(j, "ts"))
         {
            jo_next(j);
            jo_strncpy(j, ts, sizeof(ts));
            continue;
         }
         if (!jo_strcmp(j, "reason"))
         {
            jo_next(j);
            jo_strncpy(j, reason, sizeof(reason));
            continue;
         }
         if (!jo_strcmp(j, "node"))
         {
            jo_next(j);
            jo_strncpy(j, node, sizeof(node));
            continue;
         }
         if (!jo_strcmp(j, "name"))
         {
            jo_next(j);
            jo_strncpy(j, name, sizeof(name));
            continue;
         }
         if (!jo_strcmp(j, "id"))
         {
            jo_next(j);
            jo_strncpy(j, id, sizeof(id));
            continue;
         }
         if (!jo_strcmp(j, "areas"))
         {
            jo_next(j);
            jo_strncpy(j, areas, sizeof(areas));
            continue;
         }
      }
   send_sms("%s\n%s: %s\n%s\n%s %s %s", ts, tag, areas, node, reason, id, name);
}
