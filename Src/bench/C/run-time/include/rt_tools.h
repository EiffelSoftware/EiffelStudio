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
	Private general purpose utility functions.
*/

#ifndef _rt_tools_h_
#define _rt_tools_h_

#include "eif_tools.h"

#ifdef __cplusplus
extern "C" {
#endif

extern size_t nprime(size_t n);				/* Find first prime above a given number */
extern size_t prime(size_t n);					/* Test whether a number is prime or not */

#ifdef __cplusplus
}
#endif

#endif
