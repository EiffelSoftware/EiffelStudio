/*
 * CLIENTCS.H
 */

#ifndef __WEL_CLIENTCREATESTRUCT__
#define __WEL_CLIENTCREATESTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_client_cs_set_window_menu(_ptr_,_value_) (((CLIENTCREATESTRUCT *) _ptr_)->hWindowMenu = (HANDLE) (_value_))
#define cwel_client_cs_set_first_child(_ptr_,_value_) (((CLIENTCREATESTRUCT *) _ptr_)->idFirstChild = (UINT) (_value_))

#define cwel_client_cs_get_window_menu(_ptr_) ((((CLIENTCREATESTRUCT *) _ptr_)->hWindowMenu))
#define cwel_client_cs_get_first_child(_ptr_) ((((CLIENTCREATESTRUCT *) _ptr_)->idFirstChild))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CLIENTCREATESTRUCT__ */

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
