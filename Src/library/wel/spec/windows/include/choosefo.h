/*
 * CHOOSEFO.H
 */

#ifndef __WEL_CHOOSEFONT__
#define __WEL_CHOOSEFONT__

#ifndef __WEL_COMMONDIALOGS__
#	include <cdlg.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_choose_font_set_lstructsize(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lStructSize = (DWORD) (_value_))
#define cwel_choose_font_set_hwndowner(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_choose_font_set_hdc(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->hDC = (HDC) (_value_))
#define cwel_choose_font_set_lplogfont(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lpLogFont = (LPLOGFONT) (_value_))
#define cwel_choose_font_set_ipointsize(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->iPointSize = (int) (_value_))
#define cwel_choose_font_set_flags(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->Flags = (DWORD) (_value_))
#define cwel_choose_font_set_rgbcolors(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->rgbColors = (DWORD) (_value_))
#define cwel_choose_font_set_lcustdata(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lCustData = (DWORD) (_value_))
#define cwel_choose_font_set_lpfnhook(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lpfnHook = (LPCFHOOKPROC) (_value_))
#define cwel_choose_font_set_lptemplatename(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lpTemplateName = (LPCTSTR) (_value_))
#define cwel_choose_font_set_hinstance(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->hInstance = (HANDLE) (_value_))
#define cwel_choose_font_set_lpszstyle(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->lpszStyle = (LPTSTR) (_value_))
#define cwel_choose_font_set_nfonttype(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->nFontType = (WORD) (_value_))
#define cwel_choose_font_set_nsizemin(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->nSizeMin = (int) (_value_))
#define cwel_choose_font_set_nsizemax(_ptr_, _value_) (((CHOOSEFONT *) _ptr_)->nSizeMax = (int) (_value_))

#define cwel_choose_font_get_lstructsize(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->lStructSize))
#define cwel_choose_font_get_hwndowner(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->hwndOwner))
#define cwel_choose_font_get_hdc(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->hDC))
#define cwel_choose_font_get_lplogfont(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->lpLogFont))
#define cwel_choose_font_get_ipointsize(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->iPointSize))
#define cwel_choose_font_get_flags(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->Flags))
#define cwel_choose_font_get_rgbcolors(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->rgbColors))
#define cwel_choose_font_get_lcustdata(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->lCustData))
#define cwel_choose_font_get_lpfnhook(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->lpfnHook))
#define cwel_choose_font_get_lptemplatename(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->lpTemplateName))
#define cwel_choose_font_get_hinstance(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->hInstance))
#define cwel_choose_font_get_lpszstyle(_ptr_) ((EIF_POINTER) (((CHOOSEFONT *) _ptr_)->lpszStyle))
#define cwel_choose_font_get_nfonttype(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->nFontType))
#define cwel_choose_font_get_nsizemin(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->nSizeMin))
#define cwel_choose_font_get_nsizemax(_ptr_) ((EIF_INTEGER) (((CHOOSEFONT *) _ptr_)->nSizeMax))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CHOOSEFONT__ */

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
