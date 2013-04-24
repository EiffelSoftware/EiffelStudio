/*
indexing
	description: "Functions used by the class WEL_WINDOW_ENUMERATOR."
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

#include "wel_globals.h"

struct TEiffelCallback {
#ifndef EIF_IL_DLL
	EIF_OBJECT pCurrObject;
#endif
	void *fnptr;
};
typedef struct TEiffelCallback EiffelCallback;

/* Callback used by EnumChildWindows. */
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
	return TRUE; /* TRUE => Continue enumeration. */
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

/* Callback used by EnumWindows. */
BOOL CALLBACK EnumWindowsProc(HWND hwnd, LPARAM lparam)
{
	EiffelCallback* pEif_callback;
	pEif_callback = (EiffelCallback*)lparam;

	{
#ifndef EIF_IL_DLL
	EIF_BOOLEAN (*EnumChildWindowsAdd)(EIF_REFERENCE, HWND);

	EnumChildWindowsAdd = (EIF_BOOLEAN (*) (EIF_REFERENCE, HWND)) pEif_callback->fnptr;
	/* Return value from the Eiffel callback to determine whether to continue */
	return EnumChildWindowsAdd(eif_access (pEif_callback->pCurrObject), hwnd);
#else
	EIF_BOOLEAN (__stdcall *EnumChildWindowsAdd)(HWND);

	EnumChildWindowsAdd = (EIF_BOOLEAN (__stdcall *) (HWND)) pEif_callback->fnptr;
	/* Return value from the Eiffel callback to determine whether to continue */
	return EnumChildWindowsAdd(hwnd); 
#endif
	}
}

void cwel_enum_windows_procedure (
#ifndef EIF_IL_DLL
		EIF_OBJECT pCurrObject,
#endif
		void *fnptr)
{
	EiffelCallback eif_callback;
#ifndef EIF_IL_DLL
	eif_callback.pCurrObject = pCurrObject;
#endif
	eif_callback.fnptr = fnptr;

	EnumWindows(&EnumWindowsProc, (LPARAM)&eif_callback);
}
