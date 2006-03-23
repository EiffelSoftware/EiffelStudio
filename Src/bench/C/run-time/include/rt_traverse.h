/*
	description: "Private include file for traversal of objects."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_traverse_h_
#define _rt_traverse_h_

#include "eif_traverse.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_eo_store_mutex;
#ifdef ISE_GC
#define EIF_EO_STORE_LOCK \
	thread_can_launch_gc = 0; \
	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.")
#define EIF_EO_STORE_UNLOCK \
	thread_can_launch_gc = 1; \
	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.");
#else
#define EIF_EO_STORE_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.")
#define EIF_EO_STORE_UNLOCK	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.");
#endif
#else
#define EIF_EO_STORE_LOCK
#define EIF_EO_STORE_UNLOCK
#endif

RT_LNK uint32 obj_nb;					/* Count of marked objects */
RT_LNK void traversal(EIF_REFERENCE object, int p_accounting); /* Traversal of objects */

/* Maping table handling */
extern void map_start(void);			/* Reset LIFO stack into a FIFO one */
extern EIF_OBJECT map_next(void);			/* Get next object as in a FIFO stack */
extern void map_reset(int emergency);			/* Reset maping table */

#ifdef DEBUG						/* For copy.c */
extern long nomark(char *obj);
#endif

/* The mstack structure has to be an exact copy of the stack structure, but has
 * an added field st_bot at the end. That way, we may safely use the common
 * stack handling structures without any code duplication and still have the
 * added field to make a FIFO stack--RAM.
 */
struct mstack {
	struct stchunk *st_hd;	/* Head of chunk list */
	struct stchunk *st_tl;	/* Tail of chunk list */
	struct stchunk *st_cur;	/* Current chunk in use (where top is) */
	char **st_top;			/* Top in chunk (pointer to next free location) */
	char **st_end;			/* Pointer to first element beyond current chunk */
	char **st_bot;			/* ADDED FIELD for FIFO stack implementation */
};

struct obj_array {
	EIF_REFERENCE *area;	/* Area where objects are stored */
	int count;				/* Number of inserted items */
	int capacity;			/* Capacity of `area' */
	int index;				/* Cursor position */
};

#ifdef __cplusplus
}
#endif

#endif

