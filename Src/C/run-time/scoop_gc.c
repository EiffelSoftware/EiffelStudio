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

#include <stddef.h>
#include <memory.h>
#include "rt_types.h"
#include "rt_assert.h"
#include "rt_scoop_gc.h"
#include "rt_threads.h"

#define PID_MAP_COUNT     ((RT_MAX_SCOOP_PROCESSOR_COUNT + PID_MAP_ITEM_BITS - 1) / PID_MAP_ITEM_BITS)

#define RT_UNMARK_PID(pid) \
	{ \
		EIF_SCP_PID x = (EIF_SCP_PID)(pid); \
		PID_MAP_ITEM (x) &= ~ PID_MAP_BIT (x); \
	}

#define RT_IS_LIVE_PID(pid) (PID_MAP_ITEM (pid) & PID_MAP_BIT (pid))

/*
doc:	<attribute name="live_pid_map" return_type="PID_MAP_ITEM_TYPE" export="shared">
doc:		<summary>Bitmap of live processors IDs (1 corresponds to live, 0 - to dead processor).</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</attribute>
*/
rt_shared PID_MAP_ITEM_TYPE live_pid_map [PID_MAP_COUNT];

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
doc:	<attribute name="live_index" return_type="site_t *" export="shared">
doc:		<summary>Indexes of live threads (`live_index_count' in total).</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared size_t live_index [RT_MAX_SCOOP_PROCESSOR_COUNT];

/*
doc:	<attribute name="live_index_count" return_type="size_t" export="shared">
doc:		<summary>Total number of valid items in `live_index' starting from 0 index.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared size_t live_index_count;

/*
doc:	<routine name="eif_mark_live_pid" export="public">
doc:		<summary>Mark processor as live.</summary>
doc:		<param name="pid" type="EIF_SCP_PID">ID of the processor.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</routine>
*/
rt_public void eif_mark_live_pid (EIF_SCP_PID pid)
{
	RT_MARK_PID (pid);
}

/*
doc:	<routine name="prepare_live_index" export="shared">
doc:		<summary>Prepare `live_index' and `live_index_count' to track live indexes during GC.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>To be done while already pocessing the `eif_gc_mutex' lock. (i.e: encapsulated in eif_synchronize_gc and eif_unsynchronize_gc</synchronization>
doc:	</routine>
*/
rt_shared void prepare_live_index ()
{
	size_t i;
	size_t count = rt_globals_list.count;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;

		/* Clean live processor bit map. */
	memset (live_pid_map, 0, sizeof (live_pid_map));
		/* Clean "PID->index" mapping. */
		/* Use -1 to indicate that no thread index is allocated for the processor yet. */
	memset (pid_index, (int) INVALID_INDEX, sizeof (pid_index));
		/* Clean live indexes. */
	memset (live_index, 0, sizeof (live_index));
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
				/* Liveness of processor will be reported by SCOOP manager and detected during GC. */
				/* Record "PID->index" relation for future use. */
			pid_index [c -> logical_id] = i;
		}
		else {
				/* This is a non-SCOOP thread. */
				/* Add it to the live indexes. */
			live_index [live_index_count] = i;
			live_index_count++;
		}
	}

#ifdef SCOOPQS
	eveqs_enumerate_live ();
	if (!live_index_count) {
		update_live_index ();
	}
#else
		/* Check if system is running with SCOOP manager. */
	if (scp_mnger) {
			/* Record live SCOOP processors. */
		RTS_TCB(scoop_task_enumerate_live_processors,0,0,0);

			/* Update live indexes for processors reported by SCOOP manager.
			 * This step is postponed if there are already known live threads. */
		if (!live_index_count) {
			update_live_index ();
		}
	}
#endif
}

/*
doc:	<routine name="update_live_index" export="shared">
doc:		<summary>Update (already initialized) `live_index', `live_index_count'
doc:                     to include live indexes between `0' and `live_index_count - 1'.
doc:                     Add all remaining indexes to the end if no new live indexes are found
doc:                     leaving `live_index_count' without a change.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</function>
*/
rt_shared void update_live_index (void)
{
		/* Unmark any processors that were marked before. */
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	for (i = 0; i < live_index_count; i++) {
		rt_thr_context * c = t [live_index [i]] -> eif_thr_context_cx;
		if (c -> is_processor) {
			RT_UNMARK_PID (c -> logical_id);
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
						live_index [live_index_count] = p;
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
doc:	<routine name="update_live_index" export="shared">
doc:		<summary>Add indexes of dead processors at the end of the list
doc:                     leaving `live_index_count' without a change.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</function>
*/
rt_shared void complement_live_index (void)
{
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	size_t n = live_index_count; /* Total number of items in the list indexes array. */
	size_t count = rt_globals_list.count; /* Total number of indexes. */
		/* First mark all indexes. Reuse PID map for this purpose. */
	memset (live_pid_map, 0xFF, sizeof (live_pid_map));
		/* Unmark live indexes. */
	for (i = 0; i < live_index_count; i++) {
		rt_thr_context * c = t [live_index [i]] -> eif_thr_context_cx;
		if (c -> is_processor) {
			RT_UNMARK_PID (live_index [i]);
		}
	}
		/* Iterate over all indexes and add dead ones to the end of the list. */
	for (i = 0; i < count; i++) {
		rt_thr_context * c = t [i] -> eif_thr_context_cx;
		if ((c -> is_processor) && RT_IS_LIVE_PID (i)) {
				/* The index is marked. So, the index is not in the list of live ones. */
				/* Add it to the end of the list. */
			live_index [n] = i;
			n++;
		}
	}
}


#ifdef SCOOPQS
#define RTS_UNMARKED(pid) eveqs_unmarked(pid);
#else
#define RTS_UNMARKED(pid)															\
	if (scp_mnger)																			\
		{																									\
			RTS_TCB(scoop_task_free_processor, pid, 0, 0);	\
		}
#endif

/*
doc:	<routine name="report_live_index" export="shared">
doc:		<summary>Notify SCOOP manager about live indexes.</summary>
doc:		<thread_safety>Unsafe</thread_safety>
doc:		<synchronization>Ensured by the caller using `eif_gc_mutex'.</synchronization>
doc:	</function>
*/
rt_shared void report_live_index (void)
{
	size_t i;
	rt_global_context_t ** t = (rt_global_context_t **) rt_globals_list.threads.data;
	size_t count = rt_globals_list.count; /* Total number of indexes. */

	/* Iterate over all dead indexes and report processor IDs to the SCOOP manager. */
	for (i = live_index_count; i < count; i++) {
		rt_thr_context * c = t [live_index [i]] -> eif_thr_context_cx;
		/* Notify SCOOP manager that the processor is not used anymore. */
		RTS_UNMARKED(c->logical_id);
	}
	/* Notify SCOOP manager that the GC cycle is over. */
	/* Unused currently, don't want to come up with another replacement
		 macro for this as well. */
	/* RTS_TCB(scoop_task_update_statistics, 0, 0, 0); */
}


/*
doc:</file>
*/
