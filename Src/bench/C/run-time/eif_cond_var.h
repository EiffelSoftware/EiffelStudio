#ifndef _eif_cond_var_h_
#define _eif_cond_var_h_

#ifdef EIF_THREADS

#include <windows.h>
#include <process.h>

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

extern int pthread_cond_init (pthread_cond_t *,const pthread_condattr_t * ) ;
extern int pthread_cond_wait (pthread_cond_t *, pthread_mutex_t );
extern int pthread_cond_broadcast (pthread_cond_t *);
extern int pthread_cond_signal (pthread_cond_t *cv);
extern int pthread_cond_destroy (pthread_cond_t *cv) ;

#endif  /* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif  /* _eif_cond_var_h_ */
