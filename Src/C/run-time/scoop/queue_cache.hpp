/*
	description:	"SCOOP support."
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

#ifndef _QUEUE_CACHE_H_
#define _QUEUE_CACHE_H_
#include <stack>
#include <set>
#include <vector>
#include "private_queue.hpp"

#include "rt_vector.h"

class queue_cache;
RT_DECLARE_VECTOR (rt_vector_queue_cache, queue_cache*)

/**
 * 'std::unordered_map' is not available on all platforms.
 * It is replaced conditionally by something else.
 */
#if defined (__GNUC__) && (__cplusplus < 201103L)
#	include <tr1/unordered_map>
#	define RT_UNORDERED_MAP std::tr1::unordered_map
#elif EIF_OS != EIF_OS_SUNOS && !defined (__SUNPRO_CC)
#	include <unordered_map>
#	define RT_UNORDERED_MAP std::unordered_map
#else
#	include "unordered_map.hpp"
#	define RT_UNORDERED_MAP eiffel_run_time::unordered_map
#endif

/**
 * 'unordered_map::emplace' is not available on all platforms.
 * It is replaced conditionally by 'insert' that might be less efficient.
 * 'vector::emplace_back' is not available on all platforms.
 * It is replaced conditionally by 'push_back' that might be less efficient.
 */
#if (defined (__GNUC__) && (__cplusplus < 201103L)) || EIF_OS == EIF_OS_SUNOS || defined (__SUNPRO_CC)
#	define EMPLACE      insert
#	define EMPLACE_BACK push_back
#else
#	define EMPLACE      emplace
#	define EMPLACE_BACK emplace_back
#endif

/* Forward declaration */
struct queue_cache;

rt_shared priv_queue* rt_queue_cache_retrieve (struct queue_cache* self, processor* const supplier);
rt_shared EIF_BOOLEAN rt_queue_cache_is_locked (struct queue_cache* self, processor* supplier);
rt_shared void rt_queue_cache_push (struct queue_cache* self, struct queue_cache* giver);
rt_shared void rt_queue_cache_pop (struct queue_cache* self);
rt_shared EIF_BOOLEAN rt_queue_cache_has_locks_of (struct queue_cache* self, processor* const supplier);


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
doc:		<field name="owned_queues", type="TODO"> A hash table of private queues owned by this queue cache. Indexed by the pointer of the supplier processor of this queue. </field>
doc:		<field name="borrowed_queues", type="struct rt_vector_queue_cache*"> The locks passed from other processors. May be NULL. </field>
doc:		<fixme> The implementation can be rather inefficient when we have a recursion with separate callbacks. This is rare, but it can happen.
doc: 			In the future we may need to change the implementation e.g. by not extending the borrowed_queues stack if we detect that the queue_cache to be inserted
doc:			is already in the stack. This probably needs some more data structures though to ensure correct behaviour on pop(). </fixme>
doc:	</struct>
*/
struct queue_cache {
public:
	/* Construct a new queue_cache.
	 * @o the owner of this queue cache
	 */
	queue_cache(processor* o) :
		owned_queues()
	{
		owner = o;
		borrowed_queues = NULL;
	}

	processor *owner;
	RT_UNORDERED_MAP <processor*, priv_queue*> owned_queues;
	struct rt_vector_queue_cache *borrowed_queues;

public:

	/* See rt_queue_cache_retrieve(). */
	priv_queue* operator[] (processor * const supplier)
	{
		return rt_queue_cache_retrieve (this, supplier);
	}

	/* See rt_queue_cache_is_locked (). */
	bool
	has_locked (processor *proc)
	{
		return rt_queue_cache_is_locked (this, proc);
	}

	/* See rt_queue_cache_has_locks_of(). */
	bool
	has_subordinate (processor *proc)
	{
		return rt_queue_cache_has_locks_of (this, proc);
	}

public:
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

public:
	/* GC marking.
	 * @mark the marking function to use on each reference from the Eiffel
	 * runtime.
	 *
	 * Marks the calls that may be in the queues and thus otherwise invisible,
	 * to the Eiffel runtime.
	 */
	void mark (MARKER marking)
	{
		RT_UNORDERED_MAP <processor*, priv_queue*>::const_iterator pair;

			/* It is not necessary to mark queues which are borrowed from other queue_aches.
			* The GC will traverse them later. */
		for (pair = owned_queues.begin (); pair != owned_queues.end (); ++pair) {
			(pair->second) -> mark (marking);
		}
	}

public:
	void clear (processor *proc)
	{
			/* It is not necessary to delete queues which are borrowed from other queue_aches.
			* The algorithm in processor_registry will traverse them later. */
		owned_queues.erase(proc);
	}

};

#endif
