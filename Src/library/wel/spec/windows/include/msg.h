/*
 * MSG.H
 */

#ifndef __WEL_MSG__
#define __WEL_MSG__

#ifndef __WEL__
#	include <wel.h>
#endif

#define cwel_msg_get_hwnd(_ptr_) ((EIF_POINTER) ((MSG *) _ptr_)->hwnd)
#define cwel_msg_get_message(_ptr_) ((EIF_INTEGER) ((MSG *) _ptr_)->message)
#define cwel_msg_get_wparam(_ptr_) ((EIF_INTEGER) ((MSG *) _ptr_)->wParam)
#define cwel_msg_get_lparam(_ptr_) ((EIF_INTEGER) ((MSG *) _ptr_)->lParam)

#endif /* __WEL_MSG__ */

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
