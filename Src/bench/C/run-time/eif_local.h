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
	Declarations for local variable stack handling.
*/

#ifndef _eif_local_h_
#define _eif_local_h_

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void epop(struct stack *stk, rt_uint_ptr nb_items);			/* Pops values off the local stack */
#ifdef ISE_GC
RT_LNK char **eget(register int num);		/* Get another chunk for local variables */
RT_LNK void eback(register char **top);		/* Get back to the previous stack chunk */
#endif
RT_LNK void initstk(void);		/* Initialize local stacks */

#ifdef __cplusplus
}
#endif

#endif
