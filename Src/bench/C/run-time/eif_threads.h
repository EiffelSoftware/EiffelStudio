/*

 ######     #    ######           #####  #    #  #####   ######    ##    #####    ####           #    #
 #          #    #                  #    #    #  #    #  #        #  #   #    #  #               #    #
 #####      #    #####              #    ######  #    #  #####   #    #  #    #   ####           ######
 #          #    #                  #    #    #  #####   #       ######  #    #       #   ###    #    #
 #          #    #                  #    #    #  #   #   #       #    #  #    #  #    #   ###    #    #
 ######     #    #      #######     #    #    #  #    #  ######  #    #  #####    ####    ###    #    #

	Thread management routines.

*/

#ifdef EIF_THREADS
#ifndef _eif_threads_h_
#define _eif_threads_h_

extern void eif_init_root_thread(void);
extern void eif_register_thread(void);


#ifdef POSIX_THREADS

/*-----------------------*/
/*---  POSIX Threads  ---*/
/*-----------------------*/

#include <pthread.h>

#elif defined WIN32

/*-------------------------------*/
/*---  WINDOWS 95/NT Threads  ---*/
/*-------------------------------*/

#include <windows.h>
#include <process.h>

#define EIF_THR_ENTRY_TYPE		void
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS

#define EIF_THR_TYPE						HANDLE
#define EIF_THR_CREATE(entry,arg,tid,msg)	tid=_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg)); if ((int)tid==-1) panic(msg)
#define EIF_THR_EXIT(arg)					_endthread()
#define EIF_THR_JOIN(which)

#define EIF_MUTEX_TYPE						CRITICAL_SECTION
#define EIF_MUTEX_CREATE(m,msg)				InitializeCriticalSection(&(m))
#define EIF_MUTEX_LOCK(m,msg)				EnterCriticalSection(&(m))
#define EIF_MUTEX_UNLOCK(m,msg)				LeaveCriticalSection(&(m))
#define EIF_MUTEX_DESTROY(m,msg)			DeleteCriticalSection(&(m))

#define EIF_TSD_TYPE						DWORD
#define EIF_TSD_VAL_TYPE					LPVOID
#define EIF_TSD_CREATE(key,msg)				if ((key=TlsAlloc())==0xFFFFFFFF) panic(msg)
#define EIF_TSD_SET(key,val,msg)			if (!TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))) panic(msg)
#define EIF_TSD_GET(key,val,msg)			val=TlsGetValue(key); if (GetLastError()!=NO_ERROR) panic(msg)
#define EIF_TSD_GET_CONTEXT(key,val,msg)	val=(eif_global_context_t *)TlsGetValue(key); if (GetLastError()!=NO_ERROR) panic(msg)
#define EIF_TSD_DESTROY(key,msg)			if (!TlsFree(key)) panic(msg)


#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#include <thread.h>


#define EIF_THR_ENTRY_TYPE		void *
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS	THR_NEW_LWP

#define EIF_THR_TYPE						thread_t
#define EIF_THR_CREATE(entry,arg,tid,msg)	if (thr_create(NULL,0,(entry),(EIF_THR_ENTRY_ARG_TYPE)(arg),EIF_THR_CREATION_FLAGS,&(tid)) panic(msg)
#define EIF_THR_EXIT(arg)					thr_exit(arg)
#define EIF_THR_JOIN(which)					thr_join(0,(which),NULL)

#define EIF_MUTEX_TYPE				mutex_t
#define EIF_MUTEX_CREATE(m,msg)		if (mutex_init(&(m),USYNC_THREAD,NULL)) panic(msg)
#define EIF_MUTEX_LOCK(m,msg)		if (mutex_lock(&(m))) panic(msg)
#define EIF_MUTEX_UNLOCK(m,msg)		if (mutex_unlock(&(m))) panic(msg)
#define EIF_MUTEX_DESTROY(m,msg)

#define EIF_TSD_TYPE					thread_key_t
#define EIF_TSD_VAL_TYPE				void *
#define EIF_TSD_CREATE(key,msg)			if (thr_keycreate(&(key),NULL)) panic(msg)
#define EIF_TSD_SET(key,val,msg)		if (thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val))) panic(msg)
#define EIF_TSD_GET(key,val,msg)		if (thr_getspecific((key),(void **)&(val)) panic(msg)
#define EIF_TSD_GET_CONTEXT(key,val,msg)	EIF_TSD_GET(key,val,msg)
#define EIF_TSD_DESTROY(key,errcode)

#endif	/* end of POSIX, WIN32, SOLARIS... */


#endif	/* _eif_threads_h_ */
#endif	/* EIF_THREADS */

