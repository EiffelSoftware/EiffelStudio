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
#define EIF_THR_ERRCODE_TYPE				unsigned long
#define EIF_THR_CREATE(entry,arg,tid,errcode)	errcode=_beginthread((entry),0,(EIF_THR_ENTRY_ARG_TYPE)(arg)); tid=(HANDLE)(errcode)
#define EIF_THR_EXIT(arg)					_endthread()
#define EIF_THR_JOIN(which)
#define EIF_THR_INVALID_ERRCODE(errcode)	((errcode)==-1)

#define EIF_MUTEX_TYPE						CRITICAL_SECTION
#define EIF_MUTEX_ERRCODE_TYPE				int
#define EIF_MUTEX_CREATE(m,errcode)			InitializeCriticalSection(&(m))
#define EIF_MUTEX_LOCK(m,errcode)			EnterCriticalSection(&(m))
#define EIF_MUTEX_UNLOCK(m,errcode)			LeaveCriticalSection(&(m))
#define EIF_MUTEX_DESTROY(m,errcode)		DeleteCriticalSection(&(m))
#define EIF_MUTEX_INVALID_ERRCODE(errcode)	(0)

#define EIF_TSD_TYPE					DWORD
#define EIF_TSD_VAL_TYPE				LPVOID
#define EIF_TSD_ERRCODE_TYPE			DWORD
#define EIF_TSD_CREATE(key,errcode)		key=TlsAlloc(); errcode=((key)==0xFFFFFFFF)
#define EIF_TSD_SET(key,val,errcode)	errcode=(TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))==FALSE)
#define EIF_TSD_GET(key,val,errcode)	val=(eif_global_context_t *)TlsGetValue(key); errcode=(GetLastError()!=NO_ERROR)
#define EIF_TSD_GET_NOCHECK(key,val)	val=(eif_global_context_t *)TlsGetValue(key)
#define EIF_TSD_DESTROY(key,errcode)	errcode=(TlsFree()==FALSE)
#define	EIF_TSD_INVALID_ERRCODE(errcode)	(errcode)


#elif defined SOLARIS_THREADS

/*-------------------------*/
/*---  SOLARIS Threads  ---*/
/*-------------------------*/

#include <thread.h>


#define EIF_THR_ENTRY_TYPE		void *
#define EIF_THR_ENTRY_ARG_TYPE	void *

#define EIF_THR_CREATION_FLAGS	THR_NEW_LWP

#define EIF_THR_TYPE						thread_t
#define EIF_THR_ERRCODE_TYPE				int
#define EIF_THR_CREATE(entry,arg,tid,errcode)	errcode=thr_create(NULL,0,(entry),(EIF_THR_ENTRY_ARG_TYPE)(arg),EIF_THR_CREATION_FLAGS,&(tid))
#define EIF_THR_EXIT(arg)					thr_exit(arg)
#define EIF_THR_JOIN(which)					thr_join(0,(which),NULL)
#define EIF_THR_INVALID_ERRCODE(errcode)	(errcode)

#define EIF_MUTEX_TYPE						mutex_t
#define EIF_MUTEX_ERRCODE_TYPE				int
#define EIF_MUTEX_CREATE(m,errcode)			errcode=mutex_init(&(m),USYNC_THREAD,NULL)
#define EIF_MUTEX_LOCK(m,errcode)			errcode=mutex_lock(&(m))
#define EIF_MUTEX_UNLOCK(m,errcode)			errcode=mutex_unlock(&(m))
#define EIF_MUTEX_DESTROY(m,errcode)
#define EIF_MUTEX_INVALID_ERRCODE(errcode)	(errcode)

#define EIF_TSD_TYPE					thread_key_t
#define EIF_TSD_VAL_TYPE				void *
#define EIF_TSD_ERRCODE_TYPE			int
#define EIF_TSD_CREATE(key,errcode)		errcode=thr_keycreate(&(key),NULL)
#define EIF_TSD_SET(key,val,errcode)	errcode=thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val))
#define EIF_TSD_GET_NOCHECK(key,val)	thr_getspecific((key),&(val))
#define EIF_TSD_DESTROY(key,errcode)
#define	EIF_TSD_INVALID_ERRCODE(errcode) (errcode)

#endif	/* end of POSIX, WIN32, SOLARIS... */


#endif	/* _eif_threads_h_ */
#endif	/* EIF_THREADS */

