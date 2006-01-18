/*
	description: "Inclusions and declarations for timer routines."
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

