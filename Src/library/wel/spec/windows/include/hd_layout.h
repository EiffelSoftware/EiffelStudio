/*
 * HD_LAYOUT.H
 */

#ifndef __WEL_HD_LAYOUT__
#define __WEL_HD_LAYOUT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_hd_layout_set_prc(_ptr_, _value_) (((HD_LAYOUT *) _ptr_)->prc = (RECT FAR*) _value_)
#define cwel_hd_layout_get_prc(_ptr_) ((EIF_POINTER)(((HD_LAYOUT *) _ptr_)->prc))

#define cwel_hd_layout_set_pwpos(_ptr_, _value_) (((HD_LAYOUT *) _ptr_)->pwpos = (WINDOWPOS FAR*) _value_)
#define cwel_hd_layout_get_pwpos(_ptr_) ((EIF_POINTER)(((HD_LAYOUT *) _ptr_)->pwpos))


#ifdef __cplusplus
}
#endif


#endif /* __WEL_HD_LAYOUT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
