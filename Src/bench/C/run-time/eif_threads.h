/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

 #####  #    #  #####   ######    ##    #####    ####           #    #
   #    #    #  #    #  #        #  #   #    #  #               #    #
   #    ######  #    #  #####   #    #  #    #   ####           ######
   #    #    #  #####   #       ######  #    #       #   ###    #    #
   #    #    #  #   #   #       #    #  #    #  #    #   ###    #    #
   #    #    #  #    #  ######  #    #  #####    ####    ###    #    #

	Thread management routines.

*/

#ifndef _eif_threads_h_
#define _eif_threads_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_cecil.h"		/* Needed for EIF_OBJ,... definitions */

extern void eif_thr_panic(char *);
extern EIF_POINTER eif_thr_freeze(EIF_OBJ object);
extern void eif_thr_unfreeze(EIF_OBJ object);
extern EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
extern EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
extern void eif_thr_proxy_dispose(EIF_POINTER);

#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

/* Tuning for FSU POSIX Threads */
#ifdef EIF_FSUTHREADS
#define HASNT_SCHED_H
#define EIF_POSIX_THREADS
#define EIF_NONPOSIX_TSD
#define HASNT_SCHEDPARAM
#define EIF_THR_SET_PRIO attr.prio = pr
#define pthread_attr_setschedpolicy pthread_attr_setsched
#define EIF_THR_SET_DETACHSTATE(attr,detach) \
	{int idetach = (int) detach; pthread_attr_setdetachstate (&attr, &idetach);}
#define EIF_MAX_PRIORITY 101
#endif

/* Tuning for POSIX LinuxThreads */
#ifdef EIF_LINUXTHREADS
#define EIF_POSIX_THREADS
#ifndef EIF_DFLT SIGUSR
#	define EIF_DFLT_SIGUSR 	/* SIGUSR1&2 are used in inter-thread com */?
#endif	/* EIF_DFLT_SIGUSR */
#endif

/* Tuning for POSIX PCThreads */
#ifdef EIF_PCTHREADS
#define HASNT_SCHED_H
#define EIF_POSIX_THREADS
#define EIF_NONPOSIX_TSD
#define EIF_SCHEDPARAM_EXTRA param.sched_quantum = 2; /* bug in PCThreads */
#define EIF_DEFAULT_PRIORITY 16
#endif

/* Tuning for CRAY */
#ifdef _CRAY
#define EIF_NO_SEM
#define EIF_NO_POSIX_SEM
#define HASNT_SCHED_H
#define HASNT_SCHEDPARAM
#define pthread_attr_setschedpolicy(a,b)
#endif

/* Tuning for Solaris Threads */
#if defined SOLARIS_THREADS
#define HAS_SEMA
#endif

/* Tuning for VxWorks */
#ifdef VXWORKS
#define EIF_NO_CONDVAR
#define EIF_NO_POSIX_SEM
	/* This can change if VxWorks compiled with option POSIX_SEM */
#endif

/* Tuning for Windows */
#ifdef EIF_WIN32
#define EIF_NO_POSIX_SEM
#endif

/* Tuning for Unixware threads */
#ifdef UNIXWARE_THREADS
#ifndef EIF_DFLT_SIGWAITING
#	define EIF_DFLT_SIGWAITING
#endif	/* EIF_DFLT_SIGWAITING */
#define SOLARIS_THREADS
#define NEED_SYNCH_H
#define HASNT_SCHED_H
#define HASNT_SEMAPHORE_H
#define HAS_SEMA
#endif


/* Exported functions */
extern void eif_thr_init_root(void);
extern void eif_thr_register(void);
extern unsigned int eif_thr_is_initialized(void);
extern EIF_BOOLEAN eif_thr_is_root(void);
extern void eif_thr_create(EIF_OBJ, EIF_POINTER);
extern void eif_thr_exit(void);
extern void eif_thr_yield(void);
extern void eif_thr_join_all(void);
extern void eif_thr_join(EIF_POINTER);
extern void eif_thr_wait(EIF_BOOLEAN *);
extern void eif_thr_create_with_args(EIF_OBJ, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_BOOLEAN);
extern EIF_INTEGER eif_thr_default_priority(void);
extern EIF_INTEGER eif_thr_min_priority(void);
extern EIF_INTEGER eif_thr_max_priority(void);
extern EIF_POINTER eif_thr_thread_id(void);
extern EIF_POINTER eif_thr_last_thread(void);

/* Mutex functions at end of file */
/* (need some macros defined below) */

/* Constants common to all platforms */

#define EIF_SCHED_DEFAULT 0
#define EIF_SCHED_OTHER   1
#define EIF_SCHED_FIFO    2  /* FIFO scheduling        */
#define EIF_SCHED_RR      3  /* Round-robin scheduling */

/* Defaults for condition variables */
#ifdef EIF_NO_CONDVAR
#define EIF_COND_TYPE		unsigned char
#else	
#define EIF_COND_TYPE pthread_cond_t
#endif	


/* --------------------------------------- */

#ifdef EIF_POSIX_THREADS
/*-----------------------*/
/*---  POSIX Threads  ---*/
/*-----------------------*/

/* Includes */
#include <pthread.h>
#ifndef HASNT_SCHED_H
#include <sched.h>
#endif

#ifdef NEED_SYNCH_H
#include <synch.h>
#endif

/* Types */
#define EIF_THR_TYPE            pthread_t
#define EIF_MUTEX_TYPE          pthread_mutex_t
#define EIF_TSD_TYPE            pthread_key_t

/* Constants */
#ifndef EIF_DEFAULT_PRIORITY
#define EIF_DEFAULT_PRIORITY 0
#endif

#ifndef EIF_MIN_PRIORITY
#define EIF_MIN_PRIORITY 0
#endif

#ifndef EIF_MAX_PRIORITY
#define EIF_MAX_PRIORITY 255
#endif


#elif defined EIF_WIN32

/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/

#include <windows.h>

#define EIF_MIN_PRIORITY 0			/*  - not used */
#define EIF_MAX_PRIORITY 1000		/* - not used  */
#define EIF_DEFAULT_PRIORITY 0		/* - not used  */


/* Types */

#define EIF_THR_TYPE            HANDLE
#define EIF_MUTEX_TYPE          HANDLE
#define EIF_TSD_TYPE            DWORD

#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#define EIF_THR_CREATION_FLAGS THR_NEW_LWP | THR_DETACHED
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY INT_MAX
#define EIF_DEFAULT_PRIORITY 0
#define EIF_THR_ATTR_DESTROY(attr)


/* Types */

#define EIF_THR_TYPE            thread_t
#define EIF_MUTEX_TYPE          mutex_t
#define EIF_TSD_TYPE            thread_key_t
#ifndef EIF_NO_CONDVAR
#define pthread_cond_t			cond_t
#endif

#elif defined VXWORKS

/*-------------------------*/
/*---  VXWORKS Threads  ---*/
/*-------------------------*/


/* Constants */
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY 255
#define EIF_DEFAULT_PRIORITY	99
#define EIF_THR_CREATION_FLAGS	VX_FP_TASK

/* Types */
#define EIF_THR_TYPE            int
#define EIF_THR_ATTR_TYPE       int
#define EIF_TSD_TYPE            eif_global_context_t *

#else

#error Sorry, this platform does not support multithreading

#endif	/* end of POSIX, WIN32, SOLARIS_THREADS, VXWORKS... */


/* 
 * Structure used to give arguments to a new thread
 */
 
/*--------------------------*/
/*---  Mutex operations  ---*/
/*--------------------------*/

extern EIF_POINTER eif_thr_mutex_create(void);
extern void eif_thr_mutex_lock(EIF_POINTER mutex_pointer);
extern void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer);
extern EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer);
extern void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer);

/*------------------------------*/
/*---  Semaphore operations  ---*/
/*------------------------------*/

extern EIF_POINTER eif_thr_sem_create (EIF_INTEGER count);
extern void eif_thr_sem_wait (EIF_POINTER sem);
extern void eif_thr_sem_post (EIF_POINTER sem);
extern EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem);
extern void eif_thr_sem_destroy (EIF_POINTER sem);

/*---------------------------------------*/
/*---  Condition variable operations  ---*/
/*---------------------------------------*/

extern EIF_POINTER eif_thr_cond_create (void);
extern void eif_thr_cond_broadcast (EIF_POINTER cond);
extern void eif_thr_cond_signal (EIF_POINTER cond);
extern void eif_thr_cond_wait (EIF_POINTER cond, EIF_POINTER mutex);
extern void eif_thr_cond_destroy (EIF_POINTER cond);

typedef struct thr_list_struct {
    EIF_OBJ thread;
    struct thr_list_struct *next;
} thr_list_t;

/* 
 * Structure used to give arguments to a new thread
 */
 
typedef struct {
    EIF_OBJ current;
    EIF_POINTER routine;
    EIF_MUTEX_TYPE *children_mutex;
    thr_list_t **addr_thr_list;
    int *addr_n_children;
#ifndef EIF_NO_CONDVAR
    EIF_COND_TYPE *children_cond;
#endif  
    EIF_THR_TYPE *tid;
} start_routine_ctxt_t;

#else

/*---------------------------------------*/
/*---  No multi-threaded environment  ---*/
/*---------------------------------------*/

#endif	/* EIF_THREADS */

/* Once per thread management */
/* MTOG = MT Once Get */
/* MTOS = MT Once Set */

#define MTOG(result_type,item,result)	result = result_type item
#define MTOS(item,val)					item = (char *) val

/* --------------------------------------- */

#ifdef __cplusplus
}
#endif

#endif	/* _eif_threads_h_ */
