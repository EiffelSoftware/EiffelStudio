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

#include "eif_cecil.h"		/* Needed for EIF_OBJECT,... definitions */

RT_LNK void eif_thr_panic(char *);
RT_LNK EIF_POINTER eif_thr_freeze(EIF_OBJECT object);
RT_LNK void eif_thr_unfreeze(EIF_OBJECT object);
RT_LNK EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
RT_LNK EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
RT_LNK void eif_thr_proxy_dispose(EIF_POINTER);

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
#ifndef EIF_DFL_SIGUSR
#define EIF_DFLT_SIGUSR
#endif  /* EIF_DFLT_SIGUSR */
#endif

/* Tuning for POSIX PCThreads */
#ifdef EIF_PCTHREADS
#define HASNT_SCHED_H
#ifdef SIGVTARLARM
#define EIF_DFLT_SIGVTALARM
#endif /* SIGVTARLARM */
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

/* Defaults for semaphores */
#ifndef EIF_NO_POSIX_SEM

#ifndef HASNT_SEMAPHORE_H 
#include <semaphore.h>
#endif /* semaphore.h */

#define EIF_SEM_TYPE    sem_t
#define EIF_SEM_INIT(sem,count,msg) \
    if (sem_init (sem, 0, (unsigned int) count)) eraise (msg, EN_EXT)
#define EIF_SEM_CREATE(sem,count,msg) \
    sem = (EIF_SEM_TYPE *) eif_malloc (sizeof(EIF_SEM_TYPE)); \
    if (!sem) eraise ("Can't allocate memory for semaphore", EN_OMEM); \
    EIF_SEM_INIT(sem,count,msg)
#define EIF_SEM_POST(sem,msg) \
    if (sem_post (sem)) eraise (msg, EN_EXT)
#define EIF_SEM_WAIT(sem,msg) \
    if (sem_wait (sem)) eraise (msg, EN_EXT)
#define EIF_SEM_TRYWAIT(sem,r,msg) \
    r = sem_trywait (sem)
#define EIF_SEM_DESTROY(sem,msg) \
    EIF_SEM_DESTROY0(sem,msg); eif_free(sem)
#define EIF_SEM_DESTROY0(sem,msg) \
    if (sem_destroy(sem)) eraise(msg, EN_EXT)
#endif

#ifdef  HAS_SEMA
#define sem_t                   sema_t
#define sem_init(sem,shr,count) sema_init(sem,count,USYNC_THREAD,0)
#define sem_post                sema_post
#define sem_wait                sema_wait
#define sem_trywait             sema_trywait
#define sem_destroy             sema_destroy
#endif




/* Exported functions */
RT_LNK void eif_thr_init_root(void);
RT_LNK void eif_thr_register(void);
RT_LNK unsigned int eif_thr_is_initialized(void);
RT_LNK EIF_BOOLEAN eif_thr_is_root(void);
RT_LNK void eif_thr_create(EIF_OBJECT, EIF_POINTER);
RT_LNK void eif_thr_exit(void);
RT_LNK void eif_thr_yield(void);
RT_LNK void eif_thr_join_all(void);
RT_LNK void eif_thr_join(EIF_POINTER);
RT_LNK void eif_thr_wait(EIF_BOOLEAN *);
RT_LNK void eif_thr_create_with_args(EIF_OBJECT, EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_BOOLEAN);
RT_LNK EIF_INTEGER eif_thr_default_priority(void);
RT_LNK EIF_INTEGER eif_thr_min_priority(void);
RT_LNK EIF_INTEGER eif_thr_max_priority(void);
RT_LNK EIF_POINTER eif_thr_thread_id(void);
RT_LNK EIF_POINTER eif_thr_last_thread(void);

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
#define EIF_COND_ATTR_TYPE  unsigned char
#define EIF_COND_INIT(cond, msg)
#define EIF_COND_CREATE(cond, msg)
#define EIF_COND_WAIT(cond, mutex, msg)
#define EIF_COND_BROADCAST(cond, msg)
#define EIF_COND_SIGNAL(cond, msg)
#define EIF_COND_DESTROY(cond, msg)
#else /* EIF_NO_CONDVAR */
#define EIF_COND_TYPE pthread_cond_t
#define EIF_COND_ATTR_TYPE      pthread_condattr_t
#define EIF_COND_CREATE(pcond, msg) \
    pcond = (EIF_COND_TYPE *) eif_malloc (sizeof(EIF_COND_TYPE)); \
    if (!(pcond)) eraise("cannot allocate memory for cond. variable", EN_OMEM); \
    EIF_COND_INIT(pcond,msg)
#define EIF_COND_INIT(pcond, msg) \
    if (pthread_cond_init (pcond, NULL)) eraise (msg, EN_EXT)
#define EIF_COND_WAIT(pcond, pmutex, msg) \
    if (pthread_cond_wait (pcond, pmutex)) eraise (msg, EN_EXT)
#define EIF_COND_BROADCAST(pcond, msg) \
    if (pthread_cond_broadcast (pcond)) eraise (msg, EN_EXT)
#define EIF_COND_SIGNAL(pcond, msg) \
    if (pthread_cond_signal (pcond)) eraise (msg, EN_EXT)
#define EIF_COND_DESTROY(pcond, msg) \
    if (pthread_cond_destroy (pcond)) eraise (msg, EN_EXT)
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
#define EIF_THR_ENTRY_TYPE      void *
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       pthread_attr_t
#define EIF_TSD_VAL_TYPE        void *
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

/* Thread attributes initialization macros */
#ifndef EIF_NO_SCHED
#define EIF_THR_SET_SCHED(attr,sc) \
    switch(sc) { \
        case EIF_SCHED_OTHER: \
            pthread_attr_setschedpolicy(&attr,SCHED_OTHER); break; \
        case EIF_SCHED_RR: \
            pthread_attr_setschedpolicy(&attr,SCHED_RR); break; \
        case EIF_SCHED_FIFO: \
            pthread_attr_setschedpolicy(&attr,SCHED_FIFO); break; }
#else
#define EIF_THR_SET_SCHED(a,b)
#endif
#ifndef EIF_THR_SET_DETACHSTATE
#define EIF_THR_SET_DETACHSTATE(attr,detach) \
    pthread_attr_setdetachstate(&attr, \
        detach ? PTHREAD_CREATE_DETACHED : PTHREAD_CREATE_JOINABLE);
#endif

#ifdef HASNT_SCHEDPARAM
#ifndef EIF_THR_SET_PRIO
#define EIF_THR_SET_PRIO(p)
#endif
#define EIF_THR_ATTR_INIT(attr,pr,sc,detach) \
    pthread_attr_init(&(attr)); \
    EIF_THR_SET_PRIO(pr); \
    EIF_THR_SET_SCHED(attr,sc) \
    EIF_THR_SET_DETACHSTATE(attr,detach)
#else
#ifndef EIF_SCHEDPARAM_EXTRA
#define EIF_SCHEDPARAM_EXTRA
#endif
#define EIF_THR_ATTR_INIT(attr,pr,sc,detach) \
    pthread_attr_init(&(attr)); \
    { struct sched_param param; \
    param.sched_priority = pr;  \
    EIF_SCHEDPARAM_EXTRA \
    pthread_attr_setschedparam(&attr, &param); } \
    EIF_THR_SET_SCHED(attr,sc) \
    EIF_THR_SET_DETACHSTATE(attr,detach)
#endif /* HASNT_SCHEDPARAM */

#define EIF_THR_ATTR_DESTROY(attr) pthread_attr_destroy(&attr)

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg) \
    if (pthread_create (&(tid), 0, (entry), (EIF_THR_ENTRY_ARG_TYPE)(arg))) \
        eraise(msg, EN_EXT)
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    if (pthread_create (&tid, &attr, entry, (EIF_THR_ENTRY_ARG_TYPE) arg)) \
        eraise(msg, EN_EXT)
#define EIF_THR_EXIT(arg)           pthread_exit(NULL)
#define EIF_THR_JOIN(which)         pthread_join(which,NULL)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD

#define EIF_THR_SET_PRIORITY(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio)



#define EIF_TSD_CREATE(key,msg)             \
    if (pthread_key_create(&(key),NULL))    \
        eraise(msg, EN_EXT)
#define EIF_TSD_SET(key,val,msg)            \
    if (pthread_setspecific ((key), (EIF_TSD_VAL_TYPE)(val))) \
        eraise(msg, EN_EXT)

/* Thread Specific Data management */
#ifdef EIF_NONPOSIX_TSD
#define EIF_TSD_GET0(val_type,key,val) \
    pthread_getspecific((key), (void *)&(val))
#define EIF_TSD_GET(val_type,key,val,msg) \
    if (EIF_TSD_GET0(val_type,key,val)) eraise(msg, EN_EXT)
#else
#define EIF_TSD_GET0(foo,key,val) (val = pthread_getspecific(key))
#define EIF_TSD_GET(val_type,key,val,msg) \
    if (EIF_TSD_GET0(val_type,key,val) == (void *) 0) eraise(msg, EN_EXT)
#endif
#define EIF_TSD_DESTROY(key,msg, EN_EXT) if (pthread_key_delete(key) eraise(msg, EN_EXT)


/*
 * Posix 1003.1b signals
 */

#ifdef SIGRTMIN
#define EIF_DFLT_SIGRTMIN
#endif
#ifdef SIGRTMAX
#define EIF_DFLT_SIGRTMAX
#endif

/*
 * Signals reserved for Posix 1003.1c.
 */

#ifdef SIGPTINTR
#define EIF_DFLT_SIGPTINTR
#endif
#ifdef SIGPTRESCHED
#define EIF_DFLT_SIGPTRESCHED
#endif

/* Mutex management */

#ifdef _CRAY
#define EIF_MUTEX_INIT(m,msg) \
    { pthread_mutexattr_t mattr = PTHREAD_MUTEX_INITIALIZER; \
    if (pthread_mutex_init(m,&mattr)) eraise(msg, EN_EXT);}
#else /* _CRAY */
#define EIF_MUTEX_INIT(m,msg) \
    if (pthread_mutex_init(m,NULL)) eraise(msg, EN_EXT)
#endif /* _CRAY */

#define EIF_MUTEX_CREATE(m,msg) \
    m = (EIF_MUTEX_TYPE *) eif_malloc(sizeof(EIF_MUTEX_TYPE)); \
    if (!(m)) eraise("cannot allocate memory for mutex creation", EN_OMEM); \
    EIF_MUTEX_INIT(m,msg)
#define EIF_MUTEX_LOCK(m,msg) if (pthread_mutex_lock(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_TRYLOCK(m,r,msg)  \
    r = pthread_mutex_trylock(m);   \
    if (r && (r!=EBUSY)) eraise(msg, EN_EXT)
#define EIF_MUTEX_UNLOCK(m,msg) if (pthread_mutex_unlock(m)) eraise(msg, EN_OMEM)
#define EIF_MUTEX_DESTROY(m,msg) \
    EIF_MUTEX_DESTROY0(m,msg); eif_free(m)
#define EIF_MUTEX_DESTROY0(m,msg) \
    if (pthread_mutex_destroy(m)) eraise(msg, EN_EXT)

	/* tid */
#define EIF_THR_SELF	pthread_self();	/* Return a pthread_t */

#elif defined EIF_WIN32

/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/

#include <windows.h>
#include <process.h>
#include "eif_cond_var.h"

#define EIF_MIN_PRIORITY 0			/*  - not used */
#define EIF_MAX_PRIORITY 1000		/* - not used  */
#define EIF_DEFAULT_PRIORITY 0		/* - not used  */


/* Types */

#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       unsigned char /* FIXME - not used */
#define EIF_TSD_VAL_TYPE        LPVOID
#define EIF_SEM_TYPE            HANDLE
#define EIF_THR_TYPE            HANDLE
#define EIF_MUTEX_TYPE          HANDLE
#define EIF_TSD_TYPE            DWORD

/* Thread attributes initialization macros */
#define EIF_THR_ATTR_INIT(attr,prio,sched,detach) /* FIXME - not used */
#define EIF_THR_ATTR_DESTROY(attr) /* FIXME - not used */

/* Thread control macros */
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    tid=(EIF_THR_TYPE)_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg)); \
    if ((int)tid==-1) eraise(msg, EN_EXT)
#define EIF_THR_CREATE(entry,arg,tid,msg)   \
    tid=(EIF_THR_TYPE)_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg));\
    if ((int)tid==-1) eraise(msg, EN_EXT)
#define EIF_THR_EXIT(arg)                   _endthread()

#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD

#define EIF_THR_SET_PRIORITY(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio)


/* Semaphore management */
#define EIF_SEM_CREATE(sem,count,msg) \
        sem = CreateSemaphore (NULL, (LONG) count, (LONG) 0x7fffffff, NULL);  \
        if (!sem) eraise (msg, EN_EXT)
#define EIF_SEM_POST(sem,msg) \
        if (!ReleaseSemaphore(sem, 1, NULL)) eraise (msg, EN_EXT)
#define EIF_SEM_WAIT(sem,msg) \
        if (WaitForSingleObject(sem, INFINITE)==WAIT_FAILED) \
                eraise (msg, EN_EXT)
#define EIF_SEM_TRYWAIT(sem,r,msg) \
        r = (WaitForSingleObject(sem, 0)); \
        if (r==WAIT_FAILED) eraise (msg, EN_EXT); \
        r = (r!=WAIT_TIMEOUT)
#define EIF_SEM_DESTROY(sem,msg) \
        if (!CloseHandle(sem)) eraise (msg, EN_EXT)

/* Thread Specific Data management */
#define EIF_TSD_CREATE(key,msg) \
    if ((key=TlsAlloc())==0xFFFFFFFF) eraise(msg, EN_EXT)
#define EIF_TSD_SET(key,val,msg) \
    if (!TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))) eraise(msg, EN_EXT)
#define EIF_TSD_GET0(val_type,key,val) \
    val=val_type TlsGetValue(key)
#define EIF_TSD_GET(val_type,key,val,msg) \
    EIF_TSD_GET0(val_type,key,val); \
    if (GetLastError() != NO_ERROR) eraise(msg, EN_EXT)
#define EIF_TSD_DESTROY(key,msg) \
    if (!TlsFree(key)) eraise(msg, EN_EXT)

/* Mutex management */
#define EIF_MUTEX_CREATE(m,msg) \
        m = CreateMutex(NULL,FALSE,NULL); \
        if (!m) eif_thr_panic(msg);
#define EIF_MUTEX_LOCK(m,msg) \
        if (WaitForSingleObject(m, INFINITE) == WAIT_FAILED) \
        eif_thr_panic(msg)
#define EIF_MUTEX_TRYLOCK(m,r,msg)  \
        r = (WaitForSingleObject(m,0)); \
        if (r==WAIT_FAILED) eif_thr_panic(msg); \
        r = (r==WAIT_TIMEOUT)
#define EIF_MUTEX_UNLOCK(m,msg) \
        if (!ReleaseMutex(m)) eif_thr_panic(msg)
#define EIF_MUTEX_DESTROY(m,msg) \
        if (!CloseHandle(m)) eif_thr_panic(msg)


/* tid */
#define EIF_THR_SELF GetCurrentThread ()

#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#include <thread.h>
#ifndef HASNT_SCHED_H
#include <sched.h>
#endif
#ifdef NEED_SYNCH_H
#include <synch.h>
#endif

 /* Types */

rt_public typedef struct {
  int prio;
  int pol;
} eif_thr_attr_t;

 
#define EIF_THR_CREATION_FLAGS THR_NEW_LWP | THR_DETACHED
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY INT_MAX
#define EIF_DEFAULT_PRIORITY 0
#define EIF_THR_ATTR_DESTROY(attr)


/* Types */

#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  void *
#define EIF_THR_ATTR_TYPE       eif_thr_attr_t
#define EIF_TSD_VAL_TYPE        void *
#define EIF_THR_TYPE            thread_t
#define EIF_MUTEX_TYPE          mutex_t
#define EIF_TSD_TYPE            thread_key_t
#ifndef EIF_NO_CONDVAR
#define pthread_cond_t			cond_t
#endif

/* Tuning for condition variables */
#ifndef EIF_NO_CONDVAR
#define pthread_condattr_t      condattr_t
#define pthread_cond_destroy    cond_destroy
#define pthread_cond_init(a,b)  cond_init(a,USYNC_THREAD,b)
#define pthread_cond_wait       cond_wait
#define pthread_cond_signal     cond_signal
#define pthread_cond_broadcast  cond_broadcast
#endif  /* EIF_NO_CONDVAR */

/* Thread attributes initialization macros */
/* -- There's no such thing as a thread attribute with Solaris threads. For
   -- us it's a struct containing two integers.
   -- In the case of FIFO scheduling, we create the thread without increasing
   -- the level of concurrency */
#define EIF_THR_ATTR_INIT(attr,pr,policy,detach) \
    attr.prio = pr; \
    attr.pol = (policy == EIF_SCHED_FIFO) ? 0 : THR_NEW_LWP; \
    if (detach) attr.pol |= THR_DETACHED
#define EIF_THR_ATTR_DESTROY(attr)

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg)   \
    if (thr_create (NULL, 0, (void *(*)(void *))(entry), \
           (EIF_THR_ENTRY_ARG_TYPE)(arg), \
            EIF_THR_CREATION_FLAGS,&(tid))) \
        eraise(msg, EN_EXT)
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    if (thr_create (NULL, 0, (void *(*)(void *))(entry), \
           (EIF_THR_ENTRY_ARG_TYPE)(arg), attr.pol, &(tid))) \
        eraise(msg, EN_EXT); \
    if (!(attr.pol & THR_DETACHED)) \
        if(thr_setprio(tid,attr.prio)) eraise(msg, EN_EXT)

#define EIF_THR_EXIT(arg)           thr_exit(arg)
#define EIF_THR_JOIN(which)         thr_join(which,0,NULL)
#define EIF_THR_JOIN_ALL            while (thr_join(0, 0, 0) == 0)
#define EIF_THR_YIELD               thr_yield()
#define EIF_THR_SET_PRIORITY(tid,prio) thr_setprio(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio) thr_setprio(tid,&(prio))

/* Thread Specific Data management */
#define EIF_TSD_CREATE(key,msg) \
    if (thr_keycreate(&(key),NULL)) eraise(msg, EN_EXT)
#define EIF_TSD_SET(key,val,msg) \
    if (thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val))) eraise(msg, EN_EXT)
#define EIF_TSD_GET0(val_type,key,val) \
    thr_getspecific(key,(void **)&(val))
#define EIF_TSD_GET(val_type,key,val,msg) \
    if (EIF_TSD_GET0(val_type,key,val)) eraise(msg, EN_EXT)

#define EIF_TSD_DESTROY(key,msg)

/* Mutex management */

#define EIF_MUTEX_INIT(m,msg) \
    if (mutex_init((m),USYNC_THREAD,NULL)) eraise(msg, EN_EXT)
#define EIF_MUTEX_CREATE(m,msg) \
    m = (EIF_MUTEX_TYPE *) eif_malloc (sizeof(EIF_MUTEX_TYPE)); \
    if (!(m)) eraise("cannot allocate memory for mutex creation", EN_OMEM); \
    EIF_MUTEX_INIT(m,msg)
#define EIF_MUTEX_LOCK(m,msg)       if (mutex_lock(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_TRYLOCK(m,r,msg)  \
        r = mutex_trylock(m); \
        if(r && (r != EBUSY)) \
            eraise(msg, EN_EXT)
#define EIF_MUTEX_UNLOCK(m,msg)     if (mutex_unlock(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_DESTROY0(m,msg)   \
    if (mutex_destroy(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_DESTROY(m,msg) \
    EIF_MUTEX_DESTROY0(m,msg); eif_free(m)

	/* tid */
#define EIF_THR_SELF	thread_self();	/* Return a thread_t */

#elif defined VXWORKS

/*-------------------------*/
/*---  VXWORKS Threads  ---*/
/*-------------------------*/


#include <taskLib.h>        /* 'thread' operations */
#include <taskVarLib.h>     /* 'thread' 'specific data' */
#include <semLib.h>         /* 'mutexes' and semaphores */
#include <sched.h>          /* 'sched_yield' */



/* Constants */
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY 255
#define EIF_DEFAULT_PRIORITY	99
#define EIF_THR_CREATION_FLAGS	VX_FP_TASK

/* Types */
#define EIF_THR_ENTRY_TYPE      void
#define EIF_THR_ENTRY_ARG_TYPE  int
#define EIF_THR_ATTR_TYPE       int
#define EIF_THR_TYPE            int
#define EIF_THR_ATTR_TYPE       int
#define EIF_TSD_TYPE            eif_global_context_t *

/* For consistency with the other platforms, EIF_MUTEX_TYPE shouldn't
   be a pointer, that's why we use struct semaphore instead of SEM_ID
   because SEM_ID is equivalent to (struct semaphore *)
   */
#define EIF_TSD_VAL_TYPE        eif_global_context_t *
/* Other definitions are in eif_threads.h */

#ifdef EIF_NO_POSIX_SEM
#define EIF_SEM_TYPE            struct semaphore
#endif

/* Thread attributes initialization macros */
/* -- There's no such thing as a thread attribute under VxWorks, so for us,
   -- the thread attribute is only its priority */
#define EIF_THR_ATTR_INIT(attr,pr,sc,detach) attr = pr
#define EIF_THR_ATTR_DESTROY(attr)

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg)       \
    if ( ERROR == (tid = taskSpawn(             \
                NULL,                           \
                EIF_DEFAULT_PRIORITY,           \
                EIF_THR_CREATION_FLAGS,         \
                0,                              \
                (FUNCPTR)(entry),               \
                (EIF_THR_ENTRY_ARG_TYPE)(arg),  \
                0,0,0,0,0,0,0,0,0               \
                ))                              \
        ) eraise(msg, EN_EXT)

#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    if ( ERROR == (tid = taskSpawn(             \
                NULL,                           \
                attr,                           \
                EIF_THR_CREATION_FLAGS,         \
                0,                              \
                (FUNCPTR)(entry),               \
                (EIF_THR_ENTRY_ARG_TYPE)(arg),  \
                0,0,0,0,0,0,0,0,0               \
                ))                              \
        ) eraise(msg, EN_EXT)

#define EIF_THR_EXIT(arg)           taskDelete(taskIdSelf())
#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD               /*sched_yield()*/
#define EIF_THR_SET_PRIORITY(tid,prio) taskPrioritySet(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio) taskPriorityGet(tid,&(prio))


/* Mutex management */
#define EIF_MUTEX_CREATE(m,msg)     \
    if ((m=semBCreate(SEM_Q_FIFO,SEM_FULL))==NULL) eraise(msg, EN_EXT)
#define EIF_MUTEX_LOCK(m,msg)       \
    if (semTake(m,WAIT_FOREVER)!=OK) eraise(msg, EN_EXT)
#define EIF_MUTEX_TRYLOCK(m,r,msg)  \
    r = (semTake(m,NO_WAIT)==OK)
#define EIF_MUTEX_UNLOCK(m,msg)     \
    if (semGive(m)!=OK) eraise(msg, EN_EXT)
#define EIF_MUTEX_DESTROY(m,msg)    \
    if (semDelete(m)!=OK) eraise(msg, EN_EXT)

#ifdef EIF_NO_POSIX_SEM
#define EIF_SEM_CREATE(sem,count,msg) \
    if (!(sem = semCCreate (SEM_Q_FIFO, count))) eraise (msg, EN_EXT)
#define EIF_SEM_INIT(sem,count,msg)
#define EIF_SEM_POST(sem,msg) \
    if (semGive (sem) != OK) eraise (msg, EN_EXT)
#define EIF_SEM_WAIT(sem,msg) \
    if (semTake (sem, WAIT_FOREVER) != OK) eraise (msg, EN_EXT)
#define EIF_SEM_TRYWAIT(sem,r,msg) \
    r = semTake (sem, NO_WAIT) == OK ? 0 : 1;
#define EIF_SEM_DESTROY(sem,msg) \
    if (semDelete (sem) != OK) eraise (msg, EN_EXT)
#endif

/* Thread Specific Data management */
#define EIF_TSD_CREATE(key,msg)
#define EIF_TSD_SET(key,val,msg)        \
    if (taskVarAdd (taskIdSelf(), (int *)&(key)) != OK) eraise(msg, EN_EXT); \
    key = val
#define EIF_TSD_GET0(val_type,key,val)
#define EIF_TSD_GET(val_type,key,val,msg) val = key
#define EIF_TSD_DESTROY(key,msg)

#else	/* Not a supported platform */

#error Sorry, this platform does not support multithreading

#endif	/* end of POSIX, WIN32, SOLARIS_THREADS, VXWORKS... */


/* 
 * Structure used to give arguments to a new thread
 */
 
/*--------------------------*/
/*---  Mutex operations  ---*/
/*--------------------------*/

RT_LNK EIF_POINTER eif_thr_mutex_create(void);
RT_LNK void eif_thr_mutex_lock(EIF_POINTER mutex_pointer);
RT_LNK void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer);
RT_LNK EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer);
RT_LNK void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer);

/*------------------------------*/
/*---  Semaphore operations  ---*/
/*------------------------------*/

RT_LNK EIF_POINTER eif_thr_sem_create (EIF_INTEGER count);
RT_LNK void eif_thr_sem_wait (EIF_POINTER sem);
RT_LNK void eif_thr_sem_post (EIF_POINTER sem);
RT_LNK EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem);
RT_LNK void eif_thr_sem_destroy (EIF_POINTER sem);

/*---------------------------------------*/
/*---  Condition variable operations  ---*/
/*---------------------------------------*/

RT_LNK EIF_POINTER eif_thr_cond_create (void);
RT_LNK void eif_thr_cond_broadcast (EIF_POINTER cond);
RT_LNK void eif_thr_cond_signal (EIF_POINTER cond);
RT_LNK void eif_thr_cond_wait (EIF_POINTER cond, EIF_POINTER mutex);
RT_LNK void eif_thr_cond_destroy (EIF_POINTER cond);

typedef struct thr_list_struct {
    EIF_OBJECT thread;
    struct thr_list_struct *next;
} thr_list_t;

/* 
 * Structure used to give arguments to a new thread
 */
 
typedef struct {
    EIF_OBJECT current;
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
