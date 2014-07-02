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

#include "eif_macros.h"
#include "eif_scoop.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS

#define PID_MAP_ITEM_TYPE uint32                       /* Type of items in `live_pid_map'. (It must be unsigned.) */
#define PID_MAP_ITEM_SIZE (sizeof (PID_MAP_ITEM_TYPE)) /* Size of one element in `live_pid_map' in bytes. */
#define PID_MAP_ITEM_BITS (PID_MAP_ITEM_SIZE*8)        /* Size of one element in `live_pid_map' in bits. */
#define PID_MAP_ITEM(x)   live_pid_map [x / PID_MAP_ITEM_BITS] /* Item of `live_pid_map' corresponding to PID `x'. */
#define PID_MAP_BIT(x)    (((PID_MAP_ITEM_TYPE)1) << ((x) & ~(PID_MAP_ITEM_TYPE)0)) /* Bit in item corresponding to PID `x'. */

extern PID_MAP_ITEM_TYPE live_pid_map []; /* Bitmap of live processors IDs (1 corresponds to live, 0 - to dead processor). */

#define RT_MARK_PID(pid) \
	{ \
		EIF_SCP_PID x = (EIF_SCP_PID)(pid); \
		PID_MAP_ITEM (x) |= PID_MAP_BIT (x); \
	}

#define RT_MARK_PROCESSOR(obj) eif_mark_live_pid(RTS_PID(obj))

extern size_t live_index [];    /* Indexes of live threads. */
extern size_t live_index_count; /* Total number of valid items in `live_index' starting from 0 index. */

#else /* EIF_THREADS */

#define RT_MARK_PROCESSOR(obj)

#endif /* EIF_THREADS */

extern void prepare_live_index (); /* Initialize live indexes. */
extern void update_live_index (void);  /* Update live indexes by taking into account marked processors. */
extern void complement_live_index (void); /* Add indexes of dead processors at the end of the live index list. */
extern void report_live_index (void); /* Notify SCOOP manager about live indexes. */

#ifdef __cplusplus
}

#endif

#endif	/* _rt_scoop_gc_h_ */

