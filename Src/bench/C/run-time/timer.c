/*

  #####     #    #    #  ######  #####            ####
    #       #    ##  ##  #       #    #          #    #
    #       #    # ## #  #####   #    #          #
    #       #    #    #  #       #####    ###    #
    #       #    #    #  #       #   #    ###    #    #
    #       #    #    #  ######  #    #   ###     ####

	Time-related routines
*/

#include "timer.h"
#include "portable.h"

#ifndef HAS_GETRUSAGE
#ifdef HAS_TIMES
#include <sys/param.h>		/* For value of HZ */
#endif
#endif


#ifndef lint
private char *rcsid =
	"$Id$";
#endif

#ifdef HAS_GETTIMEOFDAY
public void gettime(stamp)
Timeval *stamp;
{
	struct timezone tzp;

	gettimeofday(stamp, &tzp);
}
#else
#ifdef HAS_FTIME
public void gettime(stamp)
Timeval *stamp;
{
	ftime(stamp);
}
#else
#ifdef HAS_TIME
public void gettime(stamp)
Timeval *stamp;
{
	extern Time_t time();

	(void) time(stamp);
}
#endif
#endif
#endif


#ifdef HAS_GETTIMEOFDAY
public unsigned long elapsed(first, second)
Timeval *first, *second;
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
public unsigned long elapsed(first, second)
Timeval *first, *second;
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
public unsigned long elapsed(first, second)
Timeval *first, *second;
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
public void getcputime(usertime, systime)
double *usertime, *systime;
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
public void getcputime(usertime, systime)
double *usertime, *systime;
{
	struct tms time;
	extern Clock_t times();

	(void) times(&time);
	*usertime = (double)time.tms_utime / (double)HZ;
	*systime = (double)time.tms_stime / (double)HZ;
}
#else
public void getcputime(usertime, systime)
double *usertime, *systime;
{
	*usertime = 0;
	*systime = 0;
}
#endif

#endif

