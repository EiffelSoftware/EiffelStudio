
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_globals.h"
#include "eif_file.h"
#include <stdio.h>

#ifdef EIF_WIN32
extern int print_err_msg(FILE *err, char *StrFmt, ...);
extern char *exception_trace_string;
#else
#define print_err_msg fprintf
#endif

#ifdef __cplusplus
}
#endif

#endif
