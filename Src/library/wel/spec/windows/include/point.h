/*
 * POINT.H
 */

#ifndef __WEL_POINT__
#define __WEL_POINT__

#ifndef __WEL__
#	include <wel.h>
#endif

#define cwel_point_set_x(_ptr_, _value_) (((POINT *) _ptr_)->x = (int) (_value_))
#define cwel_point_set_y(_ptr_, _value_) (((POINT *) _ptr_)->y = (int) (_value_))

#define cwel_point_get_x(_ptr_) ((EIF_INTEGER) (((POINT *) _ptr_)->x))
#define cwel_point_get_y(_ptr_) ((EIF_INTEGER) (((POINT *) _ptr_)->y))

#define cwin_pt_in_rect(_ptr_, _pt_) ((EIF_BOOLEAN) PtInRect ((RECT *) _ptr_, *((POINT *) _pt_)))

#endif /* __WEL_POINT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
