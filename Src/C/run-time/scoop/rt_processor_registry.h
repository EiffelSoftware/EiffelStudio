/*
	description:	"Declarations for struct rt_processor_registry."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2014-2015, Eiffel Software.",
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

#ifndef _rt_processor_registry_h_
#define _rt_processor_registry_h_

#include "rt_identifier_set.h"
#include "rt_scoop.h"
#include "rt_assert.h"

/* Forward declarations */
struct rt_processor;

/* Global initialization and teardown. */
rt_shared int rt_processor_registry_init (void);
rt_shared void rt_processor_registry_deinit (void);

/* Processor lifecycle management. */
rt_shared int rt_processor_registry_create_region (EIF_SCP_PID* result);
rt_shared void rt_processor_registry_activate (EIF_SCP_PID pid);
rt_shared void rt_processor_registry_deactivate (EIF_SCP_PID pid);

/* Root thread entry point. */
rt_shared void rt_processor_registry_quit_root_processor (void);

/*
doc:	<struct name="rt_processor_registry" export="shared">
doc:		<summary> The processor registry struct is a singleton.
doc:			It manages a processor's lifecycle, maintains a set of free
doc:			processor identifiers, and manages a mapping from PID to
doc:			processor objects.
doc:		</summary>
doc:		<field name="procs" type="struct rt_processor**"> The array used to map PIDs to processors. </field>
doc:		<field name="processor_count" type="volatile EIF_INTEGER_32"> An atomic integer to keep track of currently alive processors. </field>
doc:		<field name="free_pids" type="struct rt_identifier_set"> A set of free (unassigned) PIDs. </field>
doc:		<field name="all_done" type="EIF_BOOLEAN"> A boolean value indicating whether there are no more alive processors. Used by the root thread for program termination. </field>
doc:		<field name="all_done_mutex" type="EIF_MUTEX_TYPE*"> A mutex to protect the all_done field. </field>
doc:		<field name="all_done_cv" type="EIF_COND_TYPE*"> A condition variable for the root thread to wait for the all_done field to become true. </field>
doc:		<fixme> Could it be that all_done and processor_count==0 contain the same information? </fixme>
doc:	</struct>
*/
struct rt_processor_registry {
	/*
	 * Although the procs array is accessed by several threads,
	 * it is not necessary to synchronize the access. There are several
	 * properties that make it unnecessary:
	 * 
	 * Data race freedom:
	 * - A new value is inserted by the creator thread after it received
	 *   a new unique PID from the free_pids set. 
	 * - After creation, the field remains constant.
	 * - The value is reset to NULL only by the thread behind the specified
	 *   processor ID, after the garbage collector concluded that it is no
	 *   longer referenced anywhere.
	 * - The uniqueness of PIDs is guaranteed by the free_pids set. A new 
	 *   ID has to be acquired before adding an entry in 'procs', and it
	 *   can only be released after resetting 'procs' to NULL.
	 * 
	 * Visibility:
	 * - Generally, x86 has strong visibility guarantees, and by creating
	 *   initializing the processor object before adding it to 'procs'
	 *   any other thread can see a consistent view.
	 * - The update to the procs array itself is visible in the garbage collector,
	 *   because the creator thread synchronizes with the GC thread prior to a cycle.
	 * - The same applies during removal of a processor.
	 * - Between the creator thread and the spawned thread, visibility is guaranteed
	 *   because of the thread creation operation.
	 * - In between processors, visibility is guaranteed because the creator first
	 *   has to publish the root object of the new processor, and as soon as this
	 *   object is visible by other threads the update is visible as well, thanks
	 *   to the visibility guarantees of x86.
	 */
  struct rt_processor* procs [RT_MAX_SCOOP_PROCESSOR_COUNT];

  volatile EIF_INTEGER_32 processor_count;
  
  struct rt_identifier_set free_pids;

  /* end of life notification */
  volatile EIF_BOOLEAN all_done;
  EIF_MUTEX_TYPE* all_done_mutex;
  EIF_COND_TYPE* all_done_cv;
};


/*
 * NOTE: This global variable is exported only for performance reasons
 * (rt_get_processor and rt_lookup_processor can be inlined that way).
 * Do not use it directly.
 */
extern struct rt_processor_registry registry;

/*
doc:	<routine name="rt_get_processor" return_type="struct rt_processor*" export="shared">
doc:		<summary> Get the processor object with the SCOOP id 'pid'. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be found. </param>
doc:		<return> The processor with ID 'pid'. </return>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. See explanation for 'procs' attribute. </synchronization>
doc:	</routine>
*/
rt_private rt_inline struct rt_processor* rt_get_processor (EIF_SCP_PID pid)
{
	struct rt_processor *result;

	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);
	REQUIRE ("processor_alive", registry.procs[pid]);

	result = registry.procs [pid];

	ENSURE("not_null", result);
	return result;
}

/*
doc:	<routine name="rt_lookup_processor" return_type="struct rt_processor*" export="shared">
doc:		<summary> Try to get the processor object with the SCOOP id 'pid'. If none exists, the result is NULL. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be found. </param>
doc:		<return> The processor with ID 'pid'. May be NULL. </return>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. See explanation for 'procs' attribute. </synchronization>
doc:	</routine>
*/
rt_private rt_inline struct rt_processor* rt_lookup_processor (EIF_SCP_PID pid)
{
	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);
	return registry.procs [pid];
}

#endif /* _rt_processor_registry_h_ */
