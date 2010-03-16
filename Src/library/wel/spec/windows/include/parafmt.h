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

#ifndef __WEL_PARAFORMAT__
#define __WEL_PARAFORMAT__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_paraformat_set_cbsize(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_paraformat_set_dwmask(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->dwMask = (DWORD) (_value_))
#define cwel_paraformat_set_wnumbering(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->wNumbering = (WORD) (_value_))
#define cwel_paraformat_set_dxstartindent(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->dxStartIndent = (LONG) (_value_))
#define cwel_paraformat_set_dxrightindent(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->dxRightIndent = (LONG) (_value_))
#define cwel_paraformat_set_dxoffset(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->dxOffset= (LONG) (_value_))
#define cwel_paraformat_set_walignment(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->wAlignment = (WORD) (_value_))
#define cwel_paraformat_set_ctabcount(_ptr_, _value_) (((PARAFORMAT *) _ptr_)->cTabCount = (SHORT) (_value_))
#define cwel_paraformat_set_rgxtabs(_ptr_, _value_, _index_) (((PARAFORMAT *) _ptr_)->rgxTabs[_index_] = (LONG) (_value_))

#define cwel_paraformat_get_dwmask(_ptr_) ((((PARAFORMAT *) _ptr_)->dwMask))
#define cwel_paraformat_get_wnumbering(_ptr_) ((((PARAFORMAT *) _ptr_)->wNumbering))
#define cwel_paraformat_get_dxstartindent(_ptr_) ((((PARAFORMAT *) _ptr_)->dxStartIndent))
#define cwel_paraformat_get_dxrightindent(_ptr_) ((((PARAFORMAT *) _ptr_)->dxRightIndent))
#define cwel_paraformat_get_dxoffset(_ptr_) ((((PARAFORMAT *) _ptr_)->dxOffset))
#define cwel_paraformat_get_walignment(_ptr_) ((((PARAFORMAT *) _ptr_)->wAlignment))
#define cwel_paraformat_get_ctabcount(_ptr_) ((((PARAFORMAT *) _ptr_)->cTabCount))
#define cwel_paraformat_get_rgxtabs(_ptr_,_index_) ((((PARAFORMAT *) _ptr_)->rgxTabs[_index_]))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_PARAFORMAT__ */
