/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
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
doc:<file name="processor_registry.cpp" header="processor_registry.hpp" version="$Id$" summary="SCOOP support.">
*/

#include "rt_msc_ver_mismatch.h"
#include "processor_registry.hpp"
#include "internal.hpp"
#include "processor.hpp"

#include "rt_assert.h"
#include "eif_macros.h"
#include "eif_scoop.h"
#include "eif_atomops.h"

/* The global processor_registry struct. */
processor_registry registry;

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
	processor_registry* self = &registry;
	processor* root_proc = NULL;
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
		
			/* Prepare the procs attribute. */
		for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
			self->procs [i] = NULL;
		}
		
		CHECK ("has_client_set", root_proc->has_client);
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
	processor_registry* self = &registry;
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

processor* processor_registry::create_fresh (EIF_REFERENCE obj)
{
	EIF_SCP_PID pid = 0;
	processor *proc = NULL;
		/* TODO: Return newly allocated PID instead of writing it to 'obj'
		   so that the argument 'obj' can be removed. */
	EIF_OBJECT object = eif_protect (obj);

	if (!rt_identifier_set_try_consume (&this->free_pids, &pid)) {
		plsc();
		int error = rt_identifier_set_consume (&this->free_pids, &pid);  /* TODO: Error handling */
	}

	int error = rt_processor_create (pid, EIF_FALSE, &proc);
	CHECK ("no_error", error == T_OK); /* TODO: Error handling. */

	obj = eif_access (object);
	RTS_PID(obj) = pid;

	procs[pid] = proc;
		/* Atomic increment. */
	RTS_AI_I32 (&this->processor_count);

	rt_processor_spawn (proc);

	eif_wean (object);

	return proc;
}

void processor_registry::return_processor (processor *proc)
{
	EIF_SCP_PID pid = proc->pid;
	EIF_INTEGER_32 l_count = 0;

		/* Decouple processor ID from the current thread. */
	eif_unset_processor_id ();
	
	CHECK ("processor_not_collected", procs[pid]);

		/* Atomic pre-decrement. */
	l_count = RTS_AD_I32 (&this->processor_count);
	
	procs [pid] = NULL;
	rt_processor_destroy (proc);

	if (l_count == 0) {
		RT_TRACE (eif_pthread_mutex_lock (this->all_done_mutex));
		this->all_done = EIF_TRUE;
		RT_TRACE (eif_pthread_cond_signal (this->all_done_cv));
		RT_TRACE (eif_pthread_mutex_unlock (this->all_done_mutex));
	}

		/* pid 0 is special so we don't recycle that one. */
	if (pid) {
		int error = rt_identifier_set_extend (&this->free_pids, pid); /* TODO: Error handling */
	}
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
	processor* to_be_removed = NULL;
	processor* item = NULL;
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
doc:	<routine name="rt_processor_registry_quit_root_processor" return_type="void" export="shared">
doc:		<summary> Finish execution of the root processor after it has completed the root feature. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call by the root processor. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_registry_quit_root_processor (void)
{
	processor_registry* self = &registry;
	processor *root_proc = rt_get_processor (0);

		/* First we have to enter a regular application loop, as some
		 * clients may still have references to objects created by the root processor. */
	rt_processor_application_loop (root_proc);

		/* When no more references to objects on the root region exist, we terminate. */
	self->return_processor (root_proc);

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
