/*

  #####     #    #    #  ######  #####           #    #
    #       #    ##  ##  #       #    #          #    #
    #       #    # ## #  #####   #    #          ######
    #       #    #    #  #       #####    ###    #    #
    #       #    #    #  #       #   #    ###    #    #
    #       #    #    #  ######  #    #   ###    #    #

	Inclusions and declarations for timer routines.
*/

#ifndef _timer_h_
#define _timer_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "config.h"
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

#ifndef HAS_GETTIMEOFDAY
#ifndef HAS_FTIME
#ifdef HAS_TIME
typedef Time_t Timeval;
#endif
#endif
#endif

#ifdef I_SYS_TIMES
#include <sys/times.h>		/* For the times() system call */
#endif

/* Routine declarations */
extern void gettime();			/* Save current time (timestamp) */
extern unsigned long elapsed();	/* Give elapsed time between two timestamps */
extern void getcputime();		/* Get CPU usage (user time and sys time) */

#ifdef __cplusplus
}
#endif

#endif

