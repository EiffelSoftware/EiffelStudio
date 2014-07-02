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

#ifndef _eif_threads_h_
#define _eif_threads_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"
#include "eif_posix_threads.h"
#include "eif_cecil.h"

#ifndef EIF_THREADS

/* Empty stubs for EiffelThread library so that it may be compiled against a non-multithreaded run-time */

#define eif_thr_yield()
#define eif_thr_join_all()
#define eif_thr_wait(term)
#define eif_thr_wait_with_timeout(term,tms) EIF_FALSE
#define eif_thr_join(term)

#define eif_thr_thread_id() NULL
#define eif_thr_last_thread() NULL
#define eif_thr_exit()
#define eif_thr_root_object()	root_obj
#define eif_thr_default_priority() 0
#define eif_thr_min_priority() 0
#define eif_thr_max_priority() 0
#define eif_thr_create_with_attr(current_obj, init_func, attr)
#define eif_thr_create_with_attr_new(current_obj, init_func, log_id, is_proc, attr)
/* Obsolete `eif_thr_create_with_args' but maintained to make it easy to switch between runtime versions. */
#define eif_thr_create_with_args(current_obj, init_func, priority, policy, detach)
#define eif_thr_create(current_object, init_func)

#define eif_thr_sem_create(count) NULL
#define eif_thr_sem_wait(a_sem_pointer)
#define eif_thr_sem_post(a_sem_pointer)
#define eif_thr_sem_trywait(a_sem_pointer) EIF_FALSE
#define eif_thr_sem_destroy(a_sem_pointer)

#define eif_thr_rwl_create() NULL
#define eif_thr_rwl_rdlock(an_item)
#define eif_thr_rwl_unlock(an_item)
#define eif_thr_rwl_wrlock(an_item)
#define eif_thr_rwl_destroy(an_item)

#define eif_thr_mutex_create() NULL
#define eif_thr_mutex_lock(a_mutex_pointer)
#define eif_thr_mutex_unlock(a_mutex_pointer)
#define eif_thr_mutex_trylock(a_mutex_pointer) EIF_FALSE
#define eif_thr_mutex_destroy(a_mutex_pointer)

#define eif_thr_cond_create() NULL
#define eif_thr_cond_broadcast(a_cond_ptr)
#define eif_thr_cond_signal(a_cond_ptr)
#define eif_thr_cond_wait(a_cond_ptr,a_mutex_ptr)
#define eif_thr_cond_wait_with_timeout(a_cond_ptr,a_mutex_ptr,a_timeout) 0
#define eif_thr_cond_destroy(a_mutex_ptr)

#if !defined(EIF_WINDOWS) && !defined(VXWORKS)
/* Forking, only support on Unix platform on which `fork' is supported. */
#define eif_thread_fork	fork
#endif

#else

#ifdef __cplusplus
extern "C" {
#endif

/*------------------------------*/
/*----  Thread-local storage ---*/
/*------------------------------*/

#if defined(USE_TLS)
#	ifdef EIF_WINDOWS
#		ifndef __MINGW32__
#			if defined(EIF_MAKE_DLL) || defined(EIF_USE_DLL)
#				/* TLS can be accessed only through accessors */
#				define EIF_TLS_WRAP
#				define EIF_TLS_DECL __declspec (thread)
#				define EIF_TLS
#			else
#				define EIF_TLS __declspec (thread)
#			endif
#		endif
#	else
#		if defined(__GNUC__) && (__GNUC__ * 100 + __GNUC_MINOR__ >= 303)
#			define EIF_TLS __thread
#		elif EIF_OS == EIF_OS_SUNOS
#			define EIF_TLS __thread	
#		else
#			warning "USE_TLS macro is defined, but compiler does not support thread-local storage specifier."
#		endif
#	endif
#endif

#ifdef EIF_TLS
#	define EIF_HAS_TLS
#else
#	undef EIF_HAS_TLS
#	define EIF_TLS
#endif

#ifdef EIF_HAS_TLS
#	define EIF_TSD_VAL_TYPE        eif_global_context_t *
#	define EIF_TSD_TYPE            eif_global_context_t *
#elif defined EIF_POSIX_THREADS
#	define EIF_TSD_VAL_TYPE        void *
#	define EIF_TSD_TYPE            pthread_key_t
#elif defined EIF_WINDOWS
#	define EIF_TSD_VAL_TYPE        LPVOID
#	define EIF_TSD_TYPE            DWORD
#elif defined SOLARIS_THREADS
#	define EIF_TSD_VAL_TYPE        void *
#	define EIF_TSD_TYPE            thread_key_t
#elif defined VXWORKS
#	define EIF_TSD_VAL_TYPE        eif_global_context_t *
#	define EIF_TSD_TYPE            eif_global_context_t *
#endif


/*------------------------------*/
/*---- Feature definitions -----*/
/*------------------------------*/

RT_LNK void eif_thr_panic(char *);

#if !defined(EIF_WINDOWS) && !defined(VXWORKS)
/* Forking, only support on Unix platform on which `fork' is supported. */
RT_LNK pid_t eif_thread_fork(void);
#endif


/* Exported functions */
RT_LNK void eif_thr_init_root(void);
RT_LNK void eif_thr_register(int is_external);
RT_LNK int eif_thr_is_initialized(void);
RT_LNK EIF_REFERENCE eif_thr_root_object(void);
RT_LNK EIF_BOOLEAN eif_thr_is_root(void);
RT_LNK void eif_thr_create(EIF_OBJECT, EIF_POINTER);
RT_LNK void eif_thr_exit(void);
RT_LNK void eif_thr_yield(void);
RT_LNK void eif_thr_join_all(void);
RT_LNK void eif_thr_join(EIF_POINTER);
RT_LNK void eif_thr_wait(EIF_OBJECT);
RT_LNK EIF_BOOLEAN eif_thr_wait_with_timeout(EIF_OBJECT, EIF_NATURAL_64);
RT_LNK void *eif_thr_impersonate(EIF_SCP_PID);
RT_LNK void eif_thr_create_with_attr(EIF_OBJECT, EIF_PROCEDURE, EIF_THR_ATTR_TYPE *);
RT_LNK void eif_thr_create_with_attr_new(EIF_OBJECT, EIF_PROCEDURE, EIF_INTEGER_32, EIF_BOOLEAN, EIF_THR_ATTR_TYPE *);
/* Obsolete `eif_thr_create_with_args' but maintained to make it easy to switch between runtime versions. */
#define eif_thr_create_with_args(current_obj, init_func, priority, policy, detach)	\
	eif_thr_create_with_attr(current_obj,init_func, NULL);
RT_LNK EIF_INTEGER eif_thr_default_priority(void);
RT_LNK EIF_INTEGER eif_thr_min_priority(void);
RT_LNK EIF_INTEGER eif_thr_max_priority(void);
RT_LNK EIF_POINTER eif_thr_thread_id(void);
RT_LNK EIF_POINTER eif_thr_last_thread(void);

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
RT_LNK EIF_INTEGER eif_thr_cond_wait_with_timeout (EIF_POINTER cond, EIF_POINTER mutex, EIF_INTEGER a_timeout);
RT_LNK void eif_thr_cond_destroy (EIF_POINTER cond);

/*------------------------------------*/
/*---  Read/Write lock operations  ---*/
/*------------------------------------*/

RT_LNK EIF_POINTER eif_thr_rwl_create (void);
RT_LNK void eif_thr_rwl_rdlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_wrlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_unlock (EIF_POINTER rwlp);
RT_LNK void eif_thr_rwl_destroy (EIF_POINTER rwlp);

/*------------------------*/
/*---  Memory barriers ---*/
/*------------------------*/

#if defined(_WIN32) && defined(_MSC_VER)
#	if (_MSC_VER >= 1400)
		void _ReadBarrier(void);
		void _ReadWriteBarrier(void);
		void _WriteBarrier(void);
#		pragma intrinsic(_ReadBarrier)
#		pragma intrinsic(_ReadWriteBarrier)
#		pragma intrinsic(_WriteBarrier)
#		define EIF_MEMORY_READ_BARRIER _ReadBarrier()
#		define EIF_MEMORY_BARRIER _ReadWriteBarrier()
#		define EIF_MEMORY_WRITE_BARRIER _WriteBarrier()
#	elif (_MSC_VER >= 1300)
		void _ReadWriteBarrier(void);
#		pragma intrinsic(_ReadWriteBarrier)
#		define EIF_MEMORY_BARRIER _ReadWriteBarrier()
#	elif defined(MemoryBarrier)
#		define EIF_MEMORY_BARRIER MemoryBarrier()
#	endif
#endif

#ifdef EIF_MEMORY_BARRIER
#	define EIF_HAS_MEMORY_BARRIER
#endif

#ifdef EIF_HAS_MEMORY_BARRIER
#	ifndef EIF_MEMORY_READ_BARRIER
#		define EIF_MEMORY_READ_BARRIER EIF_MEMORY_BARRIER
#	endif /* EIF_MEMORY_READ_BARRIER */
#	ifndef EIF_MEMORY_WRITE_BARRIER
#		define EIF_MEMORY_WRITE_BARRIER EIF_MEMORY_BARRIER
#	endif /* EIF_MEMORY_WRITE_BARRIER */
#endif

#ifdef __cplusplus
}
#endif

#endif /* EIF_THREADS */


#ifdef __cplusplus
extern "C" {
#endif

/*************************************
 *   Definitions for once routines   *
 *************************************/

#define EIF_CHARACTER_result EIF_CHARACTER_8_result
#define EIF_WIDE_CHAR_result EIF_CHARACTER_32_result
typedef struct tag_EIF_once_value_t {
	union {
		EIF_BOOLEAN      EIF_BOOLEAN_result;
		EIF_CHARACTER_8  EIF_CHARACTER_8_result;
		EIF_CHARACTER_32 EIF_CHARACTER_32_result;
		EIF_INTEGER_8    EIF_INTEGER_8_result;
		EIF_INTEGER_16   EIF_INTEGER_16_result;
		EIF_INTEGER      EIF_INTEGER_result;
		EIF_INTEGER_32   EIF_INTEGER_32_result;
		EIF_INTEGER_64   EIF_INTEGER_64_result;
		EIF_NATURAL_8    EIF_NATURAL_8_result;
		EIF_NATURAL_16   EIF_NATURAL_16_result;
		EIF_NATURAL      EIF_NATURAL_result;
		EIF_NATURAL_32   EIF_NATURAL_32_result;
		EIF_NATURAL_64   EIF_NATURAL_64_result;
		EIF_REAL_32      EIF_REAL_32_result;
		EIF_REAL_64      EIF_REAL_64_result;
		EIF_REFERENCE *  EIF_REFERENCE_result;
		EIF_POINTER      EIF_POINTER_result;
	} result;                  /* Result of a once function (if any) */
	EIF_REFERENCE   *exception;    /* Associated exception object (if any) */
	EIF_BOOLEAN     done;      /* Can result be used?                */
#ifndef WORKBENCH
	EIF_BOOLEAN     succeeded; /* Is feature succesfully evaluated?  */
#endif
} EIF_once_value_t;

#ifdef EIF_THREADS
typedef struct tag_EIF_process_once_value_t {
	EIF_once_value_t value;  /* Once data */
	EIF_REFERENCE reference; /* Reference result (if any) */
	EIF_REFERENCE exception; /* Exception (if any) */
	EIF_MUTEX_TYPE * mutex;  /* Mutex to synchronize access to data */
	EIF_POINTER thread_id;   /* ID of a thread that owns a mutex */
	EIF_BOOLEAN completed;   /* Has execution been completed? */
} EIF_process_once_value_t;
#endif

/* Macros for once routines:
 *  MTOT - type of an element that is used to access once value
 *  MTOI(n) - get item used to store result of a once routinewith index "n"
 *  MTOD(i) - tell whether once routine was ever executed
 *  MTOR(t,i) - retrieve result of type "t" for a once routine "i"
 *  MTOP(t,i,v) - put result value of type "t" for a once routine "i"
 *  MTOM(i) - flag that a once routine "i" is executed
 *  MTOE(i,e) - record that once routine "i" has failed with exception "e". Copy pointer of EIF_REFERENCE.
 *  MTOEV(i,e) - record that once routine "i" has failed with exception "e", Copy value of EIF_REFERENCE.
 *  MTOF(i) - get an exception raised in once routine "i"
 */
#define MTOT EIF_once_value_t*
#define MTOI(index) (EIF_once_values+(index))
#define MTOD(item)  ((item)->done)
#define MTOR(result_type,item) ((item)->result.CAT2(result_type,_result))
#define MTOP(result_type,item,value) ((item)->result.CAT2(result_type,_result)) = (value)
#define MTOM(item)      (item)->done = EIF_TRUE
#define MTOE(item,ex_obj) (item)->exception = (ex_obj)
#define MTOEV(item,ex_obj) *((item)->exception) = (ex_obj)
#define MTOF(item)      (item)->exception

#ifdef __cplusplus
}

#endif

#endif	/* _eif_threads_h_ */
