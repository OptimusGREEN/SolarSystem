// Database template

#ifndef table
#define table(n,l)              // Table (n is name, and field name for auto increment id if l=0, or fixed string len l, as primary key)
#endif

#ifndef	join
#define	join(a,b)
#endif

#ifndef	link
#define	link(n)                 // Foreign key link to table n
#endif

#ifndef	unique
#define unique(a,b)             // Unique key for a/b
#endif

#ifndef	key
#define key(n,l)                // Unique key for a(l)
#endif

#ifndef	index
#define index(n)                // Simple index
#endif

#ifndef text
#define text(n,l)               // Text field (l set for fixed size)
#endif

#ifndef num
#define num(n)                  // Numeric field (integer)
#endif

#ifndef time
#define time(n)                 // Time field
#endif

#ifndef ip
#define ip(n)                   // IP field
#endif

#ifndef gpio
#define gpio(n)                 // GPIO number field (and inverted)
#endif

#ifndef gpionfc
#define gpionfc(n)                 // NFC GPIO number field (and inverted)
#endif

#ifndef gpiopcb
#define gpiopcb(n)                 // PCB template GPIO type
#endif

#ifndef gpiotype
#define gpiotype(n)             // GPIO assignment field
#endif

#ifndef bool
#define bool(n)                 // Boolean field
#endif

#ifndef areas
#define areas(n)                // Area list
#endif

#ifndef area
#define area(n)                 // Area
#endif

table(user, 0);                 // Users of the system
text(description, 0);           // Users name
text(email, 0);                 // Users email - we expect unique
key(email, 128);
text(hash, 0);                  // Password hash
bool (admin);                   // Top level admin user - can do anything

table(session, 36);             // Login session
link(user);                     // Which user
time(logintime);                // Login time
time(expires);                  // Session expiry
index(expires);                 // Easier to delete
ip(loginip);                    // Login ip
text(useragent, 0);             // User agent
link(organisation);             // Current selected organisation
link(site);                     // Current selected site

join(class, aid);
areas(access);                  // Where user is allowed access
areas(arm);                     // Where user is allowed to arm/disarm
bool (dooroverride);            // Override all door controls
bool (doorclock);               // Override time when clock not set on door

join(site, aid);

table(class, 0);                // Classification (organisation wide)
link(organisation);
text(description, 0);
bool (admin);                   // Customer level admin user - can do anything relating to this organisation
bool (caneditorganisation);
bool (caneditclass);
bool (caneditsite);
bool (canedituser);
bool (caneditdevice);
bool (caneditfob);
bool (caneditarea);

join(user, organisation);
link(class);                    // defines users permissions
text(jobtitle, 0);              // Job Title

table(organisation, 0);         // Customer (may be more than one site)
text(description, 0);

table(site, 0);                 // Site
link(organisation);
text(description,0);
text(meshid, 12);               // Hex Mesh ID
// TODO key / crypto?

table(area, 0);
link(site);
area(area);
unique(site, area);
text(description, 0);

table(fob, 14);
time(provisioned);		// When provisioned
link(class);                    // The fobs class (required)

join(fob, aid);			// Fob is in AID (adopted)

join(fob,organisation);		// Yes, per org, for security reasons
time(blocked);			// When blocked
time(confirmed);		// When confirmed blocked by fob read (no need to be in blacklist now)

table(device, 12);
text(description, 0);
link(site);			// The site the device is on
link(pcb);                      // What type of device this is
text(version, 0);               // S/w version
bool (encryptednvs);            // Built with encrypted NVS
bool (secureboot);              // Built with secure boot
num(flash);			// Flash size
link(aid);                      // The AID for door access (defines what site it is)
bool(trusted);			// Trusted device for fob provisioning
areas(doorarea);                // Areas covered by this door
num(doorauto);			// Door auto mode
time(online);                   // When online, if online
time(lastonline);               // When last went offline
time(upgrade);                  // When to do upgrade
ip(address);                    // IP address when last online
num(instance);                  // Instance for communications when on line

table(devicegpio, 0);
link(device);
gpio(gpio);
gpiotype(type);
unique(device, gpio);		// Which GPIO (from PCB)
bool (invert);		// Invert
#define i(state) areas(state)
#define s(state) areas(state)
#include "ESP32/main/states.m"

table(pending, 12);
time(online);
ip(address);
num(instance);
text(version, 0);               // S/w version
bool (encryptednvs);            // Built with encrypted NVS
bool (secureboot);              // Built with secure boot
bool (authenticated);		// New authenticated device
num(flash);			// Flash size

table(pcb, 0);                  // PCB type
text(description, 0);
gpio(tamper);			// Fixed GPIOs
gpio(blink);		
gpio(nfctx);
gpio(nfcrx);
gpio(nfcpower);
gpionfc(nfcred);		// NFC GPIO (actually NFC PCB specific, but set here, so PCB for PCB+NFC combination)
gpionfc(nfcamber);
gpionfc(nfcgreen);
gpionfc(nfctamper);
gpionfc(nfcbell);
gpionfc(nfccard);

table(pcbgpio, 0);
link(pcb);
gpio(gpio);
unique(pcb, gpio);
gpiopcb(type);
gpiotype(init);
text(pinname,0);

table(aid, 6);                  // AID (linked to organisation)
link(organisation);
text(description,0);

#undef table
#undef join
#undef link
#undef unique
#undef key
#undef index
#undef text
#undef num
#undef time
#undef ip
#undef gpio
#undef gpionfc
#undef gpiopcb
#undef gpiotype
#undef bool
#undef areas
#undef area
