/*
	description:	"Routines to manipulate SCOOP request groups, which are used to model separate arguments for routines."
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
doc:<file name="req_grp.cpp" header="req_grp.hpp" version="$Id$" summary="SCOOP support.">
*/

#include "rt_msc_ver_mismatch.h"
#include "req_grp.hpp"
#include "processor.hpp"

#include "rt_vector.h"

/* We can reuse some of the functions in rt_vector.h */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (rt_request_group, priv_queue*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (rt_request_group, priv_queue*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (rt_request_group, priv_queue*)


/* The sort function to be used within rt_request_group_lock */
rt_private int sort_func (const void* first, const void* second)
{
	const priv_queue* pq1 = *((const priv_queue**) first);
	const priv_queue* pq2 = *((const priv_queue**) second);
	int pid1 = pq1->supplier->pid;
	int pid2 = pq2->supplier->pid;
	return pid1 - pid2;
}

/*
doc:	<routine name="rt_request_group_add" return_type="void" export="shared">
doc:		<summary> Add a new supplier to the request group. This feature cannot be called any more after the first lock operation. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<param name="a_client" type="struct processor*"> The supplier processor to be added to this request group. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_add (struct rt_request_group* self, processor* supplier)
{
	priv_queue* pq = NULL;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("lock_not_called", !self->is_sorted);

	pq = self->client->cache[supplier];
	error = rt_request_group_extend (self, pq);

		/* TODO: If memory allocation failed, we need to throw an exception */
	CHECK ("no_allocation_failure", error == T_OK);
}

/*
doc:	<routine name="rt_request_group_wait" return_type="void" export="shared">
doc:		<summary>
doc:			Release all locks and wait for a change notification from any processor in the group.
doc:			This feature is usually called after a wait condition fails.
doc:			It can only be called when the request group is locked.
doc:			Note: The wait() operation is blocking! </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_wait (struct rt_request_group* self)
{
	size_t l_count = rt_request_group_count (self);
	processor* l_client = self->client;

	REQUIRE ("self_not_null", self);
	REQUIRE ("lock_called", self->is_sorted);

		/* Register the current client with the suppliers, such that we
		 * can later get a notification if a wait condition may have changed. */
	for (size_t i = 0; i < l_count; ++i) {
		rt_request_group_item (self, i)->register_wait (l_client);
	}

		/* Release the locks on the suppliers. This allows other processors
		 * to log calls on them, which in turn might make our wait condition
		 * become true. */
	rt_request_group_unlock (self);

		/* Wait for a notification from one of the suppliers. */
	l_client->my_token.wait ();
}

/*
doc:	<routine name="rt_request_group_lock" return_type="void" export="shared">
doc:		<summary> Lock all processors in the request group. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:		<fixme> We could use a simpler algorithm for sorting, because a request group is typically very small. </fixme>
doc:	</routine>
*/
rt_shared void rt_request_group_lock (struct rt_request_group* self)
{
	size_t l_count = rt_request_group_count (self);

	REQUIRE ("self_not_null", self);

		/* We first need to sort the array based on the ID of the processor.
		 * At a global scale, this avoids deadlocks and enables the
		 * "atomic locking" guarantee of multiple arguments. */
	if (!self->is_sorted) {

			/* FIXME: The array is usually very small (1 to 5 items).
			* It is probably more efficient to use a simple algorithm
			* like bubble-sort */
		qsort (self->area, self->count, sizeof(priv_queue*), sort_func);
		self->is_sorted = 1;
	}

		/* Temporarily lock the queue-of-queue of all suppliers. */
	for (size_t i = 0; i < l_count; ++i) {
		rt_request_group_item (self, i)->supplier->qoq_mutex.lock();
	}

		/* Add all private queues to the queue-of-queues */
	for (size_t i = 0; i < l_count; ++i) {
		rt_request_group_item (self, i)->lock (self->client);
	}

		/* Release the queue-of-queue locks. */
	for (size_t i = 0; i < l_count; ++i) {
		rt_request_group_item (self, i)->supplier->qoq_mutex.unlock ();
	}

	ENSURE ("sorted", self->is_sorted);
}

/*
doc:	<routine name="rt_request_group_unlock" return_type="void" export="shared">
doc:		<summary> Unlock all processors in the request group. This feature can only be called when the request group is locked. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_unlock (struct rt_request_group* self)
{
	int l_count = (int) rt_request_group_count (self);

	REQUIRE ("self_not_null", self);
	REQUIRE ("lock_called", self->is_sorted);

		/* Unlock in the opposite order that they were locked */
	for (int i = l_count-1; i >= 0; --i) {
		rt_request_group_item (self, i)->unlock ();
	}
}

/*
doc:</file>
*/
