/*
	description: "Global variables handling."
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

		/* except.c */
	struct xstack eif_stack_cx;			/* Calling stack */
	struct eif_exception exdata_cx;		/* Exception handling global flags */

		/* plug.c */
	int nstcall_cx;			/* Nested call global variable: signals a nested call and
							 * trigger an invariant check in generated C routines  */

		/* main.c */
	EIF_once_value_t *EIF_once_values_cx;	/* Once values for a thread */
	EIF_REFERENCE **EIF_oms_cx;		/* Once manifest strings for a thread */
	int in_assertion_cx ;    /* Is an assertion evaluated? */

		/* garcol.c */
	struct stack once_set_cx;	/* Once functions */
	struct stack oms_set_cx;	/* Once manifest strings */

		/* option.c */
	int trace_call_level_cx;
	struct stack *prof_stack_cx;

		/* storable.c from EiffelNet */
	int socket_fides_cx;

#ifdef WORKBENCH
		/* debug.c */
	struct dbinfo d_data_cx;			/* Global debugger information */
	struct c_opstack cop_stack_cx;

		/* interp.c */
	unsigned char *IC_cx;				/* Interpreter Counter (like PC on a CPU) */

		/* related to RT_... Eiffel class */
	int is_inside_rt_eiffel_code_cx;

#endif	/* WORKBENCH */

		/* garcol.c */
#ifdef ISE_GC
	struct stack loc_stack_cx;			/* Local indirection stack */
	struct stack loc_set_cx;	/* Local variable stack */

		/* hector.c */
	struct stack hec_stack_cx;		/* Indirection table "hector stack" for references passed to C*/
#endif
	int16 caller_assertion_level_cx;	/* Assertion level of the caller */

		/* Polymorphism. */
	int eif_optimize_return_cx;	/* Should caller optimize return? */
	EIF_TYPED_VALUE eif_optimized_return_value_cx;	/* Location where data is stored. */
	
} eif_global_context_t;


	/*
	 * Definition of the macros EIF_GET_CONTEXT
	 *
	 * EIF_GET_CONTEXT used to contain an opening curly brace `{'. It is
	 * now changed in order not to need it anymore: it is part of the local
	 * variables declarations.
	 */

#if defined EIF_TLS_WRAP /* Wrapped thread-local storage is supported */
#define EIF_GET_CONTEXT \
	eif_global_context_t * EIF_VOLATILE eif_globals = eif_global_key_get ();

#elif defined EIF_HAS_TLS /* Thread-local storage is supported */
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
#define d_data						(eif_globals->d_data_cx)		/* rt_public */
#define cop_stack					(eif_globals->cop_stack_cx)		/* rt_public */

#define is_inside_rt_eiffel_code	(eif_globals->is_inside_rt_eiffel_code_cx)	/* rt_public */
#endif

#define eif_stack			(eif_globals->eif_stack_cx)	/* rt_public */
#define exdata				(eif_globals->exdata_cx)	/* rt_public */

#ifdef WORKBENCH
#define IC							(eif_globals->IC_cx)			/* rt_public */
#endif

#define caller_assertion_level (eif_globals->caller_assertion_level_cx)	/* rt_public*/
#define nstcall				(eif_globals->nstcall_cx)			/* rt_public */

#define EIF_once_values			(eif_globals->EIF_once_values_cx)	/* rt_public */
#define EIF_oms					(eif_globals->EIF_oms_cx)	/* rt_public */
#define in_assertion			(eif_globals->in_assertion_cx)	/* rt_public */

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

#define eif_optimize_return	(eif_globals->eif_optimize_return_cx)			/* rt_public */
#define eif_optimized_return_value	(eif_globals->eif_optimized_return_value_cx)			/* rt_public */

#ifdef EIF_TLS_WRAP
RT_LNK EIF_TSD_TYPE eif_global_key_get (void);
#else
RT_LNK EIF_TLS EIF_TSD_TYPE eif_global_key;
#endif

#endif	/* EIF_THREADS */

#define GTCX	EIF_GET_CONTEXT

#ifdef __cplusplus
}
#endif

#endif	/* _eif_globals_h_ */
