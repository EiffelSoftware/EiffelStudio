/*
	description:	"SCOOP processor garbage collector."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2011-2012, Eiffel Software."
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
doc:<file name="scoop_gc.c" header="rt_scoop_gc.h" version="$Id$" summary="SCOOP processor garbage collector.">
*/

/* TODO: This code can be simplified:
 *
 * The thread_index array should be transformed to a set of
 * yet-to-be-marked threads with a single public feature next().
 *
 * rt_mark_live_pid should then check whether a processor
 * is already marked, and if not, add it to thread_index.
 *
 * rt_update_live_index currently adds all live threads found
 * since the last call to it to the end of thread_index array.
 * By doing an eager update to thread_index, it can the be removed completely.
 *
 * rt_complement_live_index and rt_set_all_threads_live are kind of complements
 * to each other. Both fill the thread_array with not-yet-marked threads for
 * the last phase of GC (the difference is that during a full cycle those threads
 * are already known to be dead).
 */

#include <stddef.h>
#include <memory.h>
#include "rt_types.h"
#include "rt_assert.h"
#include "rt_scoop_gc.h"
#include "rt_threads.h"

#include "rt_processor_registry.h"
#include "rt_processor.h"

#define PID_MAP_ITEM_TYPE uint32                       /* Type of items in `live_pid_map'. (It must be unsigned.) */
#define PID_MAP_ITEM_SIZE (sizeof (PID_MAP_ITEM_TYPE)) /* Size of one element in `live_pid_map' in bytes. */
#define PID_MAP_ITEM_BITS (PID_MAP_ITEM_SIZE*8)        /* Size of one element in `live_pid_map' in bits. */
#define PID_MAP_ITEM(x)   live_pid_map [x / PID_MAP_ITEM_BITS] /* Item of `live_pid_map' corresponding to PID `x'. */
#define PID_MAP_BIT(x)    (((PID_MAP_ITEM_TYPE)1) << ((x) & ~(PID_MAP_ITEM_TYPE)0)) /* Bit in item corresponding to PID `x'. */

#define PID_MAP_COUNT     ((RT_MAX_SCOOP_PROCESSOR_COUNT + PID_MAP_ITEM_BITS - 1) / PID_MAP_ITEM_BITS)

#define RT_MARK_PID(pid) \
	{ \
		EIF_SCP_PID x = pid; \
		PID_MAP_ITEM (x) |= PID_MAP_BIT (x); \
	}

#define RT_UNMARK_PID(pid) \
	{ \
		EIF_SCP_PID x = (EIF_SCP_PID)(pid); \
		PID_MAP_ITEM (x) &= ~ PID_MAP_BIT (x); \
	}

#define RT_IS_LIVE_PID(pid) (PID_MAP_ITEM (pid) & PID_MAP_BIT (pid))

/*
doc:	<attribute name="live_pid_map" return_type="PID_MAP_ITEM_TYPE" export="private">
doc:		<summary>Bitmap of live processors IDs (1 corresponds to live, 0 - to dead processor).</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</attribute>
*/
rt_private PID_MAP_ITEM_TYPE live_pid_map [PID_MAP_COUNT];

/*
doc:	<attribute name="pid_index" return_type="size_t *" export="shared">
doc:		<summary>Mapping "PID->index".</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private size_t pid_index [RT_MAX_SCOOP_PROCESSOR_COUNT];
#define INVALID_INDEX (~ (size_t) 0)

/*
doc:	<attribute name="thread_index" return_type="site_t *" export="private">
doc:		<summary> A container for indices of all threads. The threads in range (0 <= x < live_index_count) are found to be alive by the GC.
doc:			Threads in the range (live_index_count <= x < rt_global_data.count) are added by rt_complement_live_index() and are considered dead.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private size_t* thread_index = NULL;

/*
doc:	<attribute name="thread_index_capacity" return_type="site_t" export="private">
doc:		<summary>The current capacity of 'thread_index'.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private size_t thread_index_capacity = 0;

/*
doc:	<attribute name="live_index_count" return_type="size_t" export="private">
doc:		<summary>Total number of live items `thread_index' starting from 0 index.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private size_t live_index_count;

/*
doc:	<routine name="rt_mark_live_pid" export="shared">
doc:		<summary>Mark processor as live.</summary>
doc:		<param name="pid" type="EIF_SCP_PID">ID of the processor.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared void rt_mark_live_pid (EIF_SCP_PID pid)
{
	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);
	RT_MARK_PID (pid);
}


/*
doc:	<routine name="rt_live_thread_item" return_type="size_t" export="shared">
doc:		<summary>Return an index of the thread at position 'position'. The return value is an index to the rt_globals_list structure.</summary>
doc:		<param name="position" type="size_t">The position of the thread in the 'thread_index' array.</param>
doc:		<return> A valid index to a thread in the 'rt_globals_list' structure. </return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared size_t rt_thread_item (size_t position)
{
	REQUIRE ("in_bounds", position < rt_globals_list.count);
	ENSURE ("valid", thread_index [position] < rt_globals_list.count);
	return thread_index [position];
}


/*
doc:	<routine name="rt_live_thread_count" return_type="size_t" export="shared">
doc:		<summary>Return the total number of live threads in the 'thread_index' array.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared size_t rt_live_thread_count (void)
{
	return live_index_count;
}

/*
doc:	<routine name="rt_set_all_threads_live" return_type="size_t" export="shared">
doc:		<summary>Complement the 'thread_index' array such that all threads will be traversed for partial garbage collection.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared void rt_set_all_threads_live (void)
{
	size_t j = 0;
	size_t count = rt_globals_list.count;
	for (; j < count; j++) {
		thread_index [j] = j;
	}
}

/*
doc:	<routine name="rt_enumerate_live_processors" return_type="void" export="private">
doc:		<summary> Mark all processors that currently have a client as alive.
doc:			Note: This is an approximation (i.e. a subset) of the truly alive processors.
doc:			Some processors may not have a client at the moment, but some objects on them are still referenced. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_private void rt_enumerate_live_processors(void)
{
	struct rt_processor* proc = NULL;
	EIF_SCP_PID i;

	for (i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) {

		proc = rt_lookup_processor (i);

			/* We also mark processors as alive whose creation procedure has not been logged yet.
			 * This avoids a potential problem that a processor is garbage collected after creation,
			 * just before the RTS_PID() of its root feature has been set. */
		if (proc && (proc->is_active || !proc->is_creation_procedure_logged)) {
			rt_mark_live_pid (proc->pid);
		}
	}
}

/*
doc:	<routine name="rt_prepare_live_index" export="shared">
doc:		<summary>Prepare `thread_index' and `live_index_count' to track live indexes during GC.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock. (i.e: encapsulated in eif_synchronize_gc and eif_unsynchronize_gc</synchronization>
doc:	</routine>
*/
rt_shared void rt_prepare_live_index ()
{
	size_t i;
	size_t count = rt_globals_list.count;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;

		/* Clean live processor bit map. */
	memset (live_pid_map, 0, sizeof (live_pid_map));
		/* Clean "PID->index" mapping. */
	for (i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; i++) { 
			/* Use -1 to indicate that no thread index is allocated for the processor yet. */
		pid_index[i] = INVALID_INDEX;
	}
		/* Clean live indexes and make sure we have enough space. */
	if (thread_index_capacity < count) {
		size_t* new_thread_index = NULL;
		size_t new_capacity = 1;
			/* Double capacity until we have enough space. */
		while (new_capacity < count) {
			 new_capacity <<= 1;
		}
			/* Allocate the new array. */
		new_thread_index = malloc (new_capacity * sizeof (size_t));
		if (!new_thread_index) {
			eif_panic ("Could not increase thread_index array during garbage collection.\n");
		}
		free (thread_index);
		thread_index = new_thread_index;
		thread_index_capacity = new_capacity;
	}
	memset (thread_index, -1, count * sizeof (size_t));
	live_index_count = 0;

	/* The precondition is commented out because some threads may execute
	 * the external code and have not reached the synchronization point even
	 * though they eventually will. */
	/* REQUIRE("eif GC synchronized", eif_is_synchronized()); */

		/* Prepare `pid_index' and collect non-SCOOP threads. */
	for (i = 0; i < count; i++) {
		rt_thr_context * c = t [i] -> eif_thr_context_cx;
		if (c -> is_processor) {
				/* The thread is allocated for a processor. */
				/* Liveness of processor will be reported by rt_enumerate_live_processors and detected during GC. */
				/* Record "PID->index" relation for future use. */
			if (c->logical_id != EIF_NULL_PROCESSOR) {
				pid_index [c -> logical_id] = i;
			} else {
				/* The processor has already been collected in the previous GC cycle and is about to destroy itself.
				 * There's nothing we have to do here. */
			}
		} else {
				/* This is a non-SCOOP thread. */
				/* Add it to the live indexes. */
			thread_index [live_index_count] = i;
			live_index_count++;
		}
	}
	rt_enumerate_live_processors ();
	if (!live_index_count) {
		rt_update_live_index ();
	}
}

/*
doc:	<routine name="rt_update_live_index" export="shared">
doc:		<summary>Update (already initialized) `thread_index', `live_index_count'
doc:                     to include live indexes between `0' and `live_index_count - 1'.
doc:                     Add all remaining indexes to the end if no new live indexes are found
doc:                     leaving `live_index_count' without a change.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared void rt_update_live_index (void)
{
		/* Unmark any processors that were marked before. */
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	for (i = 0; i < live_index_count; i++) {
		rt_thr_context * c = t [thread_index [i]] -> eif_thr_context_cx;
		if (c -> is_processor) {
				/* A EIF_NULL_PROCESSOR indicates that the processor is about to destroy itself because it has no more references.
				 * If the GC thinks it's alive this is a bug. */
			CHECK ("has_id", c->logical_id != EIF_NULL_PROCESSOR);
			RT_UNMARK_PID (c->logical_id);
		}
	}
		/* Add indexes of processors that were not marked before. */
	for (i = 0; i < sizeof (live_pid_map) / PID_MAP_ITEM_SIZE; i++) {
			/* Test if any new processor is marked in this range. */
		PID_MAP_ITEM_TYPE item = live_pid_map [i];
		if (item) {
				/* Scan all processors in this range. */
			size_t j;
			for (j = PID_MAP_ITEM_BITS * i; item; j++) {
					/* Check if a processor is marked. */
				if (item & 1) {
						/* Check that a thread is allocated for the processor `j'. */
					size_t p = pid_index [j];
					if (p != INVALID_INDEX) {
							/* Add live index to the list. */
						thread_index [live_index_count] = p;
						live_index_count++;
					}
				}
					/* Advance to the next processor. */
				item >>= 1;
			}
		}
	}
}

/*
doc:	<routine name="rt_complement_live_index" export="shared">
doc:		<summary>Add indexes of dead processors at the end of the list leaving `live_index_count' without a change.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared void rt_complement_live_index (void)
{
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	size_t n = live_index_count; /* Total number of items in the list indexes array. */
	size_t count = rt_globals_list.count; /* Total number of indexes. */
		/* First mark all indexes. Reuse PID map for this purpose. */
	memset (live_pid_map, 0xFF, sizeof (live_pid_map));
		/* Unmark live indexes. */
	for (i = 0; i < live_index_count; i++) {
		rt_thr_context * c = t [thread_index [i]] -> eif_thr_context_cx;
		if (c -> is_processor) {
			RT_UNMARK_PID (thread_index [i]);
		}
	}
		/* Iterate over all indexes and add dead ones to the end of the list. */
	for (i = 0; i < count; i++) {
		rt_thr_context * c = t [i] -> eif_thr_context_cx;
		if ((c-> is_processor) && RT_IS_LIVE_PID (i)) {
				/* The index is marked. So, the index is not in the list of live ones. */
				/* Add it to the end of the list. */
			CHECK ("in_range", n < count);
			thread_index [n] = i;
			n++;
		}
	}
}

/*
doc:	<routine name="rt_report_live_index" export="shared">
doc:		<summary>Notify the processor registry about live indexes.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_shared void rt_report_live_index (void)
{
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	size_t count = rt_globals_list.count; /* Total number of indexes. */
	rt_global_context_t* l_context = NULL;
	EIF_SCP_PID l_processor_id;

	/* Iterate over all dead indexes and report processor IDs to the processor registry. */
	for (i = live_index_count; i < count; i++) {

		l_context = t [thread_index [i]];
		l_processor_id = l_context->eif_thr_context_cx->logical_id;

			/* Notify processor registry that the processor is not used anymore. */
			/* Note: Processors with a EIF_NULL_PROCESSOR are about to destroy themselves.
			 * No need to send the shutdown signal again. */
		if (l_processor_id != EIF_NULL_PROCESSOR) {
			rt_processor_registry_deactivate (l_processor_id, l_context);
		}
	}
		/* Tell the processor registry to remove passive regions. */
	rt_processor_registry_cleanup ();
}

/*
doc:	<routine name="rt_mark_all_processors" return_type="void" export="shared">
doc:		<summary> Mark all processors in the system. </summary>
doc:		<param name="marking" type="MARKER"> The marker function. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during GC. </synchronization>
doc:	</routine>
*/
rt_shared void rt_mark_all_processors (MARKER marking)
{
	struct rt_processor* proc = NULL;
	EIF_SCP_PID i = 0;

	REQUIRE ("marking_not_null", marking);

	for (i = 0; i < RT_MAX_SCOOP_PROCESSOR_COUNT; ++i) {
		proc = rt_lookup_processor (i);

		if (proc) {
			rt_processor_mark (proc, marking);
		}
	}
}
/*
doc:</file>
*/
