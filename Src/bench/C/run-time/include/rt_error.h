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
 Private declaration.
*/

#ifndef _rt_error_h_
#define _rt_error_h_

#include "eif_error.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void esys(void);				/* Raise 'Operating system error' exception */
extern void eise_io(char *tag);		/* Raise an Eiffel 'I/O error' exception with `tag' */
extern char *error_tag(int code);	/* English description out of errno code */

#ifndef HAS_SYS_ERRLIST
	extern int sys_nerr;            /* Size of sys_errlist[] */
	extern char *sys_errlist[];     /* Maps error code to string */
#endif

#ifdef __cplusplus
}
#endif

#endif
