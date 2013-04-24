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

#ifndef __WEL_LISTVIEWITEM__
#define __WEL_LISTVIEWITEM__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_lv_item_set_mask(_ptr_, _value_) 	 		(((LV_ITEM *) _ptr_)->mask = (UINT) (_value_))
#define cwel_lv_item_add_mask(_ptr_, _mask_, _value_)	(((LV_ITEM *) _ptr_)->mask = (UINT) (_mask_)|(_value_))
#define cwel_lv_item_set_iitem(_ptr_, _value_)	 		(((LV_ITEM *) _ptr_)->iItem = (int) (_value_))
#define cwel_lv_item_set_isubitem(_ptr_, _value_)		(((LV_ITEM *) _ptr_)->iSubItem = (int) (_value_))
#define cwel_lv_item_set_state(_ptr_, _value_) 			(((LV_ITEM *) _ptr_)->state = (UINT) (_value_))
#define cwel_lv_item_set_statemask(_ptr_, _value_) 		(((LV_ITEM *) _ptr_)->stateMask = (UINT) (_value_))
#define cwel_lv_item_set_psztext(_ptr_, _value_) 		(((LV_ITEM *) _ptr_)->pszText = (LPTSTR) (_value_))
#define cwel_lv_item_set_cchtextmax(_ptr_, _value_)		(((LV_ITEM *) _ptr_)->cchTextMax = (int) (_value_))
#define cwel_lv_item_set_iimage(_ptr_, _value_) 		(((LV_ITEM *) _ptr_)->iImage = (int) (_value_))
#define cwel_lv_item_set_lparam(_ptr_, _value_) 		(((LV_ITEM *) _ptr_)->lParam = (LPARAM) (_value_))

#define cwel_lv_item_get_mask(_ptr_) 					(((LV_ITEM *) _ptr_)->mask)
#define cwel_lv_item_get_iitem(_ptr_)					(((LV_ITEM *) _ptr_)->iItem)
#define cwel_lv_item_get_isubitem(_ptr_)				(((LV_ITEM *) _ptr_)->iSubItem)
#define cwel_lv_item_get_state(_ptr_) 					(((LV_ITEM *) _ptr_)->state)
#define cwel_lv_item_get_statemask(_ptr_)				(((LV_ITEM *) _ptr_)->stateMask)
#define cwel_lv_item_get_psztext(_ptr_) 				(((LV_ITEM *) _ptr_)->pszText)
#define cwel_lv_item_get_cchtextmax(_ptr_)				(((LV_ITEM *) _ptr_)->cchTextMax)
#define cwel_lv_item_get_iimage(_ptr_) 					(((LV_ITEM *) _ptr_)->iImage)
#define cwel_lv_item_get_lparam(_ptr_) 					(((LV_ITEM *) _ptr_)->lParam)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_LISTVIEWITEM__ */
