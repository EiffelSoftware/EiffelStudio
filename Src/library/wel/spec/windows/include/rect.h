/*
 * RECT.H
 */

#ifndef __WEL_RECT__
#define __WEL_RECT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_rect_set_left(_ptr_, _value_) (((RECT *) _ptr_)->left = (int) (_value_))
#define cwel_rect_set_top(_ptr_, _value_) (((RECT *) _ptr_)->top = (int) (_value_))
#define cwel_rect_set_right(_ptr_, _value_) (((RECT *)_ptr_)->right = (int) (_value_))
#define cwel_rect_set_bottom(_ptr_, _value_) (((RECT *) _ptr_)->bottom = (int) (_value_))

#define cwel_rect_get_left(_ptr_) ((((RECT *) _ptr_)->left))
#define cwel_rect_get_top(_ptr_) ((((RECT *) _ptr_)->top))
#define cwel_rect_get_right(_ptr_) ((((RECT *) _ptr_)->right))
#define cwel_rect_get_bottom(_ptr_) ((((RECT *) _ptr_)->bottom))

#define cwin_pt_in_rect(_ptr_, _point_) ((EIF_BOOLEAN) PtInRect ((RECT *) _ptr_, *((POINT *) _point_)))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_RECT__ */

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
