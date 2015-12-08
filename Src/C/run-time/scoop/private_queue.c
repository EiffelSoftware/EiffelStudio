/*
	description:	"A private message queue between a client and a supplier processor."
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
doc:<file name="private_queue.c" header="rt_private_queue.h" version="$Id$" summary="A private message queue between a client and a supplier processor.">
*/

#include "rt_private_queue.h"
#include "rt_processor.h"
#include "eif_scoop.h"

/* Macro used to remember the result in workbench mode. Has no effect in finalized mode. */
#ifdef WORKBENCH
#	define rt_macro_set_saved_result(self,x) (self)->saved_result = (x)
#else
#	define rt_macro_set_saved_result(self,x) (void) 0
#endif

/* Private declarations. */
rt_private void execute_separate_callback (struct rt_private_queue* self, struct rt_processor* client, struct rt_message* message);

/*
doc:	<routine name="rt_private_queue_init" return_type="int" export="shared">
doc:		<summary> Initialize the private queue 'self' with supplier 'a_supplier'. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be initialized. Must not be NULL. </param>
doc:		<param name="a_supplier" type="struct rt_processor*"> The supplier processor. This is where all requests will be sent to. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY or a mutex creation error code when a resource could not be allocated. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_private_queue_init (struct rt_private_queue* self, struct rt_processor* a_supplier)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", a_supplier);

	self->supplier = a_supplier;
	self->synced = EIF_FALSE;
	self->lock_depth = 0;
	rt_macro_set_saved_result (self, NULL);

	error = rt_message_channel_init (&self->channel, 512);

	return error;
}

/*
doc:	<routine name="rt_private_queue_deinit" return_type="void" export="shared">
doc:		<summary> Destroy the private queue 'self' and free all internal memory. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be de-initialized. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_deinit (struct rt_private_queue* self)
{
	REQUIRE ("self_not_null", self);
	rt_message_channel_deinit (&self->channel);
}

/*
doc:	<routine name="rt_private_queue_mark" return_type="void" export="shared">
doc:		<summary> Mark the eif_scoop_call_data structures within this private queue.
doc:			This is for integration with the EiffelStudio garbage collector
doc:			so that the target and arguments of the calls in the message channel
doc:			(which is here outside the view of the runtime) will not be collected. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marking function to use on each reference from the Eiffel runtime. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_mark (struct rt_private_queue* self, MARKER marking)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);

	rt_message_channel_mark (&self->channel, marking);

#ifdef WORKBENCH
		/* Mark saved_result, if it is a reference. */
	if (self->saved_result && ((self->saved_result->type) & SK_HEAD) == SK_REF) {
		EIF_REFERENCE* ref = &(self->saved_result->it_ref);
		*ref = marking (ref);
	}
#endif
}

/*
doc:	<routine name="rt_private_queue_is_synchronized" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Was the last call executed by 'supplier' a synchronous call?
doc:			The queue is considered synchronized if the <supplier> is currently processing
doc:			this queue but is not currently applying any call, and the queue itself is empty. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<return> EIF_TRUE, if the supplier is synchronized with 'self'. EIF_FALSE otherwise. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_private_queue_is_synchronized (struct rt_private_queue* self)
{
	REQUIRE ("self_not_null", self);
	return self->synced;
}

/*
doc:	<routine name="rt_private_queue_is_locked" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Is 'self' currently locked, i.e. is there an open request queue in the supplier's queue-of-queues? </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<return> EIF_TRUE, if 'self' is locked. EIF_FALSE otherwise. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_private_queue_is_locked (struct rt_private_queue* self)
{
	REQUIRE ("self_not_null", self);
	return self->lock_depth > 0;
}

/*
doc:	<routine name="rt_private_queue_lock" return_type="void" export="shared">
doc:		<summary> Lock this private queue by placing the queue into the supplier's queue-of-queues.
doc:			Locking can be recursive, both for the owner of this queue and any borrowers during lock passing. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be locked. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The client that performs the lock operation. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_lock (struct rt_private_queue* self, struct rt_processor* client)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);

	if (self->lock_depth == 0) {
		if (self->supplier->is_passive_region) {
				/* NOTE: We reuse the wait_condition mutex of a passive region as a lock. This mutex is never used anyway in a passive region. */
			RT_TRACE (eif_pthread_mutex_lock (self->supplier->wait_condition_mutex));
			self->synced = EIF_TRUE;
		} else {
			rt_message_channel_send (&(self->supplier->queue_of_queues), SCOOP_MESSAGE_ADD_QUEUE, client, NULL, self);
			self->synced = EIF_FALSE;
		}
	}
	self->lock_depth++;
}

/*
doc:	<routine name="rt_private_queue_unlock" return_type="void" export="shared">
doc:		<summary> Unlock this private queue by instructing the supplier to remove this queue from the queue-of-queues. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be unlocked. Must not be NULL. </param>
doc:		<param name="is_wait_condition_failure" type="EIF_BOOLEAN"> Whether the unlock operation is done after a wait condition failure. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_unlock (struct rt_private_queue* self, EIF_BOOLEAN is_wait_condition_failure)
{
	REQUIRE ("self_not_null", self);

	self->lock_depth--;

	if (self->lock_depth == 0) {
		if (self->supplier->is_passive_region) {
			if (!is_wait_condition_failure) {
				rt_processor_publish_wait_condition (self->supplier);
			}
			RT_TRACE (eif_pthread_mutex_unlock (self->supplier->wait_condition_mutex));
		} else {
			enum scoop_message_type l_type = is_wait_condition_failure ? SCOOP_MESSAGE_WAIT_CONDITION_UNLOCK : SCOOP_MESSAGE_UNLOCK;
			rt_message_channel_send (&self->channel, l_type, NULL, NULL, NULL);
		}
		self->synced = EIF_FALSE;
	}
}

/*
doc:	<routine name="rt_private_queue_register_wait" return_type="int" export="shared">
doc:		<summary> Register a wait operation at the supplier.
doc:			The supplier will contact the client when it has executed some
doc:			other calls, and thus may have changed a wait condition. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="self" type="struct rt_processor*"> The client that wants to register for a wait condition change notification. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY in case of a memory allocation failure. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_private_queue_register_wait (struct rt_private_queue* self, struct rt_processor* client)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("self_synchronized", self->synced);

	error = rt_processor_subscribe_wait_condition (self->supplier, client);
	self->synced = EIF_FALSE;
	return error;
}

/*
doc:	<routine name="rt_private_queue_log_call" return_type="void" export="shared">
doc:		<summary> Log a new call to this queue.
doc:			This is essentially an send operation on the underlying message channel,
doc: 			which can wake up the supplier if it is waiting for more calls. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The client that issues the call. </param>
doc:		<param name="call" type="struct eif_scoop_call_data*"> The call to be executed by the supplier. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_log_call (struct rt_private_queue* self, struct rt_processor* client, struct eif_scoop_call_data* call)
{
	EIF_BOOLEAN will_sync = call->is_synchronous;
	struct rt_message_channel* l_result_notify = client->result_notify_proxy;
#ifdef WORKBENCH
	EIF_TYPED_VALUE* l_result = call->result;
#endif


	if (rt_queue_cache_has_locks_of (&client->cache, self->supplier)) {
		/* 
		 * We need to log a call which is a separate callback, 
		 * meaning that the supplier has previously logged a 
		 * synchronous call on the client and is now waiting for a result.
		 * 
		 * The supplier might perform (nested) callbacks or dirty wakeups,
		 * and we have to be ready to receive them afterwards.
		 * 
		 * See also test#scoop044, test#scoop051 and review#6008977502502912.
		 */
		
		/* A separate callback should always be synchronous. */
		call->is_synchronous = EIF_TRUE;
		will_sync = EIF_TRUE;

			/* NOTE: What happens if the target region is impersonated by another processor?
			 * This cannot happen. Separate callbacks are _always_ impersonated, and the only case when
			 * this piece of code can be executed is during a separate callback to a region that is marked as
			 * non-impersonable. In that case, the 'result_notify_proxy' is the correct one. */
		rt_message_channel_send (self->supplier->result_notify_proxy, SCOOP_MESSAGE_CALLBACK, client, call, NULL);

	} else {
		rt_message_channel_send (&self->channel, SCOOP_MESSAGE_EXECUTE, client, call, NULL);
	}
		/* NOTE: After the previous send operations, the eif_scoop_call_data struct might have been */
		/* free()'d by the supplier. Therefore it must not be accessed any more here. */
	call = NULL;
	
	if (will_sync) {
		struct rt_message l_message;
		EIF_BOOLEAN is_stopped = EIF_FALSE;

			/* Wait for a result, if any. We use a loop here because we may need
			 * to answer separate callbacks. */
		while (!is_stopped) {

				/* In workbench mode, we have to keep track of the EIF_TYPED_VALUE for the result
				* and make sure the reference is updated during GC (see also test#bench016).
				* The critical section starts here, when the supplier may have finished the call but
				* before the client (i.e. the thread executing this feature) wakes up again. */
			rt_macro_set_saved_result (self, l_result);

				/* Wait on our own result notifier for a message by the other processor. */
			rt_message_channel_receive (l_result_notify, &l_message);

				/* Clear the saved_result, because the critical part is over and the
				 * current thread is awake again and synchronized with the GC.
				 * NOTE: This is also safe in case of a separate callback:
				 * The supplier won't set the value while we execute a callback
				 * (but the client may log further calls, and in that case
				 * saved_result should be NULL). */
			rt_macro_set_saved_result (self, NULL);

			switch (l_message.message_type)
			{
				case SCOOP_MESSAGE_CALLBACK:
						/* A separate callback arrived. We need to execute it right
						 * away and send back our result to the supplier. */
					execute_separate_callback (self, client, &l_message);
					break;
				case SCOOP_MESSAGE_DIRTY:
						/* The supplier suffered an exception that we need to propagate. */
					eraise ((const char *) "EVE/Qs dirty processor exception", EN_DIRTY);
					break;
				case SCOOP_MESSAGE_RESULT_READY:
					is_stopped = EIF_TRUE;
					break;
				default:
					CHECK ("valid_message", EIF_FALSE);
			}
		}
	}
	self->synced = will_sync;
}

/*
doc:	<routine name="execute_separate_callback" return_type="void" export="private">
doc:		<summary> Execute a separate callback. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The client processor that received the separate callback. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> The message containing the separate callback. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private void execute_separate_callback (struct rt_private_queue* self, struct rt_processor* client, struct rt_message* message)
{
	EIF_GET_CONTEXT
	EIF_SCP_PID current_region = eif_globals->scoop_region_id;
	EIF_SCP_PID target_region = RTS_PID (message->call->target);

	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("message_not_null", message);
	REQUIRE ("callback_message", message->message_type == SCOOP_MESSAGE_CALLBACK && message->call);

		/* Execute the separate callback on this thread (i.e. the one behind 'client').
		 * We may have to impersonate the target region here.*/
	if (current_region != target_region) {
		eif_scoop_impersonate (eif_globals, target_region);
	}

	rt_processor_execute_call (client, message->sender_processor, message->call);

		/* Switch back to the initial region. */
	if (current_region != target_region) {
		eif_scoop_impersonate (eif_globals, current_region);
	}
}

/*
doc:</file>
*/
