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
	General purpose utility functions.
*/

#ifndef _eif_tools_h_
#define _eif_tools_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Computes hashcode for a string */
RT_LNK EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count);

#ifdef __cplusplus
}
#endif

#endif
