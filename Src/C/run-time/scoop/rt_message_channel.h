/*
	description:	"Declarations for the message channel struct."
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

#ifndef _rt_message_channel_h_
#define _rt_message_channel_h_

#include "rt_message.h"
#include "eif_posix_threads.h"
#include "rt_scoop_helpers.h"

/* Cache line size on most modern processors in bytes. */
#define CACHE_LINE_SIZE 64

/* Forward declaration of the private struct mc_node. */
struct mc_node;

/*
doc:	<struct name="rt_message_channel" export="shared">
doc:		<summary> Represents a message channel between two SCOOP processors. NOTE: The implementation relies on the fact that there's only one sender and one receiver thread! </summary>
doc:		<field name="has_elements_condition_mutex" type="EIF_MUTEX_TYPE*"> A mutex which is needed for blocking receive. </field>
doc:		<field name="has_elements_condition" type="EIF_COND_TYPE*"> A condition variable which is used for blocking receive. </field>
doc:		<field name="spin" type="size_t"> The number of times a processor should try a non-blocking receive before waiting on the condition variable. </field>
doc:		<field name="tail" type="struct mc_node*"> The tail of the internal message queue. Points to the guard node. </field>
doc:		<field name="cache_line_pad" type="char[]"> Free space to ensure that no cache line ping-pong happens. </field>
doc:		<field name="head" type="struct mc_node*"> The head of the internal message queue. This is where new messages get inserted. </field>
doc:		<field name="first" type="struct mc_node*"> The last unused node. Points to a cache of free (reusable) nodes, or the guard node if none exist. </field>
doc:		<field name="tail_copy" type="struct mc_node*"> A helper pointer that points somewhere between first and tail. </field>
doc:	</struct>
*/
struct rt_message_channel {
		/* Shared part, accessed both by consumer and producer. */
	EIF_MUTEX_TYPE* has_elements_condition_mutex;
	EIF_COND_TYPE* has_elements_condition;

		/* TODO: Do we need to add another cache_line_pad?
		 *And what happens when this structure is embedded in another one? */

		/* Consumer part. Accessed mostly by the consumer, infrequently by the producer. */
	size_t spin;
	struct mc_node* tail;

		/* Boundary between consumer part and producer part,
		* to ensure that they're located on different cache lines. */
	char cache_line_pad [CACHE_LINE_SIZE];

		/* Producer part. Accessed only by the producer. */
	struct mc_node* head; /* head of the queue */
	struct mc_node* first; /* last unused node (tail of node cache) */
	struct mc_node* tail_copy; /* helper (points somewhere between first and tail) */
};

/*
The internal message queue is a linked list of mc_node elements.

--------    --------    --------    --------    --------
| node | -> | node | -> | node | -> | node | -> | node | -> /
--------    --------    --------    --------    --------
   |           |                       |           |
 first     tail_copy                  tail       head


The most important node is the one pointed at by tail.
It is a guard node and contains no element itself.
Every node left from the guard node is a garbage
node that may be reused later. The nodes at the right
of the guard node contain the actual elements.

The head node points to the end of the linked list, which contains
the most recently added node. If the list is empty the head pointer
points to the guard node. To enqueue a new element a producer thus
has to extend the list at the head node.

A dequeue operation is simply done by "moving" the head pointer
one element to the right. This "thrashes" the current guard node,
and the dequeue'd element is the new guard node.

The nodes behind the guard node form a cache of reusable node
objects. They are used by the producer thread to avoid constant
memory allocation and freeing. When the cache is empty, the
first, tail_copy and tail pointers all point to the guard node.

The tail_copy is a small optimization technique which points
somewhere between first and tail. It is used to avoid frequent
synchronization. with the consumer.

Note: The structure never releases any allocated memory unless
it is destroyed completely.
*/


/* Declarations */
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, struct rt_processor* sender_processor, struct eif_scoop_call_data* call, struct rt_private_queue* queue);
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message);
rt_shared void rt_message_channel_receive_with_gc (struct rt_message_channel* self, struct rt_message* message);
rt_shared EIF_BOOLEAN rt_message_channel_is_empty (struct rt_message_channel* self);

rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking);
rt_shared int rt_message_channel_init (struct rt_message_channel* self, size_t default_spin);
rt_shared void rt_message_channel_deinit (struct rt_message_channel* self);

#endif /* _rt_message_channel_h_ */
