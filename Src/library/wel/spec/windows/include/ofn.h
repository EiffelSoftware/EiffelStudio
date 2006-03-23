/*
 * OFN.H
 */

#ifndef __WEL_OPENFILENAME__
#define __WEL_OPENFILENAME__

#ifndef __WEL_COMMONDIALOGS__
#	include <cdlg.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_open_file_name_set_lstructsize(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lStructSize = (DWORD) (_value_))
#define cwel_open_file_name_set_hwndowner(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_open_file_name_set_hinstance(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->hInstance = (HINSTANCE) (_value_))
#define cwel_open_file_name_set_lpstrfilter(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrFilter = (LPCTSTR) (_value_))
#define cwel_open_file_name_set_lpstrcustomfilter(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrCustomFilter = (LPTSTR) (_value_))
#define cwel_open_file_name_set_nmaxcustfilter(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nMaxCustFilter = (DWORD) (_value_))
#define cwel_open_file_name_set_nfilterindex(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nFilterIndex = (DWORD) (_value_))
#define cwel_open_file_name_set_lpstrfile(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrFile = (LPTSTR) (_value_))
#define cwel_open_file_name_set_nmaxfile(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nMaxFile = (DWORD) (_value_))
#define cwel_open_file_name_set_lpstrfiletitle(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrFileTitle = (LPTSTR) (_value_))
#define cwel_open_file_name_set_nmaxfiletitle(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nMaxFileTitle = (DWORD) (_value_))
#define cwel_open_file_name_set_lpstrinitialdir(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrInitialDir = (LPCTSTR) (_value_))
#define cwel_open_file_name_set_lpstrtitle(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrTitle = (LPCTSTR) (_value_))
#define cwel_open_file_name_set_flags(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->Flags = (DWORD) (_value_))
// #define cwel_open_file_name_set_nfileoffset(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nFileOffset = (WORD) (_value_))
#define cwel_open_file_name_set_nfileextension(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->nFileExtension = (WORD) (_value_))
#define cwel_open_file_name_set_lpstrdefext(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpstrDefExt = (LPCTSTR) (_value_))
// #define cwel_open_file_name_set_lcustdata(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lCustData = (DWORD) (_value_))
// #define cwel_open_file_name_set_lpfnhook(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpfnHook = (LPOFNHOOKPROC) (_value_))
// #define cwel_open_file_name_set_lptemplatename(_ptr_, _value_) (((OPENFILENAME *) _ptr_)->lpTemplateName = (LPCTSTR) (_value_))

// #define cwel_open_file_name_get_lstructsize(_ptr_) ((((OPENFILENAME *) _ptr_)->lStructSize))
#define cwel_open_file_name_get_hwndowner(_ptr_) ((((OPENFILENAME *) _ptr_)->hwndOwner))
#define cwel_open_file_name_get_hinstance(_ptr_) ((((OPENFILENAME *) _ptr_)->hInstance))
#define cwel_open_file_name_get_lpstrfilter(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrFilter))
#define cwel_open_file_name_get_lpstrcustomfilter(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrCustomFilter))
#define cwel_open_file_name_get_nmaxcustfilter(_ptr_) ((((OPENFILENAME *) _ptr_)->nMaxCustFilter))
#define cwel_open_file_name_get_nfilterindex(_ptr_) ((((OPENFILENAME *) _ptr_)->nFilterIndex))
#define cwel_open_file_name_get_lpstrfile(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrFile))
#define cwel_open_file_name_get_nmaxfile(_ptr_) ((((OPENFILENAME *) _ptr_)->nMaxFile))
#define cwel_open_file_name_get_lpstrfiletitle(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrFileTitle))
#define cwel_open_file_name_get_nmaxfiletitle(_ptr_) ((((OPENFILENAME *) _ptr_)->nMaxFileTitle))
#define cwel_open_file_name_get_lpstrinitialdir(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrInitialDir))
#define cwel_open_file_name_get_lpstrtitle(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrTitle))
#define cwel_open_file_name_get_flags(_ptr_) ((((OPENFILENAME *) _ptr_)->Flags))
#define cwel_open_file_name_get_nfileoffset(_ptr_) ((((OPENFILENAME *) _ptr_)->nFileOffset))
#define cwel_open_file_name_get_nfileextension(_ptr_) ((((OPENFILENAME *) _ptr_)->nFileExtension))
#define cwel_open_file_name_get_lpstrdefext(_ptr_) ((((OPENFILENAME *) _ptr_)->lpstrDefExt))
// #define cwel_open_file_name_get_lcustdata(_ptr_) ((((OPENFILENAME *) _ptr_)->lCustData))
// #define cwel_open_file_name_get_lpfnhook(_ptr_) ((((OPENFILENAME *) _ptr_)->lpfnHook))
// #define cwel_open_file_name_get_lptemplatename(_ptr_) ((((OPENFILENAME *) _ptr_)->lpTemplateName))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_OPENFILENAME__ */

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
