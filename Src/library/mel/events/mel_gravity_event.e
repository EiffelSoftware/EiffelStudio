indexing

	description: 
		"Implementation of XGravityEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GRAVITY_EVENT

inherit

	MEL_EVENT

creation
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

end -- class MEL_GRAVITY_EVENT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

