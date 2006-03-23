/*
 * TCITEM.H
 */

#ifndef __WEL_TABCONTROLITEM__
#define __WEL_TABCONTROLITEM__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tc_item_set_mask(_ptr_, _value_) (((TC_ITEM *) _ptr_)->mask = (UINT) (_value_))
#define cwel_tc_item_set_psztext(_ptr_, _value_) (((TC_ITEM *) _ptr_)->pszText = (LPTSTR) (_value_))
#define cwel_tc_item_set_cchtextmax(_ptr_, _value_) (((TC_ITEM *) _ptr_)->cchTextMax = (int) (_value_))
#define cwel_tc_item_set_iimage(_ptr_, _value_) (((TC_ITEM *) _ptr_)->iImage = (int) (_value_))
#define cwel_tc_item_set_lparam(_ptr_, _value_) (((TC_ITEM *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_tc_item_get_mask(_ptr_) ((((TC_ITEM *) _ptr_)->mask))
#define cwel_tc_item_get_psztext(_ptr_) ((((TC_ITEM *) _ptr_)->pszText))
#define cwel_tc_item_get_cchtextmax(_ptr_) ((((TC_ITEM *) _ptr_)->cchTextMax))
#define cwel_tc_item_get_iimage(_ptr_) ((((TC_ITEM *) _ptr_)->iImage))
#define cwel_tc_item_get_lparam(_ptr_) ((((TC_ITEM *) _ptr_)->lParam))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TABCONTROLITEM__ */

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
