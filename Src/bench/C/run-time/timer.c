/*

  #####     #    #    #  ######  #####            ####
    #       #    ##  ##  #       #    #          #    #
    #       #    # ## #  #####   #    #          #
    #       #    #    #  #       #####    ###    #
    #       #    #    #  #       #   #    ###    #    #
    #       #    #    #  ######  #    #   ###     ####

	Time-related routines
*/

#include "eif_portable.h"
#include "eif_confmagic.h"
#include "eif_timer.h"

#ifndef HAS_GETRUSAGE
#if defined HAS_TIMES && !defined __VMS
#include <sys/param.h>		/* For value of HZ */
#endif
#endif
#ifdef _CRAY
#include <sys/machd.h>
#endif

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

#ifdef HAS_GETTIMEOFDAY
rt_public void gettime(struct timeval *stamp)
{
	struct timezone tzp;

	gettimeofday(stamp, &tzp);
}
#else
#ifdef HAS_FTIME
rt_public void gettime(Timeval *stamp)
{
	ftime(stamp);
}
#else
#ifdef HAS_TIME
rt_public void gettime(Timeval *stamp)
{
	(void) time(stamp);
}
#endif
#endif
#endif


#ifdef HAS_GETTIMEOFDAY
rt_public unsigned long elapsed(struct timeval *first, struct timeval *second)
{
	/* Computes the elapsed time in centiseconds between
	 * first and second times.
	 */
	
	if (first->tv_usec > second->tv_usec) {
		second->tv_usec += 1000000;
		second->tv_sec--;
	}
	return (unsigned long) ((second->tv_sec - first->tv_sec) * 100 +
		(second->tv_usec - first->tv_usec) / 10000);
}
#else
#ifdef HAS_FTIME
rt_public unsigned long elapsed(Timeval *first, Timeval *second)
{
	/* Computes the elapsed time in centiseconds between
	 * first and second times.
	 */
	
	if (first->millitm > second->millitm) {
		second->millitm += 1000;
		second->time--;
	}
	return (unsigned long) ((second->time - first->time) * 100 +
		(second->millitm - first->millitm) / 10);
}
#else
#ifdef HAS_TIME
rt_public unsigned long elapsed(Timeval *first, Timeval *second)
{
	/* Computes the elapsed time in centiseconds between
	 * first and second times.
	 */
	
	return (*second - *first) * 100;
}
#endif
#endif
#endif


#ifdef HAS_GETRUSAGE
rt_public void getcputime(double *usertime, double *systime)
{
	struct rusage usage;

	getrusage(RUSAGE_SELF, &usage);

	*usertime = (double)usage.ru_utime.tv_sec +
			(double)usage.ru_utime.tv_usec / 1000000.;
	*systime = (double)usage.ru_stime.tv_sec +
			(double)usage.ru_stime.tv_usec / 1000000.;
}
#else
#ifdef HAS_TIMES
rt_public void getcputime(double *usertime, double *systime)
{
	struct tms time;

	(void) times(&time);
	*usertime = (double)time.tms_utime / (double)HZ;
	*systime = (double)time.tms_stime / (double)HZ;
}
#else
rt_public void getcputime(double *usertime, double *systime)
{
	*usertime = 0;
	*systime = 0;
}
#endif

#endif

