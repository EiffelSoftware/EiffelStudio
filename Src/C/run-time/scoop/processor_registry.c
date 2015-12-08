/*
	description:	"Manages the lifecycle of SCOOP processors and regions and provides a mapping from PIDs to processor objects."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2015, Eiffel Software.",
				"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="processor_registry.c" header="rt_processor_registry.h" version="$Id$"
doc:	summary="Manages the lifecycle of SCOOP processors and regions and provides a mapping from PIDs to processor objects.">
*/

#include "rt_processor_registry.h"
#include "rt_identifier_set.h"
#include "rt_processor.h"
#include "rt_scoop_helpers.h"
#include "rt_atomic_int.h"

#include "rt_assert.h"
#include "eif_macros.h"
#include "eif_scoop.h"
#include "eif_atomops.h"


RT_DECLARE_VECTOR (rt_passive_region_context_list, rt_global_context_t*)

/* Private declarations. */
rt_private void allocate_new_identifier (EIF_SCP_PID* result);
rt_private void spawn_main (EIF_REFERENCE dummy_thread_object, EIF_SCP_PID pid);
rt_private void destroy_region (struct rt_processor* proc);


/*
doc:	<struct name="rt_processor_registry" export="shared">
doc:		<summary> The processor registry struct is a singleton.
doc:			It manages a processor's lifecycle, maintains a set of free
doc:			processor identifiers, and manages a mapping from PID to
doc:			processor objects.
doc:		</summary>
doc:		<field name="processor_lookup_table" type="struct rt_processor**"> The array used to map PIDs to processors. </field>
doc:		<field name="free_pids" type="struct rt_identifier_set"> A set of free (unassigned) PIDs. </field>
doc:		<field name="dead_passive_regions" type="rt_vector of rt_global_context_t*"> A vector of passive regions to be deleted. </field>
doc:		<field name="processor_count" type="struct rt_atomic_int"> An atomic integer to keep track of currently alive processors. </field>
doc:		<field name="all_done" type="EIF_BOOLEAN"> A boolean value indicating whether there are no more alive processors. Used by the root thread for program termination. </field>
doc:		<field name="all_done_mutex" type="EIF_MUTEX_TYPE*"> A mutex to protect the all_done field. </field>
doc:		<field name="all_done_cv" type="EIF_COND_TYPE*"> A condition variable for the root thread to wait for the all_done field to become true. </field>
doc:		<fixme> Could it be that all_done and processor_count==0 contain the same information? </fixme>
doc:	</struct>
*/
struct rt_processor_registry {
	/* processor_lookup_table is stored outside the struct to allow inlining of rt_get_processor. */

  struct rt_identifier_set free_pids;
  struct rt_passive_region_context_list dead_passive_regions;

  struct rt_atomic_int processor_count;

  /* end of life notification */
  volatile EIF_BOOLEAN all_done;
  EIF_MUTEX_TYPE* all_done_mutex;
  EIF_COND_TYPE* all_done_cv;
};


/*
* Although the processor_lookup_table is accessed by several threads,
* it is not necessary to synchronize the access. There are several
* properties that make it unnecessary:
*
* Data race freedom:
* - A new value is inserted by the creator thread after it received
*   a new unique PID from the free_pids set.
* - After creation, the field remains constant.
* - The value is reset to NULL only by the thread behind the specified
*   processor ID, after the garbage collector concluded that it is no
*   longer referenced anywhere.
* - The uniqueness of PIDs is guaranteed by the free_pids set. A new
*   ID has to be acquired before adding an entry in 'processor_lookup_table', and it
*   can only be released after resetting 'processor_lookup_table' to NULL.
*
* Visibility:
* - Generally, x86 has strong visibility guarantees, and by creating
*   initializing the processor object before adding it to 'processor_lookup_table'
*   any other thread can see a consistent view.
* - The update to the processor_lookup_table array itself is visible in the garbage collector,
*   because the creator thread synchronizes with the GC thread prior to a cycle.
* - The same applies during removal of a processor.
* - Between the creator thread and the spawned thread, visibility is guaranteed
*   because of the thread creation operation.
* - In between processors, visibility is guaranteed because the creator first
*   has to publish the root object of the new processor, and as soon as this
*   object is visible by other threads the update is visible as well, thanks
*   to the visibility guarantees of x86.
*/
struct rt_processor* processor_lookup_table [RT_MAX_SCOOP_PROCESSOR_COUNT];
struct rt_processor_registry registry;

/*
doc:	<routine name="rt_processor_registry_init" return_type="int" export="shared">
doc:		<summary> Initialize the global processor_registry struct and the root processor object.
doc:			This routine must be called at program startup to initialize the SCOOP subsystem. </summary>
doc:		<return> T_OK on success, or an error code when allocation of a resource (memory, locks) failed. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only called by the root thread during program startup. </synchronization>
doc:	</routine>
*/
rt_shared int rt_processor_registry_init (void)
{
	struct rt_processor_registry* self = &registry;
	struct rt_processor* root_proc = NULL;
	int error = T_OK;
	

	rt_passive_region_context_list_init (&self->dead_passive_regions);

	self->all_done_mutex = NULL;
	self->all_done_cv = NULL;
	self->all_done = EIF_FALSE; /* End of life notification. */

	rt_atomic_int_init (&self->processor_count);
	
		/* Create and initialize the identifier set. */
	error = rt_identifier_set_init (&self->free_pids, RT_MAX_SCOOP_PROCESSOR_COUNT);
	
		/* Create mutex and CV. */
	if (T_OK == error) {
		error = eif_pthread_mutex_create (&self->all_done_mutex);
	}
	if (T_OK == error) {
		error = eif_pthread_cond_create (&self->all_done_cv);
	}
	
		/* Create the root processor. */
	if (T_OK == error) {
		error = rt_processor_create (0, EIF_TRUE, &root_proc);
	}

	if (T_OK == error) {
		EIF_SCP_PID i;	
			/* Prepare the procs attribute. */
		for (i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
			processor_lookup_table [i] = NULL;
		}
		
		CHECK ("processor_is_active", root_proc->is_active);
		processor_lookup_table[0] = root_proc;
		
			/* Atomically increment processor_count (we start with 1 root processor). */
		rt_atomic_int_increment (&self->processor_count);
	}
	
	if (T_OK != error) {
			/* An error occurred. Free all resources. */
		rt_processor_registry_deinit();
	}
	return error;
}

/*
doc:	<routine name="rt_processor_registry_deinit" return_type="void" export="shared">
doc:		<summary> Free all resources in the processor_registry struct.
doc:			This routine can be called at program termination to free some internal resources. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only called by the root thread during program termination. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_deinit (void)
{
	struct rt_processor_registry* self = &registry;
	
	if (self->all_done_cv) {
		RT_TRACE (eif_pthread_cond_destroy (self->all_done_cv));
		self->all_done_cv = NULL;
	}
	if (self->all_done_mutex) {
		RT_TRACE (eif_pthread_mutex_destroy (self->all_done_mutex));
		self->all_done_cv = NULL;
	}
	rt_identifier_set_deinit (&self->free_pids);

	rt_passive_region_context_list_deinit (&self->dead_passive_regions);

	rt_atomic_int_deinit (&self->processor_count);
}

/*
doc:	<routine name="rt_processor_registry_create_region" return_type="int" export="shared">
doc:		<summary> Create a new SCOOP region. The region is created as passive, meaning it has no thread attached to it.
doc:			The feature may block and run the GC if there's no free processor ID. </summary>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the ID of the new region shall be stored. Must not be NULL. </param>
doc:		<return> T_OK on success. If some allocation fails an error code is returned. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared int rt_processor_registry_create_region (EIF_SCP_PID* result, EIF_BOOLEAN a_is_passive)
{
	EIF_SCP_PID pid = 0;
	int error = T_OK;
	struct rt_processor* new_processor = NULL;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("result_not_null", result);

		/* Acquire a new ID. */
	allocate_new_identifier (&pid);

		/* Create and initialize the processor object. */
	error = rt_processor_create (pid, EIF_FALSE, &new_processor);

	if (T_OK == error) {
			/* Update the internal bookkeeping structures. */
		processor_lookup_table [pid] = new_processor;
		new_processor->is_passive_region = a_is_passive;
		rt_atomic_int_increment (&self->processor_count); /* Atomic increment */
		*result = pid;
	} else {
			/* Processor allocation failed. Return the PID. */
		rt_identifier_set_extend (&self->free_pids, pid);
	}

	return error;
}

/*
doc:	<routine name="rt_processor_registry_activate" return_type="void" export="shared">
doc:		<summary> Ask the Eiffel runtime to create a new thread for the region with ID 'pid'.
doc:			The thread calling this function will wait until the new thread has been fully
doc:			initialized. This is apparently necessary for garbage collection. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The processor region for which a thread shall be spawned. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call once per processor object. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_activate (EIF_SCP_PID pid)
{
	struct rt_processor* proc = rt_get_processor (pid);

	if (proc->is_passive_region) {
		rt_global_context_t* new_context = rt_thread_new_passive_region (pid);
		rt_set_processor_id (pid, new_context);
		proc->is_active = EIF_FALSE;
	} else {
			/* TODO: What happens when thread allocation fails? */
		eif_thr_create_with_attr_new (
			NULL,	/* No root object, if this is only passed to spawn_main this is OK */
			(EIF_PROCEDURE) spawn_main, /* The entry point for the new thread. */
			pid, /* Logical PID */
			EIF_TRUE, /* We are a processor */
			NULL); /* There are no attributes */

			/* Wait for the signal that the new thread has started.
			* TODO: RS: Why exactly is this necessary? The GC can still run during the receive operation... */
		rt_message_channel_receive (&proc->startup_notify, NULL);
	}
}

/*
doc:	<routine name="rt_processor_registry_deactivate" return_type="void" export="shared">
doc:		<summary> Deactivate the processor with ID 'pid' and remove all references to it from the other processors.
doc:			This routine is a callback from the GC when it detects unused processors. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be deactivated. </param>
doc:		<param name="a_context" type="rt_global_context_t*"> The private context of the associated thread. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_deactivate (EIF_SCP_PID pid, rt_global_context_t* a_context)
{
	struct rt_processor* to_be_removed = NULL;
	struct rt_processor* item = NULL;
	EIF_SCP_PID index = 0;

	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);

		/* This is a callback from the GC, which will notify us
		 * of all unused processors, even those that have already received
		 * a SHUTDOWN message during the last GC cycle and whose thread is now
		 * in the process of terminating itself.
		 *
		 * To avoid double free we check first to see if the processor structure is
		 * still available. Note that this mechanism doesn't avoid double shutdown messages. */
	to_be_removed = rt_lookup_processor (pid);

	if (to_be_removed) {

			/* Remove any references to 'to_be_removed' from the other processors. */
		for (index = 0; index < RT_MAX_SCOOP_PROCESSOR_COUNT; ++index) {
			item = rt_lookup_processor (index);
			if (item) {
					/* Clear private queue caches. */
				rt_queue_cache_clear (&item->cache, to_be_removed);
					/* Remove leftover wait condition subscriptions. */
				rt_processor_unsubscribe_wait_condition (item, to_be_removed);
			}
		}
		if (to_be_removed->is_passive_region) {
			RT_TRACE (rt_passive_region_context_list_extend (&registry.dead_passive_regions, a_context)); /* TODO: Error handling */
		} else {
				/* Send a shutdown signal such that the processor can terminate itself. */
			rt_processor_shutdown (to_be_removed);
		}
	}
}

/*
doc:	<routine name="rt_processor_registry_cleanup" return_type="void" export="shared">
doc:		<summary> Free all dead passive regions. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_cleanup (void)
{
	rt_global_context_t* l_context = NULL;
	struct rt_processor* l_processor = NULL;
	struct rt_passive_region_context_list* l_procs = &registry.dead_passive_regions;

	while (rt_passive_region_context_list_count (l_procs) != 0) {

			/* Pop one passive region element. */
		l_context = rt_passive_region_context_list_last (l_procs);
		rt_passive_region_context_list_remove_last (l_procs);

			/* Free the region. */
		l_processor = rt_get_processor (l_context->eif_thr_context_cx->logical_id);
		rt_unset_processor_id (l_context);
		destroy_region (l_processor);
		rt_thread_destroy_passive_region (l_context);
	}
}

/*
doc:	<routine name="rt_processor_registry_quit_root_processor" return_type="void" export="shared">
doc:		<summary> Finish execution of the root processor after it has completed the root feature. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call by the root processor. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_quit_root_processor (void)
{
	struct rt_processor_registry* self = &registry;
	struct rt_processor* root_proc = rt_get_processor (0);

		/* First we have to enter a regular application loop, as some
		 * clients may still have references to objects created by the root processor. */
	rt_processor_application_loop (root_proc);

		/* When no more references to objects on the root region exist, we terminate. */
	destroy_region (root_proc);

		/* Now the root thread has to wait for all processors to finish, such that it
		 * can perform some final program cleanup.
		 * Allow the GC to execute during this period. */
	EIF_ENTER_C;
	RT_TRACE (eif_pthread_mutex_lock (self->all_done_mutex));
	while (!self->all_done) {
		RT_TRACE (eif_pthread_cond_wait (self->all_done_cv, self->all_done_mutex));
	}
	RT_TRACE (eif_pthread_mutex_unlock (self->all_done_mutex));
	EIF_EXIT_C;
	RTGC;
}

/*
doc:	<routine name="allocate_new_identifier" return_type="void" export="private">
doc:		<summary> Acquire a new unique region identifier and store it in 'result'.
doc:			If none is currently available, a GC cycle is triggered and the feature blocks until it gets a free ID. </summary>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_private void allocate_new_identifier (EIF_SCP_PID* result)
{
	EIF_BOOLEAN success = EIF_FALSE;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("result_not_null", result);

		/* We first check if there's a result available. */
	success = rt_identifier_set_try_consume (&self->free_pids, result);

		/* If none is available, we have to run the garbage collector and then wait. */
	if (!success) {
		plsc();
		rt_identifier_set_consume (&self->free_pids, result);
	}
}

/*
doc:	<routine name="spawn_main" return_type="void" export="private">
doc:		<summary> The entry point for new SCOOP processors after the Eiffel runtime has set up the context.
doc:			Note: The feature has an unused EIF_REFERENCE as its first argument.
doc:			This is necessary because eif_thr_create_with_attr_new expects an EIF_PROCEDURE as a thread entry point. </summary>
doc:		<param name="dummy_thread_object" type="EIF_REFERENCE"> A dummy object to make the signature conform to EIF_PROCEDURE. </param>
doc:		<param name="pid", type="EIF_SCP_PID"> The ID of the newly spawned processor. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None </synchronization>
doc:	</routine>
*/
rt_private void spawn_main (EIF_REFERENCE dummy_thread_object, EIF_SCP_PID pid)
{
	RT_GET_CONTEXT
	struct rt_processor *proc = rt_get_processor (pid);

		/* Record that the current thread is associated with a processor of a given ID. */
	rt_set_processor_id (pid, rt_globals);

		/* Send a message to the creator thread that we have succesfully spawned.
		 * We recycle the RESULT_READY message here since the creator is not interested in the message anyway. */
	rt_message_channel_send (&proc->startup_notify, SCOOP_MESSAGE_RESULT_READY, NULL, NULL, NULL);

	rt_processor_application_loop (proc);

		/* Decouple processor ID from the current thread. */
	rt_unset_processor_id (rt_globals);

	destroy_region (proc);
}

/*
doc:	<routine name="destroy_region" return_type="void" export="private">
doc:		<summary> Free all resources in 'proc', remove the PID->processor mapping, and recycle the identifier. </summary>
doc:		<param name="proc" type="struct rt_processor*"> The region to be destroyed. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call from the thread that owns processor 'proc'. </synchronization>
doc:	</routine>
*/
rt_private void destroy_region (struct rt_processor* proc)
{
	EIF_INTEGER_32 l_count = 0;
	EIF_SCP_PID pid = proc->pid;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("processor_not_collected", rt_lookup_processor (pid));

		/* Remove the processor from the bookkeeping structures in the processor registry. */
	l_count = rt_atomic_int_decrement_and_fetch (&self->processor_count); /* Atomic pre-decrement */
	processor_lookup_table [pid] = NULL;

		/* Free all resources in 'proc'. */
	rt_processor_destroy (proc);

		/* In case we're the last processor to be deleted, signal the root thread
		 * that the program can now be terminated. */
	if (l_count == 0) {
		RT_TRACE (eif_pthread_mutex_lock (self->all_done_mutex));
		self->all_done = EIF_TRUE;
		RT_TRACE (eif_pthread_cond_signal (self->all_done_cv));
		RT_TRACE (eif_pthread_mutex_unlock (self->all_done_mutex));
	}

		/* Add the identifier back to the list of free PIDs.
		 * Note that PID 0 is special, so we don't recycle that one. */
	if (pid != 0) {
		rt_identifier_set_extend (&self->free_pids, pid);
	}
}

/*
doc:</file>
*/
