// Solar System
// (c) Andrews & Arnold Ltd, Adrian Kennard, see LICENSE file (GPL)

// RFID Card reader for Solar System
// ESP-12F based for use with PN532

// Wiring for ESP-12F
// PN532 connnections (in addition to GND/3V3)
// GPIO13 MOSI
// GPIO12 MISO
// GPIO14 SCK (CLK)
// GPIO16 SDA (SS)

#define PINS  ((1 << 12) | (1 << 13) | (1 << 14) | (1 << ss))

#include <ESPRevK.h>
#include "Reader532.h"
#include "PN532_SPI.h"
#include "PN532RevK.h"
#include "Output.h"

PN532_SPI pn532spi(SPI, ss);
PN532RevK nfc(pn532spi);
boolean reader532ok = false;
const char* reader532_fault = NULL;
const char* reader532_tamper = NULL;

char led[10];

#define app_settings  \
  s(reader532);   \

#define s(n) const char *n=NULL
  app_settings
#undef s

#define readertimeout 100

  const char* reader532_setting(const char *tag, const byte *value, size_t len)
  { // Called for settings retrieved from EEPROM
#define s(n) do{const char *t=PSTR(#n);if(!strcmp_P(tag,t)){n=(const char *)value;return t;}}while(0)
    app_settings
#undef s
    return NULL; // Done
  }

  boolean reader532_command(const char*tag, const byte *message, size_t len)
  { // Called for incoming MQTT messages
    if (!reader532ok)
      return false; // Not configured
    if (!strcmp_P(tag, "nfc") && len)
    {
      byte res[100], rlen = sizeof(res);
      byte ok = nfc.data(len, (byte*)message, rlen, res);
      if (!ok || !rlen)
        revk.info(F("nfc"), rlen - 1, res + 1);
      else revk.error(F("nfc"), F("failed %02X (%d bytes sent %02X %02X %02X...)"), ok, len, message[0], message[1], message[2]);
      return true;
    }
    if (!strcmp_P(tag, "led") && len < sizeof(led))
    { // Sequence of LED colours (R/G/-) to repeat
      if (len)
        memcpy((void*)led, (void*) message, len);
      if (len < sizeof(led))
        led[len] = 0;
      return true;
    }
    return false;
  }

  boolean reader532_setup(ESPRevK&revk)
  {
    if (!reader532)return false; // Not configured
    debugf("GPIO pin available %X for PN532", gpiomap);
    if ((gpiomap & PINS) != PINS)
    {
      reader532_fault = PSTR("Reader532 pins (SPI) not available");
      reader532 = NULL;
      return false;
    }
    gpiomap &= ~PINS;
    debugf("GPIO remaining %X", gpiomap);
    if (!nfc.begin())
    { // no reader
      reader532_fault = PSTR("PN532 failed");
      reader532 = NULL;
      return false;
    }

    debug("PN532 OK");
    reader532ok = true;
    *led = 0;
    return true;
  }

#define MAX_UID 10
  static char tid[MAX_UID * 2 + 1] = {}; // text ID

  boolean reader532_loop(ESPRevK&revk, boolean force)
  {
    if (!reader532ok)return false; // Not configured
    long now = (millis() ? : 1); // Allowing for wrap, and using 0 to mean not set
    static long lednext = 0;
    static byte ledlast = 0xFF;
    static byte ledpos = 0;
    if ((int)(lednext - now) <= 0)
    {
      lednext += 100;
      ledpos++;
      if (ledpos >= sizeof(led) || !led[ledpos])ledpos = 0;
      byte newled = 0;
      // We are assuming exactly two LEDs, one at a time (back to back) on P30 and P31
      if (led[ledpos] == 'R')newled = 2;
      else if (led[ledpos] == 'G')newled = 1;
      if (newled != ledlast)
        nfc.led(ledlast = newled);
    }
    static long tampercheck = 0;
    if ((int)(tampercheck - now) <= 0)
    {
      tampercheck = now + 250;
      int p3 = nfc.p3();
      if (p3 < 0)
        reader532_fault = PSTR("PN532");
      else
      { // INT1 connected via switch to VCC, so expected high
        if (reader532_fault)
        {
          nfc.begin();
          ledlast = 0xFF;
        }
        reader532_fault = NULL;
        if (p3 & 0x08)
          reader532_tamper = NULL;
        else if (*reader532 == 'T')
          reader532_tamper = PSTR("PN532");
      }
    }
    static long cardcheck = 0;
    static boolean held = false;
    if ((int)(cardcheck - now) < 0)
    {
      cardcheck = now + readerpoll;
      static long found = 0;
      if (found)
      {
        // TODO MIFARE 4 byte ID dont show as connected, and constantly show read target, grrr.
        String id;
        if (!nfc.inField(readertimeout) || nfc.getID(id))
        { // still here
          if (!held && (int)(now - found) > holdtime)
          {
#ifdef USE_OUTPUT
            if (fallback && !strcmp(fallback, tid))
              output_safe_set(true);
#endif
            revk.event(F("held"), F("%s"), tid); // Previous card gone
            held = 1;
          }
        } else
        { // gone
          if (held)
          {
#ifdef USE_OUTPUT
            if (fallback && !strcmp(fallback, tid))
              output_safe_set(false);
#endif
            revk.event(F("gone"), F("%s"), tid); // Previous card gone
            held = false;
          }
          found = 0;
        }
      } else {
        String id;
        if (nfc.getID(id))
        {
          found = (now ? : 1);
          strncpy(tid, id.c_str(), sizeof(tid));
          revk.event(F("id"), F("%s"), tid);
        }
      }
    }
    return true;
  }
