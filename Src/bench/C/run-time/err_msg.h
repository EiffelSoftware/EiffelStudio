
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#include <stdio.h>

#ifdef EIF_WIN_31
extern int print_err_msg(FILE *err, char *StrFmt, ...);
#else
#define print_err_msg fprintf
#endif

#endif
