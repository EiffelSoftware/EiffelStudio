/*
 * Enum_child_windows.c
 *
 * Functions used by the class xxxx.
 *
 */

#include "wel_globals.h"

struct TEiffelCallback
	{
	void *pCurrObject;
	void *fnptr;
	};
typedef struct TEiffelCallback EiffelCallback;


BOOL CALLBACK EnumChildProc(HWND hwnd, LPARAM lparam)
	{
	EiffelCallback* pEif_callback;
	void (*EnumChildWindowsAdd)(void*, HWND);

	pEif_callback = (EiffelCallback*)lparam;
	EnumChildWindowsAdd = (void (*) (void*, HWND)) pEif_callback->fnptr;
	EnumChildWindowsAdd(pEif_callback->pCurrObject, hwnd);
	return TRUE; // TRUE => Continue enumeration.
	}

void cwel_enum_child_windows_procedure (void *pCurrObject, void *fnptr, HWND hWndParent)
	{
	EiffelCallback eif_callback;
	eif_callback.pCurrObject = pCurrObject;
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
