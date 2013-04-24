/*
indexing
	description: "C features of EDK: Eiffel Drawing Kit"
	date: "$Date$"
	revision: "$Revision$"
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



#include <edk.h>

EIF_OBJECT callback_marshal;
	// Callback Marshal object for all toolkit interaction.

EVENT_CALLBACK event_callback;
	// Callback function pointer for handling events.

EIF_POINTER intermediary_event_callback (EIF_POINTER window_handle, EIF_NATURAL message_type, EIF_POINTER message_parameter1, EIF_POINTER message_parameter2)
{
	return (EIF_POINTER) ((event_callback) (
#ifndef EIF_IL_DLL
	eif_access (callback_marshal),
#endif
		(EIF_POINTER) window_handle,
		(EIF_NATURAL) message_type,
		(EIF_POINTER) message_parameter1,
		(EIF_POINTER) message_parameter2
	)
	);

}

