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

#ifndef __WEL_MSGFILTER__
#define __WEL_MSGFILTER__

#include "redit.h"

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_msg_filter_get_msg(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->msg))
#define cwel_msg_filter_get_wparam(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->wParam))
#define cwel_msg_filter_get_lparam(_ptr_) ((EIF_INTEGER)(((MSGFILTER *) _ptr_)->lParam))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MSGFILTER__ */
