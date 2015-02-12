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
doc:<file name="processor.cpp" header="processor.hpp" version="$Id$" summary="SCOOP support.">
*/

#include "rt_msc_ver_mismatch.h"
#include "eif_utils.hpp"
#include "processor_registry.hpp"
#include "internal.hpp"
#include "private_queue.hpp"
#include "processor.hpp"
#include "eif_posix_threads.h"
#include "eif_threads.h"
#include <stdarg.h>
#include "rt_except.h"

atomic_int_type active_count = atomic_var_init;

processor::processor(EIF_SCP_PID _pid, bool _has_backing_thread) :
	cache (this),
	group_stack (),
	my_token (this),
	token_queue (),
	token_queue_mutex(),
	has_client (true),
	has_backing_thread (_has_backing_thread),
	pid(_pid),
	private_queue_cache(),
	cache_mutex(),
	dirty_for_set(),
	current_msg (),
	parent_obj (make_shared_function <void *> ((void *) 0))
{
	active_count++;
}

processor::~processor()
{
	for (std::vector<priv_queue*>::iterator pq = private_queue_cache.begin (); pq != private_queue_cache.end (); ++ pq) {
		delete *pq;
	}
}

bool processor::try_call (call_data *call)
{
		/* Switch this on to catch exceptions */
		/* This section slows down some benchmarks by 2x. I believe */
		/* this is due to either some locking in the allocation routines (again) */
		/* or reloading the thread local variables often. */
	EIF_GET_CONTEXT
	bool success;
	EIF_REFERENCE EIF_VOLATILE saved_except = NULL;
	EIF_OBJECT EIF_VOLATILE safe_saved_except = NULL;
	jmp_buf exenv;
	RTYL;

	saved_except = RTLA;
	if (saved_except) {
		safe_saved_except = eif_protect(saved_except);
	}
	excatch(&exenv);	/* Record pseudo execution vector */

	if (!setjmp(exenv)) {
#ifdef WORKBENCH
		eif_apply_wcall (call);
#else
		call->pattern (call);
#endif
		success = true;
		if (safe_saved_except) {
			set_last_exception (eif_access(safe_saved_except));
		}
	} else {
		success = false;
	}

	if (safe_saved_except) {
		eif_wean(safe_saved_except);
	}

	RTXE;
	expop(&eif_stack);					/* Pop pseudo vector */
	return success;
}

void processor::operator()(processor *client, call_data* call)
{
	EIF_SCP_PID sync_pid = call_data_sync_pid (call);

	if (call_data_is_lock_passing (call)) {
		cache.push (&client->cache);
	}

	bool successful_call = try_call (call);
	if (!successful_call) {
		dirty_for_set.insert (client);
	}

	if (call_data_is_lock_passing (call)) {
		cache.pop ();
	}

	if (sync_pid != NULL_PROCESSOR_ID) {
		std::set<processor*>::iterator it = dirty_for_set.find (client);

		if (it != dirty_for_set.end()) {
			client->result_notify.rude_awake();
			dirty_for_set.erase (it);
		} else {
			client->result_notify.result_awake();
		}
	}

	free (call);
}

void processor::process_priv_queue(priv_queue *pq)
{
	for (;;) {
		pq->pop_msg (current_msg);

		if (current_msg.call == NULL) {
			return;
		}

		(*this)(current_msg.client, current_msg.call);

		current_msg.call = NULL;
	}
}


void spawn_main(char* data, EIF_SCP_PID pid)
{
	processor *proc = registry [pid];
	(void)data;

		/* Record that the current thread is associated with a processor of a given ID. */
	eif_set_processor_id (pid);

	proc->startup_notify.result_awake();
	proc->application_loop();

	registry.return_processor (proc);
}


void processor::spawn()
{
	eif_thr_create_with_attr_new ((char**)parent_obj.get(), /* No root object, if this is only */
															/* passed to spawn_main this is OK */
		(void (*)(char* data, ...)) spawn_main,
		pid, /* Logical PID */
		EIF_TRUE, /* We are a processor */
		NULL); /* There are no attributes */
}

void processor::register_notify_token (notify_token token)
{
	unique_lock_type lock(token_queue_mutex);
	token_queue.push (token);
}

void processor::notify_next(processor *client)
{
	unique_lock_type lock(token_queue_mutex);
	std::queue <notify_token>::size_type n = token_queue.size();
	for (std::queue <notify_token>::size_type i = 0U; i < n && !token_queue.empty(); i++) {
		notify_token token = token_queue.front();
		token_queue.pop();

		if (token.client() == client) {
			token_queue.push(token);
		} else {
			token.notify(client);
		}
	}
}

void processor::application_loop()
{
	has_client = false;
	for (;;) {
		qoq_item res;

			/* Triggering the collection happens when all */
			/* processors are idle. This is sufficient for */
			/* program termination, but not sufficient for */
			/* freeing threads to let new ones take their */
			/* place. */
		if (--active_count == 0 && qoq.is_empty()) {
			plsc();
		}

		qoq.pop(res);

		if (!res.is_done) {
			active_count++;
			has_client = true;

			process_priv_queue (res.queue);
			notify_next (res.client);

			has_client = false;
		} else {
			break;
		}
	}
}

void processor::shutdown()
{
	qoq.push (qoq_item());
}

void processor::mark(MARKER marking)
{
	if (current_msg.call) {
		rt_mark_call_data (marking, current_msg.call);
	}

	for (std::vector<priv_queue*>::iterator pq = private_queue_cache.begin (); pq != private_queue_cache.end (); ++ pq) {
		(* pq) -> mark (marking);
	}
}


priv_queue* processor::new_priv_queue()
{
	unique_lock_type lk (cache_mutex);
	private_queue_cache.push_back(new priv_queue(this));
	return private_queue_cache.back();
}

/*
doc:</file>
*/
