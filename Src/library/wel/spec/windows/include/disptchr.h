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

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

#ifndef __WEL_DISPATCHER__
#define __WEL_DISPATCHER__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

EIF_REFERENCE generize (EIF_OBJECT g_item);

#ifndef EIF_IL_DLL
typedef EIF_INTEGER (* EIF_WNDPROC) (
	EIF_OBJECT,     /* WEL_DISPATCHER Eiffel object */
#else
typedef EIF_INTEGER (__stdcall* EIF_WNDPROC) (
#endif
	 EIF_POINTER, /* hwnd */
	 EIF_INTEGER, /* message */
	 EIF_POINTER, /* wparam */
	 EIF_POINTER  /* lparam */
	 );
/* Eiffel routine signature for `window_procedure' */

#ifndef EIF_IL_DLL
typedef EIF_INTEGER (* EIF_DLGPROC) (
	EIF_OBJECT,     /* WEL_DISPATCHER Eiffel object */
#else
typedef EIF_INTEGER (__stdcall* EIF_DLGPROC) (
#endif
	 EIF_POINTER, /* hwnd */
	 EIF_INTEGER, /* message */
	 EIF_POINTER, /* wparam */
	 EIF_POINTER  /* lparam */
	 );
/* Eiffel routine signature for `dialog_procedure' */

LRESULT CALLBACK cwel_window_procedure (HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK cwel_dialog_procedure (HWND, UINT, WPARAM, LPARAM);
UINT_PTR CALLBACK cwel_standard_dialog_procedure (HWND, UINT, WPARAM, LPARAM);

#define cwel_window_procedure_address ((EIF_POINTER) cwel_window_procedure)
/* Address of `cwel_window_procedure' */

#define cwel_dialog_procedure_address ((EIF_POINTER) cwel_dialog_procedure)
/* Address of `cwel_dialog_procedure' */

#ifdef EIF_THREADS
	extern void wel_set_window_procedure_address( EIF_POINTER );
#	define cwel_set_window_procedure_address(_addr_) wel_set_window_procedure_address(_addr_)
		/* Set `wel_wndproc' with `addr' */

	extern void wel_set_dialog_procedure_address( EIF_POINTER );
#	define cwel_set_dialog_procedure_address(_addr_) wel_set_dialog_procedure_address(_addr_) 
		/* Set `wel_dlgproc' with `addr' */

	extern void wel_set_standard_dialog_procedure_address( EIF_POINTER );
#	define cwel_set_standard_dialog_procedure_address(_addr_) wel_set_standard_dialog_procedure_address(_addr_) 
		/* Set `wel_stddlgproc' with `addr' */


	extern void wel_set_dispatcher_object(EIF_OBJECT _addr_);
#	define cwel_set_dispatcher_object(_addr_) wel_set_dispatcher_object(_addr_) 
		/* Set `dispatcher' with `eif_adopt (addr)' */

	extern void wel_release_dispatcher_object();
#	define cwel_release_dispatcher_object wel_release_dispatcher_object()  
		/* Release `dispatcher' object. */

	extern void wel_set_dispatcher_pointer (EIF_POINTER);
#	define cwel_set_dispatcher_pointer(_addr_) wel_set_dispatcher_pointer (_addr_)
		/* Set `dispatcher' with `addr'. */

	extern EIF_POINTER wel_dispatcher_pointer ();
#	define cwel_dispatcher_pointer wel_dispatcher_pointer()
		/* Get `dispatcher' address. */

	extern void wel_set_stddlg_dispatcher_object(EIF_OBJECT _addr_);
#	define cwel_set_stddlg_dispatcher_object(_addr_) wel_set_stddlg_dispatcher_object(_addr_) 
		/* Set `stddlg_dispatcher' with `eif_adopt (addr)' */

	extern void wel_release_stddlg_dispatcher_object();
#	define cwel_release_stddlg_dispatcher_object wel_release_stddlg_dispatcher_object()  
		/* Release `stddlg_dispatcher' object. */


#else

#	define cwel_set_window_procedure_address(_addr_) (wel_wndproc = (EIF_WNDPROC) _addr_) 
		/* Set `wel_wndproc' with `addr' */
#	define cwel_set_dialog_procedure_address(_addr_) (wel_dlgproc = (EIF_DLGPROC) _addr_)
		/* Set `wel_dlgproc' with `addr' */
#	define cwel_set_standard_dialog_procedure_address(_addr_) (wel_stddlgproc = (EIF_DLGPROC) _addr_)
		/* Set `wel_stddlgproc' with `addr' */
#	define cwel_set_dispatcher_object(_addr_) (dispatcher = (EIF_OBJECT) eif_adopt (_addr_))
		/* Set `dispatcher' with `eif_adopt (addr)' */
#	define cwel_release_dispatcher_object (eif_wean (dispatcher)) 
		/* Release `dispatcher' object. */
#	define cwel_set_dispatcher_pointer(_addr_) (dispatcher = (EIF_OBJECT) (_addr_))
		/* Set `dispatcher' with `addr'. */
#	define cwel_dispatcher_pointer ((EIF_POINTER) dispatcher)
		/* Get `dispatcher' address. */
#	define cwel_set_stddlg_dispatcher_object(_addr_) (stddlg_dispatcher = (EIF_OBJECT) eif_adopt (_addr_))
		/* Set `stddlg_dispatcher' with `eif_adopt (addr)' */
#	define cwel_release_stddlg_dispatcher_object (eif_wean (stddlg_dispatcher)) 
		/* Release `stddlg_dispatcher' object. */
#endif

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DISPATCHER__ */
