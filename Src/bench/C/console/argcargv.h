/*
	ARGCARGV.H - Cleanup for extra arguments due to debugger.
*/

#ifndef _argcargv_h
#define _argcargv_h

#include "shword.h"

	/* Clean up function */
typedef void (* EIF_CLEANUP)();

	/* Register `f' as a clean up function */
extern void eif_register_cleanup(EIF_CLEANUP f);

#endif /* _argcargv_h */
