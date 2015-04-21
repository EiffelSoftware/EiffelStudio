/*
	description:	"A private message queue between a client and a supplier processor."
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
doc:<file name="private_queue.c" header="rt_private_queue.h" version="$Id$" summary="A private message queue between a client and a supplier processor.">
*/

#include "rt_private_queue.h"
#include "rt_processor.h"
#include "rt_scoop.h"

/*
doc:	<routine name="rt_private_queue_init" return_type="void" export="shared">
doc:		<summary> Initialize the private queue 'self' with supplier 'a_supplier'. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be initialized. Must not be NULL. </param>
doc:		<param name="a_supplier" type="struct rt_processor*"> The supplier processor. This is where all requests will be sent to. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_init (struct rt_private_queue* self, struct rt_processor* a_supplier)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", a_supplier);

	self->supplier = a_supplier;
	self->synced = EIF_FALSE;
	self->lock_depth = 0;

	rt_message_channel_init (&self->channel, 512);
	rt_message_init (&self->call_stack_msg, SCOOP_MESSAGE_INVALID, NULL, NULL, NULL);
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
		rt_message_channel_send (&(self->supplier->queue_of_queues), SCOOP_MESSAGE_ADD_QUEUE, client, NULL, self);
		self->synced = EIF_FALSE;
	}
	self->lock_depth++;
}

/*
doc:	<routine name="rt_private_queue_unlock" return_type="void" export="shared">
doc:		<summary> Unlock this private queue by instructing the supplier to remove this queue from the queue-of-queues. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue to be unlocked. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_unlock (struct rt_private_queue* self)
{
	REQUIRE ("self_not_null", self);

	self->lock_depth--;

	if (self->lock_depth == 0) {
		rt_message_channel_send (&self->channel, SCOOP_MESSAGE_UNLOCK, NULL, NULL, NULL);
		self->synced = EIF_FALSE;
	}
}

/*
doc:	<routine name="rt_private_queue_register_wait" return_type="void" export="shared">
doc:		<summary> Register a wait operation at the supplier.
doc:			The supplier will contact the client when it has executed some
doc:			other calls, and thus may have changed a wait condition. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="self" type="struct rt_processor*"> The client that wants to register for a wait condition change notification. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_register_wait (struct rt_private_queue* self, struct rt_processor* client)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("client_not_null", client);
	REQUIRE ("self_synchronized", self->synced);
	rt_processor_subscribe_wait_condition (self->supplier, client);
	self->synced = EIF_FALSE;
}

/*
doc:	<routine name="rt_private_queue_log_call" return_type="void" export="shared">
doc:		<summary> Log a new call to this queue.
doc:			This is essentially an send operation on the underlying message channel,
doc: 			which can wake up the supplier if it is waiting for more calls. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="client" type="struct rt_processor*"> The client that issues the call. </param>
doc:		<param name="call" type="struct call_data*"> The call to be executed by the supplier. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_log_call (struct rt_private_queue* self, struct rt_processor* client, struct call_data* call)
{
	EIF_SCP_PID l_sync_pid = call->sync_pid;
	EIF_BOOLEAN will_sync = l_sync_pid != NULL_PROCESSOR_ID;


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
		l_sync_pid = client-> pid;
		call -> sync_pid = client -> pid;
		will_sync = EIF_TRUE;

		rt_message_channel_send (&self->supplier->result_notify, SCOOP_MESSAGE_CALLBACK, client, call, NULL);

	} else {
		rt_message_channel_send (&self->channel, SCOOP_MESSAGE_EXECUTE, client, call, NULL);
	}
		/* NOTE: After the previous send operations, the call data struct might have been */
		/* free()'d by the supplier. Therefore it must not be accessed any more here. */
	call = NULL;
	
	if (will_sync) {
		
		/* NOTE: In a previous revision, the variable 'client' was retrieved again
		 * from the global rt_processor_registry. This seemed to be unnecessary however
		 * and was therefore removed. */

		struct rt_message* l_message = &self->call_stack_msg;

			/* Wait on our own result notifier for a message by the other processor. */
		rt_message_channel_receive (&client->result_notify, l_message);

		for (;
			l_message->message_type == SCOOP_MESSAGE_CALLBACK;
			rt_message_channel_receive (&client->result_notify, l_message))
		{
				/*NOTE: The thread executing this feature is the one behind 'client'. */
			rt_processor_execute_call (client, l_message->sender, l_message->call);
			l_message->call = NULL;
		}

		if (l_message->message_type == SCOOP_MESSAGE_DIRTY) {
			eraise ((const char *) "EVE/Qs dirty processor exception", 32);
		}
	}

	self->synced = will_sync;
}

/*
doc:	<routine name="rt_private_queue_mark" return_type="void" export="shared">
doc:		<summary> Mark the call_data structs within this private queue.
doc:			This is for integration with the EiffelStudio garbage collector
doc:			so that the target and arguments of the calls in the call data
doc:			(which is here outside the view of the runtime) will not be collected. </summary>
doc:		<param name="self" type="struct rt_private_queue*"> The private queue struct. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marking function to use on each reference from the Eiffel runtime. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_private_queue_mark (struct rt_private_queue* self, MARKER marking)
{
	struct call_data* call = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);

	rt_message_channel_mark (&self->channel, marking);

	call = self->call_stack_msg.call;
	if (call) {
		rt_mark_call_data (marking, call);
	}
}

/*
doc:</file>
*/
