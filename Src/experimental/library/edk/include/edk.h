/*
indexing
description: "EDK: Eiffel Drawing Kit"
	copyright:	"Copyright (c) 1984-2007, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __EDK__
#define __EDK__

#ifndef STRICT
#	define STRICT
#endif

#include "eif_eiffel.h"

#ifdef _WIN32
#define WIN_LEAN_AND_MEAN
#define VC_EXTRALEAN
#include <windows.h>

#ifndef EIF_IL_DLL
typedef EIF_POINTER (* EVENT_CALLBACK) (
		EIF_REFERENCE,     /* CALLBACK_MARSHAL Eiffel object */
#else
typedef EIF_POINTER (__stdcall* EVENT_CALLBACK) (
#endif
	 EIF_POINTER, /* hwnd */
	 EIF_NATURAL, /* message */
	 EIF_POINTER, /* wparam */
	 EIF_POINTER  /* lparam */
	 );
/* Eiffel routine signature for standard Window callback */

typedef EIF_POINTER (__stdcall* INTERMEDIARY_EVENT_CALLBACK) (
	EIF_POINTER,
	EIF_NATURAL,
	EIF_POINTER,
	EIF_POINTER
	);

#endif



#ifdef __cplusplus
extern "C" {
#endif


EIF_OBJECT callback_marshal;
	// CALLBACK_MARSHAL Eiffel Object

EVENT_CALLBACK event_callback;
	// Eiffel Function pointer for event callback

EIF_POINTER intermediary_event_callback (EIF_POINTER window_handle, EIF_NATURAL message_type, EIF_POINTER message_parameter1, EIF_POINTER message_parameter2);
	// C Function pointer for event callback



#ifdef __cplusplus
}
#endif

#endif /* __EDK__ */

