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

#ifndef __WEL_CHOOSECOLOR__
#define __WEL_CHOOSECOLOR__

#ifndef __WEL_COMMONDIALOGS__
#	include <cdlg.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_choose_color_set_lstructsize(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->lStructSize = (DWORD) (_value_))
#define cwel_choose_color_set_hwndowner(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_choose_color_set_rgbresult(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->rgbResult = (COLORREF) (_value_))
#define cwel_choose_color_set_lpcustcolors(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->lpCustColors = (COLORREF *) (_value_))
#define cwel_choose_color_set_flags(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->Flags = (DWORD) (_value_))

#define cwel_choose_color_get_rgbresult(_ptr_) ((EIF_INTEGER) (((CHOOSECOLOR *) _ptr_)->rgbResult))
#define cwel_choose_color_get_lpcustcolors(_ptr_) ((EIF_POINTER) (((CHOOSECOLOR *) _ptr_)->lpCustColors))
#define cwel_choose_color_get_flags(_ptr_) ((EIF_INTEGER) (((CHOOSECOLOR *) _ptr_)->Flags))

#define cwel_color_palette_get_i_th_color(_ptr_, _index_) ((EIF_INTEGER) (((COLORREF *) _ptr_) [_index_]))

#define cwel_color_palette_set_i_th_color(_ptr_, _index_, _value_) ((((COLORREF *) _ptr_) [_index_] = (COLORREF) _value_))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CHOOSECOLOR__ */
