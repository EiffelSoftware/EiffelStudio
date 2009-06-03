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

#ifndef __WEL__
#define __WEL__

#ifndef STRICT
#	define STRICT
#endif

#ifdef _WIN32
#	ifndef WIN32
#		define WIN32
#	endif
#endif

#include <windows.h>
#include <commctrl.h>

#include "eif_eiffel.h"
#include "wel_lang.h"

#ifdef __cplusplus
extern "C" {
#endif

#if !defined (_WIN64) && !defined(GetWindowLongPtr)
	/* Special handling of LONG_PTR, GetWindowLongPtr, SetWindowLongPtr
	 * when compiled on a platform where the SDK header is not up to date. */

#if defined(SetWindowLongPtr) || defined(SetClassLongPtr)
	It should not be defined!!
#endif

	/* 1 - We define the type and functions. */
#ifndef LONG_PTR
#define LONG_PTR LONG
#endif
#ifndef ULONG_PTR
#define ULONG_PTR ULONG
#endif
#ifndef DWORD_PTR
#define DWORD_PTR DWORD
#endif
#ifndef PDWORD_PTR
#define PDWORD_PTR LPDWORD
#endif
#define GetWindowLongPtr GetWindowLong
#define SetWindowLongPtr SetWindowLong
#define SetClassLongPtr SetClassLong
#define GetClassLongPtr GetClassLong

	/* 2 - We define the constant values for windows. */
#ifndef GWLP_WNDPROC
#define GWLP_WNDPROC        (-4)
#endif
#ifndef GWLP_HINSTANCE
#define GWLP_HINSTANCE      (-6)
#endif
#ifndef GWLP_HWNDPARENT
#define GWLP_HWNDPARENT     (-8)
#endif
#ifndef GWLP_USERDATA
#define GWLP_USERDATA       (-21)
#endif
#ifndef GWLP_ID
#define GWLP_ID             (-12)
#endif
#ifndef GCLP_WNDPROC
#define GCLP_WNDPROC        (-24)
#endif

	/* 3 - We define the constant values for dialogs. */
#ifndef DWLP_MSGRESULT
#define DWLP_MSGRESULT  0
#endif
#ifndef DWLP_DLGPROC
#define DWLP_DLGPROC    DWLP_MSGRESULT + sizeof(LRESULT)
#endif
#ifndef DWLP_USER
#define DWLP_USER       DWLP_DLGPROC + sizeof(DLGPROC)
#endif


#endif

#define cwel_pointer_to_integer(_ptr_) ((EIF_INTEGER) _ptr_)
#define cwel_integer_to_pointer(_int_) ((EIF_POINTER) _int_)

#define cwel_temp_dialog_value (0x01)

#define cwel_menu_item_not_found 0xFFFFFFFF


#ifndef BIF_EDITBOX
#define BIF_EDITBOX				0x0010
#endif

#ifndef BIF_VALIDATE
#define BIF_VALIDATE			0x0020
#endif

#ifdef __cplusplus
}
#endif

#endif /* __WEL__ */
