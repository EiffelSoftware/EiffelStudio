/*
 * DISPATCH.H
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

typedef EIF_INTEGER (* EIF_WNDPROC)
	(EIF_OBJ,     /* WEL_DISPATCHER Eiffel object */
	 EIF_POINTER, /* hwnd */
	 EIF_INTEGER, /* message */
	 EIF_INTEGER, /* wparam */
	 EIF_INTEGER  /* lparam */
	 );
/* Eiffel routine signature for `window_procedure' */

typedef EIF_INTEGER (* EIF_DLGPROC)
	(EIF_OBJ,     /* WEL_DISPATCHER Eiffel object */
	 EIF_POINTER, /* hwnd */
	 EIF_INTEGER, /* message */
	 EIF_INTEGER, /* wparam */
	 EIF_INTEGER  /* lparam */
	 );
/* Eiffel routine signature for `dialog_procedure' */

LRESULT CALLBACK cwel_window_procedure (HWND, UINT, WPARAM, LPARAM);
BOOL CALLBACK cwel_dialog_procedure (HWND, UINT, WPARAM, LPARAM);

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

	extern void wel_set_dispatcher_object(EIF_OBJ _addr_);
#	define cwel_set_dispatcher_object(_addr_) wel_set_dispatcher_object(_addr_) 
		/* Set `dispather' with `eif_adopt (addr)' */

	extern void wel_release_dispatcher_object();
#	define cwel_release_dispatcher_object wel_release_dispatcher_object()  
		/* Release `dispatcher' object. */

	extern void wel_set_dispatcher_pointer (EIF_POINTER);
#	define cwel_set_dispatcher_pointer(_addr_) wel_set_dispatcher_pointer (_addr_)
		/* Set `dispatcher' with `addr'. */

	extern EIF_POINTER wel_dispatcher_pointer ();
#	define cwel_dispatcher_pointer wel_dispatcher_pointer()
		/* Get `dispatcher' address. */

#else

#	define cwel_set_window_procedure_address(_addr_) (wel_wndproc = (EIF_WNDPROC) _addr_) 
		/* Set `wel_wndproc' with `addr' */
#	define cwel_set_dialog_procedure_address(_addr_) (wel_dlgproc = (EIF_DLGPROC) _addr_)
		/* Set `wel_dlgproc' with `addr' */
#	define cwel_set_dispatcher_object(_addr_) (dispatcher = (EIF_OBJ) eif_adopt (_addr_))
		/* Set `dispather' with `eif_adopt (addr)' */
#	define cwel_release_dispatcher_object (eif_wean (dispatcher)) 
		/* Release `dispatcher' object. */
#	define cwel_set_dispatcher_pointer(_addr_) (dispatcher = (_addr_))
		/* Set `dispatcher' with `addr'. */
#	define cwel_dispatcher_pointer ((EIF_POINTER) dispatcher)
		/* Get `dispatcher' address. */

#endif

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DISPATCHER__ */

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
