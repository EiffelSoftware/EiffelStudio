/*
	description:	"A cache for private queues."
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
doc:<file name="queue_cache.c" header="rt_queue_cache.h" version="$Id$" summary="A cache for private queues.">
 */

#include "rt_queue_cache.h"
#include "rt_private_queue.h"
#include "rt_processor.h"

/* Function to convert the PID to a hash table key.
 * This is needed because the SCOOP pid 0 is not a valid key. */
rt_private rt_inline rt_uint_ptr pid_to_key (EIF_SCP_PID pid)
{
	REQUIRE ("not_null_processor", pid != EIF_NULL_PROCESSOR);
	return pid + 1;
}

/*
doc:	<routine name="rt_queue_cache_find_from_owned return_type="struct rt_private_queue*" export="private">
doc:		<summary> Find a private queue from the set of queues owned by 'self'. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor for which a private queue shall be found. Must not be NULL. </param>
doc:		<return> A private queue to the specified processor. The result may not be locked. If none can be found, the result is NULL. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private struct rt_private_queue* rt_queue_cache_find_from_owned (struct queue_cache* self, struct rt_processor* const supplier)
{
	struct rt_private_queue *l_result = NULL;
	struct htable* l_owned = NULL;
	struct rt_private_queue** l_position = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);

		/* Find the position in the owned_queues hash table. */
	l_owned = &self->owned_queues;
	l_position = (struct rt_private_queue**) ht_value (l_owned, pid_to_key (supplier->pid));

		/* If found, return the private queue pointer. */
	if (l_position) {
		l_result = *l_position;
	}

	return l_result;
}


/*
doc:	<routine name="rt_queue_cache_find_from_borrowed" return_type="struct rt_private_queue*" export="private">
doc:		<summary> Find a locked private queue in the stack of borrowed queue caches. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor for which a private queue shall be found. Must not be NULL. </param>
doc:		<return> A private queue to the specified processor. If none can be found, the result is NULL. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private struct rt_private_queue* rt_queue_cache_find_from_borrowed (struct queue_cache* self, struct rt_processor* const supplier)
{
	struct rt_private_queue* l_result = NULL;
	struct rt_vector_queue_cache* l_borrowed = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);

	l_borrowed = self->borrowed_queues;
	if (l_borrowed) {

			/*
			* As we push/pop from the end of the stack, we do a forward
			* search through the queue stack here.
			* This ensures that "older" locks have priority over "newer" locks
			* (i.e. if a lock has been pushed several times already it has priority
			* over a lock that has been pushed only once).
			*/

		size_t l_size = rt_vector_queue_cache_count (l_borrowed);
		size_t i;

		for (i = 0; i < l_size && !l_result; ++i) {

			struct queue_cache* l_item = rt_vector_queue_cache_item (l_borrowed, i);
			struct rt_private_queue* l_queue = rt_queue_cache_find_from_owned (l_item, supplier);

				/* Only return locked queues, ignore all others. */
			if (l_queue && rt_private_queue_is_locked (l_queue)) {
				l_result = l_queue;
			}
		}
	}

	ENSURE ("is_locked", !l_result || rt_private_queue_is_locked (l_result));
	return l_result;
}


/*
doc:	<routine name="rt_queue_cache_is_locked" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Check if 'self' has the lock (i.e. an open request queue) to 'supplier'. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor to which 'client' might have a lock to. Must not be NULL. </param>
doc:		<return> EIF_TRUE if 'self' currently holds a lock on 'supplier'. EIF_FALSE otherwise. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_queue_cache_is_locked (struct queue_cache* self, struct rt_processor* supplier)
{
	EIF_BOOLEAN l_result = EIF_FALSE;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);

		/* First check the list of borrowed queues. */
	if (rt_queue_cache_find_from_borrowed (self, supplier)) {
			/* Borrowed queues are always locked. */
		l_result = EIF_TRUE;

	} else {
			/* Next, try our own cache. */
		struct rt_private_queue* owned = rt_queue_cache_find_from_owned (self, supplier);

			/* Within our own cache a private queue might not necessarily be locked. */
		if (owned && rt_private_queue_is_locked (owned)) {
			l_result = EIF_TRUE;
		}
	}
	return l_result;
}

/*
doc:	<routine name="rt_queue_cache_push" return_type="int" export="shared">
doc:		<summary> Pass all locks from 'giver' to 'self'.
doc: 			The locks (private queues) from the other processor will be added to this cache.
doc: 			This should be called in pairs with rt_queue_cache_pop(). </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to receive the locks. Must not be NULL. </param>
doc:		<param name="giver" type="struct queue_cache*"> The queue cache to give away the locks. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY if a memory allocation failure happened. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_queue_cache_push (struct queue_cache* self, struct queue_cache* giver)
{
	struct rt_vector_queue_cache *l_borrowed = NULL;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("giver_not_null", giver);
	REQUIRE ("not_equal", self != giver);

		/* Try to get any borrowed locks from 'giver'. */
	l_borrowed = giver->borrowed_queues;

		/* If 'giver' does not yet have such locks, we have to initialize a new vector
		 * containing the queue_caches of processors that passed their locks.
		 * We can use our own 'storage' vector to avoid any memory allocation. */

		/* NOTE: This works as long as a processor cannot pass his locks multiple times to different
		 * processors, without getting them back first. Historically, this has not always been the
		 * case (i.e. when separate callbacks were executed asynchronously). */
	if (NULL == l_borrowed) {
		CHECK ("storage_not_used", rt_vector_queue_cache_count (&self->storage) == 0);
		l_borrowed = &self->storage;
	}

		/* Add 'giver' at the end of the vector. */
	error = rt_vector_queue_cache_extend (l_borrowed, giver);

	if (error == T_OK) {
			/* Update the state in both queue caches. */
		giver->borrowed_queues = NULL;
		self->borrowed_queues = l_borrowed;

		ENSURE ("locks_passed", !giver->borrowed_queues && self->borrowed_queues);
	}

	return error;
}

/*
doc:	<routine name="rt_queue_cache_pop" return_type="void" export="shared">
doc:		<summary> Return all locks that were received during the last rt_queue_cache_push() operation. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache that has the locks. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_pop (struct queue_cache* self)
{
	struct rt_vector_queue_cache *l_borrowed = NULL;
	struct queue_cache* origin = NULL;

	REQUIRE ("not_null", self);
	REQUIRE ("has_lock_stack", self->borrowed_queues);
	REQUIRE ("lock_stack_not_empty", rt_vector_queue_cache_count (self->borrowed_queues) > 0);

	l_borrowed = self->borrowed_queues;

		/* Remove the locks from the current processor. */
	self->borrowed_queues = NULL;

		/* Retrieve the queue cache that initially passed the locks.
		 * Since the push/pop operations have to be balanced,
		 * the owner is on top of the stack. */
	origin = rt_vector_queue_cache_last (l_borrowed);
	rt_vector_queue_cache_remove_last (l_borrowed);


	if (rt_vector_queue_cache_count (l_borrowed) > 0 ) {
			/* Return the locks to its original owner. */
		origin->borrowed_queues = l_borrowed;

	} else {
			/* If 'origin' was the last element in the vector,
			 * it means that the current queue_cache created
			 * the vector initially. In that case we don't have
			 * to return anything. */
		CHECK ("my_storage", l_borrowed == &self->storage);
	}

	ENSURE ("locks_returned", !self->borrowed_queues);
}


/*
doc:	<routine name="rt_queue_cache_has_locks_of" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Check if 'self' has all the locks of 'supplier'. This can only be true when 'supplier' has passed the locks to 'client' in a previous call.
dic:		The result of this query is important to determine if we need to perform a separate callback instead of a regular call. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor that might have passed its locks to 'self'. Must not be NULL. </param>
doc:		<return> EIF_TRUE if 'self' currently has the locks of 'supplier'. EIF_FALSE otherwise. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_queue_cache_has_locks_of (struct queue_cache* self, struct rt_processor* const supplier)
{
	struct rt_vector_queue_cache* l_borrowed = NULL;
	EIF_BOOLEAN l_result = EIF_FALSE;
	size_t l_size = 0, i;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);

		/* Get the borrowed queues in 'self'.
		 * Note that this value could be NULL. */
	l_borrowed = self->borrowed_queues;

		/* TODO: In the C++ implementation, the owner is subordinate to itself.
		 * This property is ensured by the next statement.
		 * It does not seem to be necessary however, but we have to check it. */
	l_result = (supplier == self->owner);

	if (l_borrowed && !l_result) {
			/* Search through all borrowed queue caches if one of their owner matches 'supplier' */
		l_size =  rt_vector_queue_cache_count(l_borrowed);

		for (i = 0; i < l_size && !l_result; ++i) {
			l_result = (rt_vector_queue_cache_item (l_borrowed, i)->owner == supplier);
		}
	}
	return l_result;
}


/*
doc:	<routine name="rt_queue_cache_retrieve" return_type="int" export="shared">
doc:		<summary> Retrieve a private queue for processor 'supplier' from this queue cache.
doc:			A new private queue will be constructed if none already exists.
doc:			This will also look to see if there are any private queues that were passed to this queue_cache during lock-passing.
doc:			These passed-queues will already be locked and have priority over non-passed, possibly unlocked queues. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor for which a private queue shall be retrieved. Must not be NULL. </param>
doc:		<param name="result" type="struct rt_private_queue**"> A pointer to the location where the result shall be stored. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY or a mutex creation error code when a resource could not be allocated. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_queue_cache_retrieve (struct queue_cache* self, struct rt_processor* const supplier, struct rt_private_queue** result)
{
	struct rt_private_queue* l_result = NULL;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("result_not_null", result);

		/* We first need to search any borrowed queues. */
	l_result = rt_queue_cache_find_from_borrowed (self, supplier);

		/* If no borrowed queue can be found, we try our own cache. */
	if (NULL == l_result) {
		l_result = rt_queue_cache_find_from_owned (self, supplier);
	}

		/* If we still don't have a queue, we need to create a new one. */
	if (NULL == l_result) {
		error = rt_processor_new_private_queue (supplier, &l_result);

			/* Add the new queue to 'owned_queues'. */
		if (T_OK == error) {
			int ht_error = ht_safe_force (&self->owned_queues, pid_to_key (supplier->pid), &l_result);

				/* Convert the error code from ht_safe_force to our own representation. */
			if (ht_error != 0) {
				error = T_NO_MORE_MEMORY;
					/* NOTE: We don't delete the generated private queue if
					 * hash table extension failed. It will be done at some
					 * later point when the supplier processor dies. */
			}
		}
	}

		/* Update the result parameter when everything went well. */
	if (T_OK == error) {
		CHECK ("l_result_not_null", l_result);
		*result = l_result;
	} else {
		*result = NULL;
	}

	ENSURE ("result_available", error != T_OK || *result);
	return error;
}

#if 0 /* Apparently the rt_queue_cache_mark feature was never used. GC traversal happens through rt_processor->generated_private_queues. */
/*
doc:	<routine name="rt_queue_cache_mark" return_type="void" export="shared">
doc:		<summary> Garbage Collection: Mark the calls that may be in the private queues handled by this cache. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The marking function to use on each reference from the Eiffel runtime. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_mark (struct queue_cache* self, MARKER marking)
{
	size_t l_count = 0;
	rt_uint_ptr* l_keys = NULL;
	struct rt_private_queue** l_area = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("marking_not_null", marking);

	l_count = self->owned_queues.h_size;
	l_keys = self->owned_queues.h_keys;
	l_area = (struct rt_private_queue**) self->owned_queues.h_values;

		/* It is not necessary to mark queues which are borrowed from other queue_aches.
		* The GC will traverse them later. */
	for (size_t i = 0; i < l_count; ++i) {
		if (l_keys [i] != 0) {
			rt_private_queue_mark (l_area [i], marking);
		}
	}
}
#endif

/*
doc:	<routine name="rt_queue_cache_clear" return_type="void" export="shared">
doc:		<summary> Garbage Collection: Remove the private queue of 'proc' from this cache, as it is not used any more. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The processor whose private queue shall be removed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_clear (struct queue_cache* self, struct rt_processor *proc)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("proc_not_null", proc);

		/* It is not necessary to delete queues which are borrowed from other queue_aches.
		* The algorithm in processor_registry will traverse them later. */
	ht_remove (&self->owned_queues, pid_to_key (proc->pid));
}

/*
doc:</file>
*/
