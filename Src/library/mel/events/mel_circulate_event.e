note

	description: 
		"Implementation of XCirculateEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CIRCULATE_EVENT

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

	is_place_on_top: BOOLEAN
			-- Is the window place on top?
		do
			Result := c_event_place (handle) = PlaceOnTop
		ensure
			valid_result: Result = not is_place_on_bottom
		end;

	is_place_on_bottom: BOOLEAN
			-- Is the window place on the bottom?
		do
			Result := c_event_place (handle) = PlaceOnBottom
		ensure
			valid_result: Result = not is_place_on_top
		end;

feature -- Pointer access

	event: POINTER
			-- Window pointer that received the event
		do
			Result := c_event_event (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XCirculateEvent *): EIF_POINTER"
		end;

	c_event_place (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCirculateEvent *): EIF_INTEGER"
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




end -- class MEL_CIRCULATE_EVENT


