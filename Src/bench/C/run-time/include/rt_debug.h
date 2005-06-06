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
	Private data structures and functions used by debugger.
*/

#ifndef _rt_debug_h_
#define _rt_debug_h_

#include "eif_debug.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS
#ifdef WORKBENCH
extern struct pgcontext d_cxt;		/* Program context */
extern struct dbstack db_stack;		/* Calling context stack */
extern struct id_list once_list;	/* Calling context once_list */
#endif
#endif

extern void dbreak_create_table(void);
extern void dbreak_free_table(void);

#ifdef __cplusplus
}
#endif

#endif
