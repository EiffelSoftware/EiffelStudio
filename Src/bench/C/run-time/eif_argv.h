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
	Argument vectors.
*/

#ifndef _eif_argv_h_
#define _eif_argv_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK int eif_argc;			/* Initial argc value (argument count) */
RT_LNK char **eif_argv;			/* Copy of initial argv (argument vector) */
RT_LNK EIF_INTEGER arg_number(void);
RT_LNK EIF_REFERENCE arg_option(EIF_INTEGER num);	/* Eiffel string of argv[num] */

#ifdef __cplusplus
}
#endif

#endif

