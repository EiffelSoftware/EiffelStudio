/*
	description:	"Declarations for the queue_cache struct."
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

#ifndef _rt_queue_cache_h_
#define _rt_queue_cache_h_

#include "rt_vector.h"
#include "rt_hashin.h"
/* #include "rt_garcol.h" */ /* Needed only for GC marking */

/* The initial size of the hash table. */
#define HASH_TABLE_SIZE 10

/* Forward declarations. */
struct queue_cache;
struct rt_processor;
struct rt_private_queue;

/* Declare an internal vector data structure. */
RT_DECLARE_VECTOR (rt_vector_queue_cache, struct queue_cache *)

/*
doc:	<struct name="queue_cache" export="shared">
doc:		<summary> A cache of private queues.
doc:
doc:			This cache of private queues creates new private queues on demand.
doc: 			It also handles moving private queues from one processor to another during lock-passing.
doc:
doc:			The scheme for tracking locks is to use a single hash table for all
doc: 			queues owned by the current processor.
doc:
doc: 			For lock passing, we use a stack of queue_caches that have been pushed
doc: 			to us. They are called "borrowed_queues". The borrowed_queues stack
doc: 			may be NULL in case no lock passing has happened, or if the locks have
doc: 			been passed further.
doc:
doc: 			On a lock passing push(), the "giver" processor takes whatever borrowed
doc: 			queues it already has, adds itself at the end of the stack, and gives
doc: 			the whole borrowed_queues stack to the receiver. The reverse operation
doc: 			happens on a lock passing pop().
doc:		</summary>
doc:		<field name="owner" type="struct rt_processor*"> The owner of this queue_cache. </field>
doc:		<field name="owned_queues" type="struct htable"> A hash table of private queues owned by this queue cache. Indexed by the processor ID of the supplier processor. </field>
doc:		<field name="borrowed_queues" type="struct rt_vector_queue_cache*"> The locks passed from other processors. May be NULL. </field>
doc:		<field name="storage" type="struct rt_vector_queue_cache"> A pre-made vector that can be used for borrowed_queues.
doc:			This field is only present to avoid memory allocation during lock passing. </field>
doc:		<fixme> The implementation can be rather inefficient when we have a recursion with separate callbacks. This is rare, but it can happen.
doc: 			In the future we may need to change the implementation e.g. by not extending the borrowed_queues stack if we detect that the queue_cache to be inserted
doc:			is already in the stack. This probably needs some more data structures though to ensure correct behaviour on pop(). </fixme>
doc:	</struct>
*/
struct queue_cache {
	struct rt_processor *owner;
	struct rt_vector_queue_cache *borrowed_queues;
	struct htable owned_queues;
	struct rt_vector_queue_cache storage;
};

/*
doc:	<routine name="rt_queue_cache_init" return_type="int" export="private">
doc:		<summary> Initialize the queue_cache struct 'self' with owner 'a_owner' and reserve some memory in the internal hash table. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to be initialized. Must not be NULL. </param>
doc:		<param name="a_owner" type="struct rt_processor*"> The owner of the queue_cache. Must not be NULL. </param>
doc:		<return> T_OK on success. T_NO_MORE_MEMORY in case of a memory allocation failure. </return>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline int rt_queue_cache_init (struct queue_cache* self, struct rt_processor* a_owner)
{
	int error = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("owner_not_null", a_owner);

	self->owner = a_owner;
	self->borrowed_queues = NULL;

		/* Initialize the storage vector. */
	rt_vector_queue_cache_init (&self->storage);

		/* Initialize and allocate the hash table used to track owned private queues. */
	error = ht_create (&self->owned_queues, HASH_TABLE_SIZE, sizeof (struct rt_private_queue*));

		/* The function ht_create returns 0 on success and -1 in case of an error.
		 * We have to convert this to our error representation. */
	if (error == -1) {
		error = T_NO_MORE_MEMORY;
	} else {
		CHECK ("zero_on_success", error == 0);
		error = T_OK;
	}

	return error;
}

/*
doc:	<routine name="rt_queue_cache_deinit" return_type="void" export="private">
doc:		<summary> Deconstruct the queue_cache 'self' and free any internal memory. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to be de-initialized. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_queue_cache_deinit (struct queue_cache* self)
{
	REQUIRE ("self_not_null", self);

		/* When a queue cache gets deleted, it should not have any passed locks,
		 * as the associated processor was idle and all its objects have been garbage collected. */
	REQUIRE ("no_borrowed_queues", !self->borrowed_queues);

		/* Delete the hash table used to hold the queues owned by this processor.
		 * The queues themselves will be deleted by the processor which is supplier of the queue. */
	ht_release (&self->owned_queues);

		/* Free any internal memory in the storage vector. */
	CHECK ("storage_not_used", rt_vector_queue_cache_count (&self->storage) == 0);
	rt_vector_queue_cache_deinit (&self->storage);
}


/* Declarations */
rt_shared int rt_queue_cache_retrieve (struct queue_cache* self, struct rt_processor* const supplier, struct rt_private_queue** result);
rt_shared EIF_BOOLEAN rt_queue_cache_is_locked (struct queue_cache* self, struct rt_processor* supplier);
rt_shared int rt_queue_cache_push (struct queue_cache* self, struct queue_cache* giver);
rt_shared void rt_queue_cache_pop (struct queue_cache* self);
rt_shared EIF_BOOLEAN rt_queue_cache_has_locks_of (struct queue_cache* self, struct rt_processor* const supplier);
/* rt_shared void rt_queue_cache_mark (struct queue_cache* self, MARKER marking); */
rt_shared void rt_queue_cache_clear (struct queue_cache* self, struct rt_processor *proc);

#endif /* _rt_queue_cache_h_ */
