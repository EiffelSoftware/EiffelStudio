indexing

	description: 
		"Implementation of XButtonEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BUTTON_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	time: INTEGER is
			-- Timestamp in milliseconds
		do
			Result := c_event_time (handle)
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

	x_root: INTEGER is
			-- X position relative to root
		do
			Result := c_event_x_root (handle)
		end;

	y_root: INTEGER is
			-- Y position relative to root
		do
			Result := c_event_y_root (handle)
		end;

	state: INTEGER is
			-- State of key and buttons
		do
			Result := c_event_state (handle)
		end;

	button: INTEGER is
			-- Button that triggered the event 
			-- (Can be compared to Button1, Button2 ...)
		do
			Result := c_event_button (handle)
		end;

	is_button_press: BOOLEAN is
			-- Is the event type `ButtonPress'?
		do
			Result := type = ButtonPress
		ensure
			valid_result: Result = not is_button_release
		end;

	is_button_release: BOOLEAN is
			-- Is the event type `ButtonRelease'?
		do
			Result := type = ButtonRelease
		ensure
			valid_result: Result = not is_button_press
		end;

	is_button_one: BOOLEAN is
			-- Is button 1 involved?
		do
			Result := button = Button1
		end;

	is_button_two: BOOLEAN is
			-- Is button 2 involved?
		do
			Result := button = Button2
		end;

	is_button_three: BOOLEAN is
			-- Is button 3 involved?
		do
			Result := button = Button3
		end;

	is_button_four: BOOLEAN is
			-- Is button 4 involved?
		do
			Result := button = Button4
		end;

	is_button_five: BOOLEAN is
			-- Is button 5 involved?
		do
			Result := button = Button5
		end;

	button_number: INTEGER is
			-- Button number 
		do
			if is_button_one then	
				Result := 1
			elseif is_button_two then	
				Result := 2
			elseif is_button_three then	
				Result := 3
			elseif is_button_four then	
				Result := 4
			elseif is_button_five then	
				Result := 5
			end
		ensure
			in_range: Result >= 1 and then Result <= 5
		end

	same_screen: BOOLEAN is
			-- Is the pointer is currently on the
			-- same screen as window
		do
			Result := c_event_same_screen (handle)
		end

	subwindow_widget: MEL_WIDGET is
			-- Subwindow widget
		do
			Result := retrieve_widget_from_window (subwindow)
		end

feature -- Pointer access

	root: POINTER is
			-- Root window 
		do
			Result := c_event_root (handle)
		end;

	subwindow: POINTER is
			-- Child window 
		do
			Result := c_event_subwindow (handle)
		end;

feature {NONE} -- Implementation

	c_event_root (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_POINTER"
		end;

	c_event_subwindow (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_x_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_y_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_button (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_same_screen (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_BUTTON_EVENT


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

