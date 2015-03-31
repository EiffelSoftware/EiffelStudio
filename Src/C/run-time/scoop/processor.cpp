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
#include "internal.hpp"

#include "processor.hpp"
#include "processor_registry.hpp"

#include "eif_atomops.h"
#include "eif_posix_threads.h"
#include "eif_threads.h"
#include <stdarg.h>
#include "rt_except.h"



/* The number of active processors.
 * Must only be accessed via increment / decrement operations.
 * TODO: This is global state. Should it be moved to processor_registry? */
rt_private EIF_INTEGER_32 active_processor_count = 0;

/* Atomically increment active_processor_count. */
rt_private void increment_active_processor_count (void)
{
	RTS_AI_I32 (&active_processor_count);
}

/* Atomically decrement active_processor_count and return the new value. */
rt_private EIF_INTEGER_32 decrement_and_fetch_active_processor_count (void)
{
	return RTS_AD_I32 (&active_processor_count);
}



/* Declare the necessary features for the request group stack. We only need the size() and the stack functions. */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (request_group_stack_t, struct rt_request_group)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (request_group_stack_t, struct rt_request_group)

/* Declare the necessary features for the subscriber list. */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (subscriber_list_t, processor*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (subscriber_list_t, processor*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (subscriber_list_t, processor*)

/* Declare necessary features for the private queue list. */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (private_queue_list_t, priv_queue*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (private_queue_list_t, priv_queue*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (private_queue_list_t, priv_queue*)


processor::processor(EIF_SCP_PID _pid, bool _has_backing_thread) :
	has_client (true),
	has_backing_thread (_has_backing_thread),
	pid(_pid),
	is_dirty (false),
	parent_obj (make_shared_function <void *> ((void *) 0))
{
	int error = T_OK;


	rt_queue_cache_init (&this->cache, this);
	rt_message_init (&this->current_msg, SCOOP_MESSAGE_UNLOCK, NULL, NULL); /*TODO: Should we add a "default" enum for initialization? */
	rt_message_channel_init (&this->result_notify, 64);
	rt_message_channel_init (&this->startup_notify, 64);
	request_group_stack_t_init (&this->request_group_stack);
	subscriber_list_t_init (&this->wait_condition_subscribers);
	private_queue_list_t_init (&this->generated_private_queues);

	increment_active_processor_count();

		/* Create mutexes to protect the generated_private_queues and the queue_of_queues. */
	error = eif_pthread_mutex_create (&this->generated_private_queues_mutex); /* TODO: Error handling */
	error = eif_pthread_mutex_create (&this->queue_of_queues_mutex); /* TODO: Error handling */

		/* Create the CV and mutex for wait condition signalling. */
	error = eif_pthread_mutex_create (&this->wait_condition_mutex); /* TODO: Error handling */
	error = eif_pthread_cond_create (&this->wait_condition); /* TODO: Error handling */
}

processor::~processor()
{
	int error = T_OK;
	size_t l_count = 0;

		/* Destroy the mutex and condition variable.
		 * This is safe: No other thread can hold the lock on the mutex,
		 * because during garbage collection all references in the
		 * 'wait_condition_subscribers' vector of other processors have been removed,
		 * and the GC cannot run while other processors may hold a lock
		 * during 'notify_next'. */
	error = eif_pthread_cond_destroy (this->wait_condition);
	this->wait_condition = NULL;
	error = eif_pthread_mutex_destroy (this->wait_condition_mutex);
	this->wait_condition = NULL;


		/* Destroy the other mutexes. */
	error = eif_pthread_mutex_destroy (this->generated_private_queues_mutex);
	this->generated_private_queues_mutex = NULL;
	error = eif_pthread_mutex_destroy (this->queue_of_queues_mutex);
	this->queue_of_queues_mutex = NULL;

	l_count = private_queue_list_t_count (&this->generated_private_queues);

	for (size_t i = 0; i < l_count; ++i) {
		priv_queue* l_queue = private_queue_list_t_item (&this->generated_private_queues, i);
		rt_private_queue_deinit (l_queue);
		free (l_queue);
	}
 	rt_message_channel_deinit (&this->startup_notify);
	rt_message_channel_deinit (&this->result_notify);
	private_queue_list_t_deinit (&this->generated_private_queues);
	subscriber_list_t_deinit (&this->wait_condition_subscribers);
	request_group_stack_t_deinit (&this->request_group_stack);
	rt_queue_cache_deinit (&this->cache);
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
			rt_queue_cache_push (&this->cache, &client->cache);
		}

			/* Execute the call. */
		bool successful_call = try_call (call);

			/* Mark the current region as dirty if the call fails. */
		if (!successful_call) {
			is_dirty = true;
		}

		if (is_synchronous) {
				/* Return the previously acquired locks. */
			rt_queue_cache_pop (&this->cache);
		}
	}

	if (is_synchronous) {

			/* Propagate exceptions on a synchronous call. */
		if (is_dirty) {
			is_dirty = false;
			rt_message_channel_send (&client->result_notify, SCOOP_MESSAGE_DIRTY, NULL, NULL);

		} else {
			rt_message_channel_send (&client->result_notify, SCOOP_MESSAGE_RESULT_READY, NULL, NULL);
		}
	}

	free (call);
}

void processor::process_priv_queue(priv_queue *pq)
{
	for (;;) {

		/* Receive a new call and store it in current_msg.
		 * This is a blocking call if no data is available.
		 * The call might be logged by the original client of the queue
		 * or some other processor that has acquired the locks during lock passing. */
		rt_message_channel_receive (&pq->channel, &this->current_msg);

		enum scoop_message_type type = current_msg.message_type;

		CHECK ("valid_messages", type == SCOOP_MESSAGE_EXECUTE || type == SCOOP_MESSAGE_UNLOCK);

		if (type == SCOOP_MESSAGE_UNLOCK) {
			/* Forget dirtiness upon unlock */
			is_dirty = false;
			return;
		}

		(*this)(current_msg.sender, current_msg.call);

			/* Make sure the call doesn't get traversed again for GC */
		current_msg.call = NULL; /* TODO: initialize to default state? */
	}
}


void spawn_main(char* data, EIF_SCP_PID pid)
{
	processor *proc = registry [pid];
	(void)data;

		/* Record that the current thread is associated with a processor of a given ID. */
	eif_set_processor_id (pid);

		/* TODO: Would it make sense to add another message type SCOOP_PROCESSOR_STARTED ? */
	rt_message_channel_send (&proc->startup_notify, SCOOP_MESSAGE_RESULT_READY, NULL, NULL);

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

void processor::notify_next(processor *client)
{
	bool found = false;
	int error = T_OK;
	struct subscriber_list_t* subscribers = &this->wait_condition_subscribers;

	while ( !(0 == subscriber_list_t_count(subscribers))) {
		processor* item = subscriber_list_t_last (subscribers);
		subscriber_list_t_remove_last (subscribers);

		if (item == client) {
				/* The client might be the processor that has just unlocked us
				 * after a wait condition has failed. We obviously don't want to
				 * send it a notification back. */
			found = true;
		} else {

				/* To avoid having to move around items within the vector,
				 * the GC may set some references to NULL. */
			if (item) {

					/* Lock the registered processor's condition variable mutex. */
				eif_pthread_mutex_lock (item->wait_condition_mutex); /* TODO: Error handling */

					/* Send a signal. */
				eif_pthread_cond_signal (item->wait_condition); /* TODO: Error handling */

					/* Release the lock. */
				eif_pthread_mutex_unlock (item->wait_condition_mutex); /* TODO: Error handling */
			}
		}
	}
	if (found) {
		error = subscriber_list_t_extend (subscribers, client);
			/* A possible error can only happen during reallocation. This is impossible here,
			 * because we only push one item, and only if it was removed previously. */
		CHECK ("no_error_possible", error == T_OK);
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
		if (decrement_and_fetch_active_processor_count() == 0 && qoq.is_empty()) {
			plsc();
		}

		qoq.pop(res);

		if (!res.is_done) {
			increment_active_processor_count();
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
	size_t l_count = 0;

	if (current_msg.call) {
		rt_mark_call_data (marking, current_msg.call);
	}

	l_count = private_queue_list_t_count (&this->generated_private_queues);

	for (size_t i = 0; i < l_count; ++i) {
		priv_queue* l_queue = private_queue_list_t_item (&this->generated_private_queues, i);
		rt_private_queue_mark (l_queue, marking);
	}
}


priv_queue* processor::new_priv_queue()
{
	int error = T_OK;

	priv_queue* l_queue = (priv_queue*) malloc (sizeof (priv_queue)); /* TODO: Error handling */
	rt_private_queue_init (l_queue, this);

		/* TODO: Error handling */
	error = eif_pthread_mutex_lock (this->generated_private_queues_mutex);
	error = private_queue_list_t_extend (&this->generated_private_queues, l_queue);
	error = eif_pthread_mutex_unlock (this->generated_private_queues_mutex);

	return l_queue;
}

/*
doc:	<routine name="rt_processor_subscribe_wait_condition" return_type="void" export="shared">
doc:		<summary> Register for a notification when the heap protected by processor 'self' may have changed.
doc:			This is used to implement wait condition change signalling.
doc:			The registration is only valid for a single notification and will be deleted by 'self' afterwards.
doc:			Note: This feature is executed by the 'client' processor (i.e. thread), and can only be called when the
doc:			supplier 'self' is synchronized with the client. </summary>
doc:		<param name="self" type="processor*"> The processor that will send the notification in the future. Must not be NULL. </param>
doc:		<param name="client" type="processor*"> The processor interested in wait condition changes. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call when 'self' is synchronized with 'client'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_subscribe_wait_condition (processor* self, processor* client)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("synchronized", rt_private_queue_is_synchronized (rt_queue_cache_retrieve (&client->cache, self)));
	subscriber_list_t_extend (&self->wait_condition_subscribers, client);
}



/*
doc:	<routine name="rt_processor_unsubscribe_wait_condition" return_type="void" export="shared">
doc:		<summary> Remove the soon-to-be-collected processor 'dead_processor' from the internal list of clients
doc:			registered for a wait condition change. This feature can only be executed by the garbage collector. </summary>
doc:		<param name="self" type="processor*"> The processor that owns the registration list. Must not be NULL. </param>
doc:		<param name="dead_processor" type="processor*"> The processor to be unsubscribed (which may be deleted soon). </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during garbage collection. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_unsubscribe_wait_condition (processor* self, processor* dead_processor)
{
	size_t l_count = 0;
	REQUIRE ("self_not_null", self);

	l_count =  subscriber_list_t_count (&self->wait_condition_subscribers);

	for (size_t i=0; i<l_count; ++i) {
		processor** l_item = subscriber_list_t_item_pointer (&self->wait_condition_subscribers, i);

		if (*l_item == dead_processor) {
			*l_item = NULL;
		}
	}
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
