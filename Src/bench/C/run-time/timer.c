/*
	description: "Time-related routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="timer.c" header="rt_timer.h" version="$Id$" summary="Time related routines">
*/

#include "eif_portable.h"
#include "eif_confmagic.h"
#include "rt_timer.h"

#ifndef HAS_GETRUSAGE
#if defined HAS_TIMES && !defined __VMS
#include <sys/param.h>		/* For value of HZ */
#endif
#endif
#ifdef _CRAY
#include <sys/machd.h>
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

/*
doc:</file>
*/
