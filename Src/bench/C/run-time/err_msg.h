
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#ifndef __WINDOWS_386__
#include <stdio.h>
#define print_err_msg fprintf
#else
#ifdef __WINDOWS_386__
extern int print_err_msg(FILE *err, char *StrFmt, ...);
#else
#include <stdio.h>
#include <stdarg.h>
int print_err_msg (FILE *err, char *StrFmt, ...)
{
	va_list ap;

	va_start (ap, StrFmt);
	return vprintf (StrFmt, ap);
}
#endif
#endif

#endif
