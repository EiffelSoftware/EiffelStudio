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
#include "eif_utils.hpp"
#include "processor_registry.hpp"
#include "internal.hpp"
#include "processor.hpp"
#include "rt_assert.h"
#include "eif_macros.h"
#include "eif_scoop.h"

processor_registry registry;

processor_registry::processor_registry ()
{
	rt_identifier_set_init (&this->free_pids, RT_MAX_SCOOP_PROCESSOR_COUNT);

	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		procs [i] = NULL;
	}

	used_pids.add(0);

	processor *root_proc = NULL;
	int error = rt_processor_create (0, EIF_TRUE, &root_proc);
	CHECK ("no_error", error == T_OK); /* TODO: Error handling. */
	CHECK ("has_client_set", root_proc->has_client);

	procs[0] = root_proc;

		/* end of life notification */
	all_done = false;

		/* GC */
	is_marking = false;
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

	procs[pid] = proc;
	obj = eif_access (object);
	RTS_PID(obj) = pid;

	used_pids.add (pid);

	rt_processor_spawn (proc);

	eif_wean (object);

	return proc;
}

processor* processor_registry::operator[] (EIF_SCP_PID pid)
{
	REQUIRE("Has PID", used_pids.has (pid));
	processor *proc = procs[pid];
	ENSURE("processor_registry: retrieved processor not NULL", proc);
	return proc;
}

void processor_registry::return_processor (processor *proc)
{
	EIF_SCP_PID pid = proc->pid;

		/* Decouple processor ID from the current thread. */
	eif_unset_processor_id ();

	if (used_pids.erase (pid)) {
		rt_processor_destroy (proc);
		procs [pid] = NULL;

		if (used_pids.size() == 0) {
			conditional_unique_lock_type lock(all_done_mutex);
			all_done = true;
			all_done_cv.notify_one();
		}

			/* pid 0 is special so we don't recycle that one. */
		if (pid) {
			int error = rt_identifier_set_extend (&this->free_pids, pid); /* TODO: Error handling */
		}
	} else {
		CHECK ("return_pid: shouldn't be there", 0);
	}
}

/* GC activities */
void processor_registry::enumerate_live ()
{
	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		if (used_pids.has (i)) {
			processor* proc = (*this) [i];
		
			if (proc->has_client) {
				rt_mark_live_pid (proc->pid);
			}
		}
	}
}

/* use cas here for operations on is_marking */
void processor_registry::mark_all (MARKER marking)
{
	bool f = false;

	if (is_marking.compare_exchange_strong(f, true)) {
		for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
			if (used_pids.has (i)) {
				processor *proc = (*this) [i];
				rt_processor_mark (proc, marking);
			}
		}
		is_marking = false;
	}
}


void processor_registry::unmark (EIF_SCP_PID pid)
{
		/* This is a callback from the GC, which will notify us */
		/* of all unused processors, even those that have already been */
		/* shutdown, but still have a thread of execution. */
		/* To avoid double free/shutdown we check first to see if they're */
		/* still active. */
	if (used_pids.has (pid)) {
		processor *proc = (*this) [pid];
		clear_from_caches (proc);
		rt_processor_shutdown (proc);
	}
}


void processor_registry::clear_from_caches (processor *proc)
{
	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		if (used_pids.has (i)) {
			rt_queue_cache_clear ( &(procs[i]->cache), proc);
			rt_processor_unsubscribe_wait_condition (procs[i], proc);
		}
	}
}


void processor_registry::wait_for_all()
{
	processor *root_proc = (*this)[0];

		/* This statement seems to be redundant with the code in rt_processor_application_loop */
	root_proc->has_client = EIF_FALSE;

	rt_processor_application_loop (root_proc);

	return_processor (root_proc);

	while(!all_done) {
		eif_lock lock (all_done_mutex);
		while(!all_done) {
			all_done_cv.wait(lock);
		}
	}
}

void processor_registry::request_gc(EIF_INTEGER_32 * fingerprint)
{
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
