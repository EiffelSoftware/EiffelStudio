/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Inclusions and declarations for timer routines.
*/

#ifndef _eif_timer_h_
#define _eif_timer_h_

#include "eif_portable.h"
#include <sys/types.h>

#ifdef I_TIME
# include <time.h>
#endif
#ifdef I_SYS_TIME
# include <sys/time.h>
#endif
#ifdef I_SYS_TIME_KERNEL
# define KERNEL
# include <sys/time.h>
# undef KERNEL
#endif
#ifdef I_TMVAL_SYS_SELECT
#include <sys/select.h>
#endif

#ifdef I_SYS_RESOURCE
#include <sys/resource.h>
#endif

#ifdef HAS_FTIME
# ifdef I_SYS_TIMEB
#  include <sys/timeb.h>
# else
#  ifndef I_SYS_TIME	/* If not already included */
#   include <sys/time.h>
#  endif
# endif
#endif

#ifdef I_SYS_TIMES
#include <sys/times.h>		/* For the times() system call */
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef HAS_GETTIMEOFDAY
#ifndef HAS_FTIME
#ifdef HAS_TIME
typedef Time_t Timeval;
#endif
#endif
#endif

/* Routine declarations */
#ifdef HAS_GETTIMEOFDAY		/* %%ss added for declaration pb */
extern void gettime(struct timeval *stamp);			/* Save current time (timestamp) */
extern unsigned long elapsed(struct timeval *first, struct timeval *second);	/* Give elapsed time between two timestamps */
#else
extern void gettime(Timeval *stamp);
extern unsigned long elapsed(Timeval *first, Timeval *second);
#endif

extern void getcputime(double *usertime, double *systime);		/* Get CPU usage (user time and sys time) */

#ifdef __cplusplus
}
#endif

#endif

