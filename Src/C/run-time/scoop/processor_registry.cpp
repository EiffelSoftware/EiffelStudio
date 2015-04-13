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

processor_registry registry;

processor_registry::processor_registry ()
{
	int error = T_OK;
	processor_registry* self = this;
	
	error = rt_identifier_set_init (&self->free_pids, RT_MAX_SCOOP_PROCESSOR_COUNT);
	CHECK ("TODO: error handling", error == T_OK);
	
	error = eif_pthread_mutex_create (&self->all_done_mutex);
	CHECK ("TODO: error handling", error == T_OK);

	error = eif_pthread_cond_create (&self->all_done_cv);
	CHECK ("TODO: error handling", error == T_OK);

	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		self->procs [i] = NULL;
	}

		/* Atomic increment. */
	RTS_AI_I32 (&self->processor_count);

	processor *root_proc = NULL;
	error = rt_processor_create (0, EIF_TRUE, &root_proc);
	CHECK ("no_error", error == T_OK); /* TODO: Error handling. */
	CHECK ("has_client_set", root_proc->has_client);

	procs[0] = root_proc;

		/* end of life notification */
	self->all_done = EIF_FALSE;
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

/* GC activities */
void processor_registry::enumerate_live ()
{
	processor* proc = NULL;
	
	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		
		proc = this->procs[i];
		
		if (proc && proc->has_client) {
			rt_mark_live_pid (proc->pid);
		}
	}
}

/* Atomic integer used only by mark_all function. */
rt_private volatile EIF_INTEGER_32 rt_is_marking = 0;

/* use cas here for operations on is_marking */
void processor_registry::mark_all (MARKER marking)
{
	processor* proc = NULL;
	
	EIF_INTEGER_32 new_value = 1;
	EIF_INTEGER_32 expected = 0;
	
		/* Use compare-exchange to determine whether marking is necessary. */
		/* TODO: RS: Why is it necessary to use CAS here? As far as I can see this
		 * operation is called exactly once and only by a single thread during GC... */
	EIF_INTEGER_32 previous = RTS_ACAS_I32 (&rt_is_marking, new_value, expected);

	if (previous == expected) {
		for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
			proc = this->procs[i];
			if (proc) {
				rt_processor_mark (proc, marking);
			}
		}
			/* Reset is_marking to zero. */
		RTS_AS_I32 (&rt_is_marking, 0);
	}
}


void processor_registry::unmark (EIF_SCP_PID pid)
{
		/* This is a callback from the GC, which will notify us */
		/* of all unused processors, even those that have already been */
		/* freed, but still have a thread of execution. */
		/* To avoid double free we check first to see if they're */
		/* still active. */
		/* Note that this mechanism doesn't avoid double shutdown messages */
	processor* proc = this->procs[pid];
	if (proc) {
		clear_from_caches (proc);
		rt_processor_shutdown (proc);
	}
}


void processor_registry::clear_from_caches (processor *to_be_removed)
{
	processor* item = NULL;

	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		item = this->procs [i];
		if (item) {
			rt_queue_cache_clear (&item->cache, to_be_removed);
			rt_processor_unsubscribe_wait_condition (item, to_be_removed);
		}
	}
}


void processor_registry::wait_for_all()
{
	processor *root_proc = rt_find_processor (0);

		/* This statement seems to be redundant with the code in rt_processor_application_loop */
	root_proc->has_client = EIF_FALSE;

	rt_processor_application_loop (root_proc);

	return_processor (root_proc);

	EIF_ENTER_C;
	RT_TRACE (eif_pthread_mutex_lock (this->all_done_mutex));
	while (!this->all_done) {
		RT_TRACE (eif_pthread_cond_wait (this->all_done_cv, this->all_done_mutex));
	}
	RT_TRACE (eif_pthread_mutex_unlock (this->all_done_mutex));
	EIF_EXIT_C;
	RTGC;
}

/* GC fingerprint, only used by request_gc. */
rt_private volatile int rt_gc_fingerprint = 0;

void processor_registry::request_gc(EIF_INTEGER_32 * fingerprint)
{
	int previous_fingerprint = * fingerprint;
	int current_fingerprint = RTS_ACAS_I32 (&rt_gc_fingerprint, previous_fingerprint + 1, previous_fingerprint);
	
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
