/*
 * DISPTCHR.C
 *
 * Dispatcher functions used by the class WEL_DISPATCHER.
 *
 */

/*
 * WEL has only 2 C-functions:
 * `cwel_window_procedure' receives messages from windows and
 * `cwel_dialog_procedure' receives messages from dialog boxes.
 * These 2 functions call the routines `window_procedure' and
 * `dialog_procedure' respectively from the Eiffel class WEL_DISPATCHER.
 * -- PK.
 */

#ifndef __WEL_DISPATCHER__
#	include <disptchr.h>
#endif

EIF_WNDPROC wel_wndproc = NULL;
/* Address of the Eiffel routine `window_procedure' (class WEL_DISPATCHER) */

EIF_DLGPROC wel_dlgproc = NULL;
/* Address of the Eiffel routine `dialog_procedure' (class WEL_DISPATCHER) */

EIF_OBJ dispatcher = NULL;
/* Address of the Eiffel object WEL_DISPATCHER created for each application */

LRESULT CALLBACK cwel_window_procedure (hwnd, msg, wparam, lparam)
HWND hwnd;
UINT msg;
WPARAM wparam;
LPARAM lparam;
{
	/*
	 * Receive window messages and call the Eiffel routine `window_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */

	if (dispatcher)
		return (LRESULT) ((wel_wndproc) (
			(EIF_OBJ) eif_access (dispatcher),
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_INTEGER) wparam,
			(EIF_INTEGER) lparam));
	else
		return DefWindowProc (hwnd, msg, wparam, lparam);
}

BOOL CALLBACK cwel_dialog_procedure (hwnd, msg, wparam, lparam)
HWND hwnd;
UINT msg;
WPARAM wparam;
LPARAM lparam;
{
	/*
	 * Receive dialog messages and call the Eiffel routine `dialog_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */

	if (dispatcher)
		return (BOOL) ((wel_dlgproc) (
			(EIF_OBJ) eif_access (dispatcher),
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_INTEGER) wparam,
			(EIF_INTEGER) lparam));
	else
		return FALSE;
}

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
