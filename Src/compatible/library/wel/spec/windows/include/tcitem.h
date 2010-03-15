/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
