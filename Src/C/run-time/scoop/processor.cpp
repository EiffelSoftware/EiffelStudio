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

/* We need the size() and all the stack functions. */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (request_group_stack_t, struct rt_request_group)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (request_group_stack_t, struct rt_request_group)

processor::processor(EIF_SCP_PID _pid, bool _has_backing_thread) :
	cache (this),
	my_token (this),
	token_queue (),
	token_queue_mutex(),
	has_client (true),
	has_backing_thread (_has_backing_thread),
	pid(_pid),
	private_queue_cache(),
	cache_mutex(),
	is_dirty (false),
	parent_obj (make_shared_function <void *> ((void *) 0))
{
	rt_message_init (&this->current_msg, SCOOP_MESSAGE_UNLOCK, NULL, NULL); /*TODO: Should we add a "default" enum for initialization? */
	request_group_stack_t_init (&this->request_group_stack);
	active_count++;
}

processor::~processor()
{
	request_group_stack_t_deinit (&this->request_group_stack);

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
		/* Record pseudo execution vector */
	excatch(&exenv);

#ifdef _MSC_VER
/* Disable warning about C++ destructor not compatible with setjmp. It does not matter since
 * we call C code. */
#pragma warning (disable:4611)
#endif
	if (!setjmp(exenv)) {
#ifdef _MSC_VER
#pragma warning (default:4611)
#endif
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
		/* Only when no exception occurred do we need to pop the stack. */
    if (success) {
			/* Pop pseudo vector */
		expop(&eif_stack);
	}
	return success;
}

void processor::operator()(processor *client, call_data* call)
{
	bool is_synchronous = (call_data_sync_pid (call) != NULL_PROCESSOR_ID);

		/* Only execute the call when the current processor region is clean. */
	if (!is_dirty) {

		if (is_synchronous) {
				/* Grab all locks held by the client. */
			cache.push (&client->cache);
		}

			/* Execute the call. */
		bool successful_call = try_call (call);

			/* Mark the current region as dirty if the call fails. */
		if (!successful_call) {
			is_dirty = true;
		}

		if (is_synchronous) {
				/* Return the previously acquired locks. */
			cache.pop ();
		}
	}

	if (is_synchronous) {

			/* Propagate exceptions on a synchronous call. */
		if (is_dirty) {
			is_dirty = false;
			client -> result_notify.rude_awake();

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
			/* Forget dirtiness upon unlock */
			is_dirty = false;
			return;
		}

		(*this)(current_msg.sender, current_msg.call);

		current_msg.call = NULL; /* TODO: initialize to default state? */
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
doc:	<routine name="rt_processor_request_group_stack_extend" return_type="void" export="shared">
doc:		<summary> Create a new request group and put it at the end of the request group stack. </summary>
doc:		<param name="self" type="processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_request_group_stack_extend (processor* self)
{
	int error = T_OK;
	struct rt_request_group l_group; /* stack-allocated */

	REQUIRE ("self_not_null", self);

	rt_request_group_init (&l_group, self);
	error = request_group_stack_t_extend (&self->request_group_stack, l_group);
	if (error == T_NO_MORE_MEMORY) {
		enomem();
	}
}

/*
doc:	<routine name="rt_processor_request_group_stack_last" return_type="struct rt_request_group*" export="shared">
doc:		<summary> Return a pointer to the last element in the group stack of 'self'. </summary>
doc:		<param name="self" type="processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<return> A pointer to the last element of the group stack. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared struct rt_request_group* rt_processor_request_group_stack_last (processor* self)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("not_empty", request_group_stack_t_count (&self->request_group_stack) > 0);
	return request_group_stack_t_last_pointer (&self->request_group_stack);
}

/*
doc:	<routine name="rt_processor_request_group_stack_remove_last" return_type="void" export="shared">
doc:		<summary> Remove the last element from the group stack and free any resources. Note: This feature also performs an unlock operation. </summary>
doc:		<param name="self" type="processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_request_group_stack_remove_last (processor* self)
{
	struct rt_request_group* l_last = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("not_empty", request_group_stack_t_count (&self->request_group_stack) > 0);

	l_last = rt_processor_request_group_stack_last (self);
	rt_request_group_unlock (l_last);
	rt_request_group_deinit (l_last);
	request_group_stack_t_remove_last (&self->request_group_stack);
}

/*
doc:</file>
*/
