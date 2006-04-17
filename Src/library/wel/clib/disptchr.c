/*
indexing
	description: "Functions used by the class WEL_DISPATCHER."
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

/*
 * WEL has only 2 C-functions:
 * `cwel_window_procedure' receives messages from windows and
 * `cwel_dialog_procedure' receives messages from dialog boxes.
 * These 2 functions call the routines `window_procedure' and
 * `dialog_procedure' respectively from the Eiffel class WEL_DISPATCHER.
 * -- PK.
 */

#include "wel_globals.h"

/* Temporary external used to get around genericity problem in Vision2. */
EIF_REFERENCE generize (EIF_OBJECT g_item)
{
	return eif_access (g_item);
}

#ifdef EIF_IL_DLL
rt_public int debug_mode = 0;	/* Assume not in debug mode */
#endif

#ifndef EIF_THREADS
	EIF_WNDPROC wel_wndproc = NULL;
	/* Address of the Eiffel routine `window_procedure' (class WEL_DISPATCHER) */
	
	EIF_DLGPROC wel_dlgproc = NULL;
	/* Address of the Eiffel routine `dialog_procedure' (class WEL_DISPATCHER) */
	
	EIF_OBJECT dispatcher = NULL;
	/* Address of the Eiffel object WEL_DISPATCHER created for each application */
#endif

LRESULT CALLBACK cwel_window_procedure (HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	/*
	 * Receive window messages and call the Eiffel routine `window_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */
	WGTCX

	if (dispatcher) {
		return (LRESULT) ((wel_wndproc) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (dispatcher),
#endif
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_POINTER) wparam,
			(EIF_POINTER) lparam));
	} else {
		return DefWindowProc (hwnd, msg, wparam, lparam);
	}
}

INT_PTR CALLBACK cwel_dialog_procedure (HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	/*
	 * Receive dialog messages and call the Eiffel routine `dialog_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */

	WGTCX

	if (dispatcher) {
		INT_PTR dialog_result;

		dialog_result = (INT_PTR) ((wel_dlgproc) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (dispatcher),
#endif
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_POINTER) wparam,
			(EIF_POINTER) lparam));

		switch (msg) {
			case WM_CHARTOITEM:
			case WM_COMPAREITEM:
			case WM_CTLCOLORBTN:
			case WM_CTLCOLORDLG:
			case WM_CTLCOLOREDIT:
			case WM_CTLCOLORLISTBOX:
			case WM_CTLCOLORMSGBOX:
			case WM_CTLCOLORSCROLLBAR:
			case WM_CTLCOLORSTATIC:
			case WM_VKEYTOITEM:
			case WM_QUERYDRAGICON:
					return (BOOL) dialog_result;
			default:
				if (dialog_result != 0) {
						/* Set the result given by WEL to the dialog */
					dialog_result = SetWindowLongPtr (hwnd, DWLP_MSGRESULT, (LONG_PTR) dialog_result);
					return (dialog_result != 0);
				} else
					return FALSE;
		}
	} else
		return FALSE;
}

#ifdef EIF_THREADS
void wel_set_window_procedure_address( EIF_POINTER _addr_)
{
	WGTCX
	wel_wndproc = (EIF_WNDPROC) _addr_ 	;
}

void wel_set_dialog_procedure_address( EIF_POINTER _addr_)
{
	WGTCX
	wel_dlgproc = (EIF_DLGPROC) _addr_;
}

void wel_set_dispatcher_object(EIF_OBJECT _addr_)
{
	WGTCX
	dispatcher = (EIF_OBJECT) eif_adopt (_addr_);	
}

void wel_release_dispatcher_object()
{
	WGTCX
	eif_wean (dispatcher);
}

void wel_set_dispatcher_pointer(EIF_POINTER _addr_)
{
	WGTCX
	dispatcher = (EIF_OBJECT) _addr_;	
}

EIF_POINTER wel_dispatcher_pointer()
{
	WGTCX
	return (EIF_POINTER) dispatcher;
}

#endif
