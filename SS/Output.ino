// Solar System
// (c) Andrews & Arnold Ltd, Adrian Kennard, see LICENSE file (GPL)

// Direct digital outputs

#include <ESPRevK.h>
#include "Output.h"
const char* output_fault = false;

#define MAX_PIN 17
#define MAX_OUTPUT 9

char outputpin[MAX_OUTPUT] = {}; // GPIO pin or relay number
unsigned int outputinvert = 0;
unsigned int outputactive = 0;
unsigned int outputstate = 0;
unsigned int outputrelay = 0;
unsigned int outputbeep = 0;
unsigned int outputoverride = 0;

unsigned long outputnext = 0;

#define app_settings  \
  s(output,0);   \

#define s(n,d) int n=d;
  app_settings
#undef s

  void output_safe_set(boolean enable)
  { // Set relay safe mode operation
    if (enable)
      outputoverride = 1;
    else
      outputoverride = 0;
    outputnext = millis();
  }

  const char* output_setting(const char *tag, const byte *value, size_t len)
  { // Called for settings retrieved from EEPROM
    if (!strncmp_P(tag, PSTR("output"), 6) && isdigit(tag[6]))
    { // Define output pin
      int i = atoi(tag + 6) - 1;
      if (i < 0 || i >= MAX_OUTPUT)
        return NULL;
      // Clear
      outputactive &= ~(1 << i);
      outputbeep &= ~(1 << i);
      outputrelay &= ~(1 << i);
      outputinvert &= ~(1 << i);
      if (len)
      {
        if (*value == '+' || *value == '-')
        { // Polarity
          if (*value == '-')
            outputinvert |= (1 << i);
          value++;
          len--;
        }
        if (!len)
          return NULL;
        byte prefix = 0;
        if (!isdigit(*value))
        {
          prefix = *value++;
          len--;
        }
        if (!len)return NULL;
        int p = 0;
        while (len && isdigit(*value))
        {
          p = p * 10 + *value++ -'0';
          len--;
        }
        if (len || p > 255)return NULL;
        if (prefix == 'R')
          outputrelay |= (1 << i); // Relay
        else if (prefix == 'B')
          outputbeep |= (1 << i);
        outputpin[i] = p;
        outputactive |= (1 << i);
      }
      // Messy...
      const char*tagname[] = {PSTR("output1"), PSTR("output2"), PSTR("output3"), PSTR("output4"), PSTR("output5"), PSTR("output6"), PSTR("output7"), PSTR("output8"), PSTR("output9")};
      return tagname[i];
    }
#define s(n,d) do{const char *t=PSTR(#n);if(!strcmp_P(tag,t)){n=(value?atoi((char*)value):d);return t;}}while(0)
    app_settings
#undef s
    return NULL; // Done
  }

  boolean output_command(const char*tag, const byte *message, size_t len)
  { // Called for incoming MQTT messages
    if (!outputactive)return false; // No outputs defined
    if (!strncasecmp_P(tag, PSTR("output"), 6) && tag[6] > '0' && tag[6] <= '0' + MAX_OUTPUT)
    {
      int i = tag[6] - '1';
      if (!(outputactive & (1 << i)))return false;
      if (len && *message == '1')
        outputstate |= (1 << i);
      else
        outputstate &= ~(1 << i);
      outputnext = millis();
      return true;
    }
    return false;
  }

  boolean output_setup(ESPRevK&revk)
  {
    if (!outputactive && !output)return false; // No outputs defined
    debugf("GPIO available %X for %d outputs", gpiomap, output);
    if (outputrelay && !(gpiomap & (1 << 1)))
    {
      output_fault = PSTR("Output relay Tx not available");
      outputrelay = 0;
    }
    if (outputrelay)gpiomap &= ~(1 << 1); // Tx used
    int i;
    // Check assigned pins
    for (i = 0; i < MAX_OUTPUT; i++)
      if ((outputactive & (1 << i)) && !(outputrelay & (1 << i)))
      {
        if (!(gpiomap & (1 << outputpin[i])))
        { // Unusable
          output_fault = PSTR("Output pin assignment not available");
          outputactive &= ~(1 << i);
          continue;
        }
        gpiomap &= ~(1 << outputpin[i]);
      }
    if (output)
    { // Auto assign some pins (deprecated)
      for (i = 0; i < output; i++)
        if (!(outputactive & (1 << i)) && !(outputrelay & (1 << i)))
        {
          int p;
          for (p = 0; p < MAX_PIN && !(gpiomap & (1 << p)); p++); // Find a pin
          if (p == MAX_PIN)
          {
            output_fault = PSTR("No output pins available to assign");
            break;
          }
          outputpin[i] = p;
          outputactive |= (1 << i);
          gpiomap &= ~(1 << outputpin[i]);
        }
    }
    debugf("GPIO remaining %X", gpiomap);
    for (i = 0; i < MAX_OUTPUT; i++)
      if (outputactive & (1 << i) && !(outputrelay & (1 << i)))
        pinMode(outputpin[i], OUTPUT);
#ifndef REVKDEBUG
    if (outputrelay)
      Serial.begin(9600);  // Serial relay control uses 9600
#endif
    debug("Output OK");
    return true;
  }

  boolean output_loop(ESPRevK&revk, boolean force)
  {
    if (!outputactive)return false; // No outputs defined
    unsigned long now = millis();
    if ((int)(outputnext - now) < 0)
    {
      outputnext = now + 1000; // Periodically re-set all output just in case, not really necessary
      unsigned long out = outputstate;
      if (insafemode)out = outputoverride; // Safe mode, normally means outputs off but can be overridden
      out ^= outputinvert;
      int i;
      for (i = 0; i < MAX_OUTPUT; i++)
        if (outputactive & (1 << i))
        {
          if (outputrelay & (1 << i))
          {
            byte msg[5];
            msg[0] = 0xA0;
            msg[1] = outputpin[i];
            msg[2] = ((out & (1 << i)) ? 1 : 0);
            msg[3] = msg[0] + msg[1] + msg[2];
            msg[4] = 0x0A;
            Serial.write(msg, 5);
          }
          else                    if (outputbeep & (1 << i))
            analogWrite(outputpin[i], (out & (1 << i)) ? PWMRANGE / 2 : 0);
          else
            digitalWrite(outputpin[i], (out & (1 << i)) ? 1 : 0);
        }
    }
    return true;
  }
