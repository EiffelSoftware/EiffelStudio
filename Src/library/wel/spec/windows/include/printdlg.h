/*
 * PRINTDLG.H
 */

#ifndef __WEL_PRINTDLG__
#define __WEL_PRINTDLG__

#ifndef __WEL_COMMONDIALOGS__
#	include <cdlg.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_print_dlg_set_lstructsize(_ptr_, _value_) (((PRINTDLG *) _ptr_)->lStructSize = (DWORD) (_value_))
#define cwel_print_dlg_set_hwndowner(_ptr_, _value_) (((PRINTDLG *) _ptr_)->hwndOwner = (HWND) (_value_))
#define cwel_print_dlg_set_flags(_ptr_, _value_) (((PRINTDLG *) _ptr_)->Flags = (DWORD) (_value_))
#define cwel_print_dlg_set_nfrompage(_ptr_, _value_) (((PRINTDLG *) _ptr_)->nFromPage = (WORD) (_value_))
#define cwel_print_dlg_set_ntopage(_ptr_, _value_) (((PRINTDLG *) _ptr_)->nToPage = (WORD) (_value_))
#define cwel_print_dlg_set_nminpage(_ptr_, _value_) (((PRINTDLG *) _ptr_)->nMinPage = (WORD) (_value_))
#define cwel_print_dlg_set_nmaxpage(_ptr_, _value_) (((PRINTDLG *) _ptr_)->nMaxPage = (WORD) (_value_))
#define cwel_print_dlg_set_ncopies(_ptr_, _value_) (((PRINTDLG *) _ptr_)->nCopies = (WORD) (_value_))

#define cwel_print_dlg_get_flags(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->Flags))
#define cwel_print_dlg_get_nfrompage(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->nFromPage))
#define cwel_print_dlg_get_ntopage(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->nToPage))
#define cwel_print_dlg_get_nminpage(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->nMinPage))
#define cwel_print_dlg_get_nmaxpage(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->nMaxPage))
#define cwel_print_dlg_get_ncopies(_ptr_) ((EIF_INTEGER) (((PRINTDLG *) _ptr_)->nCopies))
#define cwel_print_dlg_get_hdc(_ptr_) ((EIF_POINTER) (((PRINTDLG *) _ptr_)->hDC))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_PRINTDLG__ */

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
