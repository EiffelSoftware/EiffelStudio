/*
 * Enum_child_windows.c
 *
 * Functions used by the class xxxx.
 *
 */

#include "wel_globals.h"

struct TEiffelCallback {
#ifndef EIF_IL_DLL
	EIF_OBJECT pCurrObject;
#endif
	void *fnptr;
};
typedef struct TEiffelCallback EiffelCallback;


BOOL CALLBACK EnumChildProc(HWND hwnd, LPARAM lparam)
{
	EiffelCallback* pEif_callback;
	pEif_callback = (EiffelCallback*)lparam;

	{
#ifndef EIF_IL_DLL
	void (*EnumChildWindowsAdd)(EIF_REFERENCE, HWND);

	EnumChildWindowsAdd = (void (*) (EIF_REFERENCE, HWND)) pEif_callback->fnptr;
	EnumChildWindowsAdd(eif_access (pEif_callback->pCurrObject), hwnd);
#else
	void (__stdcall *EnumChildWindowsAdd)(HWND);

	EnumChildWindowsAdd = (void (__stdcall *) (HWND)) pEif_callback->fnptr;
	EnumChildWindowsAdd(hwnd);
#endif
	}
	return TRUE; // TRUE => Continue enumeration.
}

void cwel_enum_child_windows_procedure (
#ifndef EIF_IL_DLL
		EIF_OBJECT pCurrObject,
#endif
		void *fnptr,
		HWND hWndParent)
{
	EiffelCallback eif_callback;
#ifndef EIF_IL_DLL
	eif_callback.pCurrObject = pCurrObject;
#endif
	eif_callback.fnptr = fnptr;

	EnumChildWindows(hWndParent, &EnumChildProc, (LPARAM)&eif_callback);
}

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
