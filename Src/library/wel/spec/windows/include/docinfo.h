/*
 * DOCINFO.H
 */

#ifndef __WEL_DOCINFO__
#define __WEL_DOCINFO__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_doc_info_set_cbsize(_ptr_, _value_) (((DOCINFO *) _ptr_)->cbSize = (int) (_value_))
#define cwel_doc_info_set_lpszdocname(_ptr_, _value_) (((DOCINFO *) _ptr_)->lpszDocName = (LPTSTR) (_value_))
#define cwel_doc_info_set_lpszoutput(_ptr_, _value_) (((DOCINFO *) _ptr_)->lpszOutput = (LPTSTR) (_value_))

#define cwel_doc_info_get_lpszdocname(_ptr_) ((((DOCINFO *) _ptr_)->lpszDocName))
#define cwel_doc_info_get_lpszoutput(_ptr_) ((((DOCINFO *) _ptr_)->lpszOutput))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DOCINFO__ */

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
