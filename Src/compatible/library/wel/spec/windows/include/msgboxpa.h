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

#ifndef __WEL_MSGBOXPARAMS__
#define __WEL_MSGBOXPARAMS__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern void cwel_msgboxparams_set (LPMSGBOXPARAMS, HWND, HINSTANCE, LPCTSTR, LPCTSTR, DWORD, LPCTSTR, DWORD);

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MSGBOXPARAMS__ */
