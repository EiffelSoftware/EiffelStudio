/*
	description: "Thread management routines."
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

#ifndef _eif_posix_threads_h_
#define _eif_posix_threads_h_

#ifdef EIF_THREADS

#include "eif_portable.h"

/*------------------------------------*/
/*----- Platform specific tuning -----*/
/*------------------------------------*/

#ifdef EIF_LINUXTHREADS		/* Tuning for POSIX LinuxThreads */
#define EIF_POSIX_THREADS
#ifndef EIF_DFL_SIGUSR
#define EIF_DFLT_SIGUSR
#endif
#endif

#ifdef EIF_WINDOWS
#define EIF_NO_NATIVE_COND
#define EIF_NO_POSIX_SEM
#endif

#ifdef VXWORKS				/* Tuning for VxWorks */
#define EIF_NO_NATIVE_COND
#define EIF_NO_POSIX_SEM
#endif

#ifdef EIF_VMS			/* VMS supports POSIX 1003.1c threads */
#define EIF_POSIX_THREADS
#define HASNT_SCHED_H
#define HASNT_SEMAPHORE_H
#endif

/* POSIX specifics. */
#ifdef EIF_POSIX_THREADS
#define HAS_THREAD_CANCELLATION
#define EIF_THR_CANCEL(tid)	pthread_cancel(tid)
/*
 * Posix 1003.1b signals
 */
#if (_POSIX_C_SOURCE==199309L)
#ifdef SIGRTMIN
#define EIF_DFLT_SIGRTMIN
#endif
#ifdef SIGRTMAX
#define EIF_DFLT_SIGRTMAX
#endif
#endif /* _POSIX_C_SOURCE */

/*
 * Signals reserved for Posix 1003.1c.
 */
#if (_POSIX_C_SOURCE==199506L)
#ifdef SIGPTINTR
#define EIF_DFLT_SIGPTINTR
#endif
#ifdef SIGPTRESCHED
#define EIF_DFLT_SIGPTRESCHED
#endif
#endif /* _POSIX_C_SOURCE */
#endif



/*---------------------------*/
/*---- Header inclusion -----*/
/*---------------------------*/

#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)

#ifdef EIF_POSIX_THREADS
#include <pthread.h>
#elif defined(SOLARIS_THREADS)
#include <thread.h>
#endif

#ifndef HASNT_SCHED_H
#include <sched.h>
#endif

#ifdef NEED_SYNCH_H
#include <synch.h>
#endif

#elif defined EIF_WINDOWS
#include <windows.h>
#include <process.h>

#elif defined VXWORKS
#include <taskLib.h>        /* 'thread' operations */
#include <taskVarLib.h>     /* 'thread' 'specific data' */
#include <semLib.h>         /* 'mutexes' and semaphores */
#include <sched.h>          /* 'sched_yield' */

#endif

#ifndef EIF_NO_POSIX_SEM	/* Defaults for semaphore */
#ifndef HASNT_SEMAPHORE_H
#include <semaphore.h>
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*------------------------------*/
/*-----  Type definitions  -----*/
/*------------------------------*/

rt_public typedef struct {
	rt_uint_ptr	priority;
	rt_uint_ptr stack_size;
} EIF_THR_ATTR_TYPE;

#ifdef EIF_POSIX_THREADS
#define EIF_THR_TYPE            pthread_t
#define EIF_CS_TYPE				pthread_mutex_t
#define EIF_MUTEX_TYPE          pthread_mutex_t
#define EIF_SEM_TYPE			sem_t
#define EIF_COND_TYPE			pthread_cond_t
#define EIF_RWL_TYPE			pthread_rwlock_t

#elif defined SOLARIS_THREADS
#define EIF_THR_TYPE            thread_t
#define EIF_CS_TYPE				lwp_mutex_t
#define EIF_MUTEX_TYPE          mutex_t
#define EIF_SEM_TYPE			sema_t
#define EIF_COND_TYPE			cond_t
#define EIF_RWL_TYPE			rwlock_t

#elif defined(EIF_WINDOWS)
#define EIF_THR_TYPE            HANDLE
#define EIF_CS_TYPE				CRITICAL_SECTION
#define EIF_MUTEX_TYPE          HANDLE
#define EIF_SEM_TYPE            HANDLE

#elif defined VXWORKS
/* For consistency with the other platforms, EIF_.._TYPE shouldn't
   be a pointer, that's why we use struct semaphore instead of SEM_ID
   because SEM_ID is equivalent to (struct semaphore *) */
#define EIF_THR_TYPE            int
#define EIF_CS_TYPE				struct semaphore
#define EIF_MUTEX_TYPE			struct semaphore
#define EIF_SEM_TYPE            struct semaphore
#endif

#ifdef EIF_NO_NATIVE_COND
rt_public typedef struct {
		/* Semaphore used to queue up threads waiting for the condition to become signaled. */
	EIF_SEM_TYPE *semaphore;
		/* Serialize access to fields of Current. */
	EIF_CS_TYPE *csection;
		/* Number of waiters. */
	unsigned long num_waiting;
		/* Number of already awoken. */
	unsigned long num_wake;
		/* Number of time we signaled/broadcasted for improving fairness.
		 * This ensures one thread won't steal wakeups from other threads in queue. */
	unsigned long generation;
} EIF_COND_TYPE;
#endif

/* Definition of Read/Write lock structure for platforms that do not provide one. */
#ifdef EIF_POSIX_THREADS 
#elif defined(SOLARIS_THREADS)
#else
rt_public typedef struct {
	EIF_MUTEX_TYPE *m; /* Internal monitor lock. */
	int rwlock; /* >0 = # readers, <0 = writer, 0 = none */ 
	EIF_COND_TYPE *readers_ok; /* Start waiting readers. */
	unsigned int waiting_writers; /* Number of waiting writers. */
	EIF_COND_TYPE *writers_ok; /* Start a waiting writer. */
} EIF_RWL_TYPE;
#endif

#define EIF_MIN_THR_PRIORITY			0L
#define EIF_BELOW_NORMAL_THR_PRIORITY	100L
#define EIF_DEFAULT_THR_PRIORITY		127L
#define EIF_ABOVE_NORMAL_THR_PRIORITY	154L
#define EIF_MAX_THR_PRIORITY			255L

/* Thread routines */
extern int eif_pthread_create (EIF_THR_TYPE *thread_id, EIF_THR_ATTR_TYPE *thread_attr, void (*thread_routine) (void *), void *thread_arg);
extern int eif_pthread_kill (EIF_THR_TYPE thread_id);
extern int eif_pthread_exit (void *value_ptr);
extern int eif_pthread_yield (void);
extern EIF_THR_TYPE eif_pthread_self (void);
extern int eif_pthread_join (EIF_THR_TYPE thread_id);
extern int eif_pthread_set_priority (EIF_THR_TYPE thread_id, rt_uint_ptr priority);
extern int eif_pthread_get_priority (EIF_THR_TYPE thread_id, rt_uint_ptr *priority);

/* Mutex */
extern int eif_pthread_mutex_create (EIF_MUTEX_TYPE **mutex);
extern int eif_pthread_mutex_destroy (EIF_MUTEX_TYPE *mutex);
extern int eif_pthread_mutex_lock (EIF_MUTEX_TYPE *mutex);
extern int eif_pthread_mutex_trylock (EIF_MUTEX_TYPE *mutex);
extern int eif_pthread_mutex_unlock (EIF_MUTEX_TYPE *mutex);

/* Semaphore */
extern int eif_pthread_sem_create (EIF_SEM_TYPE ** sem, int shared, unsigned int count);
extern int eif_pthread_sem_destroy (EIF_SEM_TYPE * sem);
extern int eif_pthread_sem_wait (EIF_SEM_TYPE * sem);
extern int eif_pthread_sem_trywait (EIF_SEM_TYPE * sem);
extern int eif_pthread_sem_post (EIF_SEM_TYPE * sem);


/* Condition variables */
extern int eif_pthread_cond_create (EIF_COND_TYPE ** condvar);
extern int eif_pthread_cond_destroy (EIF_COND_TYPE *condvar);
extern int eif_pthread_cond_wait (EIF_COND_TYPE *condvar, EIF_MUTEX_TYPE *mutex);
extern int eif_pthread_cond_wait_with_timeout (EIF_COND_TYPE *condvar, EIF_MUTEX_TYPE *mutex, rt_uint_ptr timeout);
extern int eif_pthread_cond_signal (EIF_COND_TYPE *condvar);
extern int eif_pthread_cond_broadcast (EIF_COND_TYPE *condvar);

/* Read/write lock */
extern int eif_pthread_rwlock_create(EIF_RWL_TYPE **rwlp);
extern int eif_pthread_rwlock_rdlock (EIF_RWL_TYPE *rwlp);
extern int eif_pthread_rwlock_tryrdlock (EIF_RWL_TYPE *rwlp);
extern int eif_pthread_rwlock_wrlock (EIF_RWL_TYPE *rwlp);
extern int eif_pthread_rwlock_trywrlock (EIF_RWL_TYPE *rwlp); 
extern int eif_pthread_rwlock_unlock (EIF_RWL_TYPE *rwlp);
extern int eif_pthread_rwlock_destroy (EIF_RWL_TYPE * rwlp);

/* Critical section */
extern int eif_pthread_cs_create (EIF_CS_TYPE **section, rt_uint_ptr spin_count);
extern int eif_pthread_cs_destroy (EIF_CS_TYPE *section);
extern int eif_pthread_cs_lock (EIF_CS_TYPE *section);
extern int eif_pthread_cs_trylock (EIF_CS_TYPE *section);
extern int eif_pthread_cs_unlock (EIF_CS_TYPE *section);

#ifdef __cplusplus
}
#endif

#endif

#endif
