// Solar System
// (c) Andrews & Arnold Ltd, Adrian Kennard, see LICENSE file (GPL)

// RFID Card reader for Solar System using PN532 via SPI

#define  USE_READER532
extern boolean reader532fault;

#ifndef	HOLDTIME
#define HOLDTIME 3000
#endif

#ifndef	REALASETIME
#define RELEASETIME 1000
#endif


#include <ESP8266RevK.h>

extern const char* reader532_setting(const char *tag, const byte *value, size_t len);
extern boolean reader532_command(const char*tag, const byte *message, size_t len);
extern boolean reader532_setup(ESP8266RevK&);
extern boolean reader532_loop(ESP8266RevK&, boolean);
