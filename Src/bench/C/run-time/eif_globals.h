/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Global variables handling.
*/

#ifndef _eif_globals_h_
#define _eif_globals_h_

#include "eif_portable.h"
#include "eif_types.h"
#include "eif_threads.h"
#include "eif_main.h"
#include "eif_macros.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS

/******************************************
 *    Traditional run-time definitions    *
 ******************************************/

#define EIF_GET_CONTEXT

#else

/****************************************
 *    Reentrant run-time definitions    *
 ****************************************/


typedef struct tag_eif_globals		/* Structure containing all global variables to the run-time */
{
#ifdef EIF_WINDOWS
		/* WEL private data. It needs to be at the top of the structure,
		 * because we want it to work no matter if WORKBENCH is defined or not. */
	void *wel_per_thread_data;
#endif

#ifdef WORKBENCH
		/* debug.c */
	struct dbinfo d_data_cx;			/* Global debugger information */
	struct opstack cop_stack_cx;
#endif

		/* except.c */
	struct xstack eif_stack_cx;			/* Calling stack */
	struct eif_exception exdata_cx;		/* Exception handling global flags */

		/* interp.c */
#ifdef WORKBENCH
	unsigned char *IC_cx;				/* Interpreter Counter (like PC on a CPU) */
#endif	/* WORKBENCH */

		/* plug.c */
	int nstcall_cx;			/* Nested call global variable: signals a nested call and
							 * trigger an invariant check in generated C routines  */

		/* main.c */
	EIF_once_value_t *EIF_once_values_cx;	/* Once values for a thread */
	EIF_REFERENCE **EIF_oms_cx;		/* Once manifest strings for a thread */
	int in_assertion_cx ;    /* Is an assertion evaluated? */

		/* garcol.c */
#ifdef ISE_GC
	struct stack loc_stack_cx;			/* Local indirection stack */
	struct stack loc_set_cx;	/* Local variable stack */
#endif
	struct stack once_set_cx;	/* Once functions */
	struct stack oms_set_cx;	/* Once manifest strings */

		/* hector.c */
#ifdef ISE_GC
	struct stack hec_stack_cx;		/* Indirection table "hector stack" for references passed to C*/
#endif

		/* option.c */
	int trace_call_level_cx;
	struct stack *prof_stack_cx;

		/* storable.c from EiffelNet */
	int socket_fides_cx;
} eif_global_context_t;


	/*
	 * Definition of the macros EIF_GET_CONTEXT
	 *
	 * EIF_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 */

#if defined EIF_HAS_TLS /* Thread-local storage is supported */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_global_key;

#elif defined EIF_POSIX_THREADS	/* POSIX Threads */
#if defined EIF_NONPOSIX_TSD || defined POSIX_10034A
rt_private eif_global_context_t * eif_pthread_getspecific (EIF_TSD_TYPE global_key) {
	eif_global_context_t * Result;
	(void) pthread_getspecific(global_key,(void **)&Result);
	return Result;
}
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_pthread_getspecific(eif_global_key);
#else /* EIF_NONPOSIX_TSD */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = pthread_getspecific (eif_global_key);
#endif /* EIF_NONPOSIX_TSD */

#elif defined VXWORKS			/* VxWorks Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_global_key;

#elif defined EIF_WINDOWS			/* Windows Threads */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = \
		(eif_global_context_t *) TlsGetValue (eif_global_key);

#elif defined SOLARIS_THREADS	/* Solaris Threads */
rt_private eif_global_context_t * eif_thr_getspecific (EIF_TSD_TYPE global_key) {
	void * Result;
	(void) thr_getspecific(global_key,&Result);
	return Result;
}
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_thr_getspecific (eif_global_key);

#else
	Platform not supported for multithreading, check that you are using
	the correct EIFFEL flags
#endif
	

/*
 *	Macros definitions.
 *
 */

#ifdef WORKBENCH
#define d_data				(eif_globals->d_data_cx)		/* rt_public */
#define cop_stack			(eif_globals->cop_stack_cx)		/* rt_public */
#endif

#define eif_stack			(eif_globals->eif_stack_cx)	/* rt_public */
#define exdata				(eif_globals->exdata_cx)	/* rt_public */

#ifdef WORKBENCH
#define IC					(eif_globals->IC_cx)			/* rt_public */
#endif

#define nstcall				(eif_globals->nstcall_cx)			/* rt_public */

#define EIF_once_values		(eif_globals->EIF_once_values_cx)	/* rt_public */
#define EIF_oms			(eif_globals->EIF_oms_cx)	/* rt_public */
#define in_assertion		(eif_globals->in_assertion_cx)	/* rt_public */

#ifdef ISE_GC
#define loc_set				(eif_globals->loc_set_cx) /* rt_public */
#define loc_stack			(eif_globals->loc_stack_cx) /* rt_public */
#endif
#define once_set			(eif_globals->once_set_cx) /* rt_public */
#define oms_set				(eif_globals->oms_set_cx) /* rt_public */

#ifdef ISE_GC
#define hec_stack			(eif_globals->hec_stack_cx)		/* rt_public */
#endif

#define trace_call_level	(eif_globals->trace_call_level_cx)
#define prof_stack			(eif_globals->prof_stack_cx)

#define socket_fides		(eif_globals->socket_fides_cx)

RT_LNK EIF_TLS EIF_TSD_TYPE eif_global_key;

#endif	/* EIF_THREADS */

#define GTCX	EIF_GET_CONTEXT

#ifdef __cplusplus
}
#endif

#endif	/* _eif_globals_h_ */
