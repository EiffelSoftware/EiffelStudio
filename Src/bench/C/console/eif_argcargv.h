/*
	eif_argcargv.h - Cleanup for extra arguments due to debugger.
*/

#ifndef _eif_argcargv_h
#define _eif_argcargv_h

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

	/* Clean up function */
typedef void (* EIF_CLEANUP)(EIF_BOOLEAN);

	/* Register `f' as a clean up function */
extern void eif_register_cleanup(EIF_CLEANUP f);

#ifdef __cplusplus
}
#endif

#endif /* _eif_argcargv_h */
