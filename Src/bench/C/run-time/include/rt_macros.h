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

#ifdef EIF_THREADS
#define EIF_GC_MUTEX_LOCK	EIF_MUTEX_LOCK(eif_gc_mutex, "Could not lock GC mutex")
#define EIF_GC_MUTEX_UNLOCK	EIF_MUTEX_UNLOCK(eif_gc_mutex, "Could not unlock GC mutex")
#endif

#ifdef __cplusplus
}
#endif

#endif
