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

/* Structure used to give two arguments to a new thread,
   with only one used -- the pointer on this structure. */
 
typedef struct {
	EIF_OBJ current;
	EIF_PROC routine;
#ifdef THREAD_DEVEL
	int *addr_n_children;
#endif
} start_routine_ctxt_t;

/* Exported functions */
extern void eif_thr_init_root(void);
extern void eif_thr_register(void);
extern unsigned int eif_thr_is_initialized(void);
extern void eif_thr_create(EIF_OBJ, EIF_PROC);
extern void eif_thr_exit(void);
extern void eif_thr_yield(void);
extern void eif_thr_join_all(void);

/* Mutex functions at end of file */
/* (need some macros defined below) */

/* --------------------------------------- */

#ifdef EIF_POSIX_THREADS

/*-----------------------*/
/*---  POSIX Threads  ---*/
/*-----------------------*/

#include <pthread.h>
/* #include <sched.h> */

#define EIF_THR_ENTRY_TYPE		void *
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS

#define EIF_THR_TYPE				pthread_t
#define EIF_THR_CREATE(entry,arg,tid,msg)	\
	if (pthread_create (&(tid), 0, (entry), \
		(EIF_THR_ENTRY_ARG_TYPE)(arg)) \
	   )			\
	eif_thr_panic(msg)    ; \
					  else pthread_detach(&tid)

#define EIF_THR_EXIT(arg)			pthread_exit(NULL)
#define EIF_THR_JOIN(which)			pthread_join((which),NULL)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD				pthread_yield(0)

#define EIF_MUTEX_TYPE				pthread_mutex_t *
#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE) malloc(sizeof(pthread_mutex_t)); \
	if (!(m)) eif_thr_panic("cannot allocate memory for mutex creation\n"); \
	if (pthread_mutex_init(m,NULL)) eif_thr_panic(msg)
#define EIF_MUTEX_LOCK(m,msg)       if (pthread_mutex_lock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_TRYLOCK(m,r,msg)	\
	r = pthread_mutex_trylock(m);	\
	if (r && (r!=EBUSY))				\
		eif_thr_panic(msg)
#define EIF_MUTEX_UNLOCK(m,msg)		if (pthread_mutex_unlock(m)) eif_thr_panic(msg)
#define EIF_MUTEX_DESTROY(m,msg)	\
	if (pthread_mutex_destroy(m)) eif_thr_panic(msg); \
	free(m)

#define EIF_TSD_TYPE						pthread_key_t
#define EIF_TSD_VAL_TYPE					void *
#define EIF_TSD_CREATE(key,msg)				\
	if (pthread_key_create(&(key),NULL))	\
		eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg)			\
	if (pthread_setspecific ((key), (EIF_TSD_VAL_TYPE)(val))) \
		eif_thr_panic(msg)

#ifdef EIF_NONPOSIX_TSD
#define EIF_TSD_GET0(val_type,key,val)	\
	pthread_getspecific((key), (void *)&(val))
#define EIF_TSD_GET(val_type,key,val,msg)	\
	if ( EIF_TSD_GET0(val_type,key,val)	) eif_thr_panic(msg)
#else
#define EIF_TSD_GET0(foo,key,bar) pthread_getspecific((key))
#define EIF_TSD_GET(val_type,key,val,msg)	\
	if ( (val = EIF_TSD_GET0(0,key,0)) == (void *) 0) eif_thr_panic(msg)
#endif
#define EIF_TSD_DESTROY(key,msg)			\
	if (pthread_key_delete((key)) eif_thr_panic(msg)


#elif defined EIF_WIN32

/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/

#include <windows.h>
#include <process.h>

#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS

#define EIF_THR_TYPE						HANDLE
#define EIF_THR_CREATE(entry,arg,tid,msg)	\
	tid=(EIF_THR_TYPE)_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg));\
	if ((int)tid==-1) eif_thr_panic(msg)
#define EIF_THR_EXIT(arg)					_endthread()
#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD

#define EIF_MUTEX_TYPE						CRITICAL_SECTION *
#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE) malloc(sizeof(CRITICAL_SECTION)); \
	if (!(m)) eif_thr_panic("Not enough memory to create mutex\n"); \
	InitializeCriticalSection(m)
#define EIF_MUTEX_LOCK(m,msg)				EnterCriticalSection(m)
#define EIF_MUTEX_TRYLOCK(m,r,msg)
#define EIF_MUTEX_UNLOCK(m,msg)				LeaveCriticalSection(m)
#define EIF_MUTEX_DESTROY(m,msg)	\
	DeleteCriticalSection(m); 		\
	free(m)

#define EIF_TSD_TYPE						DWORD
#define EIF_TSD_VAL_TYPE					LPVOID
#define EIF_TSD_CREATE(key,msg)				\
	if ((key=TlsAlloc())==0xFFFFFFFF) eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg)			\
	if (!TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))) eif_thr_panic(msg)

#define EIF_TSD_GET0(val_type,key,val)		\
 	val=val_type TlsGetValue(key)
#define EIF_TSD_GET(val_type,key,val,msg)			\
	EIF_TSD_GET0(val_type,key,val);	\
	if (GetLastError() != NO_ERROR) eif_thr_panic(msg)

#define EIF_TSD_DESTROY(key,msg)			\
	if (!TlsFree(key)) eif_thr_panic(msg)


#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#include <thread.h>


#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS	THR_NEW_LWP

#define EIF_THR_TYPE						thread_t
#define EIF_THR_CREATE(entry,arg,tid,msg)	\
	if (thr_create(NULL,0,(void (*)(void *))(entry),(EIF_THR_ENTRY_ARG_TYPE)(arg), \
		EIF_THR_CREATION_FLAGS,&(tid))) \
		eif_thr_panic(msg)
#define EIF_THR_EXIT(arg)			thr_exit(arg)
#define EIF_THR_JOIN(which)			thr_join(0,(which),NULL)
#define EIF_THR_JOIN_ALL			while (thr_join(0, 0, 0) == 0)
#define EIF_THR_YIELD				thr_yield()

#define EIF_MUTEX_TYPE				mutex_t *
#define EIF_MUTEX_CREATE(m,msg)		\
	m = (EIF_MUTEX_TYPE) malloc(sizeof(mutex_t)); \
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

#define EIF_TSD_TYPE					thread_key_t
#define EIF_TSD_VAL_TYPE				void *
#define EIF_TSD_CREATE(key,msg)		\
	if (thr_keycreate(&(key),NULL)) \
		eif_thr_panic(msg)
#define EIF_TSD_SET(key,val,msg)	\
	if (thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val)))	\
		eif_thr_panic(msg)
#define EIF_TSD_GET0(val_type,key,val)		\
	thr_getspecific(key,(void **)&(val))
#define EIF_TSD_GET(val_type,key,val,msg)	\
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

#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	int

#define EIF_THR_CREATION_FLAGS	VX_FP_TASK
#ifdef THREAD_DEVEL
#define EIF_THR_DFLT_PRIORITY	99
#else
#define EIF_THR_DFLT_PRIORITY	151
#endif
#define EIF_THR_TYPE				int
#define EIF_THR_CREATE(entry,arg,tid,msg)		\
	if ( ERROR == (tid = taskSpawn(				\
/* name */		NULL,							\
				EIF_THR_DFLT_PRIORITY,			\
				EIF_THR_CREATION_FLAGS,			\
/*stack size*/	0,								\
				(FUNCPTR)(entry),				\
				(EIF_THR_ENTRY_ARG_TYPE)(arg),	\
				0,0,0,0,0,0,0,0,0				\
				))								\
		) {										\
			eif_thr_panic(msg);					\
		}

#define EIF_THR_EXIT(arg)			taskDelete(taskIdSelf())
#define EIF_THR_JOIN(which)
#define EIF_THR_JOIN_ALL
#define EIF_THR_YIELD				sched_yield()

#define EIF_MUTEX_TYPE				SEM_ID
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

#define EIF_TSD_TYPE				eif_global_context_t *
#define EIF_TSD_VAL_TYPE			eif_global_context_t *
#define EIF_TSD_CREATE(key,msg)
#define EIF_TSD_SET(key,val,msg)		\
	if (taskVarAdd (taskIdSelf(), (int *)&(key)) != OK) eif_thr_panic(msg); \
	key = val
#define EIF_TSD_GET0(val_type,key,val)
#define EIF_TSD_GET(val_type,key,val,msg) \
	val = key

#define EIF_TSD_DESTROY(key,msg)

#else

#error Sorry, this platform does not support multithreading

#endif	/* end of POSIX, WIN32, SOLARIS_THREADS, VXWORKS... */


/* --------------------------------------- */

/*--------------------------*/
/*---  Mutex operations  ---*/
/*--------------------------*/

extern EIF_MUTEX_TYPE eif_rmark_mutex;

extern EIF_MUTEX_TYPE eif_thr_mutex_create(void);
extern void eif_thr_mutex_lock(EIF_MUTEX_TYPE a_mutex_pointer);
extern void eif_thr_mutex_unlock(EIF_MUTEX_TYPE a_mutex_pointer);
extern EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE a_mutex_pointer);


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
