/*
	description:	"Routines to manipulate SCOOP request groups, which are used to model separate arguments for routines."
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
doc:<file name="request_group.c" header="rt_request_group.h" version="$Id$" summary="Routines to manipulate SCOOP request groups, which are used to model separate arguments for routines.">
*/

#include "rt_request_group.h"
#include "rt_processor.h"

#include "rt_vector.h"

/* We can reuse some of the functions in rt_vector.h */
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (rt_request_group, struct rt_private_queue*)
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (rt_request_group, struct rt_private_queue*)
RT_DECLARE_VECTOR_STACK_FUNCTIONS (rt_request_group, struct rt_private_queue*)

/* A simple bubblesort algorithm to sort an array of private queues. */
rt_private rt_inline void bubble_sort (struct rt_private_queue** area, size_t count)
{
	int right_boundary = ((int) count)-1;
	int swapped = 1, i;

	while (swapped == 1) {
		swapped = 0;
		for (i = 0; i < right_boundary; ++i) {
			if (area [i]->supplier->pid > area [i+1]->supplier->pid) {
				struct rt_private_queue* tmp = area [i];
				area [i] = area [i+1];
				area [i+1] = tmp;
				swapped = 1;
			}
		}
		--right_boundary;
	}
}

/*
doc:	<routine name="rt_request_group_add" return_type="void" export="shared">
doc:		<summary> Add a new supplier to the request group. This feature cannot be called any more after the first lock operation. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<param name="a_client" type="struct rt_processor*"> The supplier processor to be added to this request group. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_add (struct rt_request_group* self, struct rt_processor* supplier)
{
	struct rt_private_queue* pq = NULL;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("not_sorted", !self->is_sorted);
	REQUIRE ("not_locked", !self->is_locked);

	pq = rt_queue_cache_retrieve (&(self->client->cache), supplier);
	error = rt_request_group_extend (self, pq);

		/* If memory allocation failed, we need to throw an exception */
	if (error == T_NO_MORE_MEMORY) {
		enomem();
	}
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
doc:		<fixme> Instead of unlocking normally after the wait condition, we could have a special 'unlock-after-wait-condition-failure'.
doc:			That way we can avoid sending unnecessary notifications after the evaluation of a wait condition. </fixme>
doc:	</routine>
*/
rt_shared void rt_request_group_wait (struct rt_request_group* self)
{
	size_t i, l_count = rt_request_group_count (self);
	struct rt_processor* l_client = self->client;

	REQUIRE ("self_not_null", self);
	REQUIRE ("sorted", self->is_sorted);
	REQUIRE ("locked", self->is_locked);

		/* Register the current client with the suppliers, such that we
		 * can later get a notification if a wait condition may have changed. */
	for (i = 0; i < l_count; ++i) {
		struct rt_private_queue* l_queue = rt_request_group_item (self, i);

			/* We only register on queues which are currently synchronized.
			 * Those are the ones that have executed a query during the wait
			 * condition, and thus the only ones that matter.
			 * Moreover, because the suppliers are currently synchronized, we
			 * know that they cannot access their notification queue at the
			 * moment, so we can safely modify the list from this thread. */
		if (rt_private_queue_is_synchronized (l_queue)) {
			rt_private_queue_register_wait (l_queue, l_client);
		}
	}

		/* Before we unlock the synchronized queues, we have to acquire the
		 * lock to our condition variable mutex. This has to happen before
		 * rt_request_group_unlock to avoid missed signals. */
	eif_pthread_mutex_lock (l_client->wait_condition_mutex);

		/* Release the locks on the suppliers. After this statement they can
		 * execute calls from other processors and signal back a wait condition
		 * change. If we wouldn't hold the lock acquired in the previous step,
		 * we might miss those signals and thus remain stuck in a wait condition
		 * forever. */
	rt_request_group_unlock (self);

		/* Now we perform the blocking wait on our condition.
		 * This also releases the mutex, such that our suppliers may send signals to it.
		 * Note: Usually these wait operations are performed inside a loop that checks whether
		 * the wait condition became true. Our loop is compiler-generated however,
		 * that's why we don't see it here. */
	eif_pthread_cond_wait (l_client->wait_condition, l_client->wait_condition_mutex);

		/* After the wakeup signal, we can release the mutex.
		 * We're not interested in any further signals, as we re-register anyway if the
		 * wait condition fails again. */
	eif_pthread_mutex_unlock (l_client->wait_condition_mutex);

		 /* Note: We do not clean up the registrations here, because it would involve
		 * unnecessary locking and a risk of deadlocks. Instead, the suppliers delete
		 * our registration during notification, and the GC will clean up any leftover registrations. */
	ENSURE ("not_locked", !self->is_locked);
}

/*
doc:	<routine name="rt_request_group_lock" return_type="void" export="shared">
doc:		<summary> Lock all processors in the request group. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_lock (struct rt_request_group* self)
{
	size_t i, l_count = rt_request_group_count (self);

	REQUIRE ("self_not_null", self);
	REQUIRE ("not_locked", !self->is_locked);

		/* We first need to sort the array based on the ID of the processor.
		 * At a global scale, this avoids deadlocks and enables the
		 * "atomic locking" guarantee of multiple arguments. */
	if (!self->is_sorted) {

			/* The array is usually very small (1 to 5 items), so having
			 * lightweight bubblesort algorithm is probably most efficient. */
		bubble_sort (self->area, self->count);
		self->is_sorted = 1;
	}

		/* Temporarily lock the queue-of-queue of all suppliers. */
	for (i = 0; i < l_count; ++i) {
		struct rt_processor* l_supplier = rt_request_group_item (self, i)->supplier;
		eif_pthread_mutex_lock (l_supplier->queue_of_queues_mutex);
	}

		/* Add all private queues to the queue-of-queues */
	for (i = 0; i < l_count; ++i) {
		rt_private_queue_lock (rt_request_group_item (self, i), self->client);
	}

		/* Release the queue-of-queue locks. */
	for (i = 0; i < l_count; ++i) {
		struct rt_processor* l_supplier = rt_request_group_item (self, i)->supplier;
		eif_pthread_mutex_unlock (l_supplier->queue_of_queues_mutex);
	}

	self->is_locked = 1;

	ENSURE ("sorted", self->is_sorted);
	ENSURE ("locked", self->is_locked);
}

/*
doc:	<routine name="rt_request_group_unlock" return_type="void" export="shared">
doc:		<summary> Unlock all processors in the request group. This feature can only be called when the request group is locked.
doc:			This feature doesn't block long. It may block for a short amount of time for memory allocation or to send a signal. </summary>
doc:		<param name="self" type="struct rt_request_group*"> The request group struct. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_request_group_unlock (struct rt_request_group* self)
{
	size_t l_count = rt_request_group_count (self);
	int i = (int) l_count - 1;

	REQUIRE ("self_not_null", self);
	REQUIRE ("lock_called", self->is_sorted);
		/* Removed because unlock is sometimes called on unlocked objects due to a bug. */
	/* REQUIRE ("locked", self->is_locked);*/

	if (self->is_locked) {
			/* Unlock in the opposite order that they were locked */
		for (; i >= 0; --i) {
			rt_private_queue_unlock (rt_request_group_item (self, i));
		}
		self->is_locked = 0;
 	}

	ENSURE ("not_locked", !self->is_locked);
}

/*
doc:</file>
*/
