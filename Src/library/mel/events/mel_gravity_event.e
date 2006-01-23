indexing

	description: 
		"Implementation of XGravityEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GRAVITY_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

    event_widget: MEL_WIDGET is
            -- Window that received the event
        do
            Result := retrieve_widget_from_window (event)
        end;

    x: INTEGER is
			-- New x position
        do
            Result := c_event_x (handle)
        end;

    y: INTEGER is
			-- New y position
        do
            Result := c_event_y (handle)
        end;

feature -- Pointer access

    event: POINTER is
            -- Window pointer that received the event
        do
            Result := c_event_event (handle)
        end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XGravityEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGravityEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGravityEvent *): EIF_INTEGER"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_GRAVITY_EVENT


