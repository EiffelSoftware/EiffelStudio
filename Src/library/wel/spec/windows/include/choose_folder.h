/*
 * BIF.H
 */

#ifndef __WEL_BROWSEINFO__
#define __WEL_BROWSEINFO__

#ifndef __SHLOBJ__
#define __SHLOBJ__
#include <shlobj.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

// Callback for the function SHBrowseForFolder (defined in ..\Clib\choose_folder.c)
int CALLBACK cwel_browse_callback_proc(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData);

#define cwel_browse_info_set_hwndowner(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_browse_info_set_pidlroot (_ptr_, _value_) (((BROWSEINFO *) _ptr_)->pidlRoot = (LPCITEMIDLIST) (_value_))
#define cwel_browse_info_set_pszdisplayname(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->pszDisplayName = (LPSTR) (_value_))
#define cwel_browse_info_set_lpsztitle(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->lpszTitle = (LPCSTR) (_value_))
#define cwel_browse_info_set_ulflags(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->ulFlags = (UINT) (_value_))
#define cwel_browse_info_set_lpfn(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->lpfn = (BFFCALLBACK) (_value_))
#define cwel_browse_info_set_lparam(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->lParam = (LPARAM) (_value_))
#define cwel_browse_info_set_iimage(_ptr_, _value_) (((BROWSEINFO *) _ptr_)->iImage = (int) (_value_))

#define cwel_browse_info_get_hwndowner(_ptr_) ((((BROWSEINFO *) _ptr_)->hwndOwner))
#define cwel_browse_info_get_pidlroot(_ptr_) ((((BROWSEINFO *) _ptr_)->pidlRoot))
#define cwel_browse_info_get_pszdisplayname(_ptr_) ((((BROWSEINFO *) _ptr_)->pszDisplayName))
#define cwel_browse_info_get_lpszTitle(_ptr_) ((((BROWSEINFO *) _ptr_)->lpszTitle))
#define cwel_browse_info_get_ulflags(_ptr_) ((((BROWSEINFO *) _ptr_)->ulFlags))
#define cwel_browse_info_get_lpfn(_ptr_) ((((BROWSEINFO *) _ptr_)->lpfn))
#define cwel_browse_info_get_lparam(_ptr_) ((((BROWSEINFO *) _ptr_)->lParam))
#define cwel_browse_info_get_iimage(_ptr_) ((((BROWSEINFO *) _ptr_)->iImage))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_BROWSEINFO__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1999, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
