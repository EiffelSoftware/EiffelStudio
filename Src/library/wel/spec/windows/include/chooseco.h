/*
 * CHOOSECO.H
 */

#ifndef __WEL_CHOOSECOLOR__
#define __WEL_CHOOSECOLOR__

#ifndef __WEL_COMMONDIALOGS__
#	include <cdlg.h>
#endif

#define cwel_choose_color_set_lstructsize(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->lStructSize = (DWORD) (_value_))
#define cwel_choose_color_set_hwndowner(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_choose_color_set_rgbresult(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->rgbResult = (COLORREF) (_value_))
#define cwel_choose_color_set_lpcustcolors(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->lpCustColors = (COLORREF *) (_value_))
#define cwel_choose_color_set_flags(_ptr_, _value_) (((CHOOSECOLOR *) _ptr_)->Flags = (DWORD) (_value_))

#define cwel_choose_color_get_rgbresult(_ptr_) ((EIF_POINTER) (((CHOOSECOLOR *) _ptr_)->rgbResult))
#define cwel_choose_color_get_lpcustcolors(_ptr_) ((EIF_POINTER) (((CHOOSECOLOR *) _ptr_)->lpCustColors))
#define cwel_choose_color_get_flags(_ptr_) ((EIF_INTEGER) (((CHOOSECOLOR *) _ptr_)->Flags))

#define cwel_color_palette_get_i_th_color(_ptr_, _index_) ((EIF_POINTER) (((COLORREF *) _ptr_) [_index_]))

#define cwel_color_palette_set_i_th_color(_ptr_, _index_, _value_) ((((COLORREF *) _ptr_) [_index_] = (COLORREF) _value_))

#endif /* __WEL_CHOOSECOLOR__ */
