/*
	description: "Condtion variable management routines."
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
doc:<file name="eif_cond_var.c" header="eif_cond_var.h" version="$Id$" summary="Condition variable management routine for Windows.">
*/

#include "eif_cond_var.h"
#ifdef EIF_THREADS

int pthread_cond_init (pthread_cond_t *cv, const pthread_condattr_t* unused)
{
  cv->waiters_ = 0;
  cv->was_broadcast_ = 0;
  cv->sema_ = 
	  CreateSemaphore (0, /* no security */
                        0, /* non-signaled */
                        0x7fffffff, /* max count */
                        0); /* unnamed  */

  InitializeCriticalSection (&cv->waiters_lock_);

  cv->waiters_done_ = 
	  CreateEvent (0, /* no security */
                   FALSE, /* auto-reset */
                   FALSE, /* non-signaled  */
                   NULL); /* unnamed */
  return 0;
}

int pthread_cond_destroy (pthread_cond_t *cv)
{								   
	CloseHandle(cv->sema_);
	DeleteCriticalSection (&cv->waiters_lock_);
	CloseHandle(cv->waiters_done_);
	return 0;
}

int pthread_cond_wait (pthread_cond_t *cv, pthread_mutex_t external_mutex)
{
	DWORD result = 0;

		/* It's ok to increment the number   */
		/* of waiters since <external_mutex> */
		/* must be locked by the caller.     */
	cv->waiters_++;

#if defined (SIGNAL_OBJECT_AND_WAIT) /* NT 4.0 only */
		/* This call will automatically release     */
		/* the mutex and wait on the semaphore      */
		/* until cond_signal() or cond_broadcast()  */
		/* are called by another thread.            */
	result = SignalObjectAndWait (external_mutex, cv->sema_, INFINITE, FALSE);

#else /* NT 3.51 or Win95 */
		/* Keep the lock held just long enough to        */
		/* increment the count of waiters by one.        */
		/* We can't keep it held across the call         */
		/* to WaitForSingleObject() since that will      */
		/* deadlock other calls to pthread_cond_signal() */
		/* and pthread_cond_broadcast().                 */
	ReleaseMutex (external_mutex);

	/* Wait to be awakened by a pthread_cond_signal() or */
	/* pthread_cond_broadcast().                         */
	result = WaitForSingleObject (cv->sema_, INFINITE);

#endif /* SIGNAL_OBJECT_AND_WAIT */

	if (result != WAIT_FAILED) {
			/* Reacquire lock to avoid race conditions.*/
		EnterCriticalSection (&cv->waiters_lock_);

			/* We're no longer waiting...*/
		cv->waiters_--;

			/* If we're the last waiter thread            */
			/* during this particular broadcast then      */
			/* let all the other threads proceed.         */
		if (cv->was_broadcast_ && cv->waiters_ == 0) {
			SetEvent (cv->waiters_done_); 
		}
		
		LeaveCriticalSection (&cv->waiters_lock_);
	}

		/* Always regain the external mutex since that's */
		/* the guarantee that we give to our callers.    */
	WaitForSingleObject (external_mutex, INFINITE); 

	return (result == WAIT_FAILED ? WAIT_FAILED : 0);
}

int pthread_cond_timedwait (pthread_cond_t *cv, pthread_mutex_t external_mutex, int timeout)
{
	DWORD result = 0;

		/* It's ok to increment the number   */
		/* of waiters since <external_mutex> */
		/* must be locked by the caller.     */
	cv->waiters_++;

#if defined (SIGNAL_OBJECT_AND_WAIT) /* NT 4.0 only */
		/* This call will automatically release     */
		/* the mutex and wait on the semaphore      */
		/* until cond_signal() or cond_broadcast()  */
		/* are called by another thread.            */
	result = SignalObjectAndWait (external_mutex, cv->sema_, timeout, FALSE);
#else /* NT 3.51 or Win95 */
		/* Keep the lock held just long enough to        */
		/* increment the count of waiters by one.        */
		/* We can't keep it held across the call         */
		/* to WaitForSingleObject() since that will      */
		/* deadlock other calls to pthread_cond_signal() */
		/* and pthread_cond_broadcast().                 */
	ReleaseMutex (external_mutex);

		/* Wait to be awakened by a pthread_cond_signal() or */
		/* pthread_cond_broadcast().                         */
	result = WaitForSingleObject (cv->sema_, timeout);

#endif /* SIGNAL_OBJECT_AND_WAIT */
	

	if (result != WAIT_FAILED) {
			/* Reacquire lock to avoid race conditions.*/
		EnterCriticalSection (&cv->waiters_lock_);

		/* We're no longer waiting...*/
		cv->waiters_--;

		/* If we're the last waiter thread            */
		/* during this particular broadcast then      */
		/* let all the other threads proceed.         */
		if (cv->was_broadcast_ && cv->waiters_ == 0) {
			SetEvent (cv->waiters_done_); 
		}
		
		LeaveCriticalSection (&cv->waiters_lock_);
	}

	/* Always regain the external mutex since that's */
	/* the guarantee that we give to our callers.    */

	WaitForSingleObject (external_mutex, INFINITE); 

	return result; 

	/* Return Code 	Description 																*/
	/* WAIT_ABANDONED 	The specified object is a mutex object that was not released  			*/
	/*				   	by the thread that owned the mutex object before the owning 			*/
	/*				   	thread terminated. Ownership of the mutex object is granted 			*/
	/*				   	to the calling thread, and the mutex is set to nonsignaled. 			*/
	/* WAIT_OBJECT_0 	The state of the specified object is signaled. 							*/
	/* WAIT_TIMEOUT 	The time-out interval elapsed, and the object's state is nonsignaled. 	*/
	/*  																						*/
	/* ( only for SignalObjectAndWait ... 														*/
  	/*	   WAIT_IO_COMPLETION 	 																*/
	/*				   The wait was ended by one or more user-mode asynchronous 				*/
	/*				   procedure calls (APC) queued to the thread. 								*/
	/* )																						*/
	/* If the function fails, the return value is WAIT_FAILED.  								*/
	/* ... 																						*/

}

int pthread_cond_signal (pthread_cond_t *cv)
{
  /* If there aren't any waiters, then this */
  /* is a no-op.                            */

  if (cv->waiters_ > 0)
    ReleaseSemaphore (cv->sema_, 1, 0);

  return 0; 
}


int pthread_cond_broadcast (pthread_cond_t *cv)
{
  /* If there aren't any waiters, then this   */
  /* is a no-op.                              */

  if (cv->waiters_ == 0)
    return 0; 
  else 
    /* We are broadcasting, even if there     */
    /* is just one waiter...                  */
    {
      int result = 0;
      /* Record that we are broadcasting.     */
      /* This helps optimize cond_wait().     */
      cv->was_broadcast_ = 1;

      /* Wake up all the waiters.             */
      ReleaseSemaphore (cv->sema_, 
                          cv->waiters_, 0);

      /* Wait for all the awakened threads to */
      /* acquire the counting semaphore.      */
      WaitForSingleObject (cv->waiters_done_, 
                             INFINITE);
      cv->was_broadcast_ = 0;

	  return 0;
    }
    return 1; 
}

#endif

/*
doc:</file>
*/
