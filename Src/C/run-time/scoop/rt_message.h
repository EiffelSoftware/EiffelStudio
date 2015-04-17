/*
	description:	"Definitions for message types sent between processors."
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

#ifndef _rt_message_h_
#define _rt_message_h_

#include "eif_portable.h"
#include "rt_assert.h"

/* Forward declarations */
struct rt_processor;
struct call_data;
struct rt_private_queue;

/* The message types that can be sent between processors. */
enum scoop_message_type {

		/* An invalid message, used for initialization only. */
	SCOOP_MESSAGE_INVALID,

		/* Execute a separate call. */
	SCOOP_MESSAGE_EXECUTE,

		/* Unlock operation. After this the receiver can start executing calls from another queue. */
	SCOOP_MESSAGE_UNLOCK,

		/* Inform the receiver that a synchronous call has ended. */
	SCOOP_MESSAGE_RESULT_READY,

		/* Execute a separate callback. Can only happen when the receiver is waiting for the result of a synchronous call. */
	SCOOP_MESSAGE_CALLBACK,

		/* Propagate an exception to the receiver. */
	SCOOP_MESSAGE_DIRTY,

		/* Add a private queue to the receiver's queue-of-queues to be executed. */
	SCOOP_MESSAGE_ADD_QUEUE,

		/* Shutdown the processor. This is used by the garbage collector to instruct a dead processor to terminate itself. */
	SCOOP_MESSAGE_SHUTDOWN
};

/*
doc:	<struct name="rt_message", export="shared">
doc:		<summary> Represents a message that can be sent between two SCOOP processors. </summary>
doc:		<field name="sender", type="struct rt_processor*"> The sender of the message. Note that for EXECUTE and CALLBACK messages the sender can be seen as the client sending a call to some supplier. This field may be NULL. </field>
doc:		<field name="call", type="struct call_data*"> The information needed to execute the call. The call field must not be NULL for EXECUTE and CALLBACK messages, but must be NULL for all other messages. </field>
doc:		<field name="message_type", type="enum scoop_message_type"> The type of the message. </field>
doc:	</struct>
 */
struct rt_message {
  struct rt_processor* sender;
  struct call_data* call;
  struct rt_private_queue* queue;
  enum scoop_message_type message_type;
};

/*
doc:	<routine name="rt_message_init" return_type="void" export="private">
doc:		<summary> Initialize the rt_message struct 'self' with the message in 'a_message'. </summary>
doc:		<param name="self" type="struct rt_message*"> The message to be initialized. Must not be NULL. </param>
doc:		<param name="a_message" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="a_sender" type="struct rt_processor*"> The sender of the message. Must not be NULL for EXECUTE and CALLBACK messages. </param>
doc:		<param name="a_call" type="struct call_data*"> The information needed to execute a call. Must not be NULL for EXECUTE and CALLBACK messages. </param>
doc:		<param name="a_queue" type="struct rt_private_queue*"> The queue to be executed by the receiver. Must not be NULL for ADD_QUEUE messages. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_message_init (struct rt_message* self, enum scoop_message_type a_message, struct rt_processor* a_sender, struct call_data* a_call, struct rt_private_queue* a_queue)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("sender_not_null", a_sender || (a_message != SCOOP_MESSAGE_EXECUTE && a_message != SCOOP_MESSAGE_CALLBACK));
	REQUIRE ("call_not_null", a_call || (a_message != SCOOP_MESSAGE_EXECUTE && a_message != SCOOP_MESSAGE_CALLBACK));
	REQUIRE ("queue_not_null", a_queue || (a_message != SCOOP_MESSAGE_ADD_QUEUE));

	self->sender = a_sender;
	self->call = a_call;
	self->queue = a_queue;
	self->message_type = a_message;
}

#endif /* _rt_message_h_ */
