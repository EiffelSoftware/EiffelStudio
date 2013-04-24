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

#ifndef __WEL_WINDOWSX__
#define __WEL_WINDOWSX__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifndef _INC_WINDOWSX
#	include <windowsx.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwin_get_wm_vscroll_pos(wparam, lparam) ( \
		(EIF_INTEGER) (SHORT) GET_WM_VSCROLL_POS (wparam, lparam) \
	)

#define cwin_get_wm_hscroll_pos(wparam, lparam) ( \
		(EIF_INTEGER) (SHORT) GET_WM_HSCROLL_POS (wparam, lparam) \
	)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_WINDOWSX__ */

