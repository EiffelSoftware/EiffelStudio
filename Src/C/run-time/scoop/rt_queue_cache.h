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
doc: 			For lock passing, we use a stack of queue_caches that are available to us.
doc:			It is called "lock_stack". The lock_stack contains "earlier" locks (i.e.
doc:			locks that have been pushed to us) at the beginning, and always has the
doc:			queue_cache of the current region at the end. The pointer may be NULL if
doc:			the current region has pushed away all its locks.
doc:
doc: 			On a lock passing push(), the receiver processor takes the lock_stack of
doc:			the "giver" processor and adds its own queue cache at the end. The reverse
doc:			operation happens on a pop() operation.
doc:
doc:			The 'lock_stack_status' variable is used to monitor the lock_stack. If positive,
doc:			the number counts how many times it has been push()ed to another processor
doc:			in a non-impersonated push. If its value is negative, the current region is
doc:			suspended and has given away its locks.
doc:
doc:			The 'push_operation_count' variable is used to count the number of times the
doc:			current processor has received locks during non-impersonated lock passing.
doc:			It is incremented during a push() operation and decremented during a pop().
doc:			When it's value reaches zero, a processor needs to re-establish the lock_stack
doc:			variable with its own 'storage' cache.
doc:		</summary>
doc:		<field name="owner" type="struct rt_processor*"> The owner of this queue_cache. </field>
doc:		<field name="owned_queues" type="struct htable"> A hash table of private queues owned by this queue cache. Indexed by the processor ID of the supplier processor. </field>
doc:		<field name="lock_stack" type="struct rt_vector_queue_cache*"> The locks of all queue_caches available to this cache. </field>
doc:		<field name="storage" type="struct rt_vector_queue_cache"> A pre-made vector that can be used for lock_stack. It is the 'native' stack which is used
doc:			when a processor doesn't hold someone else's locks. </field>
doc:		<fixme> The implementation can be rather inefficient when we have a recursion with separate callbacks. This is rare, but it can happen.
doc: 			In the future we may need to change the implementation e.g. by not extending the lock_stack if we detect that the queue_cache to be inserted
doc:			is already in the stack. This probably needs some more data structures though to ensure correct behaviour on pop(). </fixme>
doc:	</struct>
*/
struct queue_cache {
	struct rt_processor *owner;
	struct rt_vector_queue_cache *lock_stack;
	struct htable owned_queues;
	struct rt_vector_queue_cache storage;
	int lock_stack_status;
	int push_operation_count;
};

/* Declarations */
rt_shared int rt_queue_cache_init (struct queue_cache* self, struct rt_processor* a_owner);
rt_shared void rt_queue_cache_deinit (struct queue_cache* self);

rt_shared int rt_queue_cache_retrieve (struct queue_cache* self, struct rt_processor* const supplier, struct rt_private_queue** result);
rt_shared EIF_BOOLEAN rt_queue_cache_is_locked (struct queue_cache* self, struct rt_processor* supplier);
rt_shared int rt_queue_cache_push (struct queue_cache* self, struct queue_cache* giver);
rt_shared void rt_queue_cache_pop (struct queue_cache* self, struct queue_cache* origin);
rt_shared EIF_BOOLEAN rt_queue_cache_has_locks_of (struct queue_cache* self, struct rt_processor* const supplier);
rt_shared void rt_queue_cache_clear (struct queue_cache* self, struct rt_processor* a_dead_processor);

/* Declarations for lock passing on impersonation. */
rt_shared int rt_queue_cache_push_on_impersonation (struct queue_cache* self, struct queue_cache* giver);
rt_shared void rt_queue_cache_pop_on_impersonation (struct queue_cache* self, size_t count);
rt_shared size_t rt_queue_cache_lock_passing_count (struct queue_cache* self);

#endif /* _rt_queue_cache_h_ */
