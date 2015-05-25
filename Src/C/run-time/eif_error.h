/*
	description: "Definition of eio()."
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

#ifndef _eif_error_h_
#define _eif_error_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"

#ifdef EIF_ASSERTIONS
#include "rt_assert.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

	/* Tracking of Eiffel routines returning an error number. */
#ifdef EIF_ASSERTIONS
#define RT_TRACE(exp)			CHECK("RT_TRACE", (exp) == T_OK)
#define RT_TRACE_KEEP(res,exp)	res = exp; CHECK("RT_TRACE_KEEP", (res) == T_OK)
#else
#define RT_TRACE(exp)			(void) exp
#define RT_TRACE_KEEP(res,exp)	res = exp
#endif

	/* Error codes returned by Eiffel routines. Users should not assume their value. */
#define T_OK									0x00L
#define T_UNKNOWN_ERROR							0x01L
#define T_INVALID_ARGUMENT						0x02L
#define T_BUSY									0x03L
#define T_NO_MORE_MEMORY						0x04L
#define T_TRY_AGAIN								0x05L
#define T_TIMEDOUT								0x06L
#define T_UNSUPPORTED							0x07L
#define T_NOT_ENOUGH_PERMISSION					0x08L
#define T_NOT_IMPLEMENTED						0x09L
#define T_INVALID_POINTER						0x0aL
#define	T_DEADLOCK								0x0bL

#define T_CANNOT_CREATE_THREAD					0x101L
#define	T_CANNOT_TERMINATE_THREAD				0x102L

#define T_CANNOT_CREATE_MUTEX					0x103L
#define T_CANNOT_DESTROY_MUTEX					0x104L

#define T_CANNOT_CREATE_CONDVAR					0x105L
#define T_CANNOT_CREATE_SEMAPHORE				0x106L
#define T_CANNOT_DESTROY_SEMAPHORE				0x107L

#define T_CANNOT_CREATE_RWLOCK					0x108L
#define T_CANNOT_DESTROY_RWLOCK					0x109L

#define T_CANNOT_CREATE_CRITICAL_SECTION		0x10aL

#define	T_CANNOT_YIELD							0x10bL
#define T_NO_THREAD_WITH_ID						0x10cL

#define T_INVALID_ANNOTATIONS					0x201L

/* As a special case, an I/O error is raised when a system call which is
 * I/O bound fails.
 * Obsolete: use `eraise (NULL, EN_IO)' instead
 */
#define eio()	eraise(NULL, EN_IO)

RT_LNK void esys(void);				/* Raise 'Operating system error' exception */

#ifdef __cplusplus
}
#endif

#endif
