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
#include "rt_processor.h"
#include "rt_scoop_helpers.h"

#include "rt_assert.h"
#include "eif_macros.h"
#include "eif_scoop.h"
#include "eif_atomops.h"

/* The global processor_registry struct. */
struct rt_processor_registry registry;

/* Private declarations. */
rt_private void rt_processor_registry_destroy_region (struct rt_processor* proc);
rt_private void spawn_main (EIF_REFERENCE dummy_thread_object, EIF_SCP_PID pid);

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
	
	self->all_done_mutex = NULL;
	self->all_done_cv = NULL;
	self->processor_count = 0;
	self->all_done = EIF_FALSE; /* End of life notification. */
	
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
			self->procs [i] = NULL;
		}
		
		CHECK ("processor_is_active", root_proc->is_active);
		self->procs[0] = root_proc;
		
			/* Atomically increment processor_count (we start with 1 root processor). */
		RTS_AI_I32 (&self->processor_count);
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
	/* CHECK ("no_more_processors", self->processor_count == 0); */
	
	if (self->all_done_cv) {
		RT_TRACE (eif_pthread_cond_destroy (self->all_done_cv));
		self->all_done_cv = NULL;
	}
	if (self->all_done_mutex) {
		RT_TRACE (eif_pthread_mutex_destroy (self->all_done_mutex));
		self->all_done_cv = NULL;
	}
	rt_identifier_set_deinit (&self->free_pids);
}


/*
doc:	<routine name="rt_processor_registry_new_identifier" return_type="int" export="private">
doc:		<summary> Acquire a new unique region identifier and store it in 'result'.
doc:			If none is currently available, a GC cycle is triggered and the feature blocks until it gets a free ID. </summary>
doc:		<param name="result" type="EIF_SCP_PID*"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<return> T_OK on success. If acquiring the mutex fails, an error code is returned. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_private int rt_processor_registry_new_identifier (EIF_SCP_PID* result)
{
	int error = T_OK;
	EIF_BOOLEAN success = EIF_FALSE;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("result_not_null", result);

		/* We first check if there's a result available. */
	success = rt_identifier_set_try_consume (&self->free_pids, result);

		/* If none is available, we have to run the garbage collector and then wait. */
	if (!success) {
		plsc();
		error = rt_identifier_set_consume (&self->free_pids, result);
	}
	return error;
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
rt_shared int rt_processor_registry_create_region (EIF_SCP_PID* result)
{
	EIF_SCP_PID pid = 0;
	int error = T_OK;
	struct rt_processor* new_processor = NULL;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("result_not_null", result);

		/* Acquire a new ID. */
	error = rt_processor_registry_new_identifier (&pid);

	if (T_OK == error) {
			/* Create and initialize the processor object. */
		error = rt_processor_create (pid, EIF_FALSE, &new_processor);

		if (T_OK == error) {
				/* Update the internal bookkeeping structures. */
			self->procs [pid] = new_processor;
			RTS_AI_I32 (&self->processor_count); /* Atomic increment */
			*result = pid;
		} else {
				/* Processor allocation failed. Return the PID. */
			RT_TRACE (rt_identifier_set_extend (&self->free_pids, pid));
		}
	}
	return error;
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
	struct rt_processor *proc = rt_get_processor (pid);

		/* Record that the current thread is associated with a processor of a given ID. */
	rt_set_processor_id (pid);

		/* Send a message to the creator thread that we have succesfully spawned.
		 * We recycle the RESULT_READY message here since the creator is not interested in the message anyway. */
	rt_message_channel_send (&proc->startup_notify, SCOOP_MESSAGE_RESULT_READY, NULL, NULL, NULL);

	rt_processor_application_loop (proc);

	rt_processor_registry_destroy_region (proc);
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

/*
doc:	<routine name="rt_processor_registry_deactivate" return_type="void" export="shared">
doc:		<summary> Deactivate the processor with ID 'pid' and remove all references to it from the other processors.
doc:			This routine is a callback from the GC when it detects unused processors. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be deactivated. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_deactivate (EIF_SCP_PID pid)
{
		/* This is a callback from the GC, which will notify us */
		/* of all unused processors, even those that have already been */
		/* freed, but still have a thread of execution. */
		/* To avoid double free we check first to see if they're */
		/* still active. */
		/* Note that this mechanism doesn't avoid double shutdown messages. */
	struct rt_processor* to_be_removed = NULL;
	struct rt_processor* item = NULL;
	EIF_SCP_PID index = 0;

	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);

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
			/* Send a shutdown signal such that the processor can terminate itself. */
		rt_processor_shutdown (to_be_removed);
	}
}

/*
doc:	<routine name="rt_processor_registry_destroy_region" return_type="void" export="private">
doc:		<summary> Free all resources in 'proc', remove the PID->processor mapping, and recycle the identifier. </summary>
doc:		<param name="fingerprint" type="EIF_INTEGER_32"> The fingerprint value. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call from the thread belonging to processor 'proc'. </synchronization>
doc:	</routine>
*/
rt_private void rt_processor_registry_destroy_region (struct rt_processor* proc)
{
	EIF_INTEGER_32 l_count = 0;
	EIF_SCP_PID pid = proc->pid;
	struct rt_processor_registry* self = &registry;

	REQUIRE ("processor_not_collected", rt_lookup_processor (pid));

		/* Decouple processor ID from the current thread. */
	rt_unset_processor_id ();

		/* Remove the processor from the bookkeeping structures in the processor registry. */
	l_count = RTS_AD_I32 (&self->processor_count); /* Atomic pre-decrement */
	self->procs [pid] = NULL;

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
		RT_TRACE (rt_identifier_set_extend (&self->free_pids, pid));
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
	rt_processor_registry_destroy_region (root_proc);

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
doc:	<routine name="rt_scoop_gc_request" return_type="void" export="shared">
doc:		<summary> Run a GC cycle when 'fingerprint' has not changed since the last call. </summary>
doc:		<param name="fingerprint" type="EIF_INTEGER_32"> The fingerprint value. </param>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required, done internally through atomic operations. </synchronization>
doc:	</routine>
*/
rt_shared void rt_scoop_gc_request (EIF_INTEGER_32* fingerprint)
{
	static volatile int gc_fingerprint = 0;
	int previous_fingerprint = * fingerprint;
	int current_fingerprint = RTS_ACAS_I32 (&gc_fingerprint, previous_fingerprint + 1, previous_fingerprint);
	
	if (current_fingerprint == previous_fingerprint) {
			/* The fingerprint is unchanged since last call, no GC was run, do it now. */
			/* Record newly written fingerprint for the next time. */
		* fingerprint = previous_fingerprint + 1;
			/* Run GC. */
		plsc();
	}
	else {
			/* Record current fingerprint for the next time. */
		* fingerprint = current_fingerprint;
	}
}

/*
doc:</file>
*/
