/*
	description:	"Declarations for the rt_request_group struct."
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

#ifndef _rt_request_group_h_
#define _rt_request_group_h_

#include "eif_portable.h"
#include "rt_assert.h"

struct rt_processor;
struct rt_private_queue;

/*
doc:	<struct name="rt_request_group", export="shared">
doc:		<summary> Request groups model a set of locks to be taken and released atomically. They are used for separate arguments in a routine.
doc: 			The rt_request_group contains all the fields of an vector struct, and thus "inherits" from it. </summary>
doc:		<field name="area", type="struct rt_private_queue**"> A dynamically allocated array containing private queues (~ locks) within the request group. </field>
doc:		<field name="count", type="size_t"> The current number of private queues. </field>
doc:		<field name="capacity", type="size_t"> The currently reserved space in 'area', measured in number of elements. </field>
doc:		<field name="client", type="struct rt_processor*> The processor that wants to acquire the locks. </field>
doc:		<field name="is_sorted", type="EIF_BOOLEAN"> A boolean to indicate whether the private queues within this request group are sorted.
doc: 			It also indicates whether rt_request_group_lock() has been called in the past. </field>
doc:		<field name="is_locked", type="EIF_BOOLEAN"> A boolean to indicate whether the request group is locked.
doc:			NOTE: This attribute is a ghost field for contract checking. </field>
doc:		<fixme> A possible improvement might be to place the first few private queues into the request group struct itself, to avoid memory allocation on the heap. </fixme>
doc:	</struct>
 */
struct rt_request_group
{
		/* NOTE: All fields are private. Do not modify them directly. */
	struct rt_private_queue** area;
	size_t capacity;
	size_t count;
	struct rt_processor* client;
	EIF_BOOLEAN is_sorted;
	EIF_BOOLEAN is_locked;
};

/*
doc:	<routine name="rt_request_group_init" return_type="void" export="private">
doc:		<summary> Initialize the request group to a consistent state. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group to be initialized. Must not be NULL. </param>
doc:		<param name="a_client" type="struct rt_processor*"> The processor which will issue calls to the suppliers within this request group. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_request_group_init (struct rt_request_group* self, struct rt_processor* a_client)
{
	REQUIRE ("not_null", self);
	self->area = NULL;
	self->capacity = 0;
	self->count = 0;
	self->is_sorted = 0;
	self->is_locked = 0;
	self->client = a_client;
}

/*
doc:	<routine name="rt_request_group_deinit" return_type="void" export="private">
doc:		<summary> Deconstruct the request group and free any memory allocated within. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group to be de-initialized. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_request_group_deinit (struct rt_request_group* self)
{
	REQUIRE ("not_null", self);
	REQUIRE ("not_locked", !self->is_locked);
	free (self->area);
	rt_request_group_init (self, NULL);
}


/* Declarations */
rt_shared int rt_request_group_add (struct rt_request_group* self, struct rt_processor* supplier);
rt_shared int rt_request_group_wait (struct rt_request_group* self);
rt_shared void rt_request_group_lock (struct rt_request_group* self);
rt_shared void rt_request_group_unlock (struct rt_request_group* self, EIF_BOOLEAN is_wait_condition_failure);

#endif /* _rt_request_group_h_ */
