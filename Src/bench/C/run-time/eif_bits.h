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
	Declarations for bits handling routines.
*/

#ifndef _eif_bits_h_
#define _eif_bits_h_

#include "eif_portable.h"
#include "eif_plug.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */
RT_LNK EIF_BOOLEAN b_equal(EIF_REFERENCE a, EIF_REFERENCE b);	/* needed in interp.c */
RT_LNK EIF_REFERENCE b_eout(EIF_REFERENCE bit);					/* Eiffel string for out representation of a bit */
RT_LNK EIF_REFERENCE b_clone(EIF_REFERENCE bit);				/* Clones bit */
RT_LNK void b_copy(EIF_REFERENCE a, EIF_REFERENCE b);			/* Copies bit */
RT_LNK void b_put(EIF_REFERENCE bit, char value, int at);
RT_LNK EIF_BOOLEAN b_item(EIF_REFERENCE bit, EIF_INTEGER at);
RT_LNK EIF_REFERENCE b_shift(EIF_REFERENCE bit, EIF_INTEGER s);
RT_LNK EIF_REFERENCE b_rotate(EIF_REFERENCE bit, EIF_INTEGER s);
RT_LNK EIF_REFERENCE b_and(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_implies(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_or(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_xor(EIF_REFERENCE a, EIF_REFERENCE b);
RT_LNK EIF_REFERENCE b_not(EIF_REFERENCE a);
RT_LNK EIF_REFERENCE b_out(EIF_REFERENCE bit);
RT_LNK EIF_REFERENCE b_mirror(EIF_REFERENCE a);
RT_LNK EIF_INTEGER b_count(EIF_REFERENCE bit);

#ifdef __cplusplus
}
#endif


#endif
