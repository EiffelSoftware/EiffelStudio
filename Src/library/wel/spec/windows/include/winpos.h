/*
 * WINPOS.H
 */

#ifndef __WEL_WINDOWPOS__
#define __WEL_WINDOWPOS__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_windowpos_set_hwnd(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->hwnd = (HWND) (_value_))
#define cwel_windowpos_set_hwndinsertafter(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->hwndInsertAfter = (HWND) (_value_))
#define cwel_windowpos_set_x(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->x = (int) (_value_))
#define cwel_windowpos_set_y(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->y = (int) (_value_))
#define cwel_windowpos_set_width(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->cx = (int) (_value_))
#define cwel_windowpos_set_height(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->cy = (int) (_value_))
#define cwel_windowpos_set_flags(_ptr_, _value_) (((WINDOWPOS *) _ptr_)->flags = (UINT) (_value_))

#define cwel_windowpos_get_hwnd(_ptr_) ((((WINDOWPOS *) _ptr_)->hwnd))
#define cwel_windowpos_get_hwndinsertafter(_ptr_) ((((WINDOWPOS *) _ptr_)->hwndInsertAfter))
#define cwel_windowpos_get_x(_ptr_) ((((WINDOWPOS *) _ptr_)->x))
#define cwel_windowpos_get_y(_ptr_) ((((WINDOWPOS *) _ptr_)->y))
#define cwel_windowpos_get_width(_ptr_) ((((WINDOWPOS *) _ptr_)->cx))
#define cwel_windowpos_get_height(_ptr_) ((((WINDOWPOS *) _ptr_)->cy))
#define cwel_windowpos_get_flags(_ptr_) ((((WINDOWPOS *) _ptr_)->flags))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_WINDOWPOS__ */

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
