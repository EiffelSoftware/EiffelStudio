/*
 * REGISTRY_VALUE.H
 */

#ifndef __WEL_REGISTRY_VALUE__
#define __WEL_REGISTRY_VALUE__

#ifndef __WEL__
#	include <wel.h>
#endif

typedef struct {
	DWORD type;
	LPBYTE data;
	DWORD length;
	} REG_VALUE;

#define cwin_reg_value_alloc (EIF_POINTER)((REG_VALUE *)malloc (sizeof (REG_VALUE)))	
#define cwin_reg_value_get_type(_ptr_) (EIF_INTEGER)(((REG_VALUE *) _ptr_)->type)
#define cwin_reg_value_get_data(_ptr_) (EIF_POINTER)(((REG_VALUE *) _ptr_)->data)
#define cwin_reg_value_get_data_dword(_ptr_) (EIF_INTEGER)(*(((REG_VALUE *) _ptr_)->data))
#define cwin_reg_value_set_type(_ptr_, _type_) (((REG_VALUE *) _ptr_)->type = (DWORD) (_type_))
#define cwin_reg_value_set_data(_ptr_, _data_) (((REG_VALUE *) _ptr_)->data = (LPBYTE) (_data_))
#define cwin_reg_value_set_data_length(_ptr_, _length_) (((REG_VALUE *) _ptr_)->length = (DWORD) (_length_))
#define cwin_reg_value_set_data_dword(_ptr_, _data_) (((REG_VALUE *) _ptr_)->data = (LPBYTE) (&(_data_)))

#endif  /* __WEL_REGISTRY_VALUE__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
