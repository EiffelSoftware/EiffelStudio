/*
 * MSG.H
 */

#ifndef __WEL_MSG__
#define __WEL_MSG__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_msg_set_hwnd(_ptr_, _value_) (((MSG *) _ptr_)->hwnd = (HWND) (_value_))
#define cwel_msg_set_message(_ptr_, _value_) (((MSG *) _ptr_)->message = (UINT) (_value_))
#define cwel_msg_set_wparam(_ptr_, _value_) (((MSG *) _ptr_)->wParam = (WPARAM) (_value_))
#define cwel_msg_set_lparam(_ptr_, _value_) (((MSG *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_msg_get_hwnd(_ptr_) (((MSG *) _ptr_)->hwnd)
#define cwel_msg_get_message(_ptr_) (((MSG *) _ptr_)->message)
#define cwel_msg_get_wparam(_ptr_) (((MSG *) _ptr_)->wParam)
#define cwel_msg_get_lparam(_ptr_) (((MSG *) _ptr_)->lParam)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MSG__ */

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
