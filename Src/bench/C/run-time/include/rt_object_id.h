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
 * Object id externals
 */

#ifndef _rt_object_id_h_
#define _rt_object_id_h_

#include "eif_object_id.h"


#ifdef __cplusplus
extern "C" {
#endif

extern struct stack object_id_stack;	/* Stack where objects referenced through `object_id' are stored
										 * See class IDENTIFIED */	

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_object_id_stack_mutex;
#endif

#ifdef __cplusplus
}
#endif


#endif
