
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

#ifdef EIF_WIN32
extern int print_err_msg(FILE *err, char *StrFmt, ...);
extern char *exception_trace_string;
#else
#define print_err_msg fprintf
#endif

#ifndef MAX_PATH
#define MAX_PATH	260
#endif

extern char starting_working_directory [MAX_PATH];

#ifdef EIF_GNU_WIN
#undef MAX_PATH
#endif

#ifdef __cplusplus
}
#endif

#endif
