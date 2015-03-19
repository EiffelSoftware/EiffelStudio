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

/*
doc:	<struct name="rt_message_channel", export="shared">
doc:		<summary> Represents a message channel between two SCOOP processor. </summary>
doc:		<field name="TODO", type="TODO"> TODO: convert spsc class. </field>
doc:		<field name="spin", type="size_t"> The number of times a processor should try a non-blocking receive before waiting on a condition variable. </field>
doc:	</struct>
 */
struct rt_message_channel {
	spsc<rt_message> impl;
	EIF_MUTEX_TYPE* has_elements_condition_mutex;
	EIF_COND_TYPE* has_elements_condition;
	size_t spin;
};

/*
doc:	<routine name="rt_message_channel_init" return_type="void" export="private">
doc:		<summary> Initialize the rt_message_channel struct 'self' and allocate some initial memory. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel to be initialized. Must not be NULL. </param>
doc:		<param name="default_spin" type="size_t"> The number of times a thread should spin on receive before waiting on a condition variable. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_message_channel_init (struct rt_message_channel* self, size_t default_spin)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);

	error = eif_pthread_mutex_create (&self->has_elements_condition_mutex);
	if (error != T_OK) {
		esys();
	}

	error = eif_pthread_cond_create (&self->has_elements_condition);

	if (error != T_OK) {
		eif_pthread_mutex_destroy (self->has_elements_condition_mutex);
		esys ();
	}

	self->spin = default_spin;
}

/*
doc:	<routine name="rt_message_channel_deinit" return_type="void" export="private">
doc:		<summary> Deconstruct 'self' and free all internal memory. </summary>
doc:		<param name="self" type="struct rt_message_channel*"> The channel to be destroyed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_message_channel_deinit (struct rt_message_channel* self)
{
	REQUIRE ("self_not_null", self);

	eif_pthread_cond_destroy (self->has_elements_condition);
	self->has_elements_condition = NULL;

	eif_pthread_mutex_destroy (self->has_elements_condition_mutex);
	self->has_elements_condition_mutex = NULL;
}

/* Declarations */
rt_shared void rt_message_channel_send (struct rt_message_channel* self, enum scoop_message_type message_type, processor* sender, struct call_data* call);
rt_shared void rt_message_channel_receive (struct rt_message_channel* self, struct rt_message* message);
rt_shared void rt_message_channel_mark (struct rt_message_channel* self, MARKER marking);


#endif /* _rt_message_channel_h_ */
