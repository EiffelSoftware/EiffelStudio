/*
	description:	"SCOOP constants and features needed by the runtime."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2016, Eiffel Software."
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

#ifndef _rt_scoop_h_
#define _rt_scoop_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"

/* Maximum number of SCOOP processors, including root. */
#define RT_MAX_SCOOP_PROCESSOR_COUNT 1024

#ifdef __cplusplus
extern "C" {
#endif

/* Setup and teardown of the SCOOP subsystem. */
rt_shared void rt_scoop_setup (int is_scoop_enabled);
rt_shared void rt_scoop_reclaim (void);

#ifdef EIF_WINDOWS
/*
doc:	<routine name="rt_scoop_set_wel_per_thread_data" return_type="void" export="shared">
doc:		<summary>Set 'stored_wel_per_thread_data' associated with the processor of ID 'pid' to the specified value. </summary>
doc:		<param name="data" type="void*">The new value of 'stored_wel_per_thread_data'</param>
doc:		<param name="pid" type="EIF_SCP_PID">The processor to update the data.</param>
doc:		<thread_safety>Safe.</thread_safety>
doc:	</routine>
*/
rt_shared void rt_scoop_set_wel_per_thread_data (void * data, EIF_SCP_PID pid);
#endif

#ifdef __cplusplus
}
#endif

#endif	/* _rt_scoop_h_ */
