
/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h

#ifndef __WATCOMC__
#include <stdio.h>
#define print_err_msg fprintf
#else
extern int print_err_msg()
#endif

#endif
