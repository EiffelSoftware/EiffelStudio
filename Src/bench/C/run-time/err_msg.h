
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"
#include <stdio.h>

#ifdef EIF_WINDOWS
extern int print_err_msg(FILE *err, char *StrFmt, ...);
extern void show_trace();		/* %%zs undefined */
#else
#define print_err_msg fprintf
#endif

#ifdef __cplusplus
}
#endif

#endif
