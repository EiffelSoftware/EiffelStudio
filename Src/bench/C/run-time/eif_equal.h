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
	Include file for Eiffel equality
*/

#ifndef _eif_equal_h_
#define _eif_equal_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Routine declarations
 */

RT_LNK EIF_BOOLEAN xequal(EIF_REFERENCE ref1, EIF_REFERENCE ref2);			/* Equality with no conformance constraint */
RT_LNK EIF_BOOLEAN eequal(register EIF_REFERENCE target, register EIF_REFERENCE source);			/* Standard equality on standard objects */
extern EIF_BOOLEAN eiso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard isomorphism on normal objects */
extern EIF_BOOLEAN spiso(register EIF_REFERENCE target, register EIF_REFERENCE source);				/* Standard isomorphism on special objects */
RT_LNK EIF_BOOLEAN ediso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Standard recursive isomorphism */

#ifdef __cplusplus
}
#endif

#endif
