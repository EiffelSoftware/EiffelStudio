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

#if defined EIF_ASSERTIONS
/* A set of basic invariants which must always be true, no matter if locks are pushed away. */
rt_private EIF_BOOLEAN basic_invariant (struct queue_cache* self)
{
	EIF_BOOLEAN result = EIF_TRUE;

		/* Owner should never be NULL. */
	result = result && self->owner;

		/* A negative lock_stack_status means that the lock stack has been pushed away. */
	result = result && ((self->lock_stack_status < 0) == (!self->lock_stack));

		/* self should always be at the first position of the storage array. */
	result = result && (rt_vector_queue_cache_item (&self->storage, 0) == self);

		/* There should be no negative push_operation_count */
	result = result && (self->push_operation_count >= 0);

	return result;
}

/* The invariant of a queue cache. Note that the invariant may be broken when a processor gives away its queues.
 * In that case it is suspended however and shouldn't call rt_queue_cache_retrieve() and some other methods.*/
rt_private EIF_BOOLEAN invariant (struct queue_cache* self)
{
	EIF_BOOLEAN result = EIF_TRUE;
	struct rt_vector_queue_cache* l_queues = self->lock_stack;

		/* The basic invariant should hold. */
	result = result && basic_invariant (self);

		/* Borrowed queues should never be NULL. */
	result = result && l_queues;

		/* A negative lock_stack_status means the locks have been pushed away. */
	result = result && (self->lock_stack_status >= 0);

		/* The vector should always be bigger than lock_passing_count, because
		 * 'self' is always present and during impersonated lock passing only the vector grows. */
	result = result && (self->lock_stack_status < (int) rt_vector_queue_cache_count (l_queues));

		/* (lock_passing_queue == 0) implies that the queue stack contains 'self' at the first position. */
	result = result && ((self->lock_stack_status > 0) || (l_queues == &self->storage ));

		/* The queue cache of the current region should always be last. */
	/*result = result && (rt_vector_queue_cache_last (l_queues)->owner->pid == TODO;*/

	return result;
}
#endif /* EIF_ASSERTIONS */


/* Function to convert the PID to a hash table key.
 * This is needed because the SCOOP pid 0 is not a valid key. */
rt_private rt_inline rt_uint_ptr pid_to_key (EIF_SCP_PID pid)
{
	REQUIRE ("not_null_processor", pid != EIF_NULL_PROCESSOR);
	return pid + 1;
}


/*
doc:	<routine name="rt_queue_cache_init" return_type="int" export="shared">
doc:		<summary> Initialize the queue_cache struct 'self' with owner 'a_owner' and reserve some memory in the internal hash table. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to be initialized. Must not be NULL. </param>
doc:		<param name="a_owner" type="struct rt_processor*"> The owner of the queue_cache. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY in case of a memory allocation failure. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_queue_cache_init (struct queue_cache* self, struct rt_processor* a_owner)
{
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("owner_not_null", a_owner);

	self->owner = a_owner;
	self->lock_stack_status = 0;
	self->push_operation_count = 0;
	self->lock_stack = &self->storage;

		/* Initialize the storage vector. */
	rt_vector_queue_cache_init (&self->storage);

		/* The current queue cache is always present in the lock stack. */
	error = rt_vector_queue_cache_extend (&self->storage, self);

	if (error == T_OK) {
			/* Initialize and allocate the hash table used to track owned private queues. */
		error = ht_create (&self->owned_queues, HASH_TABLE_SIZE, sizeof (struct rt_private_queue*));
			/* Convert the error code to our own representation. */
		error = (error == 0) ? T_OK : T_NO_MORE_MEMORY;
	}

		/* Release storage memory if hash table creation failed. */
	if (error != T_OK) {
		rt_vector_queue_cache_deinit (&self->storage);
	}

	ENSURE ("invariant_established", error != T_OK || invariant (self));
	return error;
}

/*
doc:	<routine name="rt_queue_cache_deinit" return_type="void" export="shared">
doc:		<summary> Deconstruct the queue_cache 'self' and free any internal memory. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to be de-initialized. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_deinit (struct queue_cache* self)
{
		/* When a queue cache gets deleted, it should not have any passed locks,
		 * as the associated processor was idle and all its objects have been garbage collected. */
	REQUIRE ("self_not_null", self);
	REQUIRE ("no_foreign_lock_stack", self->lock_stack == &self->storage);
	REQUIRE ("no_foreign_locks", rt_vector_queue_cache_count (&self->storage) == 1);
	REQUIRE ("invariant_established", invariant (self));

		/* Delete the hash table used to hold the queues owned by this processor.
		 * The queues themselves will be deleted by the processor which is supplier of the queue. */
	ht_release (&self->owned_queues);

		/* Free any internal memory in the storage vector. */
	rt_vector_queue_cache_deinit (&self->storage);
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
	REQUIRE ("basic_invariant", basic_invariant (self));

		/* Find the position in the owned_queues hash table. */
	l_owned = &self->owned_queues;
	l_position = (struct rt_private_queue**) ht_value (l_owned, pid_to_key (supplier->pid));

		/* If found, return the private queue pointer. */
	if (l_position) {
		l_result = *l_position;
	}

	ENSURE ("basic_invariant", basic_invariant (self));
	ENSURE ("correct", !l_result || l_result->supplier == supplier);
	return l_result;
}


/*
doc:	<routine name="rt_queue_cache_find_locked_queue" return_type="struct rt_private_queue*" export="private">
doc:		<summary> Find a locked private queue in the stack of queue caches. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="supplier" type="struct rt_processor*"> The processor for which a private queue shall be found. Must not be NULL. </param>
doc:		<return> A locked private queue to the specified processor. If none can be found, the result is NULL. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private struct rt_private_queue* rt_queue_cache_find_locked_queue (struct queue_cache* self, struct rt_processor* const supplier)
{
	struct rt_private_queue* l_result = NULL;
	struct rt_vector_queue_cache* l_lock_stack = NULL;
	size_t l_size = 0;
	size_t i = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("invariant_on_self", invariant (self));

	l_lock_stack = self->lock_stack;
	CHECK ("not_null", l_lock_stack);

		/*
		* As we push/pop from the end of the stack, we do a forward
		* search through the queue stack here.
		* This ensures that "older" locks have priority over "newer" locks
		* (i.e. if a lock has been pushed several times already it has priority
		* over a lock that has been pushed only once).
		*/

	l_size = rt_vector_queue_cache_count (l_lock_stack);

	for (i = 0; i < l_size && !l_result; ++i) {

		struct queue_cache* l_item = rt_vector_queue_cache_item (l_lock_stack, i);
		struct rt_private_queue* l_queue = rt_queue_cache_find_from_owned (l_item, supplier);

			/* Only return locked queues, ignore all others. */
		if (l_queue && rt_private_queue_is_locked (l_queue)) {
			l_result = l_queue;
		}
	}

	ENSURE ("invariant_on_self", invariant (self));
	ENSURE ("correct", !l_result || (l_result->supplier == supplier));
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
	REQUIRE ("invariant_on_self", invariant (self));

		/* Find a locked queue in the lock_stack. */
	if (rt_queue_cache_find_locked_queue (self, supplier)) {
		l_result = EIF_TRUE;
	}

	ENSURE ("correct", !l_result || rt_private_queue_is_locked (rt_queue_cache_find_locked_queue (self, supplier)));
	ENSURE ("invariant_on_self", invariant (self));
	return l_result;
}

/*
doc:	<routine name="rt_queue_cache_push" return_type="int" export="shared">
doc:		<summary> Pass all locks from 'giver' to 'self'.
doc: 			The lock stack (with all private queues) from the other processor will be adopted by this cache.
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
	struct rt_vector_queue_cache *l_lock_stack = NULL;
	int error = T_OK;

	REQUIRE ("self_not_null", self);
	REQUIRE ("giver_not_null", giver);
	REQUIRE ("not_equal", self != giver);
	REQUIRE ("invariant_on_giver", invariant (giver));
	REQUIRE ("basic_inv_on_self", basic_invariant (self));

		/* Get the locks currently held by 'giver'. */
	l_lock_stack = giver->lock_stack;

		/* Add ourselves at the end of the vector. */
	error = rt_vector_queue_cache_extend (l_lock_stack, self);

	if (error == T_OK) {

			/* Update 'self' to take the locks from 'giver'. */
		self->lock_stack = l_lock_stack;
		self->push_operation_count += 1;
		self->lock_stack_status = giver->lock_stack_status + 1;

			/* Invalidate 'giver'. */
		giver->lock_stack = NULL;
		giver->lock_stack_status = -1;

		ENSURE ("locks_passed", !giver->lock_stack && self->lock_stack);
		ENSURE ("basic_inv_on_giver", basic_invariant (giver));
		ENSURE ("invariant_on_self", invariant (self));
	}
	return error;
}

/*
doc:	<routine name="rt_queue_cache_pop" return_type="void" export="shared">
doc:		<summary> Return all locks that were received during the last rt_queue_cache_push() operation. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache that has the locks. Must not be NULL. </param>
doc:		<param name="origin" type="struct queue_cache*"> The queue cache that originally passed the locks. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_pop (struct queue_cache* self, struct queue_cache* origin)
{
	struct rt_vector_queue_cache *l_lock_stack = NULL;

	REQUIRE ("self_not_null", self);
	REQUIRE ("origin_not_null", origin);
	REQUIRE ("not_equal", self != origin);
	REQUIRE ("invariant_on_self", invariant (self));
	REQUIRE ("basic_inv_on_origin", basic_invariant (origin));
	REQUIRE ("lock_stack_not_empty", rt_vector_queue_cache_count (self->lock_stack) > 1);

	l_lock_stack = self->lock_stack;

		/* Retrieve the queue cache that initially passed the locks.
		 * Since the push/pop operations have to be balanced,
		 * 'self' should be on top of the stack.
		 * The 'origin' cache may not be the second-last however, because
		 * there could be a number of impersonated push operations in between. */
	CHECK ("self_is_last", rt_vector_queue_cache_last (l_lock_stack) == self);

	rt_vector_queue_cache_remove_last (l_lock_stack);

		/* lock_stack_status == 1 implies that 'origin' was the first to push away the locks (in a non-impersonated push). */
	CHECK ("balanced", self->lock_stack_status != 1 || l_lock_stack == &origin->storage);

		/* Re-establish the invariant in 'origin'. */
	origin->lock_stack = l_lock_stack;
	origin->lock_stack_status = self->lock_stack_status - 1;

		/* Remove the locks from this queue cache. */
	self->push_operation_count -= 1;
	if (self->push_operation_count == 0) {
		self->lock_stack = &self->storage;
		self->lock_stack_status = 0;
	} else {
		self->lock_stack = NULL;
		self->lock_stack_status = -1;
	}

	ENSURE ("invariant_on_origin", invariant (origin));
	ENSURE ("basic_inv_on_self", basic_invariant (self));
	ENSURE ("locks_returned", self->lock_stack == &self->storage || !self->lock_stack);
}

/*
doc:	<routine name="rt_queue_cache_push_on_impersonation" return_type="int" export="shared">
doc:		<summary> Pass all locks from 'giver' to 'self'.
doc: 			The lock stack (with all private queues) from the other processor will be adopted by this cache.
doc:			The difference between a regular push/pop is that this feature is executed by the client during impersonation,
doc:			and thus the implementation is a bit simpler.
doc: 			This should be called in pairs with rt_queue_cache_pop_on_impersonation(). </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to receive the locks. Must not be NULL. </param>
doc:		<param name="giver" type="struct queue_cache*"> The queue cache to give away the locks. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY if a memory allocation failure happened. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared int rt_queue_cache_push_on_impersonation (struct queue_cache* self, struct queue_cache* giver)
{
	int error = T_OK;
	REQUIRE ("self_not_null", self);
	REQUIRE ("giver_not_null", giver);

	error = rt_vector_queue_cache_extend (self->lock_stack, giver);
	return error;
}

/*
doc:	<routine name="rt_queue_cache_pop_on_impersonation" return_type="void" export="shared">
doc:		<summary> Return all locks that were received during the last rt_queue_cache_push_on_impersonation() operation. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache that has the locks. Must not be NULL. </param>
doc:		<param name="count" type="size_t"> The number of times the pop() operation should be executed. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_pop_on_impersonation (struct queue_cache* self, size_t count)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("valid_count", count < rt_vector_queue_cache_count (self->lock_stack));
	while (count > 0) {
		rt_vector_queue_cache_remove_last (self->lock_stack);
		--count;
	}
}

/*
doc:	<routine name="rt_queue_cache_lock_passing_count" return_type="size_t" export="shared">
doc:		<summary> The current size of the lock stack in the queue_cache objct. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache object. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared size_t rt_queue_cache_lock_passing_count (struct queue_cache* self)
{
	REQUIRE ("self_not_null", self);
	return rt_vector_queue_cache_count (self->lock_stack);
}


/*
doc:	<routine name="rt_queue_cache_has_locks_of" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Check if 'self' has the locks of 'supplier'. This can only be true when 'supplier' has passed the locks to 'client' in a previous call.
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
	struct rt_vector_queue_cache* l_lock_stack = NULL;
	EIF_BOOLEAN l_result = EIF_FALSE;
	size_t l_size = 0;
	size_t i = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("supplier_not_null", supplier);
	REQUIRE ("invariant_on_self", invariant (self));
	REQUIRE ("different_regions", supplier != rt_vector_queue_cache_last (self->lock_stack)->owner);

		/* Get the lock stack in 'self'. */
	l_lock_stack = self->lock_stack;
	l_size =  rt_vector_queue_cache_count (l_lock_stack);

	CHECK ("l_lock_stack_not_null", l_lock_stack);


	while (i < l_size && !l_result) {
		l_result = rt_vector_queue_cache_item (l_lock_stack, i)->owner == supplier;
		i = i + 1;
	}

	ENSURE ("invariant_on_self", invariant (self));
	return l_result;
}


/*
doc:	<routine name="rt_queue_cache_retrieve" return_type="int" export="shared">
doc:		<summary> Retrieve a private queue for processor 'supplier' from this queue cache.
doc:			A new private queue will be constructed if none already exists.
doc:			This will also look to see if there are any private queues that were passed to 'self' during lock-passing.
doc:			A passed queue is always locked and has priority over an owned, possibly unlocked queues. </summary>
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
	REQUIRE ("invariant_on_self", invariant (self));

		/* We first need to search the lock stack. */
	l_result = rt_queue_cache_find_locked_queue (self, supplier);

		/* If no locked queue can be found, we try our own cache for unlocked queues. */
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
			error = (ht_error == 0) ? T_OK : T_NO_MORE_MEMORY;
		}
	}

		/* Update the result parameter when everything went well. */
	if (T_OK == error) {
		CHECK ("l_result_not_null", l_result);
		*result = l_result;
	} else {
		*result = NULL;
			/* NOTE: We don't delete a (potentially) generated private
			 * queue in case of an error. This will be done at some
			 * later point when the supplier processor dies. */
	}

	ENSURE ("result_available", error != T_OK || *result);
	ENSURE ("invariant_on_self", invariant (self));
	return error;
}

/*
doc:	<routine name="rt_queue_cache_clear" return_type="void" export="shared">
doc:		<summary> Garbage Collection: Remove the private queue of 'a_dead_processor' from this cache, as it is not used any more. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache. Must not be NULL. </param>
doc:		<param name="marking" type="MARKER"> The processor whose private queue shall be removed. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_shared void rt_queue_cache_clear (struct queue_cache* self, struct rt_processor *a_dead_processor)
{
	REQUIRE ("self_not_null", self);
	REQUIRE ("proc_not_null", a_dead_processor);
	REQUIRE ("basic_invariant", basic_invariant (self));

		/* NOTE: We only need to delete the queue in 'owned_queues', but not those in 'lock_stack'.
		* The algorithm used by the GC will traverse them later. */
	ht_remove (&self->owned_queues, pid_to_key (a_dead_processor->pid));

	ENSURE ("basic_invariant", basic_invariant (self));
}

/*
doc:</file>
*/
