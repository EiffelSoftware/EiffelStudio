/*
 * NMHDR.H
 */

#ifndef __WEL_MSGFILTER__
#define __WEL_MSGFILTER__

#include <richedit.h>

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_msg_filter_get_msg(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->msg))
#define cwel_msg_filter_get_wparam(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->wParam))
#define cwel_msg_filter_get_lparam(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->lParam))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MSGFILTER__ */

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
