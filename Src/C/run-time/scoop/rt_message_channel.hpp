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

#include "eif_error.h"
#include "eif_posix_threads.h"

#include "spsc.hpp"
#include "rt_message.h"

/* Cache line size on most modern processors in bytes. */
#define CACHE_LINE_SIZE 64

/* Forward declaration of the private struct mc_node. */
struct mc_node;

/*
doc:	<struct name="rt_message_channel", export="shared">
doc:		<summary> Represents a message channel between two SCOOP processor. </summary>
doc:		<field name="TODO", type="TODO"> TODO: convert spsc class. </field>
doc:		<field name="spin", type="size_t"> The number of times a processor should try a non-blocking receive before waiting on a condition variable. </field>
doc:	</struct>
 */
struct rt_message_channel {
	spsc<rt_message> impl;

		/* Shared part which is accessed by both. */
	EIF_MUTEX_TYPE* has_elements_condition_mutex;
	EIF_COND_TYPE* has_elements_condition;

		/* TODO: Add another cache_line_pad ? */

		/* Consumer part. Accessed mostly by the consumer, infrequently by the producer. */
	struct mc_node* tail;
	size_t spin;

		/* Boundary between consumer part and producer part,
		* to ensure that they're located on different cache lines. */
	char cache_line_pad [CACHE_LINE_SIZE];

		/* Producer part. Accessed only by the producer. */
	struct mc_node* head; /* head of the queue */
	struct mc_node* first; /* last unused node (tail of node cache) */
	struct mc_node* tail_copy; /* helper (points somewhere between first and tail) */
};

/* Declarations */
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, processor* sender, struct call_data* call);
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message);
rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking);
rt_shared void rt_message_channel_init (struct rt_message_channel* self, size_t default_spin);
rt_shared void rt_message_channel_deinit (struct rt_message_channel* self);

#endif /* _rt_message_channel_h_ */
