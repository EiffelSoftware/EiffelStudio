/*
	description:	"Declarations for the rt_private_queue struct."
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

#ifndef _rt_private_queue_h_
#define _rt_private_queue_h_

#include "rt_message.h"
#include "rt_message_channel.h"

struct rt_processor;

/*
doc:	<struct name="rt_private_queue" export="shared">
doc:		<summary> The private queue struct.
doc:
doc:			This structure serves as a central part of communication between
doc:			a client and a supplier. It contains an rt_message_channel for the
doc:			client to send new SCOOP separate calls.
doc:
doc:			The struct also serves as a lock for the client on the supplier:
doc:			As long as a private queue is inside the queue-of-queues
doc:			of the supplier, the client has exclusive access.
doc:
doc:			Note that the client processor may change during lock passing, i.e.
doc:			it's not guaranteed to be always the client that created the queue.
doc:		</summary>
doc:		<field name="channel" type="struct rt_message_channel"> The message channel used for communication. </field>
doc:		<field name="supplier" type="struct rt_processor*"> The supplier to whom messages will be sent. This field is constant. Accessed only by the client. </field>
doc:		<field name="lock_depth" type="int"> The current lock depth (for recursive locking). Accessed only by the client. </field>
doc:		<field name="synced" type="EIF_BOOLEAN"> Whether the supplier is synchronized with the client. Accessed only by the client. </field>
doc:		<field name="saved_result" type="EIF_TYPED_VALUE*"> The typed Eiffel value where the result of a query gets stored. This is only needed in workbench mode to update a reference during GC. </field>
doc:	</struct>
*/
struct rt_private_queue {
		/* Shared part. */
	struct rt_message_channel channel;

		/* Producer (or client)  part */
	struct rt_processor *supplier;
	int lock_depth;
	EIF_BOOLEAN synced;
#ifdef WORKBENCH
	EIF_TYPED_VALUE* saved_result;
#endif
};

/* Declarations. */
rt_shared int rt_private_queue_init (struct rt_private_queue* self, struct rt_processor* a_supplier);
rt_shared void rt_private_queue_deinit (struct rt_private_queue* self);
rt_shared void rt_private_queue_mark (struct rt_private_queue* self, MARKER marking);

rt_shared EIF_BOOLEAN rt_private_queue_is_synchronized (struct rt_private_queue* self);
rt_shared EIF_BOOLEAN rt_private_queue_is_locked (struct rt_private_queue* self);

rt_shared void rt_private_queue_lock (struct rt_private_queue* self, struct rt_processor* client);
rt_shared void rt_private_queue_unlock (struct rt_private_queue* self, EIF_BOOLEAN is_wait_condition_failure);
rt_shared int rt_private_queue_register_wait (struct rt_private_queue* self, struct rt_processor* client);

rt_shared void rt_private_queue_log_call (struct rt_private_queue* self, struct rt_processor* client, struct eif_scoop_call_data* call);

#endif /* _rt_private_queue_h_ */
