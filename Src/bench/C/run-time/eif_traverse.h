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
	Include file for traversal of objects.
*/

#ifndef _eif_traverse_h_
#define _eif_traverse_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define TR_ACCOUNT_ATTR	0x04		/* Accounting of types of attributes */
#define INDEPEND_ACCOUNT 0x11
#define RECOVER_ACCOUNT	0x15

RT_LNK EIF_REFERENCE find_referers (EIF_REFERENCE target, EIF_INTEGER result_type);
RT_LNK EIF_REFERENCE find_instance_of (EIF_INTEGER instance_type, EIF_INTEGER result_type);
RT_LNK EIF_REFERENCE find_all_instances (EIF_INTEGER result_type);

#ifdef __cplusplus
}
#endif

#endif

