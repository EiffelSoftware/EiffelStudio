
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#include <stdio.h>

#ifdef EIF_WINDOWS
extern int print_err_msg(FILE *err, char *StrFmt, ...);
extern int save_exception_trace;
extern char *exception_trace_string;
extern void show_trace();
#else
#define print_err_msg fprintf
#endif

#endif
