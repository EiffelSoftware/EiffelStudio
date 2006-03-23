/*
 * TVITEM.H
 */

#ifndef __WEL_TREEVIEWITEM__
#define __WEL_TREEVIEWITEM__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tv_item_set_mask(_ptr_, _value_) 			(((TV_ITEM *) _ptr_)->mask = (UINT) (_value_))
#define cwel_tv_item_add_mask(_ptr_, _mask_, _value_)	(((TV_ITEM *) _ptr_)->mask = (UINT) (_mask_)|(_value_))
#define cwel_tv_item_set_hitem(_ptr_, _value_)			(((TV_ITEM *) _ptr_)->hItem = (HTREEITEM) (_value_))
#define cwel_tv_item_set_state(_ptr_, _value_)			(((TV_ITEM *) _ptr_)->state = (UINT) (_value_))
#define cwel_tv_item_set_statemask(_ptr_, _value_)		(((TV_ITEM *) _ptr_)->stateMask = (UINT) (_value_))
#define cwel_tv_item_set_psztext(_ptr_, _value_)		(((TV_ITEM *) _ptr_)->pszText = (LPTSTR) (_value_))
#define cwel_tv_item_set_cchtextmax(_ptr_, _value_)		(((TV_ITEM *) _ptr_)->cchTextMax = (int) (_value_))
#define cwel_tv_item_set_iimage(_ptr_, _value_)			(((TV_ITEM *) _ptr_)->iImage = (int) (_value_))
#define cwel_tv_item_set_iselectedimage(_ptr_, _value_)	(((TV_ITEM *) _ptr_)->iSelectedImage = (int) (_value_))
#define cwel_tv_item_set_cchildren(_ptr_, _value_)		(((TV_ITEM *) _ptr_)->cChildren = (int) (_value_))
#define cwel_tv_item_set_lparam(_ptr_, _value_)			(((TV_ITEM *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_tv_item_get_mask(_ptr_)					((((TV_ITEM *) _ptr_)->mask))
#define cwel_tv_item_get_hitem(_ptr_)					((((TV_ITEM *) _ptr_)->hItem))
#define cwel_tv_item_get_state(_ptr_)					((((TV_ITEM *) _ptr_)->state))
#define cwel_tv_item_get_statemask(_ptr_)				((((TV_ITEM *) _ptr_)->stateMask))
#define cwel_tv_item_get_psztext(_ptr_)					((((TV_ITEM *) _ptr_)->pszText))
#define cwel_tv_item_get_cchtextmax(_ptr_)				((((TV_ITEM *) _ptr_)->cchTextMax))
#define cwel_tv_item_get_iimage(_ptr_)					((((TV_ITEM *) _ptr_)->iImage))
#define cwel_tv_item_get_iselectedimage(_ptr_)			((((TV_ITEM *) _ptr_)->iSelectedImage))
#define cwel_tv_item_get_cchildren(_ptr_)				((((TV_ITEM *) _ptr_)->cChildren))
#define cwel_tv_item_get_lparam(_ptr_)					((((TV_ITEM *) _ptr_)->lParam))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TREEVIEWITEM__ */

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
