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

#ifndef _eif_error_h_
#define _eif_error_h_

#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

/* As a special case, an I/O error is raised when a system call which is
 * I/O bound fails.
 * Obsolete: use `eraise (NULL, EN_IO)' instead
 */
#define eio()	eraise(NULL, EN_IO)

#ifdef __cplusplus
}
#endif

#endif
