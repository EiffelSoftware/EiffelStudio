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

#include "cecil.h"		/* Needed for EIF_OBJ,... definitions */

extern void eif_thr_panic(char *);
extern void eif_thr_freeze(EIF_OBJ object);
extern EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
extern EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
extern void eif_thr_proxy_dispose(EIF_POINTER);

#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

/* Tuning for FSU POSIX Threads */
#ifdef EIF_FSUTHREADS
#ifndef EIF_POSIX_THREADS
#define EIF_POSIX_THREADS
#endif
#define EIF_NONPOSIX_TSD
#define HASNT_SCHEDPARAM
#ifdef __linux__
#ifndef ASMi386_SIGCONTEXT_H
#define ASMi386_SIGCONTEXT_H 
/* Or there will be a conflict between sys/time.h and pthread/signal.h */
#endif
#endif
#endif

/* Tuning for POSIX LinuxThreads */
#ifdef EIF_LINUXTHREADS
#ifndef EIF_POSIX_THREADS
#define EIF_POSIX_THREADS
#endif
#endif

/* Tuning for POSIX PCThreads */
#ifdef EIF_PCTHREADS
#ifndef EIF_POSIX_THREADS
#define EIF_POSIX_THREADS
#endif
#define EIF_NONPOSIX_TSD
#endif

/* Tuning for Solaris Threads */
#ifdef SOLARIS_THREADS
#define EIF_NO_JOIN_ALL
#endif

/* Exported functions */
extern void eif_thr_init_root(void);
extern void eif_thr_register(void);
extern unsigned int eif_thr_is_initialized(void);
extern void eif_thr_create(EIF_OBJ, EIF_PROC);
extern void eif_thr_exit(void);
extern void eif_thr_yield(void);
extern void eif_thr_join_all(void);
extern void eif_thr_create_with_args(EIF_OBJ, EIF_PROC, EIF_INTEGER, EIF_INTEGER);
extern EIF_INTEGER eif_thr_default_priority(void);
extern EIF_INTEGER eif_thr_min_priority(void);
extern EIF_INTEGER eif_thr_max_priority(void);
extern EIF_POINTER eif_thr_task_id(void);
extern EIF_POINTER eif_thr_last_thread(void);

/* Mutex functions at end of file */
/* (need some macros defined below) */

/* Constants common to all platforms */

#define EIF_SCHED_DEFAULT 0
#define EIF_SCHED_OTHER   1
#define EIF_SCHED_FIFO    2  /* FIFO scheduling        */
#define EIF_SCHED_RR      3  /* Round-robin scheduling */

/* --------------------------------------- */

#ifdef EIF_POSIX_THREADS

/*-----------------------*/
/*---  POSIX Threads  ---*/
/*-----------------------*/

/* Includes */
#include <pthread.h>
#if defined EIF_LINUXTHREADS
#include <sched.h>
#endif

/* Types */
#define EIF_THR_ENTRY_TYPE		void *
#define EIF_THR_ENTRY_ARG_TYPE	void *
#define EIF_THR_ATTR_TYPE       pthread_attr_t
#define EIF_THR_TYPE			pthread_t
#define EIF_MUTEX_TYPE			pthread_mutex_t
#define EIF_TSD_TYPE			pthread_key_t
#define EIF_TSD_VAL_TYPE		void *

/* Constants */
#define EIF_THR_CREATION_FLAGS
#ifdef EIF_PCTHREADS
#define EIF_DEFAULT_PRIORITY 16
#else
#define EIF_DEFAULT_PRIORITY 0
#endif
#define EIF_MIN_PRIORITY 0
#if defined EIF_FSUTHREADS
#define EIF_MAX_PRIORITY 101
#else
#define EIF_MAX_PRIORITY 255
#endif

/* Thread attributes initialization macros */
#ifdef HASNT_SCHEDPARAM
#define EIF_THR_ATTR_INIT(attr,pr,sc) \
	pthread_attr_init(&(attr)); \
	attr.prio = pr; \
	switch(sc) { \
		case EIF_SCHED_OTHER: pthread_attr_setsched(&attr,SCHED_OTHER); break; \
		case EIF_SCHED_RR:    pthread_attr_setsched(&attr,SCHED_RR); break; \
		case EIF_SCHED_FIFO:  pthread_attr_setsched(&attr,SCHED_FIFO); break; }
#else
#ifdef EIF_PCTHREADS
#define EIF_THR_ATTR_INIT(attr,pr,sc) \
	pthread_attr_init(&(attr)); \
	{ struct sched_param param; \
	param.sched_priority = pr;  \
	param.sched_quantum = 2; /* Due to a bug in PCThreads */ \
	pthread_attr_setschedparam(&attr, &param); } \
	switch(sc) { \
		case EIF_SCHED_OTHER: pthread_attr_setschedpolicy(&attr,SCHED_OTHER); break; \
		case EIF_SCHED_RR:    pthread_attr_setschedpolicy(&attr,SCHED_RR); break; \
		case EIF_SCHED_FIFO:  pthread_attr_setschedpolicy(&attr,SCHED_FIFO); break; }
#else /* EIF_PCTHREADS */
#define EIF_THR_ATTR_INIT(attr,pr,sc) \
	pthread_attr_init(&(attr)); \
	{ struct sched_param param; \
	param.sched_priority = pr;  \
	pthread_attr_setschedparam(&attr, &param); } \
	switch(sc) { \
		case EIF_SCHED_OTHER: pthread_attr_setschedpolicy(&attr,SCHED_OTHER); break; \
		case EIF_SCHED_RR:    pthread_attr_setschedpolicy(&attr,SCHED_RR); break; \
		case EIF_SCHED_FIFO:  pthread_attr_setschedpolicy(&attr,SCHED_FIFO); break; }
#endif /* EIF_PCTHREADS */
#endif /* HASNT_SCHEDPARAM */

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg) \
	if (pthread_create (&(tid), 0, (entry), (EIF_THR_ENTRY_ARG_TYPE)(arg))) \
		eif_thr_panic(msg)
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
	if (pthread_create (&tid, &attr, entry, (EIF_THR_ENTRY_ARG_TYPE) arg)) \
		eif_thr_panic(msg)
#define EIF_THR_EXIT(arg)			pthread_exit(NULL)
#define EIF_THR_JOIN(which)			pthread_join((which),NULL)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD				pthread_yield(0)

#define EIF_THR_SET_PRIORITY(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio)

/* Mutex management */
#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE *) malloc(sizeof(EIF_MUTEX_TYPE)); \
	if (!(m)) eif_thr_panic("cannot allocate memory for mutex creation\n"); \
	if (pthread_mutex_init(m,NULL)) eif_thr_panic(msg)
#define EIF_MUTEX_LOCK(m,msg) if (pthread_mutex_lock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_TRYLOCK(m,r,msg)	\
	r = pthread_mutex_trylock(m);	\
	if (r && (r!=EBUSY)) eif_thr_panic(msg)
#define EIF_MUTEX_UNLOCK(m,msg) if (pthread_mutex_unlock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_DESTROY(m,msg) \
	if (pthread_mutex_destroy(m)) eif_thr_panic(msg); free(m)

#define EIF_TSD_CREATE(key,msg)				\
	if (pthread_key_create(&(key),NULL))	\
		eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg)			\
	if (pthread_setspecific ((key), (EIF_TSD_VAL_TYPE)(val))) \
		eif_thr_panic(msg)

/* Thread Specific Data management */
#ifdef EIF_NONPOSIX_TSD
#define EIF_TSD_GET0(val_type,key,val) \
	pthread_getspecific((key), (void *)&(val))
#define EIF_TSD_GET(val_type,key,val,msg) \
	if (EIF_TSD_GET0(val_type,key,val)) eif_thr_panic(msg)
#else
#define EIF_TSD_GET0(foo,key,val) (val = pthread_getspecific(key))
#define EIF_TSD_GET(val_type,key,val,msg) \
	if (EIF_TSD_GET0(val_type,key,val) == (void *) 0) eif_thr_panic(msg)
#endif
#define EIF_TSD_DESTROY(key,msg) if (pthread_key_delete(key) eif_thr_panic(msg)


#elif defined EIF_WIN32

/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/

#include <windows.h>
#include <process.h>

/* Types */
#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	void *
#define EIF_THR_TYPE			HANDLE
#define EIF_THR_ATTR_TYPE		unsigned char /* FIXME - not used */
#define EIF_MUTEX_TYPE			CRITICAL_SECTION
#define EIF_TSD_TYPE			DWORD
#define EIF_TSD_VAL_TYPE		LPVOID

/* Constants */
#define EIF_THR_CREATION_FLAGS
#define EIF_MIN_PRIORITY 0			/* FIXME - not used */
#define EIF_MAX_PRIORITY 1000		/* FIXME - not used */
#define EIF_DEFAULT_PRIORITY 0		/* FIXME - not used */

/* Thread attributes initialization macros */
#define EIF_THR_ATTR_INIT(attr,prio,sched) /* FIXME - not used */

/* Thread control macros */
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
	tid=(EIF_THR_TYPE)_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg)); \
	if ((int)tid==-1) eif_thr_panic(msg)
#define EIF_THR_CREATE(entry,arg,tid,msg)	\
	tid=(EIF_THR_TYPE)_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg));\
	if ((int)tid==-1) eif_thr_panic(msg)
#define EIF_THR_EXIT(arg)					_endthread()
#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD

#define EIF_THR_SET_PRIORITY(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio)

/* Mutex management */
#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE *) malloc(sizeof(EIF_MUTEX_TYPE)); \
	if (!(m)) eif_thr_panic("Not enough memory to create mutex\n"); \
	InitializeCriticalSection(m)
#define EIF_MUTEX_LOCK(m,msg)				EnterCriticalSection(m)
#define EIF_MUTEX_TRYLOCK(m,r,msg)
#define EIF_MUTEX_UNLOCK(m,msg)				LeaveCriticalSection(m)
#define EIF_MUTEX_DESTROY(m,msg)	\
	DeleteCriticalSection(m); 		\
	free(m)

/* Thread Specific Data management */
#define EIF_TSD_CREATE(key,msg) \
	if ((key=TlsAlloc())==0xFFFFFFFF) eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg) \
	if (!TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))) eif_thr_panic(msg)
#define EIF_TSD_GET0(val_type,key,val) \
 	val=val_type TlsGetValue(key)
#define EIF_TSD_GET(val_type,key,val,msg) \
	EIF_TSD_GET0(val_type,key,val);	\
	if (GetLastError() != NO_ERROR) eif_thr_panic(msg)
#define EIF_TSD_DESTROY(key,msg) \
	if (!TlsFree(key)) eif_thr_panic(msg)


#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#include <thread.h>
#include <sched.h>

 /* Types */

typedef struct {
  int prio;
  int pol;
} eif_thr_attr_t;

#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	void *
#define EIF_THR_TYPE			thread_t
#define EIF_THR_ATTR_TYPE		eif_thr_attr_t
#define EIF_MUTEX_TYPE			mutex_t
#define EIF_TSD_TYPE			thread_key_t
#define EIF_TSD_VAL_TYPE		void *

/* Constants */
#define EIF_THR_CREATION_FLAGS THR_NEW_LWP
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY INT_MAX
#define EIF_DEFAULT_PRIORITY 0

/* Thread attributes initialization macros */
/* -- There's no such thing as a thread attribute with Solaris threads. For
   -- us it's astruct containing two integers.
   -- In the case of FIFO scheduling, we create the thread without increasing
   -- the level of concurrency */
#define EIF_THR_ATTR_INIT(attr,pr,policy) \
	attr.prio = pr; \
	attr.pol = (policy == EIF_SCHED_FIFO) ? 0 : THR_NEW_LWP

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg)	\
	if (thr_create (NULL, 0, (void *(*)(void *))(entry), \
		   (EIF_THR_ENTRY_ARG_TYPE)(arg), \
			EIF_THR_CREATION_FLAGS,&(tid))) \
		eif_thr_panic(msg)
#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
	if (thr_create (NULL, 0, (void *(*)(void *))(entry), \
		   (EIF_THR_ENTRY_ARG_TYPE)(arg), attr.pol, &(tid))) \
		eif_thr_panic(msg); \
	if (thr_setprio(tid,attr.prio)) eif_thr_panic(msg); \
	if (attr.pol == THR_NEW_LWP) thr_setconcurrency(1)
#define EIF_THR_EXIT(arg)			thr_exit(arg)
#define EIF_THR_JOIN(which)			thr_join(0,(which),NULL)
#define EIF_THR_JOIN_ALL			while (thr_join(0, 0, 0) == 0)
#define EIF_THR_YIELD				thr_yield()
#define EIF_THR_SET_PRIORITY(tid,prio) thr_setprio(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio) thr_setprio(tid,&(prio))

#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE *) malloc (sizeof(EIF_MUTEX_TYPE)); \
	if (!(m)) eif_thr_panic("cannot allocate memory for mutex creation\n"); \
	if (mutex_init((m),USYNC_THREAD,NULL)) eif_thr_panic(msg)

#define EIF_MUTEX_LOCK(m,msg)		if (mutex_lock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_TRYLOCK(m,r,msg)	\
		r = mutex_trylock(m); \
		if(r && (r != EBUSY)) \
			eif_thr_panic(msg)
#define EIF_MUTEX_UNLOCK(m,msg)		if (mutex_unlock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_DESTROY(m,msg)	\
	if (mutex_destroy(m)) eif_thr_panic(msg) \
	free(m)

#define EIF_TSD_CREATE(key,msg) \
	if (thr_keycreate(&(key),NULL)) eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg) \
	if (thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val))) eif_thr_panic(msg)
#define EIF_TSD_GET0(val_type,key,val) \
	thr_getspecific(key,(void **)&(val))
#define EIF_TSD_GET(val_type,key,val,msg) \
	if (EIF_TSD_GET0(val_type,key,val)) eif_thr_panic(msg)

#define EIF_TSD_DESTROY(key,msg)


#elif defined VXWORKS

/*-------------------------*/
/*---  VXWORKS Threads  ---*/
/*-------------------------*/

#include <taskLib.h>		/* 'thread' operations */
#include <taskVarLib.h>		/* 'thread' 'specific data' */
#include <semLib.h>			/* 'mutexes' and semaphores */
#include <sched.h>			/* 'sched_yield' */

/* Types */
#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	int
#define EIF_THR_TYPE			int
#define EIF_THR_ATTR_TYPE       int
/* For consistency with the other platforms, EIF_MUTEX_TYPE shouldn't
   be a pointer, that's why we use struct semaphore instead of SEM_ID
   because SEM_ID is equivalent to (struct semaphore *)
   */
#define EIF_MUTEX_TYPE			struct semaphore
#define EIF_TSD_TYPE			eif_global_context_t *
#define EIF_TSD_VAL_TYPE		eif_global_context_t *

/* Constants */
#define EIF_MIN_PRIORITY 0
#define EIF_MAX_PRIORITY 255
#define EIF_DEFAULT_PRIORITY	99
#define EIF_THR_CREATION_FLAGS	VX_FP_TASK

/* Thread attributes initialization macros */
/* -- There's no such thing as a thread attribute under VxWorks, so for us,
   -- the thread attribute is only its priority */
#define EIF_THR_ATTR_INIT(attr,pr,sc) attr = pr

/* Thread control macros */
#define EIF_THR_CREATE(entry,arg,tid,msg)		\
	if ( ERROR == (tid = taskSpawn(				\
				NULL,							\
				EIF_DEFAULT_PRIORITY,			\
				EIF_THR_CREATION_FLAGS,			\
				0,								\
				(FUNCPTR)(entry),				\
				(EIF_THR_ENTRY_ARG_TYPE)(arg),	\
				0,0,0,0,0,0,0,0,0				\
				))								\
		) eif_thr_panic(msg)

#define EIF_THR_CREATE_WITH_ATTR(entry,arg,tid,attr,msg) \
	if ( ERROR == (tid = taskSpawn(				\
		   		NULL,							\
				attr,							\
				EIF_THR_CREATION_FLAGS,			\
				0,								\
				(FUNCPTR)(entry),				\
				(EIF_THR_ENTRY_ARG_TYPE)(arg),	\
				0,0,0,0,0,0,0,0,0				\
				))								\
		) eif_thr_panic(msg)

#define EIF_THR_EXIT(arg)			taskDelete(taskIdSelf())
#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD				sched_yield()
#define EIF_THR_SET_PRIORITY(tid,prio) taskPrioritySet(tid,prio)
#define EIF_THR_GET_PRIORITY(tid,prio) taskPriorityGet(tid,&(prio))

/* Mutex management */
#define EIF_MUTEX_CREATE(m,msg)		\
	if ((m=semBCreate(SEM_Q_FIFO,SEM_FULL))==NULL) eif_thr_panic(msg)
#define EIF_MUTEX_LOCK(m,msg)		\
	if (semTake(m,WAIT_FOREVER)!=OK) eif_thr_panic(msg)
#define EIF_MUTEX_TRYLOCK(m,r,msg)	\
	r = (semTake(m,NO_WAIT)==OK)
#define EIF_MUTEX_UNLOCK(m,msg)		\
	if (semGive(m)!=OK) eif_thr_panic(msg)
#define EIF_MUTEX_DESTROY(m,msg)	\
	if (semDelete(m)!=OK) eif_thr_panic(msg)

/* Thread Specific Data management */
#define EIF_TSD_CREATE(key,msg)
#define EIF_TSD_SET(key,val,msg)		\
	if (taskVarAdd (taskIdSelf(), (int *)&(key)) != OK) eif_thr_panic(msg); \
	key = val
#define EIF_TSD_GET0(val_type,key,val)
#define EIF_TSD_GET(val_type,key,val,msg) val = key
#define EIF_TSD_DESTROY(key,msg)

#else

#error Sorry, this platform does not support multithreading

#endif	/* end of POSIX, WIN32, SOLARIS_THREADS, VXWORKS... */


/* --------------------------------------- */

/* 
 * Structure used to give arguments to a new thread
 */
 
typedef struct {
	EIF_OBJ current;
	EIF_PROC routine;
#ifndef EIF_NO_JOIN_ALL
	int *addr_n_children;
#endif
	EIF_THR_TYPE *tid;
} start_routine_ctxt_t;


/*--------------------------*/
/*---  Mutex operations  ---*/
/*--------------------------*/

extern EIF_MUTEX_TYPE *eif_rmark_mutex;

extern EIF_MUTEX_TYPE *eif_thr_mutex_create(void);
extern void eif_thr_mutex_lock(EIF_MUTEX_TYPE *a_mutex_pointer);
extern void eif_thr_mutex_unlock(EIF_MUTEX_TYPE *a_mutex_pointer);
extern EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE *a_mutex_pointer);


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
