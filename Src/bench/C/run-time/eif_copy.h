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
	Include file for source file copy.c
*/

#ifndef _eif_copy_h_
#define _eif_copy_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Functions declarations
 */

RT_LNK EIF_REFERENCE eclone(register EIF_REFERENCE source);			/* Clone of an Eiffel object */
RT_LNK EIF_REFERENCE edclone(EIF_CONTEXT EIF_REFERENCE source);			/* Deep clone of an Eiffel object */
RT_LNK EIF_REFERENCE rtclone(EIF_REFERENCE source);			/* The Eiffel clone operation (run-time) */
RT_LNK void xcopy(EIF_REFERENCE source, EIF_REFERENCE target);			/* Expanded copy with possible exception */
RT_LNK void ecopy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK void eif_std_ref_copy(register EIF_REFERENCE source, register EIF_REFERENCE target);			/* Standard copy of a normal Eiffel object */
RT_LNK EIF_BOOLEAN c_check_assert (EIF_BOOLEAN b);
RT_LNK void sp_copy_data (EIF_REFERENCE Current, EIF_REFERENCE source, EIF_INTEGER source_index, EIF_INTEGER destination_index, EIF_INTEGER n);
RT_LNK void spclearall(EIF_REFERENCE spobj);		/* Reset special object's items to default */

#ifdef __cplusplus
}
#endif

#endif
