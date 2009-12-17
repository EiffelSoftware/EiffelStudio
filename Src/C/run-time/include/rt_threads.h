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

#ifndef _rt_threads_h_
#define _rt_threads_h_

#include "eif_posix_threads.h"
#include "eif_threads.h"
#include "eif_error.h"
#include "rt_globals.h"
#include "rt_timer.h"
#include "rt_sig.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS

/* GC synchronization feature */
extern void eif_thread_cleanup (void);
extern void eif_synchronize_gc(rt_global_context_t *);
extern void eif_unsynchronize_gc(rt_global_context_t *);
#ifdef EIF_ASSERTIONS
extern int eif_is_synchronized (void);
#endif

/* Killing threads */
#ifdef ISE_GC
extern void eif_terminate_all_other_threads(void);
#endif

/* Debugger usage */
#ifdef WORKBENCH
rt_shared rt_uint_ptr dbg_switch_to_thread (rt_uint_ptr);
#endif

/* --------------------------------------- */
/* --- Thread Specific Data management --- */
/* --------------------------------------- */

#ifdef EIF_HAS_TLS
#	define EIF_TSD_CREATE(key,msg)
#	define EIF_TSD_SET(key,val,msg) key = val
#	define EIF_TSD_GET0(val_type,key,val)
#	define EIF_TSD_GET(val_type,key,val,msg) val = key
#	define EIF_TSD_DESTROY(key,msg)
#elif defined EIF_POSIX_THREADS
#	define EIF_TSD_CREATE(key,msg)             \
	    if (pthread_key_create(&(key),NULL))    \
	        eraise(msg, EN_EXT)
#	define EIF_TSD_SET(key,val,msg)            \
	    if (pthread_setspecific ((key), (EIF_TSD_VAL_TYPE)(val))) \
	        eraise(msg, EN_EXT)
#	if defined  EIF_NONPOSIX_TSD || defined POSIX_10034A
#		define EIF_TSD_GET0(val_type,key,val) \
		    pthread_getspecific((key), (void *)&(val))
#		define EIF_TSD_GET(val_type,key,val,msg) \
		    if (EIF_TSD_GET0(val_type,key,val)) eraise(msg, EN_EXT)
#	else
#		define EIF_TSD_GET0(foo,key,val) (val = pthread_getspecific(key))
#		define EIF_TSD_GET(val_type,key,val,msg) \
		    if (EIF_TSD_GET0(val_type,key,val) == (void *) 0) eraise(msg, EN_EXT)
#	endif
#	ifdef POSIX_10034A
#		define EIF_TSD_DESTROY(key,msg) 
#	else	/* POSIX_10034A */
#		define EIF_TSD_DESTROY(key,msg) if (pthread_key_delete(key)) eraise(msg, EN_EXT)
#	endif	/* POSIX_10034A */
#elif defined EIF_WINDOWS
#	define EIF_TSD_CREATE(key,msg) \
	    if ((key=TlsAlloc())==0xFFFFFFFF) eraise(msg, EN_EXT)
#	define EIF_TSD_SET(key,val,msg) \
	    if (!TlsSetValue((key),(EIF_TSD_VAL_TYPE)(val))) eraise(msg, EN_EXT)
#	define EIF_TSD_GET0(val_type,key,val) \
	    val=val_type TlsGetValue(key)
#	define EIF_TSD_GET(val_type,key,val,msg) \
	    EIF_TSD_GET0(val_type,key,val); \
	    if (GetLastError() != NO_ERROR) eraise(msg, EN_EXT)
#	define EIF_TSD_DESTROY(key,msg) \
	    if (!TlsFree(key)) eraise(msg, EN_EXT)
#elif defined SOLARIS_THREADS
#	define EIF_TSD_CREATE(key,msg) \
	    if (thr_keycreate(&(key),NULL)) eraise(msg, EN_EXT)
#	define EIF_TSD_SET(key,val,msg) \
	    if (thr_setspecific((key),(EIF_TSD_VAL_TYPE)(val))) eraise(msg, EN_EXT)
#	define EIF_TSD_GET0(val_type,key,val) \
	    thr_getspecific(key,(void **)&(val))
#	define EIF_TSD_GET(val_type,key,val,msg) \
	    if (EIF_TSD_GET0(val_type,key,val)) eraise(msg, EN_EXT)
#	define EIF_TSD_DESTROY(key,msg)
#elif defined VXWORKS
#	define EIF_TSD_CREATE(key,msg)
#	define EIF_TSD_SET(key,val,msg)        \
	    if (taskVarAdd (taskIdSelf(), (int *)&(key)) != OK) eraise(msg, EN_EXT); \
	    key = val
#	define EIF_TSD_GET0(val_type,key,val)
#	define EIF_TSD_GET(val_type,key,val,msg) val = key
#	define EIF_TSD_DESTROY(key,msg)
#endif

/* --------------------------------------- */
/* Async safe version of mutex locking/unlocking. */
#define EIF_ASYNC_SAFE_MUTEX_LOCK(m) \
	SIGBLOCK; \
	eif_pthread_mutex_lock(m);

#define EIF_ASYNC_SAFE_MUTEX_UNLOCK(m) \
	eif_pthread_mutex_unlock(m); \
	SIGRESUME;

#define EIF_ASYNC_SAFE_CS_LOCK(m) \
	SIGBLOCK; \
	RT_TRACE(eif_pthread_cs_lock(m));

#define EIF_ASYNC_SAFE_CS_UNLOCK(m) \
	RT_TRACE(eif_pthread_cs_unlock(m)); \
	SIGRESUME

#endif	/* EIF_THREADS */

#ifdef __cplusplus
}
#endif

#endif	/* _rt_threads_h_ */
