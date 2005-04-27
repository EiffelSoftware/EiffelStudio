/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Macros used by the run time to display error messages
*/

#ifndef _err_msg_h
#define _err_msg_h


#include "eif_globals.h"
#include "eif_file.h"
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS
extern int print_err_msg(FILE *err, char *StrFmt, ...);
extern char *exception_trace_string;
#else
#define print_err_msg fprintf
#endif

#ifdef __cplusplus
}
#endif

#endif
