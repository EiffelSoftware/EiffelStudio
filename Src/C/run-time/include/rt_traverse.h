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
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_traverse.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_CS_TYPE *eif_eo_store_mutex;
#ifdef ISE_GC
#define EIF_EO_STORE_LOCK \
	thread_can_launch_gc = 0; \
	EIF_ASYNC_SAFE_CS_LOCK(eif_eo_store_mutex)
#define EIF_EO_STORE_UNLOCK \
	thread_can_launch_gc = 1; \
	EIF_ASYNC_SAFE_CS_UNLOCK(eif_eo_store_mutex)
#else
#define EIF_EO_STORE_LOCK	EIF_ASYNC_SAFE_CS_LOCK(eif_eo_store_mutex)
#define EIF_EO_STORE_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_eo_store_mutex)
#endif
#else
#define EIF_EO_STORE_LOCK
#define EIF_EO_STORE_UNLOCK
#endif

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define TR_ACCOUNT_ATTR	0x04		/* Accounting of types of attributes */
#define TR_STORE_ACCOUNT	(TR_ACCOUNT | TR_ACCOUNT_ATTR)

/*
doc:	<struct name="rt_traversal_context" export="public">
doc:		<summary>Context used to configure or get results from a call to `traversal'.</summary>
doc:		<field name="obj_nb" type="uint32">Number of objects found during traversal.</summary>
doc:		<field name="accounting" type="int">Type of possible accounting (TR_PLAIN, TR_ACCOUNT, TR_MAP, TR_ACCOUNT_ATTR, TR_STORE_ACCOUNT).</field>
doc:		<field name="account" type="struct rt_traversal_info *">Array of traversed dynamic types.</field>
doc:		<field name="account_count" type="size_t">Size of `account' array. Used for proper resizing of `account'.</field>
doc:		<field name="is_for_persistence" type="int">Is traversal for persistence purpose? If not it is for copy purpose.</field>
doc:		<field name="is_unmarking" type="int">Is traversal going to unmark objects instead of marking them? Useful to unmark objects in the event of an exception.</field>
doc:	</struct>
*/
struct rt_traversal_context {
	uint32 obj_nb;						/* Number of objects found during traversal. */
	int accounting;						/* Type of accounting being done. */
	struct rt_traversal_info *account;	/* Array of traversed dyn types */
	size_t account_count;
		/* The members below are private and should only be used inside `traverse.c'. */
	int is_for_persistence;
	int is_unmarking;
};


RT_LNK void traversal(struct rt_traversal_context *a_context, EIF_REFERENCE object); /* Traversal of objects */

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
	struct oastack stack;
	struct oacursor bottom;
};

struct obj_array {
	EIF_REFERENCE *area;	/* Area where objects are stored */
	uint32 count;				/* Number of inserted items */
	uint32 capacity;			/* Capacity of `area' */
	uint32 index;				/* Cursor position */
};

struct rt_traversal_info {
	int processed;
	int attributes_processed;
};


#ifdef __cplusplus
}
#endif

#endif

