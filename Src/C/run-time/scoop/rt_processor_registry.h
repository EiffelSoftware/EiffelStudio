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

#include "rt_scoop.h"
#include "rt_assert.h"
#include "rt_globals.h"

/* Forward declarations */
struct rt_processor;

/*
 * NOTE: This global variable is exported only for performance reasons
 * (rt_get_processor and rt_lookup_processor can be inlined that way).
 * Do not use it directly.
 */
extern struct rt_processor* processor_lookup_table[];

/* Global initialization and teardown. */
rt_shared int rt_processor_registry_init (void);
rt_shared void rt_processor_registry_deinit (void);

/* Processor lifecycle management. */
rt_shared int rt_processor_registry_create_region (EIF_SCP_PID* result, EIF_BOOLEAN is_passive);
rt_shared void rt_processor_registry_activate (EIF_SCP_PID pid);
rt_shared void rt_processor_registry_deactivate (EIF_SCP_PID pid, rt_global_context_t* a_context);
rt_shared void rt_processor_registry_cleanup (void);

/* Root thread entry point. */
rt_shared void rt_processor_registry_quit_root_processor (void);

/*
doc:	<routine name="rt_get_processor" return_type="struct rt_processor*" export="shared">
doc:		<summary> Get the processor object with the SCOOP id 'pid'. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be found. </param>
doc:		<return> The processor with ID 'pid'. </return>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. See explanation for 'processor_lookup_table' attribute. </synchronization>
doc:	</routine>
*/
rt_private rt_inline struct rt_processor* rt_get_processor (EIF_SCP_PID pid)
{
	struct rt_processor *result;

	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);
	REQUIRE ("processor_alive", processor_lookup_table [pid]);

	result = processor_lookup_table [pid];

	ENSURE("not_null", result);
	return result;
}

/*
doc:	<routine name="rt_lookup_processor" return_type="struct rt_processor*" export="shared">
doc:		<summary> Try to get the processor object with the SCOOP id 'pid'. If none exists, the result is NULL. </summary>
doc:		<param name="pid" type="EIF_SCP_PID"> The ID of the processor to be found. </param>
doc:		<return> The processor with ID 'pid'. May be NULL. </return>
doc:		<thread_safety> Safe </thread_safety>
doc:		<synchronization> None required. See explanation for 'processor_lookup_table' attribute. </synchronization>
doc:	</routine>
*/
rt_private rt_inline struct rt_processor* rt_lookup_processor (EIF_SCP_PID pid)
{
	REQUIRE ("in_bounds", pid < RT_MAX_SCOOP_PROCESSOR_COUNT);
	return processor_lookup_table [pid];
}

#endif /* _rt_processor_registry_h_ */
