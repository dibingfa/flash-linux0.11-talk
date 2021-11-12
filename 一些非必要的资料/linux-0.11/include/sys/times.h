#ifndef _TIMES_H
#define _TIMES_H

#include <sys/types.h>

struct tms {
	time_t tms_utime;
	time_t tms_stime;
	time_t tms_cutime;
	time_t tms_cstime;
};

extern time_t times(struct tms * tp);

#endif
