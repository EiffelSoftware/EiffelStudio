/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
	copyright:	"Copyright (c) 2010-2012, Eiffel Software.",
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

processor_registry::processor_registry () :
	free_pids (RT_MAX_SCOOP_PROCESSOR_COUNT)
{
	for (EIF_SCP_PID i = 1; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		free_pids.enqueue (i);
	}

	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		procs [i] = NULL;
	}

	used_pids.add(0);

	processor *root_proc = new processor(0, true);
	root_proc->has_client = true;

	procs[0] = root_proc;

		/* end of life notification */
	all_done = false;

		/* GC */
	is_marking = false;
}

processor* processor_registry::create_fresh (EIF_REFERENCE obj)
{
	EIF_SCP_PID pid = 0;
	processor *proc;

	if (!free_pids.dequeue (pid)) {
		plsc();
		{
			eif_lock lock (need_pid_mutex);
			{
				while (!free_pids.dequeue (pid))
					{
						need_pid_cv.wait (lock);
					}
			}
		}
	}

	proc = new processor(pid, false);
	procs[pid] = proc;
	RTS_PID(obj) = pid;

	used_pids.add (pid);

	proc->spawn();
	proc->startup_notify.wait();

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
		delete proc;
		procs [pid] = NULL;

		if (used_pids.size() == 0) {
			conditional_unique_lock_type lock(all_done_mutex);
			all_done = true;
			all_done_cv.notify_one();
		}

			/* pid 0 is special so we don't recycle that one. */
		if (pid) {
			eif_lock lock (need_pid_mutex);
			free_pids.enqueue (pid);
			need_pid_cv.notify_all();
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
				proc->mark (marking);
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
		proc->shutdown();
	}
}


void processor_registry::clear_from_caches (processor *proc)
{
	for (EIF_SCP_PID i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {
		if (used_pids.has (i)) {
			procs[i]->cache.clear (proc);
		}
	}
}


void processor_registry::wait_for_all()
{
	processor *root_proc = (*this)[0];

	root_proc->has_client = false;
	root_proc->application_loop();

	return_processor (root_proc);

	while(!all_done) {
		eif_lock lock (all_done_mutex);
		while(!all_done) {
			all_done_cv.wait(lock);
		}
	}
}

void processor_registry::run_gc()
{
	plsc();
}

/*
doc:</file>
*/
