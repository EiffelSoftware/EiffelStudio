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

#ifndef _rt_lmalloc_h_
#define _rt_lmalloc_h_

#include "eif_lmalloc.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int is_in_lm (void *ptr);
extern void eif_lm_display (void);
extern int eif_lm_free (void);

#ifdef __cplusplus
}
#endif

#endif
