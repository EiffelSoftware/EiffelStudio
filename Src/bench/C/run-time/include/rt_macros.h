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
	((spec) + (HEADER(spec)->ov_size & B_SIZE) - LNGPAD_2)
#define RT_SPECIAL_INFO_WITH_ZONE(spec,zone) \
	((spec) + ((zone)->ov_size & B_SIZE) - LNGPAD_2)

#define RT_SPECIAL_COUNT(spec) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO(spec))
#define RT_SPECIAL_COUNT_WITH_ZONE(spec,zone) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO_WITH_ZONE(spec,zone))
#define RT_SPECIAL_COUNT_WITH_INFO(offset) \
	(*(EIF_INTEGER *) offset)

#define RT_SPECIAL_ELEM_SIZE(spec) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO(spec) + sizeof(EIF_INTEGER))
#define RT_SPECIAL_ELEM_SIZE_WITH_ZONE(spec,zone) \
	(*(EIF_INTEGER *) RT_SPECIAL_INFO_WITH_ZONE(spec,zone) + sizeof(EIF_INTEGER))
#define RT_SPECIAL_ELEM_SIZE_WITH_INFO(offset) \
	(*(EIF_INTEGER *) (offset + sizeof(EIF_INTEGER)))


/* Macro used to protect concurrent running of GC. */
#ifdef EIF_THREADS
#define EIF_GC_MUTEX_LOCK	EIF_MUTEX_LOCK(eif_gc_mutex, "Could not lock GC mutex")
#define EIF_GC_MUTEX_UNLOCK	EIF_MUTEX_UNLOCK(eif_gc_mutex, "Could not unlock GC mutex")
#endif

#ifdef __cplusplus
}
#endif

#endif
