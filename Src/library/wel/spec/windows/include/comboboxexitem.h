/*
 * COMBOBOXEXITEM.H
 */

#ifndef __WEL_COMBOBOXEXITEM__
#define __WEL_COMBOBOXEXITEM__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_comboboxex_item_set_mask(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->mask = (UINT) (_value_))
#define cwel_comboboxex_item_set_iitem(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->iItem = (int) (_value_))
#define cwel_comboboxex_item_set_psztext(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->pszText = (LPTSTR) (_value_))
#define cwel_comboboxex_item_set_cchtextmax(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->cchTextMax = (int) (_value_))
#define cwel_comboboxex_item_set_iimage(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->iImage = (int) (_value_))
#define cwel_comboboxex_item_set_iselectedimage(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->iSelectedImage = (int) (_value_))
#define cwel_comboboxex_item_set_ioverlay(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->iOverlay = (int) (_value_))
#define cwel_comboboxex_item_set_iindent(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->iIndent = (int) (_value_))
#define cwel_comboboxex_item_set_lparam(_ptr_, _value_) (((COMBOBOXEXITEM *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_comboboxex_item_get_mask(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->mask)
#define cwel_comboboxex_item_get_iitem(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->iItem)
#define cwel_comboboxex_item_get_psztext(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->pszText)
#define cwel_comboboxex_item_get_cchtextmax(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->cchTextMax)
#define cwel_comboboxex_item_get_iimage(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->iImage)
#define cwel_comboboxex_item_get_iselectedimage(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->iSelectedImage)
#define cwel_comboboxex_item_get_ioverlay(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->iOverlay)
#define cwel_comboboxex_item_get_iindent(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->iIndent)
#define cwel_comboboxex_item_get_lparam(_ptr_) (((COMBOBOXEXITEM *) _ptr_)->lParam)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_COMBOBOXEXITEM__ */

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
