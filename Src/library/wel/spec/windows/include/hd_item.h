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

#ifndef __WEL_HD_ITEM__
#define __WEL_HD_ITEM__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_hd_item_set_mask(_ptr_, _value_) (((HD_ITEM *) _ptr_)->mask = (UINT) _value_)
#define cwel_hd_item_get_mask(_ptr_) ((EIF_INTEGER)(((HD_ITEM *) _ptr_)->mask))

#define cwel_hd_item_set_cxy(_ptr_, _value_) (((HD_ITEM *) _ptr_)->cxy = (int) _value_)
#define cwel_hd_item_get_cxy(_ptr_) ((EIF_INTEGER)(((HD_ITEM *) _ptr_)->cxy))

#define cwel_hd_item_set_psz_text(_ptr_, _value_) (((HD_ITEM *) _ptr_)->pszText = (LPTSTR) _value_)
#define cwel_hd_item_get_psz_text(_ptr_) ((EIF_POINTER)(((HD_ITEM *) _ptr_)->pszText))

#define cwel_hd_item_set_hbm(_ptr_, _value_) (((HD_ITEM *) _ptr_)->hbm = (HBITMAP) _value_)
#define cwel_hd_item_get_hbm(_ptr_) ((EIF_POINTER)(((HD_ITEM *) _ptr_)->hbm))

#define cwel_hd_item_set_cch_text_max(_ptr_, _value_) (((HD_ITEM *) _ptr_)->cchTextMax = (int) _value_)
#define cwel_hd_item_get_cch_text_max(_ptr_) ((EIF_INTEGER)(((HD_ITEM *) _ptr_)->cchTextMax))

#define cwel_hd_item_set_fmt(_ptr_, _value_) (((HD_ITEM *) _ptr_)->fmt = (int) _value_)
#define cwel_hd_item_get_fmt(_ptr_) ((EIF_INTEGER)(((HD_ITEM *) _ptr_)->fmt))

#define cwel_hd_item_set_l_param(_ptr_, _value_) (((HD_ITEM *) _ptr_)->lParam = (LPARAM) _value_)
#define cwel_hd_item_get_l_param(_ptr_) ((EIF_INTEGER)(((HD_ITEM *) _ptr_)->lParam))



#ifdef __cplusplus
}
#endif

#endif /* __WEL_HD_ITEM__ */
