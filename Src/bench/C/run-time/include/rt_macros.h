/*

 #    #    ##     ####   #####    ####    ####           #    #
 ##  ##   #  #   #    #  #    #  #    #  #               #    #
 # ## #  #    #  #       #    #  #    #   ####           ######
 #    #  ######  #       #####   #    #       #   ###    #    #
 #    #  #    #  #    #  #   #   #    #  #    #   ###    #    #
 #    #  #    #   ####   #    #   ####    ####    ###    #    #

	Private Macros used by C code at run time.
*/

#ifndef _rt_macros_h_
#define _rt_macros_h_

#include "eif_macros.h"
#include "rt_wbench.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Macro used to initialize `count' and `internal_hash_code' of STRING. Only `count' access
 * is defined in workbench mode, as only setting hash code makes sense for fast finalized 
 * executable. */
#ifdef WORKBENCH
#define RT_STRING_SET_COUNT(string,count) \
	nstcall = 0; \
	(egc_strset)((EIF_REFERENCE) string, (EIF_INTEGER) count);
#define RT_STRING_SET_HASH_CODE(string, hash)
#else
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
#define EIF_GC_MUTEX_LOCK \
	EIF_LW_MUTEX_LOCK(eif_gc_mutex, "Could not lock GC mutex")
#define EIF_GC_MUTEX_UNLOCK \
	EIF_LW_MUTEX_UNLOCK(eif_gc_mutex, "Could not unlock GC mutex")

	/* For insertion in various global set such as `rem_set', `moved_set' */
#define EIF_GC_SET_MUTEX_LOCK \
	GC_THREAD_PROTECT(gc_thread_status = EIF_THREAD_GC_SET); \
	EIF_LW_MUTEX_LOCK(eif_gc_set_mutex, "Could not lock GC rem_set mutex"); \
	RTGC; \
	GC_THREAD_PROTECT(gc_thread_status = EIF_THREAD_RUNNING);
#define EIF_GC_SET_MUTEX_UNLOCK \
	EIF_LW_MUTEX_UNLOCK(eif_gc_set_mutex, "Could not unlock GC rem_set mutex")

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
#endif

#ifdef __cplusplus
}
#endif

#endif
