/*
	description:	"Representation of a SCOOP processor."
	date:		"$Date$"
	revision:	"$Revision$"
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
doc:<file name="processor.c" header="rt_processor.h" version="$Id$" summary="Representation of a SCOOP processor.">
*/

#include "rt_processor.h"
#include "eif_scoop.h"
#include "rt_scoop_helpers.h"

#include "eif_atomops.h"
#include "eif_posix_threads.h"



/* The number of active processors.
 * Must only be accessed via increment / decrement operations.
 * TODO: This is global state. Should it be moved to processor_registry? */
rt_private volatile EIF_INTEGER_32 active_processor_count = 0;

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
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (subscriber_list_t, struct rt_processor*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (subscriber_list_t, struct rt_processor*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (subscriber_list_t, struct rt_processor*)

/* Declare necessary features for the private queue list. */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (private_queue_list_t, struct rt_private_queue*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (private_queue_list_t, struct rt_private_queue*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (private_queue_list_t, struct rt_private_queue*)




/*
doc:	<routine name="rt_processor_create" return_type="int" export="shared">
doc:		<summary> Create a new processor with ID 'a_pid'. Note: This only creates the processor object and does not spawn a new thread. </summary>
doc:		<param name="a_pid" type="EIF_SCP_PID"> The new ID of the processor. </param>
doc:		<param name="is_root_processor" type="EIF_BOOLEAN"> A boolean indicating whether the new processor is the root processor. </param>
doc:		<param name="result" type="struct rt_processor**"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<return> An error code: T_OK on success. T_NO_MORE_MEMORY when memory allocation fails, and possibly any of the error codes that may happen during mutex creation. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared int rt_processor_create (EIF_SCP_PID a_pid, EIF_BOOLEAN is_root_processor, struct rt_processor** result)
{
	int error = T_OK;
	struct rt_processor* self = NULL;

	REQUIRE ("result_not_null", result);
	REQUIRE ("valid_pid", a_pid != EIF_NULL_PROCESSOR);
		/* The valid_pid precondition may be dropped one day, but currently the SCOOP
		 * runtime is not able to handle processors with this reserved ID. */

		/* Note: We initialize to zero to avoid having inconsistent states
		 * in case we need to call rt_processor_destroy when a failure happens. */
	self = (struct rt_processor*) calloc (1, sizeof (struct rt_processor));

	if (self) {

			/* Initialize the data fields. */
		self->pid = a_pid;
		self->client = EIF_NULL_PROCESSOR;
		self->is_active = EIF_TRUE;
		self->is_dirty = EIF_FALSE;
		rt_message_init (&self->current_msg, SCOOP_MESSAGE_INVALID, NULL, NULL, NULL);
			/* Only the root processor's creation procedure is initially "logged". */
		self->is_creation_procedure_logged = is_root_processor;

			/* Initialize the embedded vector structs.
			 * As no memory allocation happens, we don't have to care about errors. */
		request_group_stack_t_init (&self->request_group_stack);
		subscriber_list_t_init (&self->wait_condition_subscribers);
		private_queue_list_t_init (&self->generated_private_queues);

			/* Initialize the queue_cache. We may get an allocation failure here. */
		error = rt_queue_cache_init (&self->cache, self);

			/* Next we need to initialize several message channels. */
		if (T_OK == error) {
				/* TODO: Change rt_message_channel_init to return an error code instead of an exception. */
			rt_message_channel_init (&self->result_notify, 64);
		}
		if (T_OK == error) {
			rt_message_channel_init (&self->startup_notify, 64);
		}
		if (T_OK == error) {
			rt_message_channel_init (&self->queue_of_queues, 128);
		}


			/* As a last step we create mutexes and condition variables.
			 * This may fail as well, so we have to catch errors. */
		if (T_OK == error) {
			error = eif_pthread_mutex_create (&self->generated_private_queues_mutex);
		}
		if (T_OK == error) {
			error = eif_pthread_mutex_create (&self->queue_of_queues_mutex);
		}

		if (T_OK == error) {
			error = eif_pthread_mutex_create (&self->wait_condition_mutex);
		}
		if (T_OK == error) {
			error = eif_pthread_cond_create (&self->wait_condition);
		}

		if (T_OK == error) {
				/* If we managed to allocate all we need we can increase the number of active processors. */
			increment_active_processor_count();
			*result = self;
		} else {
				/* Something went wrong. Try to clean up any partially allocated resources before returning. */
			rt_processor_destroy (self);
		}
	} else {
			/* The initial allocation failed. Report allocation failure. */
		error = T_NO_MORE_MEMORY;
	}

	return error;
}

/*
doc:	<routine name="rt_processor_destroy" return_type="void" export="shared">
doc:		<summary> Destroy the processor 'self' and release all internal resources. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor to be destroyed. May be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call this function after the garbage collection phase, when all wait condition registrations and private queues from this processor have been revoked. </synchronization>
doc:		<fixme> This is currently called by the processor that terminates itself. We may have to find another solution for passive processors. </fixme>
doc:	</routine>
*/
rt_shared void rt_processor_destroy (struct rt_processor* self)
{
	size_t l_count = 0, i;
	struct rt_private_queue** l_item = NULL;

	if (self) {

			/* Note: We don't propagate error codes when freeing mutexes / condition variables.
			* It can only happen when the mutex is locked, the condition variable is waited on,
			* or when an invalid pointer is passed. All three are clear indications of a bug
			* in the runtime. */

			/* Destroy the mutex and condition variable.
			* This is safe: No other thread can hold the lock on the mutex,
			* because during garbage collection all references in the
			* 'wait_condition_subscribers' vector of other processors have been removed,
			* and the GC cannot run while other processors may hold a lock
			* during 'notify_next'. */
		if (self->wait_condition) {
			RT_TRACE (eif_pthread_cond_destroy (self->wait_condition));
			self->wait_condition = NULL;
		}

		if (self->wait_condition_mutex) {
			RT_TRACE (eif_pthread_mutex_destroy (self->wait_condition_mutex));
			self->wait_condition_mutex = NULL;
		}

			/* Destroy the other mutexes.
			* Again, this is safe because the garbage collector has removed any references
			* to this processor before sending the shutdown message. */
		if (self->generated_private_queues_mutex) {
			RT_TRACE (eif_pthread_mutex_destroy (self->generated_private_queues_mutex));
			self->generated_private_queues_mutex = NULL;
		}

		if (self->queue_of_queues_mutex) {
			RT_TRACE (eif_pthread_mutex_destroy (self->queue_of_queues_mutex));
			self->queue_of_queues_mutex = NULL;
		}

			/* Free all private queues generated by this processor.
			* The queues have been removed from the caches of the client processors during GC. */
		l_count = private_queue_list_t_count (&self->generated_private_queues);
		for (i = 0; i < l_count; ++i) {
			l_item = private_queue_list_t_item_pointer (&self->generated_private_queues, i);
			if (*l_item) {
				rt_private_queue_deinit (*l_item);
				free (*l_item);
				*l_item = NULL;
			}
		}

			/* Free all our message channels. */
		rt_message_channel_deinit (&self->queue_of_queues);
		rt_message_channel_deinit (&self->startup_notify);
		rt_message_channel_deinit (&self->result_notify);

			/* Free the internal memory of the vectors. */
		private_queue_list_t_deinit (&self->generated_private_queues);
		subscriber_list_t_deinit (&self->wait_condition_subscribers);
		request_group_stack_t_deinit (&self->request_group_stack);

			/* As a last step, deallocate the queue cache and the processor struct itself. */
		rt_queue_cache_deinit (&self->cache);
		free (self);
	}
}

/*
doc:	<routine name="rt_processor_mark" return_type="void" export="shared">
doc:		<summary> Mark the private queues generated by this processor. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor object. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marker function. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_mark (struct rt_processor* self, MARKER marking)
{
	size_t l_count = 0, i;
	struct rt_private_queue* l_queue = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);

		/* Also mark the call that may be executed right now. */
	if (self->current_msg.call) {
		rt_mark_call_data (marking, self->current_msg.call);
	}

		/* Mark all private queues in generated_private_queues */
	l_count = private_queue_list_t_count (&self->generated_private_queues);

	for (i = 0; i < l_count; ++i) {
		l_queue = private_queue_list_t_item (&self->generated_private_queues, i);
		rt_private_queue_mark (l_queue, marking);
	}
}

/*
doc:	<routine name="rt_processor_execute_call" return_type="void" export="shared">
doc:		<summary> Execute the call 'call' coming from processor 'client'. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that executes the call. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The processor that sent the request. Must not be NULL. </param>
doc:		<param name="call" type="struct call_data*"> The call to be executed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only execute this feature on the thread behind processor 'self'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_execute_call (struct rt_processor* self, struct rt_processor* client, struct call_data* call)
{
	EIF_BOOLEAN is_synchronous;
	EIF_BOOLEAN is_successful;
	size_t l_count = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("call_not_null", call);

	is_synchronous = (call->sync_pid != EIF_NULL_PROCESSOR);

		/* Only execute the call when the current processor region is clean. */
	if (!self->is_dirty) {

		if (is_synchronous) {
				/* Grab all locks held by the client. */
			RT_TRACE (rt_queue_cache_push (&self->cache, &client->cache)); /* TODO: Handle error.*/
		}
			/* Remember the size of the request group stack. */
		l_count = rt_processor_request_group_stack_count (self);

			/* Execute the call. */
		is_successful = rt_scoop_try_call (call);

			/* Mark the current region as dirty if the call fails. */
		if (!is_successful) {
			self->is_dirty = EIF_TRUE;
				/* Unlock any request groups that may have been locked during this call. */
			rt_processor_request_group_stack_remove (self, rt_processor_request_group_stack_count (self) - l_count);
		}

			/* The request group stack should be the same after this call. */
		CHECK ("same_stack_size", rt_processor_request_group_stack_count(self) == l_count);

		if (is_synchronous) {
				/* Return the previously acquired locks. */
			rt_queue_cache_pop (&self->cache);
		}
	}

	if (is_synchronous) {

		if (self->is_dirty) {
			self->is_dirty = EIF_FALSE;
				/* Propagate exceptions on a synchronous call. */
			rt_message_channel_send (&client->result_notify, SCOOP_MESSAGE_DIRTY, NULL, NULL, NULL);

		} else {
				/* Inform the client that we finished executing his call. */
			rt_message_channel_send (&client->result_notify, SCOOP_MESSAGE_RESULT_READY, NULL, NULL, NULL);
		}
	}

		/* Free the call data struct, as it's not needed any more. */
	free (call);
}


/*
doc:	<routine name="rt_processor_process_private_queue" return_type="void" export="private">
doc:		<summary> Execute all calls in the private queue 'queue' until an unlock message has arrived. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor object. Must not be NULL. </param>
doc:		<param name="queue" type="struct rt_private_queue*"> The private queue to be worked on. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only execute this feature on the thread behind processor 'self'. </synchronization>
doc:	</routine>
*/
rt_private void rt_processor_process_private_queue (struct rt_processor* self, struct rt_private_queue *queue)
{
	EIF_BOOLEAN is_stopped = EIF_FALSE;
	enum scoop_message_type type = SCOOP_MESSAGE_INVALID;

	REQUIRE ("self_not_null", self);
	REQUIRE ("queue_not_null", queue);

	while (!is_stopped) {

			/* Receive a new call and store it in current_msg.
			* This is a blocking call if no data is available.
			* The call might be logged by the original client of the queue
			* or some other processor that has acquired the locks during lock passing. */
		rt_message_channel_receive (&queue->channel, &self->current_msg);

		type = self->current_msg.message_type;

		CHECK ("valid_messages", type == SCOOP_MESSAGE_EXECUTE || type == SCOOP_MESSAGE_UNLOCK);

		if (type == SCOOP_MESSAGE_UNLOCK) {
				/* Forget dirtiness upon unlock */
			self->is_dirty = EIF_FALSE;
			is_stopped = EIF_TRUE;
		} else {

			rt_processor_execute_call (self, self->current_msg.sender, self->current_msg.call);

				/* Make sure the call doesn't get traversed again for GC */
			self->current_msg.message_type = SCOOP_MESSAGE_INVALID;
			self->current_msg.sender = NULL;
			self->current_msg.call = NULL;
		}
	}
}

/*
doc:	<routine name="rt_processor_publish_wait_condition" return_type="void" export="private">
doc:		<summary> Notify all processors in the 'self->wait_condition_subscribers' vector that a wait condition has changed. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor with the subscribers list. Must not be NULL. </param>
doc:		<param name="dead_processor" type="struct rt_processor*"> The processor whose private queue 'self' has been processing last. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> The feature rt_processor_subscribe_wait_condition must only be called when the thread executing 'self' is synchronized with a client.
doc:			This ensures that rt_publish_wait_condition cannot be executed at the same time. </synchronization>
doc:	</routine>
*/
rt_private void rt_processor_publish_wait_condition (struct rt_processor* self, struct rt_processor *client)
{
	EIF_BOOLEAN found = EIF_FALSE;
	struct subscriber_list_t* subscribers = NULL;

	REQUIRE ("self_not_null", self);

	subscribers = &self->wait_condition_subscribers;

	while ( !(0 == subscriber_list_t_count(subscribers))) {
		struct rt_processor* item = subscriber_list_t_last (subscribers);
		subscriber_list_t_remove_last (subscribers);

		if (item == client) {
				/* The client might be the processor that has just unlocked us
				 * after a wait condition has failed. We obviously don't want to
				 * send it a notification back. */
			found = EIF_TRUE;
		} else {

				/* To avoid having to move around items within the vector,
				 * the GC may set some references to NULL. */
			if (item) {

					/* Lock the registered processor's condition variable mutex. */
				RT_TRACE (eif_pthread_mutex_lock (item->wait_condition_mutex)); /* TODO: Return an error code? */

					/* Send a signal. */
				RT_TRACE (eif_pthread_cond_signal (item->wait_condition));

					/* Release the lock. */
				RT_TRACE (eif_pthread_mutex_unlock (item->wait_condition_mutex));
			}
		}
	}
	if (found) {
			/* An error can only happen during reallocation. This is impossible here,
			 * because we only push one item, and only if it was removed previously. */
		RT_TRACE (subscriber_list_t_extend (subscribers, client));
	}
}

/*
doc:	<routine name="rt_processor_application_loop" return_type="void" export="shared">
doc:		<summary> The main loop of a SCOOP processor.
doc:			Normally this will be called when the thread spawns but here we expose it
doc:			so that it may be called externally for the root thread (whose thread is
doc:			the main thread of the program, and thus already exists). </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor object. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only execute this feature on the thread behind processor 'self'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_application_loop (struct rt_processor* self)
{
	EIF_BOOLEAN is_stopped = EIF_FALSE;

	REQUIRE ("self_not_null", self);

	self->is_active = EIF_FALSE;

	while (!is_stopped) {
		struct rt_message next_job;

			/* Triggering the collection happens when all */
			/* processors are idle. This is sufficient for */
			/* program termination, but not sufficient for */
			/* freeing threads to let new ones take their */
			/* place. */
		if (decrement_and_fetch_active_processor_count() == 0
			&& rt_message_channel_is_empty (&self->queue_of_queues)) {
			plsc();
		}

		rt_message_channel_receive_with_gc (&self->queue_of_queues, &next_job);

		if (next_job.message_type == SCOOP_MESSAGE_ADD_QUEUE) {
			increment_active_processor_count();
			self->is_active = EIF_TRUE;
			self->client = next_job.sender->pid;

			rt_processor_process_private_queue (self, next_job.queue);
			rt_processor_publish_wait_condition (self, next_job.sender);

			self->is_active = EIF_FALSE;
			self->client = EIF_NULL_PROCESSOR;
		} else {
			CHECK ("shutdown_message", next_job.message_type == SCOOP_MESSAGE_SHUTDOWN);
			is_stopped = EIF_TRUE;
		}
	}
		/* Check disabled because queue-of-queues might contain multiple shutdown messages. */
	/*CHECK ("empty_queue_of_queues", rt_message_channel_is_empty (&self->queue_of_queues)); */
}

/*
doc:	<routine name="rt_processor_shutdown" return_type="void" export="shared">
doc:		<summary> Send a shutdown message. This will cause the thread to terminate itself when
doc:			it receives it. A shutdown should only happen when the GC has detected that there
doc:			are no more referenced objects on this region and the processor is idle. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor to be shut down. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_shutdown (struct rt_processor* self)
{
	REQUIRE ("self_not_null", self);
	rt_message_channel_send (&self->queue_of_queues, SCOOP_MESSAGE_SHUTDOWN, NULL, NULL, NULL);
}

/*
doc:	<routine name="rt_processor_new_private_queue" return_type="int" export="shared">
doc:		<summary> Create a new private queue whose supplier is this processor. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor object. Must not be NULL. </param>
doc:		<param name="result" type="struct rt_private_queue**"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY or a mutex locking error code on failure. </return>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
int rt_processor_new_private_queue (struct rt_processor* self, struct rt_private_queue** result)
{
	int error = T_OK;
	struct rt_private_queue* l_queue = NULL;

	REQUIRE ("self_not_nul", self);
	REQUIRE ("result_not_null", result);

	l_queue = (struct rt_private_queue*) malloc (sizeof (struct rt_private_queue));

	if (l_queue) {
			/* TODO: Change rt_private_queue_init to return an error code instead of an exception. */
		/*error=*/rt_private_queue_init (l_queue, self);

		if (T_OK == error) {
			error = eif_pthread_mutex_lock (self->generated_private_queues_mutex);

			if (T_OK == error) {
				error = private_queue_list_t_extend (&self->generated_private_queues, l_queue);
			}
				/* An error during unlock is an indication of a bug. */
			RT_TRACE (eif_pthread_mutex_unlock (self->generated_private_queues_mutex));
		}

		if (T_OK == error) {
			*result = l_queue;
		} else {
				/* An error occured. Free allocated resources and return. */
			rt_private_queue_deinit (l_queue);
			free (l_queue);
		}

	} else {
		error = T_NO_MORE_MEMORY;
	}
	return error;
}

/*
doc:	<routine name="rt_processor_subscribe_wait_condition" return_type="void" export="shared">
doc:		<summary> Register for a notification when the heap protected by processor 'self' may have changed.
doc:			This is used to implement wait condition change signalling.
doc:			The registration is only valid for a single notification and will be deleted by 'self' afterwards.
doc:			Note: This feature is executed by the 'client' processor (i.e. thread), and can only be called when the
doc:			supplier 'self' is synchronized with the client. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that will send the notification in the future. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The processor interested in wait condition changes. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call when 'self' is synchronized with 'client'. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_subscribe_wait_condition (struct rt_processor* self, struct rt_processor* client)
{
	struct rt_private_queue* pq = NULL; /* For assertion checking. */
	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("queue_available", T_OK == rt_queue_cache_retrieve (&client->cache, self, &pq));
	REQUIRE ("synchronized", rt_private_queue_is_synchronized (pq));

	subscriber_list_t_extend (&self->wait_condition_subscribers, client);
}



/*
doc:	<routine name="rt_processor_unsubscribe_wait_condition" return_type="void" export="shared">
doc:		<summary> Remove the soon-to-be-collected processor 'dead_processor' from the internal list of clients
doc:			registered for a wait condition change. This feature can only be executed by the garbage collector. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that owns the registration list. Must not be NULL. </param>
doc:		<param name="dead_processor" type="struct rt_processor*"> The processor to be unsubscribed (which may be deleted soon). </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during garbage collection. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_unsubscribe_wait_condition (struct rt_processor* self, struct rt_processor* dead_processor)
{
	size_t l_count = 0, i;
	REQUIRE ("self_not_null", self);

	l_count =  subscriber_list_t_count (&self->wait_condition_subscribers);

	for (i = 0; i<l_count; ++i) {
		struct rt_processor** l_item = subscriber_list_t_item_pointer (&self->wait_condition_subscribers, i);

		if (*l_item == dead_processor) {
			*l_item = NULL;
		}
	}
}

/*
doc:	<routine name="rt_processor_request_group_stack_extend" return_type="void" export="shared">
doc:		<summary> Create a new request group and put it at the end of the request group stack. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_request_group_stack_extend (struct rt_processor* self)
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
doc:	<routine name="rt_processor_request_group_stack_count" return_type="size_t" export="shared">
doc:		<summary> Return the number of elements in the request group stack of 'self'. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<return> The number of request groups in the stack. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared size_t rt_processor_request_group_stack_count (struct rt_processor* self)
{
	REQUIRE ("self_not_null", self);
	return request_group_stack_t_count (&self->request_group_stack);
}

/*
doc:	<routine name="rt_processor_request_group_stack_last" return_type="struct rt_request_group*" export="shared">
doc:		<summary> Return a pointer to the last element in the group stack of 'self'. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<return> A pointer to the last element of the group stack. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared struct rt_request_group* rt_processor_request_group_stack_last (struct rt_processor* self)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("not_empty", request_group_stack_t_count (&self->request_group_stack) > 0);
	return request_group_stack_t_last_pointer (&self->request_group_stack);
}

/*
doc:	<routine name="rt_processor_request_group_stack_remove" return_type="void" export="shared">
doc:		<summary> Remove the last 'count' elements from the group stack and free any resources. Note: This feature also performs an unlock operation. </summary>
doc:		<param name="self" type="struct rt_processor*"> The processor that owns the group stack. Must not be NULL. </param>
doc:		<param name="count" type="size_t"> The number of elements to be removed. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_processor_request_group_stack_remove (struct rt_processor* self, size_t count)
{
	struct rt_request_group* l_last = NULL;
	size_t i;

	REQUIRE ("self_not_null", self);
	REQUIRE ("enough_elements", request_group_stack_t_count (&self->request_group_stack) >= count);

	for (i = 0; i < count; ++i) {
		l_last = rt_processor_request_group_stack_last (self);
		rt_request_group_unlock (l_last);
		rt_request_group_deinit (l_last);
		request_group_stack_t_remove_last (&self->request_group_stack);
	}
}

/*
doc:</file>
*/
