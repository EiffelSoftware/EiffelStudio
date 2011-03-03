/*
	description: "Thread management routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2009, Eiffel Software."
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

/*
doc:<file name="eif_thread.c" header="eif_thread.h" version="$Id$" summary="Thread management routines">
*/

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "rt_threads.h"
#include "eif_posix_threads.h"
#include "rt_lmalloc.h"
#include "rt_globals.h"
#include "rt_err_msg.h"
#include "eif_sig.h"
#include "rt_garcol.h"
#include "rt_malloc.h"
#include "rt_macros.h"
#include "rt_types.h"
#include "rt_interp.h"
#include "rt_assert.h"
#include "rt_retrieve.h"
#include "rt_gen_conf.h"
#include "rt_hector.h"
#include "rt_run_idr.h"
#include "rt_store.h"
#include "rt_except.h"
#include "rt_memory.h"
#include "rt_option.h"
#include "rt_traverse.h"
#include "rt_object_id.h"
#include "rt_cecil.h"
#include "rt_debug.h"
#include "rt_main.h"
#include "eif_error.h"
#ifdef BOEHM_GC
#include "rt_boehm.h"
#endif

#include <string.h>


#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

rt_public void eif_thr_panic(char *);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(int is_external);
rt_public int eif_thr_is_initialized(void);

rt_public void eif_thr_create_with_attr(EIF_OBJECT, EIF_PROCEDURE, EIF_THR_ATTR_TYPE *);
rt_public void eif_thr_create_with_attr_new(EIF_OBJECT, EIF_PROCEDURE, EIF_INTEGER_32, EIF_BOOLEAN, EIF_THR_ATTR_TYPE *);
rt_public void eif_thr_exit(void);

rt_public EIF_POINTER eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_POINTER);
rt_public void eif_thr_mutex_unlock(EIF_POINTER);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER);
rt_public void eif_thr_mutex_destroy(EIF_POINTER);

rt_private rt_global_context_t *eif_new_context (void);
rt_private void eif_free_context (rt_global_context_t *);
rt_private void eif_thr_entry(void *);
rt_private EIF_THR_TYPE eif_thr_current_thread(void);

	/* To update GC with thread specific data */
rt_private void eif_remove_gc_stacks(rt_global_context_t *);
rt_private void eif_init_gc_stacks(rt_global_context_t *);
rt_private void eif_free_gc_stacks (void);
rt_private void load_stack_in_gc (struct stack_list *, void *);
rt_private void remove_data_from_gc (struct stack_list *, void *);
rt_private void eif_stack_free (void *stack);

#ifdef EIF_TLS_WRAP
/*
doc:	<function name="eif_global_key" return_type="EIF_TSD_TYPE" export="private">
doc:		<summary>Key used to access per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</function>
*/
rt_private EIF_TLS_DECL EIF_TSD_TYPE eif_global_key;
/*
doc:	<routine name="eif_global_key_get" return_type="EIF_TSD_TYPE" export="public">
doc:		<summary>Key used to access per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public EIF_TSD_TYPE eif_global_key_get (void)
{
	return eif_global_key;
}
#else
/*
doc:	<attribute name="eif_global_key" return_type="EIF_TSD_TYPE" export="public/private">
doc:		<summary>Key used to access per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_public EIF_TLS EIF_TSD_TYPE eif_global_key;
#endif

#ifdef EIF_TLS_WRAP
/*
doc:	<attribute name="rt_global_key" return_type="RT_TSD_TYPE" export="private">
doc:		<summary>Key used to access private per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_private EIF_TLS_DECL RT_TSD_TYPE rt_global_key;
/*
doc:	<routine name="rt_global_key_get" return_type="RT_TSD_TYPE" export="shared">
doc:		<summary>Key used to access private per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared RT_TSD_TYPE rt_global_key_get (void)
{
	return rt_global_key;
}
#else
/*
doc:	<attribute name="rt_global_key" return_type="RT_TSD_TYPE" export="shared">
doc:		<summary>Key used to access private per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</attribute>
*/
rt_shared EIF_TLS RT_TSD_TYPE rt_global_key;
#endif

/*
doc:	<attribute name="eif_thread_launch_mutex" return_type="EIF_CS_TYPE *" export="private">
doc:		<summary>Mutex used to protect launching of a thread.</summary>
doc:		<thread_safety>Safe, initialized once in `eif_thr_root_init'.</thread_safety>
doc:		<synchronization>None</synchronization>
doc:		<fixme>Mutex is not freed.</fixme>
doc:	</attribute>
*/
rt_private EIF_CS_TYPE *eif_thread_launch_mutex = NULL;

/*
doc:	<attribute name="eif_is_gc_collecting" return_type="int" export="public">
doc:		<summary>Is GC currently performing a collection?</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_public int volatile eif_is_gc_collecting = 0;

/*
doc:	<attribute name="rt_globals_list" return_type="struct stack_list" export="private">
doc:		<summary>Used to store all per thread data of all running threads.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>eif_gc_mutex</synchronization>
doc:	</attribute>
*/
rt_private struct stack_list rt_globals_list = {
	(int) 0,	/* count */
	(int) 0,	/* capacity */
	{NULL}		/* rt_globals_list */
};


/* Debugger usage */
#ifdef WORKBENCH
/*
doc:	<routine name="get_thread_index" export="private">
doc:		<summary>This is used to get the index of thread `th_id' in rt_globals_list.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock. (i.e: encapsulated in eif_synchronize_gc and eif_unsynchronize_gc</synchronization>
doc:	</routine>
*/
rt_private int get_thread_index(EIF_THR_TYPE th_id)
{
#ifdef EIF_THREADS
	int count;
	int i;
	rt_global_context_t ** lst;
	
	REQUIRE("eif GC synchronized", eif_is_synchronized());
	count = rt_globals_list.count;
	lst = (rt_global_context_t **) rt_globals_list.threads.data;
	for (i = 0; i < count; i++) {
		if (th_id == (((rt_global_context_t*)lst[i])->eif_thr_context_cx->thread_id)) {
			break;
		}
	}
	return i;
#else
	return 0;
#endif
}

/*
doc:	<routine name="dbg_switch_to_thread" export="shared">
doc:		<summary>This is used to put `th_id''s thread context into current thread's context. Should be temporary, and we should replace orignal context right after. Return current thread id (to be used for restoring current context.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock. (i.e: encapsulated in eif_synchronize_gc and eif_unsynchronize_gc</synchronization>
doc:	</routine>
*/

rt_shared EIF_THR_TYPE dbg_switch_to_thread (EIF_THR_TYPE th_id) {
	RT_GET_CONTEXT
	rt_global_context_t ** p_rtglob;
	eif_global_context_t ** p_eifglob;
	EIF_THR_TYPE thid;
	thid = rt_globals->eif_thr_context_cx->thread_id;

#define thread_rt_globals(th_id) ( ((rt_global_context_t **) rt_globals_list.threads.data)[get_thread_index(th_id)] ) 

	if (th_id != 0) {
		if (thid != th_id) {
#ifdef DEBUG
			printf ("Switch from %d to %d \n\n", thid, th_id);
#endif
			CHECK("eif GC synchronized", eif_is_synchronized());
			p_rtglob = &thread_rt_globals (th_id);
			p_eifglob = &((*p_rtglob)->eif_globals);
			EIF_TSD_SET(rt_global_key, *p_rtglob, "switch to thread id (rt).");	
			EIF_TSD_SET(eif_global_key, *p_eifglob, "switch to thread id (eif).");	
		}
	}
#undef thread_rt_globals
	return thid;
}
#endif

#define LAUNCH_MUTEX_LOCK		RT_TRACE(eif_pthread_cs_lock(eif_thread_launch_mutex))
#define LAUNCH_MUTEX_UNLOCK		RT_TRACE(eif_pthread_cs_unlock(eif_thread_launch_mutex))

rt_private void eif_thr_init_global_mutexes (void)
{
#ifdef ISE_GC
	RT_TRACE(eif_pthread_cs_create(&eif_gc_mutex, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_gc_set_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_gc_gsz_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_type_set_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_free_list_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eiffel_usage_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&trigger_gc_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_rt_g_data_mutex, 100));
#endif
	RT_TRACE(eif_pthread_cs_create(&eif_thread_launch_mutex, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_except_lock, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_memory_mutex, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_trace_mutex, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_eo_store_mutex, 0));
	RT_TRACE(eif_pthread_cs_create(&eif_global_once_set_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_object_id_stack_mutex, 4000));
	RT_TRACE(eif_pthread_cs_create(&eif_gen_mutex, 100));
	RT_TRACE(eif_pthread_cs_create(&eif_hec_saved_mutex, 100));
	RT_TRACE(eif_pthread_cs_create(&eif_cecil_mutex, 0));
#ifdef EIF_WINDOWS
	RT_TRACE(eif_pthread_cs_create(&eif_console_mutex, 0));
#endif
}

rt_public void eif_thr_init_root(void) 
{
	/*
	 * This function must be called once and only once at the very beginning
	 * of an Eiffel program (typically from main()) or the first time a thread
	 * initializes the Eiffel run-time if it is part of a Cecil system.
	 * The global key for Thread Specific Data is initialized: this variable
	 * is shared by all the threads, but it allows them to fetch a pointer
	 * to their own context (eif_globals structure).
	 */

	EIF_TSD_CREATE(eif_global_key,"Couldn't create global key for root thread");
	EIF_TSD_CREATE(rt_global_key,"Couldn't create private global key for root thread");
	eif_thr_init_global_mutexes();
	eif_thr_register(0);
#ifdef ISE_GC
	create_scavenge_zones();
#endif
}

/*
doc:	<routine name="eif_thread_cleanup" export="shared">
doc:		<summary>To cleanup thread runtime data such as mutexes used for synchronization of CECIL, memory and GC.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared void eif_thread_cleanup (void)
{
	RT_GET_CONTEXT
	int destroy_mutex = 0;

	REQUIRE("is_root", eif_thr_context->is_root);

		/* Free per thread data which is not free because root thread
		 * does not go through `eif_thr_exit'. See `eif_thr_exit' for explanation. */
	if (eif_thr_context->children_mutex) {
		EIF_ASYNC_SAFE_MUTEX_LOCK(eif_thr_context->children_mutex);
		if (eif_thr_context->n_children == 0) destroy_mutex = 1; /* No children are alive */
		EIF_ASYNC_SAFE_MUTEX_UNLOCK(eif_thr_context->children_mutex);
	}
	if (destroy_mutex) {
		RT_TRACE(eif_pthread_mutex_destroy(eif_thr_context->children_mutex));
		eif_thr_context->children_mutex = NULL;
		RT_TRACE(eif_pthread_cond_destroy(eif_thr_context->children_cond));
		eif_thr_context->children_cond = NULL;
			/* Context data if any */
		eif_thr_context->thread_id = (EIF_THR_TYPE) 0;
		eif_free (eif_thr_context);		/* Thread context passed by parent */
		eif_thr_context = NULL;
	}

		/* Free rt_globals context */
	eif_free_context (rt_globals);

		/* Free GC allocated stacks. */
	eif_free_gc_stacks ();

#ifdef ISE_GC
	RT_TRACE(eif_pthread_cs_destroy(eif_gc_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_gc_set_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_gc_gsz_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_type_set_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_free_list_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eiffel_usage_mutex));
	RT_TRACE(eif_pthread_cs_destroy(trigger_gc_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_rt_g_data_mutex));
#endif
	RT_TRACE(eif_pthread_cs_destroy(eif_thread_launch_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_except_lock));
	RT_TRACE(eif_pthread_cs_destroy(eif_memory_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_trace_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_eo_store_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_global_once_set_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_object_id_stack_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_gen_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_hec_saved_mutex));
	RT_TRACE(eif_pthread_cs_destroy(eif_cecil_mutex));
#ifdef EIF_WINDOWS
	RT_TRACE(eif_pthread_cs_destroy(eif_console_mutex));
#endif

	EIF_TSD_DESTROY(eif_global_key, "Could not free key");
	EIF_TSD_DESTROY(rt_global_key, "Could not free key");
}

rt_public void eif_thr_register(int is_external)
{
	/*
	 * Allocates memory for the rt_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for onces (for non-root threads)
	 */

	static int not_root_thread = 0;	/* For initial eif_thread, we don't know how
							 		 * many once values we have to allocate */

	rt_global_context_t *rt_globals = eif_new_context();

	{
		EIF_GET_CONTEXT

		if (not_root_thread) {
		
			/* Allocate room for once manifest strings array. */
			ALLOC_OMS (EIF_oms);

			if (EIF_once_count == 0) {
				EIF_once_values = (EIF_once_value_t *) 0;
			} else {
				/*
				 * Allocate room for once values for all threads but the initial 
				 * because we do not have the number of onces yet
				 * Also set value root thread id.
				 */
				EIF_once_values = (EIF_once_value_t *) eif_realloc (EIF_once_values, EIF_once_count * sizeof *EIF_once_values);
					/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
				if (EIF_once_values == (EIF_once_value_t *) 0) /* Out of memory */
					enomem();
				memset ((EIF_REFERENCE) EIF_once_values, 0, EIF_once_count * sizeof *EIF_once_values);
			}
		} else {
			not_root_thread = 1;

			eif_thr_context = (rt_thr_context *) eif_malloc (sizeof (rt_thr_context));
			if (eif_thr_context == NULL) {
				eif_panic ("Couldn't allocate thread context");
			} else {
				memset (eif_thr_context, 0, sizeof (rt_thr_context));
				eif_thr_context->is_alive = 1;
				eif_thr_context->is_root = 1;
				eif_thr_context->thread_id = eif_thr_current_thread();
				eif_thr_context->is_processor = eif_thr_context->is_processor;
				eif_thr_context->logical_id = eif_thr_context->logical_id; 
#ifdef WORKBENCH
				dnotify_create_thread(eif_thr_context->thread_id);
#endif
			}
		}
			/* Is current thread created by the EiffelThread library or by a third party library */
		eif_globals->is_external_cx = is_external;
	}
}

/*
doc:	<routine name="eif_set_thr_context" export="public">
doc:		<summary>Initialize thread context for non Eiffel threads. There is not much to initialize, but this is necessary so that `eif_thr_is_root' can distinguish the root thread from the others.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_public void eif_set_thr_context (void) {
		/* Initialize thread context for non Eiffel Threads.
		 * There is not much to initialize, but this is necessary
		 * so that `eif_thr_is_root ()' can distinguish the root thread
		 * from the others.	*/
	RT_GET_CONTEXT	
	if (rt_globals && !eif_thr_context) {
		eif_thr_context = (rt_thr_context *) eif_malloc (sizeof (rt_thr_context));
		if (eif_thr_context == NULL) {
			eif_panic ("Couldn't allocate thread context");
		} else {
			memset (eif_thr_context, 0, sizeof (rt_thr_context));
			eif_thr_context->is_alive = 1;
			eif_thr_context->is_root = 0;
			eif_thr_context->logical_id = 0;
			eif_thr_context->is_processor = EIF_FALSE;
			eif_thr_context->thread_id = eif_thr_current_thread();
		}
	}
}

/*
doc:	<routine name="eif_thr_current_thread" return_type="EIF_THR_TYPE" export="private">
doc:		<summary>Helper routine to be called only once per thread to avoid leaks (HANDLE leak under Windows). Which will give the associated thread identifier for either the main thread or a thread that was not started by the Eiffel runtime.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_private EIF_THR_TYPE eif_thr_current_thread(void)
{
	EIF_THR_TYPE Result;

#ifdef EIF_WINDOWS
		/* On Windows, `eif_pthread_self' returns a pseudo handle to the Current thread, so we have to do
		 * something special on Windows. */
	Result = OpenThread(THREAD_ALL_ACCESS, FALSE, GetCurrentThreadId());
	CHECK("Cannot be null", Result);
#else
	Result = eif_pthread_self();
#endif
	return Result;
}

/*
doc:	<routine name="eif_thr_root_object" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Return the root object associated with the Current thread. It can be Void in case the thread was not started by the Eiffel runtime.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_thr_root_object(void)
{
	RT_GET_CONTEXT
	if (rt_globals && !(eif_thr_context->is_root)) {
		return eif_access(eif_thr_context->current);
	} else {
		return root_obj;
	}
}

/*
doc:	<routine name="eif_thr_is_root" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>True if the calling thread is the Eiffel root thread. False otherwise.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/
rt_public EIF_BOOLEAN eif_thr_is_root(void)
{
		/* Returns True is the calling thread is the Eiffel root thread,
		 * False otherwise. */
	RT_GET_CONTEXT
	if (rt_globals) {
		return EIF_TEST(eif_thr_context->is_root);
	} else {
		return EIF_FALSE;
	}
}

/* Returns a non-zero value if the calling thread is initialized for Eiffel, zero otherwise. */
rt_public int eif_thr_is_initialized(void)
{
	EIF_GET_CONTEXT
	return (eif_globals != NULL);
}

rt_private rt_global_context_t *eif_new_context (void)
{
	/*
	 * Create rt_globals and eif_globals structure and initializes some of their fields
	 * fields.
	 */
	rt_global_context_t *rt_globals;
	eif_global_context_t *eif_globals;

		/* Create and initialize private context */
#ifdef BOEHM_GC
		/* Because Boehm GC is not able to access per thread data for marking data that might
		 * be references from there, we use the Boehm special allocator `GC_malloc_uncollectable'
		 * which will make `rt_globals' one of the root for the GC mark and sweep. */
	rt_globals = (rt_global_context_t *) GC_malloc_uncollectable (sizeof(rt_global_context_t));
#else
	rt_globals = (rt_global_context_t *) eif_malloc(sizeof(rt_global_context_t));
#endif
	if (!rt_globals) {
		eif_thr_panic("No more memory for thread context");
	}
	memset (rt_globals, 0, sizeof(rt_global_context_t));
	EIF_TSD_SET(rt_global_key, rt_globals, "Couldn't bind private context to TSD.");

		/* Create and initialize public context */
	eif_globals = (eif_global_context_t *) eif_malloc(sizeof(eif_global_context_t));
	if (!eif_globals) {
		eif_free(rt_globals);
		eif_thr_panic("No more memory for thread context");
	}
	memset (eif_globals, 0, sizeof(eif_global_context_t));
	EIF_TSD_SET(eif_global_key, eif_globals, "Couldn't bind public context to TSD.");

		/* Private context has always a reference to public one to avoid 
		 * calls to get thread specific data. */
	rt_globals->eif_globals = eif_globals;

		/* Initialize per thread data. It is done in the module which uses them */

		/* except.c */
	eif_except_thread_init ();

		/* gen_conf.c */
	eif_gen_conf_thread_init ();

		/* retrieve.c */
	eif_retrieve_thread_init ();

		/* run_idr.c */
	eif_run_idr_thread_init ();

		/* store.c */
	eif_store_thread_init ();

		/* eif_threads.c */
#ifdef ISE_GC
		/* By default current thread is allowed to launch a GC cycle */
	thread_can_launch_gc = 1;
#endif

		/* eif_type_id.c */
	eif_pre_ecma_mapping_status = 1;

	eif_init_gc_stacks(rt_globals);

	return rt_globals;
}

/*
doc:	<routine name="eif_free_context" export="private">
doc:		<summary>To cleanup per thread data.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_private void eif_free_context (rt_global_context_t *rt_globals)
{
	eif_global_context_t *eif_globals;

	REQUIRE ("rt_globals not null", rt_globals);

	eif_globals = rt_globals->eif_globals;

		/* gen_conf.c */
	eif_gen_conf_thread_cleanup ();

		/* sig.c */
#ifdef HAS_SIGALTSTACK
	if (c_sig_stk) {
		eif_rt_xfree(c_sig_stk->ss_sp);
		eif_rt_xfree(c_sig_stk);
		c_sig_stk = NULL;
	}
#endif

		/* First free content of `eif_globals'. */
#ifdef EIF_WINDOWS
		/* WEL data if any */
	if (eif_globals->wel_per_thread_data) {
		eif_free (eif_globals->wel_per_thread_data);
	}
#endif

		/* Free array of once manifest strings */
	FREE_OMS (EIF_oms);

	if (EIF_once_values != NULL) {
			/* Free once values. */
		eif_free (EIF_once_values);
		EIF_once_values = NULL;
	}

		/* Free allocated stacks in eif_globals. */
#ifdef ISE_GC
	st_reset (&loc_stack);
	st_reset (&loc_set);
	st_reset (&hec_stack);
#endif
	st_reset (&once_set);
	st_reset (&oms_set);
	if (prof_stack) {
		st_reset (prof_stack);
	}
	xstack_reset (&eif_stack);
#ifdef WORKBENCH
	c_opstack_reset (&cop_stack);
#endif

		/* Free public per thread data */
	eif_free (eif_globals);
	rt_globals->eif_globals = NULL;

		/* Free allocated stacks in rt_globals. */
	xstack_reset (&eif_trace);

		/* Free allocated structure for trace printing. */
	ex_string.used = 0;
	ex_string.size = 0;
	if (ex_string.area) {
		eif_rt_xfree (ex_string.area);
		ex_string.area = NULL;
	}

		/* Free allocated structure for invariant monitoring. */
	if (inv_mark_tablep) {
		eif_rt_xfree(inv_mark_tablep);
		inv_mark_tablep = NULL;
	}

#ifdef WORKBENCH
	opstack_reset (&op_stack);
	dbstack_reset (&db_stack);
	if (iregs) {
		eif_rt_xfree (iregs);
	}
#endif

		/* Free private per thread data */
	eif_free (rt_globals);

		/* Reset the per thread data. */
	EIF_TSD_SET(rt_global_key, NULL, "Couldn't bind private context to TSD.");
	EIF_TSD_SET(eif_global_key, NULL, "Couldn't bind private context to TSD.");
}

rt_public void eif_thr_create_with_attr (EIF_OBJECT thr_root_obj, 
										 EIF_PROCEDURE init_func,
										 EIF_THR_ATTR_TYPE *attr)
{
	eif_thr_create_with_attr_new (thr_root_obj, init_func, -1, EIF_FALSE, attr);
}

rt_public void eif_thr_create_with_attr_new (EIF_OBJECT thr_root_obj, 
										 EIF_PROCEDURE init_func,
										 EIF_INTEGER_32 thr_logical_id,
										 EIF_BOOLEAN is_processor,
										 EIF_THR_ATTR_TYPE *attr)
{
	/*
	 * Creates a new Eiffel thread. This function is only called from
	 * Eiffel and is given five arguments: 
	 * - the object (whose class inherits from THREAD) a clone of which
	 *   will become the root object of the new thread
	 * - the Eiffel routine it will execute
	 * - the priority, the stack size.
	 *
	 * These arguments are part of the routine context that will be
	 * passed to the new thread via the low-level platform-dependant
	 * thread-creation function.
	 *
	 * This context also contains a pointer to the thread-id of the new
	 * thread, a pointer to the parent's children-counter `n_children', a
	 * mutex and a condition variable that are used by eif_thr_join_all()
	 * and eif_thr_exit().
	 */

	RT_GET_CONTEXT

	rt_thr_context *routine_ctxt;
	int res;

	routine_ctxt = (rt_thr_context *) eif_malloc(sizeof(rt_thr_context));
	if (!routine_ctxt) {
		eif_thr_panic("No more memory to launch new thread\n");
	} else {
		memset(routine_ctxt, 0, sizeof(rt_thr_context));
		routine_ctxt->current = eif_adopt (thr_root_obj);
		routine_ctxt->routine = init_func;
		routine_ctxt->thread_id = (EIF_THR_TYPE) 0;
		routine_ctxt->logical_id = thr_logical_id;
		routine_ctxt->is_processor = is_processor;
		routine_ctxt->parent_context = eif_thr_context;
		routine_ctxt->is_alive = 1;

		if (!eif_thr_context->children_mutex) {
				/* It is the first time this thread creates a subthread (hopefully!), so
				 * we create a mutex and a condition variable for join and join_all */
			RT_TRACE_KEEP(res, eif_pthread_mutex_create(&eif_thr_context->children_mutex));
			if (res != T_OK) {
				eif_thr_panic ("Couldn't create join mutex");
			} else {
				RT_TRACE_KEEP(res, eif_pthread_cond_create (&eif_thr_context->children_cond));
				if (res != T_OK) {
						/* Free previously allocated mutex. */
					RT_TRACE(eif_pthread_mutex_destroy(eif_thr_context->children_mutex));
					eif_thr_panic ("Cannot create children condition variable");
				}
			}
		}
		EIF_ASYNC_SAFE_MUTEX_LOCK(eif_thr_context->children_mutex);
		eif_thr_context->n_children++;	
		EIF_ASYNC_SAFE_MUTEX_UNLOCK(eif_thr_context->children_mutex);

		SIGBLOCK;
		LAUNCH_MUTEX_LOCK;

			/* Actual creation of the thread in the next 3 lines. */
		RT_TRACE_KEEP(res, eif_pthread_create (&routine_ctxt->thread_id, attr, eif_thr_entry, routine_ctxt));
		last_child = routine_ctxt->thread_id;
		LAUNCH_MUTEX_UNLOCK;
		SIGRESUME;
		if (res == T_CANNOT_CREATE_THREAD) {
			eraise("Cannot create thread", EN_EXT);
		}
	}
}

rt_private void eif_thr_entry (void *arg)
{
	/*
	 * This function is a wrapper to the Eiffel routine that will be
	 * executed by the new thread. It is directly called upon creation
	 * of the thread, and initializes the Eiffel run-time.
	 */

	rt_thr_context *routine_ctxt = (rt_thr_context *) arg;
		/* To prevent current thread to return too soon after call
		 * to eif_pthread_create.
		 * That way `thread' is properly initialized and can be freed
		 * safely later on */
	LAUNCH_MUTEX_LOCK;
	LAUNCH_MUTEX_UNLOCK;
	eif_thr_register(0);
	{
		RT_GET_CONTEXT
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;

		eif_thr_context = routine_ctxt;
		initsig();
		initstk();
		if (egc_prof_enabled)
			initprf();
		exvect = new_exset((char *) 0, 0, (char *) 0, 0, 0, 0);
		exvect->ex_jbuf = &exenv;

#ifdef _CRAY
		if (setjmp(exenv))
			failure();
#else
		if ((echval = setjmp(exenv)))
			failure();
#endif

#ifdef WORKBENCH
		xinitint();
			/* Call the `execute' routine of the thread */
		dnotify_create_thread(eif_thr_context->thread_id);
		if (eif_thr_context->is_processor == EIF_TRUE)
				dnotify_register_scoop_processor (eif_thr_context->thread_id, eif_thr_context->logical_id);

#endif
		init_emnger(); /* Initialize objects hold by exception manager */
		if (eif_thr_context->logical_id != -1)
				// A logical ID has been set so pass to Eiffel thread init callback.
			(FUNCTION_CAST(void,(EIF_REFERENCE, EIF_INTEGER_32)) eif_thr_context->routine)(eif_access(routine_ctxt->current), eif_thr_context->logical_id);
		else
			(FUNCTION_CAST(void,(EIF_REFERENCE)) eif_thr_context->routine)(eif_access(routine_ctxt->current));

		exok();
	}
	eif_thr_exit ();
	return;
}

rt_public void eif_thr_exit(void)
{
	/*
	 * Function called to terminate a thread launched by Eiffel with eif_thr_create_with_attr().
	 * All the memory allocated with eif_malloc() for the thread context is freed
	 * This function must be called from the thread itself (not the parent).
	 */

	RT_GET_CONTEXT

	if (!thread_exiting) {
#ifdef LMALLOC_CHECK
			/* Perform call to `eif_thr_is_root' now as later, it would fail
			 * since the per thread data could be removed if thread is exiting
			 * following a call to `eif_terminate_all_other_threads'. */
		EIF_BOOLEAN is_root_thread = eif_thr_is_root();
#endif
		int destroy_mutex; /* If non null, we'll destroy the 'join' mutex */
		int l_has_parent_thread;
		int ret;	/* Return Status of "eifaddr_offset". */
		EIF_INTEGER offset;	/* Location of `terminated' in `eif_thr_context->current' */
		EIF_MUTEX_TYPE *l_children_mutex, *l_parent_children_mutex;
		EIF_THR_TYPE l_thread_id = eif_thr_context->thread_id;

		thread_exiting = 1;

		REQUIRE("has_context", eif_thr_context);

		l_has_parent_thread = (eif_thr_context->current) && (eif_thr_context->parent_context);
#ifdef WORKBENCH
		if (l_has_parent_thread) {
			dnotify_exit_thread(eif_thr_context->thread_id);
		}
#endif
		exitprf();

		if (l_has_parent_thread) {

			if (eif_thr_context->is_processor == EIF_FALSE)
			{
				// Set {THREAD}.terminated to True, not applicable to SCOOP Processors.

				offset = eifaddr_offset (eif_access(eif_thr_context->current), "terminated", &ret);
				CHECK("terminated attribute exists", ret == EIF_CECIL_OK);

					/* Set the `terminated' field of the thread object to True so that
					* it knows the thread is terminated */
				*(EIF_BOOLEAN *) (eif_access(eif_thr_context->current) + offset) = EIF_TRUE;
			}
				
				/* Remove current object from hector and reset entry to NULL. */
			eif_wean(eif_thr_context->current);
			eif_thr_context->current = NULL;

				/* Prevent other threads to wait for current thread in case 
				 * one of the following calls is blocking. */
			EIF_ENTER_C;
			l_parent_children_mutex = eif_thr_context->parent_context->children_mutex;
			EIF_ASYNC_SAFE_MUTEX_LOCK(l_parent_children_mutex);
				/* Decrement the number of child threads of the parent */
			eif_thr_context->parent_context->n_children -= 1;
				/* Check if no children are alive and parent is dead. */
			destroy_mutex = (!eif_thr_context->parent_context->is_alive) && (eif_thr_context->parent_context->n_children == 0);
			RT_TRACE(eif_pthread_cond_broadcast(eif_thr_context->parent_context->children_cond));
			EIF_ASYNC_SAFE_MUTEX_UNLOCK(l_parent_children_mutex);

				/* If we are the last running child of our parent and that our parent does not exist anymore
				 * we have to clean the resources. */
			if (destroy_mutex) {
				RT_TRACE(eif_pthread_mutex_destroy(l_parent_children_mutex));
				RT_TRACE(eif_pthread_cond_destroy(eif_thr_context->parent_context->children_cond));
				eif_thr_context->parent_context->children_cond = NULL;
				eif_free (eif_thr_context->parent_context);
				eif_thr_context->parent_context = NULL;
			}
		} else {
			EIF_ENTER_C;
		}

			/* Every thread that has created a child thread with
			 * eif_thr_create_with_attr() has created a mutex and a condition 
			 * variable to be able to do a join_all (or a join). If no children are
			 * still alive, we destroy eif_children_mutex and eif_children_cond,
			 * otherwise we will let the last child alive do the cleaning. */
		l_children_mutex = eif_thr_context->children_mutex;
		if (l_children_mutex) {
			EIF_ASYNC_SAFE_MUTEX_LOCK(l_children_mutex);
				/* Find out if there are still some children running. */
			destroy_mutex = eif_thr_context->n_children == 0;
			EIF_ASYNC_SAFE_MUTEX_UNLOCK(l_children_mutex);
		} else {
			destroy_mutex = 0;
		}
		if (destroy_mutex) {
			RT_TRACE(eif_pthread_mutex_destroy(l_children_mutex));
			eif_thr_context->children_mutex = NULL;
			RT_TRACE(eif_pthread_cond_destroy(eif_thr_context->children_cond));
			eif_thr_context->children_cond = NULL;
				/* Context data if any */
			eif_thr_context->thread_id = (EIF_THR_TYPE) 0;
			eif_free (eif_thr_context);		/* Thread context passed by parent */
			eif_thr_context = NULL;
		} else {
			eif_thr_context->is_alive = 0;
		}
		EIF_EXIT_C;

#ifdef ISE_GC
			/* Destroy GC data associated with the current thread. Since we also
			 * destroy the data used for signal handling, we cannot handle signals
			 * anymore. So we are just going to prevent the signal from being
			 * processed alltogether by a call to SIGBLOCK without corresponding
			 * SIGRESUME. */
		SIGBLOCK;
		eif_synchronize_gc (rt_globals);
		eif_remove_gc_stacks (rt_globals);
#endif

#ifdef LMALLOC_CHECK
		if (is_root_thread)	{	/* Is this the root thread */
			eif_lm_display ();
			eif_lm_free ();
		}
#endif	/* LMALLOC_CHECK */

			/* Clean per thread data. */
		eif_free_context (rt_globals);
		rt_globals = NULL;

#ifdef ISE_GC
			/* We cannot use `eif_unsynchronize_gc' because `rt_globals' has been completely freed. */
		RT_TRACE(eif_pthread_cs_unlock(eif_gc_mutex));
#endif

#ifdef VXWORKS
		/* The TSD is managed in a different way under VxWorks: each thread
		 * must call taskVarAdd upon initialization and taskVarDelete upon
		 * termination.  It was impossible to call taskVarDelete using the same
		 * model as on other platforms unless creating a new macro that would
		 * be useful only for VxWorks. It is easier to do the following:
		 */


		if (taskVarDelete(0,(int *)&(eif_global_key))) 
		  eif_thr_panic("Problem with taskVarDelete\n");
		if (taskVarDelete(0,(int *)&(rt_global_key))) 
		  eif_thr_panic("Problem with taskVarDelete\n");
#endif	/* VXWORKS */


			/* Only call the platform specific exit when thread was not created by the Eiffel runtime. */
		if (l_has_parent_thread) {
			eif_pthread_exit(l_thread_id);
		}
	}
}	/* eif_thr_exit ().*/


/**************************************************************************/
/* NAME: eif_init_gc_stacks                                               */
/* ARGS: rt_globals: References to thread specific data                   */
/*------------------------------------------------------------------------*/
/* Initialize shared global stacks with thread specific stack. That way   */
/* the GC holds references to Eiffel objects in each thread               */
/**************************************************************************/

rt_private void eif_init_gc_stacks(rt_global_context_t *rt_globals)
{
#ifdef ISE_GC
	eif_global_context_t *eif_globals = rt_globals->eif_globals;
	eif_synchronize_gc(rt_globals);
	load_stack_in_gc (&rt_globals_list, rt_globals);
	load_stack_in_gc (&loc_stack_list, &loc_stack);	
	load_stack_in_gc (&loc_set_list, &loc_set);	
	load_stack_in_gc (&once_set_list, &once_set);	
	load_stack_in_gc (&oms_set_list, &oms_set);	
	load_stack_in_gc (&hec_stack_list, &hec_stack);	
	load_stack_in_gc (&eif_stack_list, &eif_stack);	
	load_stack_in_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	load_stack_in_gc (&opstack_list, &op_stack);
#endif
	eif_unsynchronize_gc(rt_globals);
#endif
}

/**************************************************************************/
/* NAME: eif_free_gc_stacks                                               */
/*------------------------------------------------------------------------*/
/* Free stacks allocated to hold all running threads.                     */
/**************************************************************************/

rt_private void eif_free_gc_stacks(void)
{
#ifdef ISE_GC
	eif_free (rt_globals_list.threads.data);
	eif_free (loc_stack_list.threads.data);
	eif_free (loc_set_list.threads.data);
	eif_free (once_set_list.threads.data);
	eif_free (oms_set_list.threads.data);
	eif_free (hec_stack_list.threads.data);
	eif_free (eif_stack_list.threads.data);
	eif_free (eif_trace_list.threads.data);
#ifdef WORKBENCH
	eif_free (opstack_list.threads.data);
#endif
#endif
}

/**************************************************************************/
/* NAME: eif_remove_gc_stacks                                            */
/* ARGS: rt_globals: References to thread specific data                   */
/*------------------------------------------------------------------------*/
/* Destroy thread specific stacks and remove them from GC global stack    */
/**************************************************************************/

rt_private void eif_remove_gc_stacks(rt_global_context_t *rt_globals)
{
#ifdef ISE_GC
	eif_global_context_t *eif_globals = rt_globals->eif_globals;
	remove_data_from_gc (&rt_globals_list, rt_globals);
	remove_data_from_gc (&loc_stack_list, &loc_stack);
	remove_data_from_gc (&loc_set_list, &loc_set);
	remove_data_from_gc (&once_set_list, &once_set);
	remove_data_from_gc (&oms_set_list, &oms_set);
	remove_data_from_gc (&hec_stack_list, &hec_stack);
	remove_data_from_gc (&eif_stack_list, &eif_stack);
	remove_data_from_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	remove_data_from_gc (&opstack_list, &op_stack);
#endif
	eif_stack_free (&loc_stack);
	eif_stack_free (&loc_set);
	eif_stack_free (&once_set);
	eif_stack_free (&oms_set);
	eif_stack_free (&hec_stack);
		/* The two stacks below are not properly cleaned up with `eif_stack_free'
		 * as they have one more attribute than the `struct stack' structure, thus
		 * the extra attribute is not reset. */
	eif_stack_free (&eif_stack);
	eif_stack_free (&eif_trace);
#ifdef WORKBENCH
		/* Although the stack below is made of 5 pointers like `struct stack' it
		 * is not exactly the same structure, but the call to `eif_stack_free'
		 * should do the job properly. */
	eif_stack_free (&op_stack);
#endif
#endif
}


/**************************************************************************/
/* NAME: load_stack_in_gc                                                 */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific stack that we are putting in `st_list'.      */
/*------------------------------------------------------------------------*/
/* Insert `st' in `st_list->threads_stack' and update `st_list'.          */
/**************************************************************************/

rt_private void load_stack_in_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count + 1;
	st_list->count = count;
	if (st_list->capacity < st_list->count) {
		void **stack;
		stack = (void **) eif_realloc (st_list->threads.data,
			count * sizeof(struct stack **));
		if (!stack) {
			enomem();
		} else {
			st_list->threads.data = stack;
			st_list->capacity = count;
		}
	}
	st_list->threads.data[count - 1] = st;
}


/**************************************************************************/
/* NAME: remove_data_from_gc                                              */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific data that should be in `st_list'.            */
/*------------------------------------------------------------------------*/
/* Remove `st' from `st_list->threads_stack' and update `st_list'         */
/* accordingly.                                                           */
/**************************************************************************/

rt_private void remove_data_from_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count;
	int i = 0;
	void **stack = st_list->threads.data;

	REQUIRE("Stack not empty", count > 0);

		/* Linear search to find `st' in `threads_stack' */
	while (i < count) {
		if (stack[i] == st)
			break;
		i = i + 1;
	}

	CHECK("Is found", i < count);   /* We must have found entry that holds reference to `st' */

		/* Remove one element */
	st_list->count = count - 1;
	stack [i] = stack [count -1];
	stack [count - 1] = NULL;
}

/**************************************************************************/
/* NAME: eif_stack_free                                                   */
/* ARGS: st: thread specific stack.                                       */
/*------------------------------------------------------------------------*/
/* Free memory used by `st'.                                              */
/**************************************************************************/

rt_private void eif_stack_free (void *stack){
	struct stack *st = (struct stack *) stack;
	struct stchunk *c, *cn;

	for (c = st->st_hd; c != (struct stchunk *) 0; c = cn) {
		cn = c->sk_next;
		eif_rt_xfree ((EIF_REFERENCE) c);
	}

	st->st_hd = NULL;
	st->st_tl = NULL;
	st->st_cur = NULL;
	st->st_top = NULL;
	st->st_end = NULL;
}

#ifdef ISE_GC
rt_public void eif_synchronize_for_gc (void)
	/* Synchronize current thread for a GC cycle */
{
	RT_GET_CONTEXT

		/* Simple synchronization, if a GC cycle was performed, then
		 * we will lock on `gc_mutex' only if current thread is not the
		 * one performing the GC cycle, otherwise we could cause dead-lock.
		 * This is needed when a GC cycle trigger calls to `dispose' routines.
		 */
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
		gc_thread_status = EIF_THREAD_SUSPENDED;
		EIF_GC_MUTEX_LOCK;
		gc_thread_status = EIF_THREAD_RUNNING;
		EIF_GC_MUTEX_UNLOCK;
		if (gc_stop_thread_request) {
			eif_thr_exit();
		}
	}
}

rt_public int eif_is_in_eiffel_code (void)
{
	RT_GET_CONTEXT
	return ((gc_thread_status == EIF_THREAD_RUNNING) ? 1 : 0);
}

rt_public void eif_enter_eiffel_code(void)
	/* Synchronize current thread as we enter some Eiffel code */
{
	RT_GET_CONTEXT
		/* Do not change current thread status if we are currently running a
		 * GC cycle, the status will be reset in `eif_unsynchronize_gc'. */
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
			/* Check if GC requested a synchronization before resetting our status. */
		gc_thread_status = EIF_THREAD_RUNNING;
	}
	if (gc_stop_thread_request) {
		eif_thr_exit();
	}
}

rt_public void eif_exit_eiffel_code(void)
	/* Synchronize current thread as we exit some Eiffel code */
{
	RT_GET_CONTEXT
		/* Do not change current thread status if we are currently running a
		 * GC cycle, the status will be reset in `eif_unsynchronize_gc'. */
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
		gc_thread_status = EIF_THREAD_BLOCKED;
	}
}

#ifdef DEBUG
rt_private int counter = 0;
#endif

#ifdef EIF_ASSERTIONS
/*
doc:	<routine name="eif_is_synchronized" return_type="int" export="shared">
doc:		<summary>Check if all threads are in a paused state, so that GC can safely be performed.</summary>
doc:		<return>1 when synchronized, 0 otherwise</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock.</synchronization>
doc:	</routine>
*/

rt_shared int eif_is_synchronized (void)
{
	int i;

	for (i = 0; i < rt_globals_list.count; i ++) {
		if (((rt_global_context_t *) (rt_globals_list.threads.data [i]))->gc_thread_status_cx == EIF_THREAD_RUNNING) {
			return 0;
#ifdef DEBUG
		} else {
			printf ("Status is %d\n", ((rt_global_context_t *) (rt_globals_list.threads.data [i]))->gc_thread_status_cx);
#endif
		}
	}
	return 1;
}
#endif

#define NB_THREADS_DATA	20
rt_private void * rt_threads_data [NB_THREADS_DATA];

rt_shared void eif_synchronize_gc (rt_global_context_t *rt_globals)
	/* Synchronize all threads under GC control */
{
	if (gc_thread_status != EIF_THREAD_GC_RUNNING) {
		struct stack_list all_thread_list;
		struct stack_list running_thread_list = {0, 0, { NULL }};
		rt_global_context_t *thread_globals;
		rt_thr_context *ctxt;
		int status, i;

			/* We are marking ourself to show that we are requesting a safe access
			 * to GC data. */
		gc_thread_status = EIF_THREAD_GC_REQUESTED;
		EIF_GC_MUTEX_LOCK;
#ifdef DEBUG
		printf ("Starting Collection number %d ...", counter);
#endif
		eif_is_gc_collecting = 1;
		gc_thread_collection_count = 1;
		gc_thread_status = EIF_THREAD_GC_RUNNING;

			/* It is only useful to iterate over the threads when there are more than one. */
		if (rt_globals_list.count > 1) {
				/* We have acquired the lock, now, process all running threads and wait until
				 * they are all not marked `EIF_THREAD_RUNNING'. */
			memcpy(&all_thread_list, &rt_globals_list, sizeof(struct stack_list));
				/* Optimization to avoid calling `eif_malloc' in this critical section.
				 * It is also a way to circumvent a case where `eif_malloc' will deadlock
				 * when we arrive here after a signal was sent to the application and that
				 * the platform implementation of malloc is not async-safe. */
			if (rt_globals_list.count > NB_THREADS_DATA) {
				all_thread_list.threads.data = eif_malloc (rt_globals_list.count * sizeof(void *));
				if (!all_thread_list.threads.data) {
					EIF_GC_MUTEX_UNLOCK;
					enomem();
				}
			} else {
				all_thread_list.threads.data = rt_threads_data;
			}

			memcpy(all_thread_list.threads.data, rt_globals_list.threads.data,
				rt_globals_list.count * sizeof(void *));

			CHECK("data not null", all_thread_list.threads.data);

			while (all_thread_list.count != 0) {
				for (i = 0; i < all_thread_list.count; i++) {
					thread_globals = (rt_global_context_t *) all_thread_list.threads.data[i];
					if (thread_globals != rt_globals) {
						status = thread_globals->gc_thread_status_cx;
						if (status == EIF_THREAD_RUNNING) {
							ctxt = thread_globals->eif_thr_context_cx;
							if (ctxt && ctxt->is_alive && eif_pthread_is_alive (ctxt->thread_id) != T_OK) {
									/* Thread has died, we have to remove it from our internal list. */
								eif_remove_gc_stacks (thread_globals);
							} else {
								load_stack_in_gc (&running_thread_list, thread_globals);
							}
						}
					}
				}
				if (all_thread_list.threads.data != rt_threads_data) {
					eif_free (all_thread_list.threads.data);
				}
				memcpy(&all_thread_list, &running_thread_list, sizeof(struct stack_list));
				memset(&running_thread_list, 0, sizeof(struct stack_list));

				CHECK("data not null if not empty", (all_thread_list.count == 0) || (all_thread_list.threads.data));

					/* For performance reasons on systems with a poor scheduling policy, 
					 * we switch context to one of the remaining running thread. Not doing
					 * so on a uniprocessor WinXP system, the execution was about 1000 times
					 * slower than on a bi-processor WinXP system. */
				if (all_thread_list.count != 0) {
						// Yield to other runnable threads if available.
					RT_TRACE(eif_pthread_yield());
				}
			}


#ifdef DEBUG
			printf ("Synchronized...");
#endif
		}
	} else {
			/* A recursive demand was made, we simply increment the blocking counter.
			 * No synchronization is required as we are still under the protection
			 * of `eif_gc_mutex'. */
		gc_thread_collection_count++;	
#ifdef DEBUG
		printf ("+");
#endif
	}

		/* The postcondition cannot hold in most cases. For example, when launching quickly
		 * new threads, the above code will assume N threads, but now we might have N + 1 threads
		 * and the newly launched thread has not yet reached a synchronization point although we are
		 * sure at 100% that no Eiffel code will be executed. */
/*	ENSURE("Synchronized", eif_is_synchronized()); */
}

rt_shared void eif_unsynchronize_gc (rt_global_context_t *rt_globals)
	/* Free all threads under GC control from GC control */
{
	gc_thread_collection_count--;

	if (gc_thread_collection_count == 0) {
#ifdef DEBUG
		printf ("... finishing %d\n", counter);
		counter++;
#endif
			/* Here we have still the lock of `gc_mutex'. So it is safe to update
			 * `eif_is_gc_collecting'. */
		eif_is_gc_collecting = 0;

			/* Let's mark ourself as a running thread. */
		gc_thread_status = EIF_THREAD_RUNNING;

			/* Because recursive calls can be made to `eif_synchronize_gc' we
			 * have to unlock the `eif_gc_mutex' mutex only at the last call
			 * to `eif_unsynchronize_gc'. */
		EIF_GC_MUTEX_UNLOCK;
	} else {
#ifdef DEBUG
		printf ("-");
#endif
	}
}

/*
doc:	<routine name="eif_terminate_all_other_threads" return_type="void" export="shared">
doc:		<summary>Kill all running threads but Current one. Useful when performing a call to reclaim which cannot be done if we still have some Eiffel threads running.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Global synchronization.</synchronization>
doc:	</routine>
*/

rt_shared void eif_terminate_all_other_threads (void) {
	RT_GET_CONTEXT
	rt_global_context_t *thread_globals;
	rt_thr_context *ctxt;
	int i, nb;
	int is_main_thread_blocked = 0;
	struct stack_list running_thread_list = {0, 0, { NULL }};

		/* Block all running threads. */
	eif_synchronize_gc (rt_globals);
	nb = rt_globals_list.count;

		/* We have acquired the lock, now, process all running threads and let them
		 * know we don't want them to execute anymore code. */
	for (i = 0; i < nb; i++) {
		thread_globals = (rt_global_context_t *) rt_globals_list.threads.data[i];
		if (thread_globals != rt_globals) {
			thread_globals->gc_stop_thread_request_cx = 1;
		}
	}

	eif_unsynchronize_gc (rt_globals);

		/* Now we wait `nb' times (i.e. number of threads minus 1) for the
		 * thread to actually exit. Most of the time all the other threads
		 * should have finished. */
	EIF_ENTER_C;
	nb = nb - 1;
	for (i = 0; i < nb; i++) {
		RT_TRACE(eif_pthread_yield());
	}
	EIF_EXIT_C;

		/* Check that there is only one more thread left. If not then we will explicitely
		 * kill the remaining blocked threads. */
	eif_synchronize_gc (rt_globals);
	nb = rt_globals_list.count;
		
	while (nb > 1) {
		for (i = 0; i < nb; i++) {
			thread_globals = (rt_global_context_t *) rt_globals_list.threads.data[i];
			if (thread_globals != rt_globals) {	
					/* Worst case scenario, some threads are still running (see eweasel test#thread012). */
				if
					((thread_globals->gc_thread_status_cx == EIF_THREAD_BLOCKED) &&
					!(thread_globals->thread_exiting_cx))
				{
					if (!thread_globals->eif_globals->is_external_cx) {
						ctxt = thread_globals->eif_thr_context_cx;
						if (ctxt && !ctxt->is_root) {
							if (ctxt->is_alive && eif_pthread_is_alive (ctxt->thread_id) != T_OK) {
									/* Thread was just killed. */
								load_stack_in_gc (&running_thread_list, thread_globals);
							} else {
#ifdef HAS_THREAD_CANCELLATION
								EIF_THR_CANCEL(ctxt->thread_id);
#else
								RT_TRACE(eif_pthread_kill(ctxt->thread_id));
#endif
							}
						} else {
								/* Main thread is blocked this is bad. */
							is_main_thread_blocked = 1;
						}
					} else {
							/* Thread has not been created by our runtime or the EiffelThread
							 * library, we simply record it for removing its data from the runtime. */
						load_stack_in_gc (&running_thread_list, thread_globals);
					}
				}
			}
		}
		nb = running_thread_list.count;
		if (nb > 0) {
			for (i = 0; i < nb; i++) {
				eif_remove_gc_stacks ((rt_global_context_t *) running_thread_list.threads.data[i]);
			}
				/* We need to wipe out the content of `running_thread_list' to
				 * prevent multiple removal of the same data in `rt_globals_list'. */
			eif_free (running_thread_list.threads.data);
			memset(&running_thread_list, 0, sizeof(struct stack_list));
		}
			/* Let's wait for the termination of non-blocked thread. */
		eif_unsynchronize_gc (rt_globals);
		EIF_ENTER_C;
		RT_TRACE(eif_pthread_yield());
		EIF_EXIT_C;

			/* Prepare next iteration of loop. */
		eif_synchronize_gc (rt_globals);
		nb = rt_globals_list.count;
		if (is_main_thread_blocked) {
			nb--;
		}
		is_main_thread_blocked = 0;
	}
	eif_unsynchronize_gc (rt_globals);
}

#endif /* ISE_GC */

#if !defined(EIF_WINDOWS) && !defined(VXWORKS)
/*
doc:	<routine name="eif_thread_fork" return_type="pid_t" export="shared">
doc:		<summary>Call system fork and make sure that the GC is correctly updated in newly forked process. Made especially for EMC.</summary>
doc:		<return>On success, the PID of the child process is returned in the parent's thread of execution, and a 0 is returned in the child's thread of execution. On failure, a -1 will be returned in the parent's context, no child process will be created, and errno will be set appropriately.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Global synchronization.</synchronization>
doc:	</routine>
*/

extern pid_t waitpid (pid_t pid, int *status, int options);

rt_shared pid_t eif_thread_fork(void) {
	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	pid_t result = (pid_t) 0;

		/* Synchronize GC, so that only current thread is the one allowed to perform a fork. */
#ifdef ISE_GC
	eif_synchronize_gc (rt_globals);
#endif

		/* EMC using as far as we know only Linux and Solaris, that's the two fork we are taking
		 * care of. Not that for Solaris, we us `fork1()' which only forks the current thread, not
		 * all thread, so that it matches the Linux behavior of `fork'. */
#ifdef SOLARIS_THREAD
	result = fork1();
#else
	result = fork();
#endif

	if (result == 0) {
			/* We are now in the child process. */

			/* Reinitialize our global lists to let the GC think that there
			 * is only one running thread. */
		memset (&rt_globals_list, 0, sizeof (struct stack_list));
#ifdef ISE_GC
		memset (&loc_stack_list, 0, sizeof (struct stack_list));
		memset (&loc_set_list, 0, sizeof (struct stack_list));
		memset (&once_set_list, 0, sizeof (struct stack_list));
		memset (&hec_stack_list, 0, sizeof (struct stack_list));
		memset (&eif_stack_list, 0, sizeof (struct stack_list));
		memset (&eif_trace_list, 0, sizeof (struct stack_list));
#ifdef WORKBENCH
		memset (&opstack_list, 0, sizeof (struct stack_list));
#endif

		load_stack_in_gc (&rt_globals_list, rt_globals);
		load_stack_in_gc (&loc_stack_list, &loc_stack);	
		load_stack_in_gc (&loc_set_list, &loc_set);	
		load_stack_in_gc (&once_set_list, &once_set);	
		load_stack_in_gc (&hec_stack_list, &hec_stack);	
		load_stack_in_gc (&eif_stack_list, &eif_stack);	
		load_stack_in_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
		load_stack_in_gc (&opstack_list, &op_stack);
#endif
#endif

		CHECK("Only one thread", rt_globals_list.count == 1);
	}

#ifdef ISE_GC
	eif_unsynchronize_gc (rt_globals);
#endif
	return result;
}

#endif

rt_public void eif_thr_yield(void)
{
	/*
	 * Yields execution to other threads. Platform dependant, sometimes
	 * undefined.
	 */

	RT_TRACE(eif_pthread_yield());
}


rt_public void eif_thr_join_all(void)
{
	/* Our implementation of join_all: the parent thread keeps a record of the
	 * number of threads it has launched, and the children have a pointer to
	 * the parent context. So they decrement it upon termination. This
	 * variable is protected by the mutex children_mutex.
	 * This function loops until the value of n_children is equal to zero. In
	 * order not to use all the CPU, we yield the execution to other threads
	 * if there are still more children.
	 * NB: this function might be very costly in CPU if the yield function
	 * doesn't work. */

	RT_GET_CONTEXT

		/* If no thread has been launched, the mutex isn't initialized */
	if (eif_thr_context->children_mutex) {
		EIF_ASYNC_SAFE_MUTEX_LOCK(eif_thr_context->children_mutex);
		while (eif_thr_context->n_children != 0) {
			RT_TRACE(eif_pthread_cond_wait(eif_thr_context->children_cond, eif_thr_context->children_mutex));
		}
		EIF_ASYNC_SAFE_MUTEX_UNLOCK(eif_thr_context->children_mutex);
	}
}

rt_public void eif_thr_wait (EIF_OBJECT Current)
{
	/*
	 * Waits until a thread sets `terminated' from `Current' to True, which means it
	 * is terminated. This function is called by `join'. The calling
	 * thread must be the direct parent of the thread, or the function
	 * might loop indefinitely --PCV
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	int ret;	/* Return Status of "eifaddr". */
	EIF_INTEGER offset;	/* location of `terminated' in Current */
	EIF_REFERENCE thread_object = NULL;

		/* We need to protect thread_object, because the protected
		 * reference `eif_access (Current)' will be cleaned when
		 * Current thread exit. */
	RT_GC_PROTECT(thread_object);
	thread_object = eif_access(Current);
	offset = eifaddr_offset (thread_object, "terminated", &ret);
	CHECK("terminated attribute exists", ret == EIF_CECIL_OK);

		/* If no thread has been launched, the mutex isn't initialized */
	if (eif_thr_context->children_mutex) {
		EIF_ASYNC_SAFE_MUTEX_LOCK(eif_thr_context->children_mutex);
		while (*(EIF_BOOLEAN *) (thread_object + offset) == EIF_FALSE) {
			RT_TRACE(eif_pthread_cond_wait(eif_thr_context->children_cond, eif_thr_context->children_mutex));
		}
		EIF_ASYNC_SAFE_MUTEX_UNLOCK(eif_thr_context->children_mutex);
	}
	RT_GC_WEAN(thread_object);
}

rt_public EIF_BOOLEAN eif_thr_wait_with_timeout (EIF_OBJECT Current, EIF_NATURAL_64 a_timeout_ms)
{
	/*
	 * Waits until a thread sets `terminated' from `Current' to True or reaching `a_timeout_ms'.
	 * This function is called by `join_with_timeout'. The calling thread must be the direct parent
	 * of the thread, or the function might loop indefinitely --PCV */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	int res;
	EIF_INTEGER offset;	/* location of `terminated' in Current */
	EIF_REFERENCE thread_object = NULL;

		/* We need to protect thread_object, because the protected
		 * reference `eif_access (Current)' will be cleaned when
		 * Current thread exit. */
	RT_GC_PROTECT(thread_object);
	thread_object = eif_access(Current);
	offset = eifaddr_offset (thread_object, "terminated", &res);
	CHECK("terminated attribute exists", res == EIF_CECIL_OK);

		/* If no thread has been launched, the mutex isn't initialized */
	res = T_OK;
	if (eif_thr_context->children_mutex) {
		EIF_ASYNC_SAFE_MUTEX_LOCK(eif_thr_context->children_mutex);
		while ((*(EIF_BOOLEAN *) (thread_object + offset) == EIF_FALSE) && (res == T_OK)) {
			RT_TRACE_KEEP(res,eif_pthread_cond_wait_with_timeout(eif_thr_context->children_cond, eif_thr_context->children_mutex, a_timeout_ms));
		}
		EIF_ASYNC_SAFE_MUTEX_UNLOCK(eif_thr_context->children_mutex);
	}
	RT_GC_WEAN(thread_object);

	return (res == T_TIMEDOUT ? EIF_FALSE : EIF_TRUE);
}


rt_public void eif_thr_join (EIF_POINTER tid)
{
	/*
	 * Invokes thr_join, pthread_join, etc.. depending on the platform.
	 * No such routine exists on VxWorks or Windows, so the Eiffel version
	 * should be used (ie. `join' <-> eif_thr_wait)
	 */

	int res;

	if (tid != (EIF_POINTER) 0) {
		RT_TRACE_KEEP(res, eif_pthread_join((EIF_THR_TYPE) tid));
	} else {
		eraise ("Trying to join a thread whose ID is NULL", EN_EXT);
	}
}


/*
 * These three functions are used from Eiffel: they return the default,
 * minimum and maximum priority values for the current platform --PCV
 */

rt_public EIF_INTEGER eif_thr_default_priority(void) {
	return EIF_DEFAULT_THR_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_min_priority(void) {
	return EIF_MIN_THR_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_max_priority(void) {
	return EIF_MAX_THR_PRIORITY;
}

/*
 * These two functions each return a pointer to respectively the thread-id
 * of the current thread and the thread-id of the last created thread.
 * They are used from the class THREAD.--PCV
 */

rt_public EIF_POINTER eif_thr_thread_id(void) {
	RT_GET_CONTEXT
	return (EIF_POINTER) eif_thr_context->thread_id;
}

rt_public EIF_POINTER eif_thr_last_thread(void) {
	RT_GET_CONTEXT
	return (EIF_POINTER) last_child;
}


/*
 * Functions for mutex management:
 *	- creation, locking, unlocking, non-blocking locking and destruction
 */
 
rt_public EIF_POINTER eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE *a_mutex_pointer;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_mutex_create(&a_mutex_pointer));
	if (res != T_OK) {
		eraise ("Cannot create mutex", EN_EXT);
	}
	return a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_mutex_lock(a_mutex_pointer));
	if (res != T_OK) {
		eraise ("Cannot lock mutex", EN_EXT);
	}
}

rt_public void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_mutex_unlock(a_mutex_pointer));
	if (res != T_OK) {
		eraise ("Cannot unlock mutex", EN_EXT);
	}
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	int res;
		/* We do not use `RT_TRACE_KEEP' because we might get T_BUSY. We will trace the error after. */
	res = eif_pthread_mutex_trylock(a_mutex_pointer);
	if (res == T_OK) {
		return EIF_TRUE;
	} else if (res == T_BUSY) {
		return EIF_FALSE;
	} else {
		RT_TRACE(res);
		eraise ("Cannot lock mutex", EN_EXT);
		return EIF_FALSE;
	}
}

rt_public void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_mutex_destroy(a_mutex_pointer));
}


/*
 * class SEMAPHORE externals
 */

rt_public EIF_POINTER eif_thr_sem_create (EIF_INTEGER count)
{
	EIF_SEM_TYPE *a_sem_pointer;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_sem_create(&a_sem_pointer, 0, (unsigned int) count));
	if (res != T_OK) {
		eraise ("Cannot create semaphore", EN_EXT);
	}
	return (EIF_POINTER) a_sem_pointer;
}

rt_public void eif_thr_sem_wait (EIF_POINTER sem)
{
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_sem_wait(a_sem_pointer));
	if (res != T_OK) {
		eraise ("Cannot wait on semaphore", EN_EXT);
	}
}

rt_public void eif_thr_sem_post (EIF_POINTER sem)
{
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_sem_post(a_sem_pointer));
	if (res != T_OK) {
		eraise ("Cannot post on semaphore", EN_EXT);
	}
}

rt_public EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem)
{
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	int res;
		/* We do not use `RT_TRACE_KEEP' because we might get T_BUSY. We will trace the error after. */
	res = eif_pthread_sem_trywait(a_sem_pointer);
	if (res == T_OK) {
		return EIF_TRUE;
	} else if (res == T_BUSY) {
		return EIF_FALSE;
	} else {
		RT_TRACE(res);
		eraise ("Cannot trywait on semaphore", EN_EXT);
		return EIF_FALSE;
	}
}

rt_public void eif_thr_sem_destroy (EIF_POINTER sem)
{
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_sem_destroy(a_sem_pointer));
}

/*
 * class CONDITION_VARIABLE externals
 */

rt_public EIF_POINTER eif_thr_cond_create (void)
{
	EIF_COND_TYPE *cond;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_cond_create (&cond));
	if (res != T_OK) {
		eraise ("Cannot create cond. variable", EN_EXT);
	}
	return cond;
}

rt_public void eif_thr_cond_broadcast (EIF_POINTER cond_ptr)
{
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_cond_broadcast(cond));
	if (res != T_OK)  {
		eraise ("Cannot broadcast on condition variable", EN_EXT);
	}
}

rt_public void eif_thr_cond_signal (EIF_POINTER cond_ptr)
{
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_cond_signal(cond));
	if (res != T_OK)  {
		eraise ("Cannot signal on condition variable", EN_EXT);
	}
}

rt_public void eif_thr_cond_wait (EIF_POINTER cond_ptr, EIF_POINTER mutex_ptr)
{
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_MUTEX_TYPE *mutex = (EIF_MUTEX_TYPE *) mutex_ptr;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_cond_wait(cond, mutex));
	if (res != T_OK) {
		eraise ("Cannot wait on condition variable", EN_EXT);
	}
}

rt_public EIF_INTEGER eif_thr_cond_wait_with_timeout (EIF_POINTER cond_ptr, EIF_POINTER mutex_ptr, EIF_INTEGER a_timeout)
{
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_MUTEX_TYPE *mutex = (EIF_MUTEX_TYPE *) mutex_ptr;
	int res;
		/* We do not use `RT_TRACE_KEEP' because we might get T_TIMEDOUT. We will trace the error after. */
	res = eif_pthread_cond_wait_with_timeout(cond, mutex, (rt_uint_ptr) a_timeout);
	if (res != T_OK) {
		if (res == T_TIMEDOUT) {
			return 0;
		} else {
			RT_TRACE(res);
			eraise ("Cannot wait with timeout on condition variable", EN_EXT);
				/* Not reachable. */
			return -1;
		}
	} else {
		return 1;
	}
}

rt_public void eif_thr_cond_destroy (EIF_POINTER cond_ptr)
{
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_cond_destroy(cond));
}

/*
 * class READ_WRITE_LOCK externals
 */

rt_public EIF_POINTER eif_thr_rwl_create (void)
{
	EIF_RWL_TYPE *rwlp;
	int res;
	RT_TRACE_KEEP(res, eif_pthread_rwlock_create(&rwlp));
	if (res != T_OK) {
		eraise ("Cannot create rwl variable", EN_EXT);
	}
	return rwlp;
}

rt_public void eif_thr_rwl_rdlock (EIF_POINTER rwlp_ptr)
{
	EIF_RWL_TYPE *rwlp = (EIF_RWL_TYPE *) rwlp_ptr;
	int res;
	RT_TRACE_KEEP(res,eif_pthread_rwlock_rdlock(rwlp));
	if (res != T_OK) {
		eraise ("Cannot read lock", EN_EXT);
	}
}

rt_public void eif_thr_rwl_wrlock (EIF_POINTER rwlp_ptr)
{
	EIF_RWL_TYPE *rwlp = (EIF_RWL_TYPE *) rwlp_ptr;
	int res;
	RT_TRACE_KEEP(res,eif_pthread_rwlock_wrlock(rwlp));
	if (res != T_OK) {
		eraise ("Cannot write lock", EN_EXT);
	}
}


rt_public void eif_thr_rwl_unlock (EIF_POINTER rwlp_ptr)
{
	EIF_RWL_TYPE *rwlp = (EIF_RWL_TYPE *) rwlp_ptr;
	int res;
	RT_TRACE_KEEP(res,eif_pthread_rwlock_unlock(rwlp));
	if (res != T_OK) {
		eraise ("Cannot unlock read/write lock", EN_EXT);
	}
}

rt_public void eif_thr_rwl_destroy (EIF_POINTER rwlp_ptr)
{
	EIF_RWL_TYPE *rwlp = (EIF_RWL_TYPE *) rwlp_ptr;
	int res;
	RT_TRACE_KEEP(res,eif_pthread_rwlock_destroy(rwlp));
}


rt_public void eif_thr_panic(char *msg)
{
	print_err_msg (stderr, "*** Thread panic! ***\n");
	eif_panic(msg);
}

#endif /* EIF_THREADS */
/*
doc:</file>
*/
