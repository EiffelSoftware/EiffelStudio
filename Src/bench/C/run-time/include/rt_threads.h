/*

 #####  #    #  #####   ######    ##    #####    ####           #    #
   #    #    #  #    #  #        #  #   #    #  #               #    #
   #    ######  #    #  #####   #    #  #    #   ####           ######
   #    #    #  #####   #       ######  #    #       #   ###    #    #
   #    #    #  #   #   #       #    #  #    #  #    #   ###    #    #
   #    #    #  #    #  ######  #    #  #####    ####    ###    #    #

	Thread management routines.

*/

#ifndef _rt_threads_h_
#define _rt_threads_h_

#include "eif_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

#ifdef EIF_FSUTHREADS		/* Tuning for FSU POSIX Threads */
#define EIF_THR_SET_PRIO attr.prio = pr
#define pthread_attr_setschedpolicy pthread_attr_setsched
#define EIF_THR_SET_DETACHSTATE(attr,detach) \
    {int idetach = (int) detach; pthread_attr_setdetachstate (&attr, &idetach);}
#define EIF_MAX_PRIORITY 101
#endif

#ifdef EIF_PCTHREADS		/* Tuning for POSIX PCThreads */
#define EIF_SCHEDPARAM_EXTRA param.sched_quantum = 2; /* bug in PCThreads */
#define EIF_DEFAULT_PRIORITY 16
#endif

#ifdef _CRAY 				/* Tuning for CRAY */
#define pthread_attr_setschedpolicy(a,b)
#endif

/* Defaults for semaphores */
#ifndef EIF_NO_POSIX_SEM
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


/* Constants common to all platforms */

#define EIF_SCHED_DEFAULT 0
#define EIF_SCHED_OTHER   1
#define EIF_SCHED_FIFO    2  /* FIFO scheduling        */
#define EIF_SCHED_RR      3  /* Round-robin scheduling */

/* Defaults for condition variables */
#ifdef EIF_NO_CONDVAR
#define EIF_COND_INIT(cond, msg)
#define EIF_COND_CREATE(cond, msg)
#define EIF_COND_WAIT(cond, mutex, msg)
#define EIF_COND_BROADCAST(cond, msg)
#define EIF_COND_SIGNAL(cond, msg)
#define EIF_COND_DESTROY(cond, msg)
#else /* EIF_NO_CONDVAR */
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
    EIF_COND_DESTROY0 (pcond, msg); eif_free (pcond);
#define EIF_COND_DESTROY0(pcond,msg) \
    if (pthread_cond_destroy (pcond)) eraise (msg, EN_EXT)
#endif	


/* --------------------------------------- */

#ifdef EIF_POSIX_THREADS
/*-----------------------*/
/*---  POSIX Threads  ---*/
/*-----------------------*/

/* Posix drafts compatibility */
#ifdef POSIX_10034A
#define pthread_attr_init	pthread_attr_create
#define pthread_key_create	pthread_keycreate
#define pthread_attr_setschedpolicy	pthread_attr_setsched
#define pthread_attr_setschedparam(x,y)		pthread_attr_setprio (x, (*(y)).sched_priority)
#define pthread_attr_destroy(x)		pthread_attr_delete (x)
#endif	/*POSIX_10034A */

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
#ifndef POSIX_10034A
#ifndef EIF_THR_SET_DETACHSTATE
#define EIF_THR_SET_DETACHSTATE(attr,detach) \
    pthread_attr_setdetachstate(&attr, \
        detach ? PTHREAD_CREATE_DETACHED : PTHREAD_CREATE_JOINABLE);
#endif
#else	/* POSIX_10034A */
#define EIF_THR_SET_DETACHSTATE(attr, detach)	/* Nothing */
#endif	/* POSIX_10034A */

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
#ifdef __Lynx__
#define EIF_THR_CREATE(entry,arg,tid,msg) \
    if (pthread_create (&(tid), pthread_attr_default, (entry), (EIF_THR_ENTRY_ARG_TYPE)(arg))) \
        eraise(msg, EN_EXT);
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    if (pthread_create (&tid, attr, entry, (EIF_THR_ENTRY_ARG_TYPE) arg)) \
        eraise(msg, EN_EXT)
#else
#define EIF_THR_CREATE(entry,arg,tid,msg) \
    if (pthread_create (&(tid), 0, (entry), (EIF_THR_ENTRY_ARG_TYPE)(arg))) \
        eraise(msg, EN_EXT)
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
    if (pthread_create (&tid, &attr, entry, (EIF_THR_ENTRY_ARG_TYPE) arg)) \
        eraise(msg, EN_EXT)
#endif
#ifdef FIXME_LYNX
#define EIF_THR_EXIT(arg) \
	pthread_exit(NULL);\
	pthread_detach (eif_thr_id) ;
#else /* POSIX_10034A */
#define EIF_THR_EXIT(arg)           pthread_exit(NULL)
#endif	/* POSIX_10034A */
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
#if defined  EIF_NONPOSIX_TSD || defined POSIX_10034A
#define EIF_TSD_GET0(val_type,key,val) \
    pthread_getspecific((key), (void *)&(val))
#define EIF_TSD_GET(val_type,key,val,msg) \
    if (EIF_TSD_GET0(val_type,key,val)) eraise(msg, EN_EXT)
#else
#define EIF_TSD_GET0(foo,key,val) (val = pthread_getspecific(key))
#define EIF_TSD_GET(val_type,key,val,msg) \
    if (EIF_TSD_GET0(val_type,key,val) == (void *) 0) eraise(msg, EN_EXT)
#endif
#ifdef POSIX_10034A
#define EIF_TSD_DESTROY(key,msg) 
#else	/* POSIX_10034A */
#define EIF_TSD_DESTROY(key,msg) if (pthread_key_delete(key)) eraise(msg, EN_EXT)
#endif	/* POSIX_10034A */

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
#define EIF_MUTEX_UNLOCK(m,msg) if (pthread_mutex_unlock(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_DESTROY(m,msg) \
    EIF_MUTEX_DESTROY0(m,msg); eif_free(m)
#define EIF_MUTEX_DESTROY0(m,msg) \
    if (pthread_mutex_destroy(m)) eraise(msg, EN_EXT)

	/* tid */
#define EIF_THR_SELF	pthread_self()	/* Return a pthread_t */


#elif defined EIF_WIN32
/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/
#define EIF_MIN_PRIORITY 0			/*  - not used */
#define EIF_MAX_PRIORITY 1000		/* - not used  */
#define EIF_DEFAULT_PRIORITY 0		/* - not used  */


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
        if (!m) eraise(msg, EN_EXT);
#define EIF_MUTEX_LOCK(m,msg) \
        if (WaitForSingleObject(m, INFINITE) == WAIT_FAILED) \
        eraise(msg, EN_EXT)
#define EIF_MUTEX_TRYLOCK(m,r,msg)  \
        r = (WaitForSingleObject(m,0)); \
        if (r==WAIT_FAILED) eraise (msg, EN_EXT); \
        r = (r==WAIT_TIMEOUT)
#define EIF_MUTEX_UNLOCK(m,msg) \
        if (!ReleaseMutex(m)) eraise(msg, EN_EXT)
#define EIF_MUTEX_DESTROY(m,msg) \
        if (!CloseHandle(m)) eraise (msg, EN_EXT)


/* tid */
#define EIF_THR_SELF GetCurrentThread ()


#elif defined SOLARIS_THREADS
/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/
#define EIF_THR_CREATION_FLAGS THR_NEW_LWP | THR_DETACHED
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY INT_MAX
#define EIF_DEFAULT_PRIORITY 0
#define EIF_THR_ATTR_DESTROY(attr)

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
#define EIF_THR_SELF	thread_self()	/* Return a thread_t */


#elif defined VXWORKS
/*-------------------------*/
/*---  VXWORKS Threads  ---*/
/*-------------------------*/
/* Current Thread Id */
#define EIF_THR_SELF	taskIdSelf ()

/* Constants */
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY 255
#define EIF_DEFAULT_PRIORITY	99
#define EIF_THR_CREATION_FLAGS	VX_FP_TASK

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

#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif	/* _rt_threads_h_ */
