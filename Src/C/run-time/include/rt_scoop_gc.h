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

#ifndef _rt_scoop_gc_h_
#define _rt_scoop_gc_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "rt_garcol.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern void rt_mark_live_pid(EIF_SCP_PID pid);

extern size_t rt_thread_item (size_t position); /* Get thread at 'position' (0 <= position < rt_globals_list.count) */
extern size_t rt_live_thread_count (void); /* The number of alive threads. */
extern void rt_set_all_threads_live (void); /* Mark all threads in the runtime as alive. */
#endif

extern void rt_prepare_live_index (void); /* Initialize live indexes. */
extern void rt_update_live_index (void);  /* Update live indexes by taking into account marked processors. */
extern void rt_complement_live_index (void); /* Add indexes of dead processors at the end of the live index list. */
extern void rt_report_live_index (void); /* Notify SCOOP manager about live indexes. */

extern void rt_mark_all_processors (MARKER marking); /* Mark all eif_scoop_call_data structures in all processors. */

#ifdef __cplusplus
}
#endif

#endif	/* _rt_scoop_gc_h_ */

