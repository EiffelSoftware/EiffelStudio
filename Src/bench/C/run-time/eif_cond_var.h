/*
	description: "Declarations for `eif_cond_var.c'."
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

#ifndef _eif_cond_var_h_
#define _eif_cond_var_h_

#ifdef EIF_THREADS

#include <windows.h>
#include <process.h>
#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct
{
  long waiters_;
  /* Number of waiting threads. */

  CRITICAL_SECTION  waiters_lock_;
  /* Serialize access to the waiters count. */

  HANDLE sema_;
  /* Semaphore used to queue up threads waiting */
  /* for the condition to become signaled.      */

  HANDLE waiters_done_;
  /* An auto reset event used by the broadcast/signal */
  /* thread to wait for all the waiting thread(s) to  */
  /* wake up and be released from the semaphore.      */

  size_t was_broadcast_;
  /* Keeps track of whether we were broadcasting      */
  /* or signaling.  This allows us to optimize the    */
  /* code if we're just signaling.                    */
} pthread_cond_t;


/* Use a Win32 Mutex type for the POSIX pthread_mutex_t; */
typedef HANDLE pthread_mutex_t;
typedef void pthread_condattr_t ; /* unused */

RT_LNK int pthread_cond_init (pthread_cond_t *, const pthread_condattr_t * ) ;
RT_LNK int pthread_cond_wait (pthread_cond_t *, pthread_mutex_t );
RT_LNK int pthread_cond_timedwait (pthread_cond_t *, pthread_mutex_t, int);
RT_LNK int pthread_cond_broadcast (pthread_cond_t *);
RT_LNK int pthread_cond_signal (pthread_cond_t *cv);
RT_LNK int pthread_cond_destroy (pthread_cond_t *cv) ;

#endif  /* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif  /* _eif_cond_var_h_ */
