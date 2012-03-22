note

	description: 
		"Implementation of XMapEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAP_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	event_widget: MEL_WIDGET
			-- Window that received the event
		do
			Result := retrieve_widget_from_window (event)
		end;

	override_redirect: BOOLEAN
			-- Will the window manager not intercept the
			-- creation request?
		do
			Result := c_event_override_redirect (handle)
		end

feature -- Pointer access

	event: POINTER
			-- Window pointer that received the event
		do
			Result := c_event_event (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XMapEvent *): EIF_POINTER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN
		external
			"C [macro %"events.h%"] (XMapEvent *): EIF_BOOLEAN"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_MAP_EVENT


