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
	Externals for class BOOL_STRING.
*/

#ifndef _eif_boolstr_h_
#define _eif_boolstr_h_

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK char *bl_str_set(char *a1, int s, int n);
RT_LNK char *bl_str_and(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_or(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_xor(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_not(char *a1, char *a2, int s);
RT_LNK char *bl_str_shiftr(char *a1, char *a2, int s, int n);
RT_LNK char *bl_str_shiftl(char *a1, char *a2, int s, int n);

#ifdef __cplusplus
}
#endif

#endif

