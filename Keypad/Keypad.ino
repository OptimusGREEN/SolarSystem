// Keypad / display
// ESP-01 based with RS485 board
// Connect to Galaxy keypad

//#define DEBUG // log message (header bytes)

#include <ESP8266RevK.h>

ESP8266RevK revk(__FILE__, __DATE__ " " __TIME__);

#define RTS 2

#define commands  \
  f(07,display,32,0) \
  f(19,keyclick,1,5) \
  f(0C,beep,2,0) \
  f(0D,backlight,1,1) \
  f(07a,cursor,2,0) \
  f(07b,blink,1,0) \

#define f(id,name,len,def) static byte name[len]={def};boolean send##id=false;byte name##_len=0;
  commands
#undef  f

  boolean app_setting(const char *setting, const byte *value, size_t len)
  { // Called for commands retrieved from EEPROM
    return false; // Done
  }

  boolean app_cmnd(const char*suffix, const byte *message, size_t len)
  { // Called for incoming MQTT messages
#define f(i,n,l,d) if(!strcasecmp(suffix,#n)&&len<=l){memcpy(n,message,len);n##_len=len;if(len<l)memset(n+len,0,l-len);send##i=true;return true;}
    commands
#undef f
    return false;
  }

  void setup()
  {
#ifndef REVKDEBUG
    Serial.begin(9600);	// Galaxy uses 9600 8N2
#endif
    digitalWrite(RTS, LOW);
    pinMode(RTS, OUTPUT);

  }

  void loop()
  {
    if (!revk.loop())return; // Not connected
    long now = millis();
    static long next = 0;
    if ((int)(next - now) < 0)
    {
      next = ((now + 1000) ? : 1); // Default if nothing responding
      static boolean send0B = false;
      static boolean toggle0B = false;
      static boolean toggle07 = false;
      static boolean online = false;
      static boolean tamper = false;
      static boolean fault = false;
      byte buf[100], p = 0;
      if (!online)
      { // Init
        buf[++p] = 0x00;
        buf[++p] = 0x0E;
      } else    if (send0B)
      { // key confirm
        buf[++p] = 0x0B;
        buf[++p] = toggle0B ? 2 : 0;
        toggle0B = !toggle0B;
        send0B = false;
      } else if (send07 || send07a || send07b)
      { // Text
        buf[++p] = 0x07;
        buf[++p] = 0x01 | ((blink[0] & 1) ? 0x08 : 0x00) | (toggle07 ? 0x80 : 0);
        if (display_len)
        {
          if (cursor[0])
          {
            buf[++p] = 0x07; // cursor off while we update
            send07a = true; // send cursor when done
          }
          buf[++p] = 0x1F; //  home
          int y, x;
          for (y = 0; y < 2; y++)
          {
            buf[++p] = 0x03; // Cursor
            buf[++p] = (y ? 0x40 : 0);
            for (x = 0; x < 16; x++)buf[++p] = (display[y * 16 + x] ? : ' ');
          }
        }
        else buf[++p] = 0x17; // clear
        if (send07a)
        { // cursor
          if (cursor_len)
          {
            buf[++p] = 0x03;
            buf[++p] =  ((cursor[0] & 0x10) ? 0x40 : 0) + (cursor[0] & 0x0F);
            if (cursor[0] & 0x80)
              buf[++p] = 0x06;       // Solid block
            else if (cursor[0] & 0x40)
              buf[++p] = 0x10;       // Underline
          }
          else buf[++p] = 0x07; // cursor off
        }
        if (!toggle07)
        { // send twice
          send07a = false;
          send07b = false;
          send07 = false;
        }
        toggle07 = !toggle07;
      } else if (send19)
      { // Key keyclicks
        buf[++p] = 0x19;
        buf[++p] = (keyclick[0] & 0x7); // 0x03 (silent), 0x05 (quiet), or 0x01 (normal)
        buf[++p] = 0;
        send19 = false;
      } else if (send0C)
      { // Beeper
        buf[++p] = 0x0C;
        buf[++p] = beep_len ? beep[1] ? 3 : 1 : 0;
        buf[++p] = (beep[0] & 0x3F); // Time on
        buf[++p] = (beep[1] & 0x3F); // Time off
        send0C = false;
      } else if (send0D)
      { // Light change
        buf[++p] = 0x0D;
        buf[++p] = (backlight[0] & 1);
        send0D = false;
      } else
        buf[++p] = 0x06; // Normal poll
      // Send
      buf[0] = 0x10; // ID of display
      p++;
      { // Checksum
        unsigned int c = 0xAA, n;
        for (n = 0; n < p; n++)
          c += buf[n];
        while (c > 0xFF)
          c = (c >> 8) + (c & 0xFF);
        buf[p++] = c;
      }
#ifdef DEBUG
      if (buf[1] != 0x06)
        revk.stat("Tx", "%d: %02X %02X %02X %02X", p, buf[0], buf[1], buf[2], buf[3]);
#endif
      byte cmd = buf[1];
      digitalWrite(RTS, HIGH);
      delay(1);
      Serial.write(buf, p);
      Serial.flush();
      digitalWrite(RTS, LOW);
      Serial.setTimeout(10);
      p = Serial.readBytes(buf, 1);
      if (p)
      {
        Serial.setTimeout(2);
        p += Serial.readBytes(buf + p, sizeof(buf) - p);
#ifdef DEBUG
        if (buf[1] != 0xFE)
          revk.stat("Rx", "%d: %02X %02X %02X %02X", p, buf[0], buf[1], buf[2], buf[3]);
#endif
        unsigned int c = 0xAA, n;
        for (n = 0; n < p - 1; n++)
          c += buf[n];
        while (c > 0xFF)
          c = (c >> 8) + (c & 0xFF);
        if (p < 2 || buf[n] != c || buf[0] != 0x11 || buf[1] == 0xF2)
        {
          if (!fault)
          {
            revk.stat("fault", "1");
            fault = true;
          }
        }
        else
        {
          if (fault)
          {
            revk.stat("fault", "0");
            fault = false;
          }
          if (cmd == 0x00 && buf[1] == 0xFF && p > 5)
          { // Set up response
            if (!online)
            {
              online = true;
              toggle0B = false;
              toggle07 = true;
              send07 = true;
              send07a = true;
              send07b = true;
              send0B = true;
              send0C = true;
              send0D = true;
              send19 = true;
            }
          } else if (buf[1] == 0xFE)
          { // Idle, no tamper
            if (tamper)revk.stat("tamper", "0");
            tamper = false;
          } else if (cmd == 0x06 && buf[1] == 0xF4 && p > 3)
          { // Status
            if (buf[2] & 0x40)
            {
              if (!tamper)revk.stat("tamper", "1");
              tamper = true;
            } else
            {
              if (tamper)revk.stat("tamper", "0");
              tamper = false;
            }
            if (!send0B && buf[2] != 0x7F)
            { // Key
              send0B = true;
              // Note mapping and key held bit...
              // TODO why duplicates?
              revk.stat(buf[2] & 0x80 ? "hold" : "key", "%c", "0123456789BA\n\e*#"[buf[2] & 0x0F]);
            }
          }
          next = ((millis() + 20) ? : 1);
        }
      } else
      {
        if (!fault)
        {
          fault = true;
          revk.stat("fault", "1");
        }
        online = false;
      }
      delay(1);
    }
  }
