indexing
	description: 
		"Implementation of XConfigureEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CONFIGURE_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	event_widget: MEL_WIDGET is
			-- Widget that received the event
		do
			Result := retrieve_widget_from_window (event)
		end;

	x: INTEGER is
            -- X position in window
		do
			Result := c_event_x (handle)
		end

	y: INTEGER is
            -- Y position in window
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER is
			-- New width of window
		do
			Result := c_event_width (handle)
		end

	height: INTEGER is
			-- New height of window
		do
			Result := c_event_height (handle)
		end;

	border_width: INTEGER is
			-- New border width of window
		do
			Result := c_event_border_width (handle)
		end;

	above_window_widget: MEL_WIDGET is
			-- Sibling widget
		do
			Result := retrieve_widget_from_window (above_window)
		end;

	override_redirect: BOOLEAN is
			-- Will the window manager not intercept the
			-- configuration request?
		do
			Result := c_event_override_redirect (handle)
		end

feature -- Pointer access

	event: POINTER is
			-- Window that received the event
		do
			Result := c_event_event (handle)
		end;

	above_window: POINTER is
			-- Sibling window
		do
			Result := c_event_above (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_INTEGER"
		end;

	c_event_above (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_POINTER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XConfigureEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_CONFIGURE_EVENT


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

