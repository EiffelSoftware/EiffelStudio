/*
	eif_argcargv.h - Cleanup for extra arguments due to debugger.
*/

#ifndef _eif_argcargv_h
#define _eif_argcargv_h

#include "eif_eiffel.h"

	/* Clean up function */
typedef void (* EIF_CLEANUP)(EIF_BOOLEAN);

	/* Register `f' as a clean up function */
extern void eif_register_cleanup(EIF_CLEANUP f);

#endif /* _eif_argcargv_h */
