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
	Externals for class STRING
*/

#ifndef _eif_str_h_
#define _eif_str_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_INTEGER str_left(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK void str_ljustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_rjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_cjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK EIF_INTEGER str_right(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK void str_replace(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER start, EIF_INTEGER end);
RT_LNK void str_insert(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER idx);
RT_LNK void str_cprepend(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
RT_LNK void str_rmchar(EIF_CHARACTER *str, EIF_INTEGER l, EIF_INTEGER i);
RT_LNK EIF_INTEGER str_rmall(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
RT_LNK EIF_INTEGER str_atoi(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_REAL str_ator(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_DOUBLE str_atod(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isr(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isd(EIF_CHARACTER *str, EIF_INTEGER length);

#ifdef __cplusplus
}
#endif

#endif

