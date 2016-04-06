/*
indexing
	description: "Functions used by the class WEL_DISPATCHER."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
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
#include "wel.h"

#ifdef _MSC_VER
/* Pragma for automatically linking against Common Controls 6.0 */
#pragma comment(linker,"\"/manifestdependency:type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")
#endif

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

	EIF_DLGPROC wel_stddlgproc = NULL;
	/* Address of the Eiffel routine to use for dispatch. */
	
	EIF_OBJECT dispatcher = NULL;
	/* Address of the Eiffel object WEL_DISPATCHER created for each application */

	EIF_OBJECT stddlg_dispatcher = NULL;
	/* Address of Eiffel object used to interact with `wel_stddlgproc'. */
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
			/* When `dispatcher' is NULL, it means we are called from the `dispose' routine.
			 * We are therefore called within the call to `DestroyWindow'.
			 * If the window is a Windows control we need to call its original window
			 * procedure as `DefWindowProc' will do nothing. This prevents memory leak
			 * because only the original default window procedure knows how to clean itself.
			 */
		WNDPROC l_proc = (WNDPROC) GetClassLongPtr (hwnd, GCLP_WNDPROC);
		if (l_proc && l_proc != cwel_window_procedure) {
			return CallWindowProc (l_proc, hwnd, msg, wparam, lparam);
		} else {
			return DefWindowProc (hwnd, msg, wparam, lparam);
		}
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

UINT_PTR CALLBACK cwel_standard_dialog_procedure (HWND hdlg, UINT msg, WPARAM wparam, LPARAM lparam)
{
	/*
	 * Receive dialog messages for standard dialogs and call the Eiffel routine `wel_stddlgproc'
	 * of the `stddlg_dispatcher' Eiffel object. Since `stddlg_dispatcher' is an adopted
	 * object we need to call `eif_access' to use it. Note that for EIF_IL_DLL mode
	 * we do not need `stddlg_dispatcher'.
	 */

	WGTCX

#ifdef EIF_IL_DLL
	if (wel_stddlgproc){
		return (UINT_PTR) ((wel_stddlgproc)
			((EIF_POINTER) hdlg, (EIF_INTEGER) msg, (EIF_POINTER) wparam, (EIF_POINTER) lparam));
#else
	if ((stddlg_dispatcher) && (wel_stddlgproc)){
		return (UINT_PTR) ((wel_stddlgproc) (
			(EIF_OBJECT) eif_access (stddlg_dispatcher),
			(EIF_POINTER) hdlg, (EIF_INTEGER) msg, (EIF_POINTER) wparam, (EIF_POINTER) lparam));

#endif
	} else {
		return 0;
	}
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

void wel_set_standard_dialog_procedure_address( EIF_POINTER _addr_)
{
	WGTCX
	wel_stddlgproc = (EIF_DLGPROC) _addr_;
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
	if (_addr_) {
		WGTCX
		dispatcher = (EIF_OBJECT) _addr_;
	}
	else {
		/*
		 * Avoid allocating new thread context when it does not exist and _addr_ is 0.
		 * It is possible that the context has been freed when the corresponding thread has been terminated
		 * and the current call is from a dispose routine when allocating a new context is pointless.
		 */
		wel_global_context_t *wel_globals = wel_thr_context_opt ();
		if (wel_globals) {
			dispatcher = (EIF_OBJECT) _addr_;
		}
	}
}

EIF_POINTER wel_dispatcher_pointer()
{
	/*
	 * Avoid allocating new thread context when it does not exist.
	 * It is possible that the context has been freed when the corresponding thread has been terminated
	 * and the current call is from a dispose routine when allocating a new context is pointless.
	 */
	wel_global_context_t *wel_globals = wel_thr_context_opt ();
	if (wel_globals) {
		return (EIF_POINTER) dispatcher;
	}
	else {
		return (EIF_POINTER) 0;
	}
}

void wel_set_stddlg_dispatcher_object(EIF_OBJECT _addr_)
{
	WGTCX
	stddlg_dispatcher = (EIF_OBJECT) eif_adopt (_addr_);	
}

void wel_release_stddlg_dispatcher_object()
{
	WGTCX
	eif_wean (stddlg_dispatcher);
}

#endif
