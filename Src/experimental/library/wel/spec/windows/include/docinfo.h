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
