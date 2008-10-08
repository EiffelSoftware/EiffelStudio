/*
	description: "Private Macros used by C code at run time."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
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

#ifndef _rt_macros_h_
#define _rt_macros_h_

#include "eif_macros.h"
#include "eif_types.h"
#include "rt_wbench.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Macro used to initialize `count' and `internal_hash_code' of STRING. Only `count' access
 * is defined in workbench mode, as only setting hash code makes sense for fast finalized 
 * executable. */
#ifdef WORKBENCH
#define RT_STRING_MAKE(string,len) \
	{ \
		EIF_TYPED_VALUE u; \
		u.type = SK_INT32; \
		u.it_i4 = (EIF_INTEGER) (len); \
		(egc_strmake)((EIF_REFERENCE) (string), u); \
	}
#define RT_STRING_SET_COUNT(string,count) \
	nstcall = 0; \
	{ \
		EIF_TYPED_VALUE u; \
		u.type = SK_INT32; \
		u.it_i4 = (EIF_INTEGER) count; \
		(egc_strset)((EIF_REFERENCE) string, u); \
	}
#define RT_STRING_SET_HASH_CODE(string, hash)
#else
#define RT_STRING_MAKE(string,len) \
	(egc_strmake)((EIF_REFERENCE) (string), (len))
#define RT_STRING_SET_COUNT(string, count) \
	*(EIF_INTEGER *) ((EIF_REFERENCE) string + egc_str_count_offset) = (EIF_INTEGER) count;
#define RT_STRING_SET_HASH_CODE(string, hash) \
	*(EIF_INTEGER *) ((EIF_REFERENCE) string + egc_str_hash_offset) = (EIF_INTEGER) hash;
#endif


/* Macro used for variable protection when using the ISE GC. */
/* RT_GC_PROTECT(a)	push `a' into `loc_stack' so that we always have a valid
 					access to `a'. */
/* RT_GC_WEAN(a)	remove protection of GC to `a' by poping one item from `loc_stack'. */
/* RT_GC_WEAN_N(n)	pop `n' items from `loc_stack'. */

#ifdef ISE_GC
#define RT_GC_PROTECT(a)	epush(&loc_stack,(EIF_REFERENCE) &a)
#define RT_GC_WEAN(a)		epop(&loc_stack,1)
#define RT_GC_WEAN_N(n)		epop(&loc_stack,n)
#else
#define RT_GC_PROTECT(a)
#define RT_GC_WEAN(a)
#define RT_GC_WEAN_N(n)
#endif

/* Macro used to get info about SPECIAL objects. */
/* RT_SPECIAL_INFO, RT_SPECIAL_INFO_WITH_ZONE returns pointer to where `count' and `element_size'
 *    of a special objects is stored.
 * RT_SPECIAL_COUNT, RT_SPECIAL_COUNT_WITH_ZONE, RT_SPECIAL_COUNT_WITH_INFO returns `count'
 *    of special objects.
 * RT_SPECIAL_ELEM_SIZE, RT_SPECIAL_ELEM_SIZE_WITH_ZONE, RT_SPECIAL_ELEM_SIZE_WITH_INFO returns
 *    `element_size' of items in special objects.
 */
#define RT_SPECIAL_INFO(spec) \
	(char *) ((spec) + (HEADER(spec)->ov_size & B_SIZE) - LNGPAD_2)
#define RT_SPECIAL_INFO_WITH_ZONE(spec,zone) \
	(char *) ((spec) + ((zone)->ov_size & B_SIZE) - LNGPAD_2)

#define RT_SPECIAL_COUNT(spec) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO(spec))
#define RT_SPECIAL_COUNT_WITH_ZONE(spec,zone) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO_WITH_ZONE(spec,zone))
#define RT_SPECIAL_COUNT_WITH_INFO(offset) \
	(*(EIF_INTEGER *) offset)

#define RT_SPECIAL_ELEM_SIZE(spec) \
	(*(EIF_INTEGER *) (RT_SPECIAL_INFO(spec) + sizeof(EIF_INTEGER)))
#define RT_SPECIAL_ELEM_SIZE_WITH_ZONE(spec,zone) \
	(*(EIF_INTEGER *) (RT_SPECIAL_INFO_WITH_ZONE(spec,zone) + sizeof(EIF_INTEGER)))
#define RT_SPECIAL_ELEM_SIZE_WITH_INFO(offset) \
	(*(EIF_INTEGER *) (offset + sizeof(EIF_INTEGER)))


/* Macro used to protect concurrent running of GC. */
#ifdef EIF_THREADS
	/* For GC collection locking */
#define EIF_GC_MUTEX_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_gc_mutex, "Could not lock GC mutex")
#define EIF_GC_MUTEX_UNLOCK	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_gc_mutex, "Could not unlock GC mutex")

	/* For insertion in various global set such as `rem_set', `moved_set' */
#define EIF_GC_SET_MUTEX_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_gc_set_mutex, "Could not lock GC rem_set mutex");
#define EIF_GC_SET_MUTEX_UNLOCK	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_gc_set_mutex, "Could not unlock GC rem_set mutex")

	/* To protect access to `rt_g_data'. */
#define EIF_G_DATA_MUTEX_LOCK	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_rt_g_data_mutex, "Could not lock GC rem_set mutex");
#define EIF_G_DATA_MUTEX_UNLOCK	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_rt_g_data_mutex, "Could not unlock GC rem_set mutex")

	/* Values used to set the running status of a thread. */
#define EIF_THREAD_RUNNING		0
#define EIF_THREAD_GC_REQUESTED	1001
#define EIF_THREAD_GC_RUNNING	1002
#define EIF_THREAD_GC_GSZ		1003
#define EIF_THREAD_GC_SET		1004
#define EIF_THREAD_BLOCKED 		3
#define EIF_THREAD_SUSPENDED	4
#define EIF_THREAD_DYING		5
#define GC_THREAD_PROTECT(x)	x
#else
#define GC_THREAD_PROTECT(x)
#define EIF_G_DATA_MUTEX_LOCK
#define EIF_G_DATA_MUTEX_UNLOCK
#endif

/* Macro for enabling/disabling debugger */
#ifdef WORKBENCH
rt_public void discard_breakpoints(void);	/* Avoid debugger to stop while in GC cycles */
rt_public void undiscard_breakpoints(void); /* re-authorize the debugger to stop */
#define DISCARD_BREAKPOINTS	discard_breakpoints();
#define UNDISCARD_BREAKPOINTS	undiscard_breakpoints();
#define BREAKPOINTS_DISCARDED	(d_data.db_discard_breakpoints)

#else
#define DISCARD_BREAKPOINTS
#define UNDISCARD_BREAKPOINTS
#define BREAKPOINTS_DISCARDED	(1)
#endif

/* macro to handle catcall status */
#define set_catcall_detection_mode_for(b,t)	catcall_detection_mode = b?(catcall_detection_mode | t):(catcall_detection_enabled & ~t)
#define set_catcall_detection_console(b)	set_catcall_detection_mode_for(b,0x1)
#define catcall_detection_enabled	(catcall_detection_mode)
#define catcall_detection_console_enabled	(catcall_detection_mode & 0x1)
#ifdef WORKBENCH
#define default_catcall_detection_mode	(0x1 | 0x2)
#define set_catcall_detection_debugger(b)	set_catcall_detection_mode_for(b,0x2)
#define catcall_detection_debugger_enabled	(catcall_detection_mode & 0x2)
#else
#define default_catcall_detection_mode	(0)
#endif

/* Macro for conformance */
#define par_info(t)	(eif_par_table2[t])

#ifdef __cplusplus
}
#endif

#endif
