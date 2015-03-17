/*
	description:	"Declarations for the queue_cache struct."
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


/* TODO: Rename the file to rt_queue_cache.h */
#ifndef _rt_queue_cache_h_
#define _rt_queue_cache_h_

#include "rt_vector.h"
#include "rt_hashin.h"
#include "rt_garcol.h"

/* The initial size of the hash table. */
#define HASH_TABLE_SIZE 10

/* Forward declarations. */
struct queue_cache;
class processor;
class priv_queue;

/* Declare an internal vector data structure. */
RT_DECLARE_VECTOR (rt_vector_queue_cache, queue_cache*)


/* Forward declaration */
rt_shared priv_queue* rt_queue_cache_retrieve (struct queue_cache* self, processor* const supplier);
rt_shared EIF_BOOLEAN rt_queue_cache_is_locked (struct queue_cache* self, processor* supplier);
rt_shared void rt_queue_cache_push (struct queue_cache* self, struct queue_cache* giver);
rt_shared void rt_queue_cache_pop (struct queue_cache* self);
rt_shared EIF_BOOLEAN rt_queue_cache_has_locks_of (struct queue_cache* self, processor* const supplier);
rt_shared void rt_queue_cache_mark (struct queue_cache* self, MARKER marking);
rt_shared void rt_queue_cache_clear (struct queue_cache* self, processor *proc);

/*
doc:	<struct name="queue_cache", export="shared">
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
doc:		<field name="owner", type="processor*"> The owner of this queue_cache. </field>
doc:		<field name="owned_queues", type="struct htable"> A hash table of private queues owned by this queue cache. Indexed by the processor ID of the supplier processor. </field>
doc:		<field name="borrowed_queues", type="struct rt_vector_queue_cache*"> The locks passed from other processors. May be NULL. </field>
doc:		<fixme> The implementation can be rather inefficient when we have a recursion with separate callbacks. This is rare, but it can happen.
doc: 			In the future we may need to change the implementation e.g. by not extending the borrowed_queues stack if we detect that the queue_cache to be inserted
doc:			is already in the stack. This probably needs some more data structures though to ensure correct behaviour on pop(). </fixme>
doc:	</struct>
*/
struct queue_cache {
	processor *owner;
	struct rt_vector_queue_cache *borrowed_queues;
	struct htable owned_queues;


public: /* C++ support */

	/* See rt_queue_cache_retrieve(). */
	priv_queue* operator[] (processor * const supplier)
	{
		return rt_queue_cache_retrieve (this, supplier);
	}

	/* See rt_queue_cache_is_locked (). */
	EIF_BOOLEAN
	has_locked (processor *proc)
	{
		return rt_queue_cache_is_locked (this, proc);
	}

	/* See rt_queue_cache_has_locks_of(). */
	EIF_BOOLEAN
	has_subordinate (processor *proc)
	{
		return rt_queue_cache_has_locks_of (this, proc);
	}

	/* See rt_queue_cache_push (). */
	void
	push (queue_cache* other)
	{
		rt_queue_cache_push (this, other);
	}


	/* See rt_queue_cache_pop (). */
	void pop ()
	{
		rt_queue_cache_pop (this);
	}

	/* See rt_queue_cache_mark (). */
	void mark (MARKER marking)
	{
		rt_queue_cache_mark (this, marking);
	}

	/* See rt_queue_cache_clear (). */
	void clear (processor *proc)
	{
		rt_queue_cache_clear (this, proc);
	}

};

/*
doc:	<routine name="rt_queue_cache_init" return_type="void" export="private">
doc:		<summary> Initialize the queue_cache struct 'self' with owner 'a_owner' and reserve some memory in the internal hash table. </summary>
doc:		<param name="self" type="struct queue_cache*"> The queue cache to be initialized. Must not be NULL. </param>
doc:		<param name="a_owner" type="struct processor*"> The owner of the queue_cache. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None. </synchronization>
doc:	</routine>
*/
rt_private rt_inline void rt_queue_cache_init (struct queue_cache* self, processor* a_owner)
{
	int error = 0;

	REQUIRE ("self_not_null", self);
	REQUIRE ("owner_not_null", a_owner);

	self -> owner = a_owner;
	self -> borrowed_queues = NULL;

	error = ht_create (&self->owned_queues, HASH_TABLE_SIZE, sizeof (priv_queue*));
	if (error != 0) {
		enomem();
	}
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

		/* TODO: Figure out who is going to deallocate the private queues within this queue cache. */
	ht_release (&self->owned_queues);
}

#endif /* _rt_queue_cache_h_ */
