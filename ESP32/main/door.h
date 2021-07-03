// Autonomous door control
// Copyright © 2019 Adrian Kennard, Andrews & Arnold Ltd. See LICENCE file for details. GPL 3.0

const char *door_fob(fob_t *);
const char * door_unlock(const uint8_t * a, const char *why);
const char * door_lock(const uint8_t * a);
const char *door_deadlock(const uint8_t * a);
