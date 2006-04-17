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
