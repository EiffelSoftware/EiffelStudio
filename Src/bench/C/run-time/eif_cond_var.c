/*
 
 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######
 
  ####    ####   #    #  #####           #    #    ##    #####            ####
 #    #  #    #  ##   #  #    #          #    #   #  #   #    #          #    #
 #       #    #  # #  #  #    #          #    #  #    #  #    #          #
 #       #    #  #  # #  #    #          #    #  ######  #####    ###    #
 #    #  #    #  #   ##  #    #           #  #   #    #  #   #    ###    #    #
  ####    ####   #    #  #####  #######    ##    #    #  #    #   ###     ####

	Condtion variable management routines.

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
  /* It's ok to increment the number   */
  /* of waiters since <external_mutex> */
  /* must be locked by the caller.     */
  cv->waiters_++;

#if defined (SIGNAL_OBJECT_AND_WAIT) /* NT 4.0 only */
  /* This call will automatically release     */
  /* the mutex and wait on the semaphore      */
  /* until cond_signal() or cond_broadcast()  */
  /* are called by another thread.            */
  SignalObjectAndWait (external_mutex,
                         cv->sema_,
                         INFINITE, FALSE);
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
  WaitForSingleObject (cv->sema_, INFINITE);

#endif /* SIGNAL_OBJECT_AND_WAIT */

  /* Reacquire lock to avoid race conditions.*/
  EnterCriticalSection (&cv->waiters_lock_);

  /* We're no longer waiting...*/
  cv->waiters_--;

  /* If we're the last waiter thread            */
  /* during this particular broadcast then      */
  /* let all the other threads proceed.         */
  if (cv->was_broadcast_ && cv->waiters_ == 0)  
    SetEvent (cv->waiters_done_); 
  
  LeaveCriticalSection (&cv->waiters_lock_);


  /* Always regain the external mutex since that's */
  /* the guarantee that we give to our callers.    */

  WaitForSingleObject (external_mutex, INFINITE); 

  return 0; 
}

int pthread_cond_timedwait (pthread_cond_t *cv, pthread_mutex_t external_mutex, int timeout)
{
  int result;
  int bTimedOut;

  result = 0;
  bTimedOut = 0;

  /* It's ok to increment the number   */
  /* of waiters since <external_mutex> */
  /* must be locked by the caller.     */
  cv->waiters_++;

#if defined (SIGNAL_OBJECT_AND_WAIT) /* NT 4.0 only */
  /* This call will automatically release     */
  /* the mutex and wait on the semaphore      */
  /* until cond_signal() or cond_broadcast()  */
  /* are called by another thread.            */
  bTimedOut = SignalObjectAndWait (external_mutex,
                         cv->sema_,
                         timeout, FALSE);
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
  bTimedOut = WaitForSingleObject (cv->sema_, timeout);

#endif /* SIGNAL_OBJECT_AND_WAIT */
  

  /* Reacquire lock to avoid race conditions.*/
  EnterCriticalSection (&cv->waiters_lock_);

  /* We're no longer waiting...*/
  cv->waiters_--;

  /* If we're the last waiter thread            */
  /* during this particular broadcast then      */
  /* let all the other threads proceed.         */
  if (cv->was_broadcast_ && cv->waiters_ == 0)  
    SetEvent (cv->waiters_done_); 
  
  LeaveCriticalSection (&cv->waiters_lock_);

  /* Always regain the external mutex since that's */
  /* the guarantee that we give to our callers.    */

  WaitForSingleObject (external_mutex, INFINITE); 

  return bTimedOut;
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
