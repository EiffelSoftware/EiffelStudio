/*
	description:	"A channel for rt_message structs between processors."
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
doc:<file name="message_channel.cpp" header="rt_message_channel.hpp" version="$Id$" summary="A channel for rt_message structs between processors.">
*/

#include "rt_message_channel.hpp"
#include "spsc.hpp"
#include "rt_message.h"

/*
doc:	<routine name="rt_message_channel_send" return_type="void" export="shared">
doc:		<summary> Send the message 'message_type' over channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to send the message. Must not be NULL. </param>
doc:		<param name="message_type" type="enum scoop_message_type"> The type of the message. </param>
doc:		<param name="sender" type="struct processor*"> The sender processor. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<param name="call" type="struct call_data*"> Information about a call to be executed. Must not be NULL for SCOOP_MESSAGE_EXECUTE and SCOOP_MESSAGE_CALLBACK. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, processor* sender, struct call_data* call)
{
	struct rt_message message;

	REQUIRE ("self_not_null", self);
	REQUIRE ("sender_not_null", a_sender || (a_message != SCOOP_MESSAGE_EXECUTE && a_message != SCOOP_MESSAGE_CALLBACK));
	REQUIRE ("call_not_null", a_call || (a_message != SCOOP_MESSAGE_EXECUTE && a_message != SCOOP_MESSAGE_CALLBACK));

	rt_message_init (&message, message_type, sender, call);
	self->impl.push (message);
}

/*
doc:	<routine name="rt_message_channel_receive" return_type="void" export="shared">
doc:		<summary> Receive a message on channel 'self' and store the result in 'message'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel on which to receive the message. Must not be NULL. </param>
doc:		<param name="message" type="struct rt_message*"> A pointer to a rt_message struct where the result shall be stored. Must not be NULL. </param>
doc:		<thread_safety> Safe for exactly one sender thread and one receiver thread. </thread_safety>
doc:		<synchronization> None required. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("message_not_null", message);

		/* TODO: In theory we could allow 'message' to be NULL.
		 * There's one use case in processor_registry that is not interested in the result. */
	self->impl.pop (*message, self->spin);
}

/*
doc:	<routine name="rt_message_channel_mark" return_type="void" export="shared">
doc:		<summary> Mark all call_data structs during garbage collection in message channel 'self'. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The rt_message_channel struct. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marker function. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC phase. </synchronization>
doc:	</routine>
*/
rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);
	self->impl.mark (marking);
}

/*
doc:</file>
*/
