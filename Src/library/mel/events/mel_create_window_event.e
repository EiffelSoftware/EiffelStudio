indexing

	description: 
		"Implementation of XCreateWindowEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CREATE_WINDOW_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	parent_widget: MEL_WIDGET is
			-- Parent widget of `window_widget'
		do
			Result := retrieve_widget_from_window (parent)
		end;

	x: INTEGER is
			-- X position in window
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER is
			-- Y position in window
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER is
			-- Width of window
		do
			Result := c_event_width (handle)
		end

	height: INTEGER is
			-- Height of window
		do
			Result := c_event_height (handle)
		end;

	border_width: INTEGER is
			-- Border width of window
		do
			Result := c_event_border_width (handle)
		end;

	override_redirect: BOOLEAN is
			-- Will the window manager not intercept the
			-- creation request?
		do
			Result := c_event_override_redirect (handle)
		end

feature -- Pointer access

	parent: POINTER is
		do
			Result := c_event_parent (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_CREATE_WINDOW_EVENT

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

