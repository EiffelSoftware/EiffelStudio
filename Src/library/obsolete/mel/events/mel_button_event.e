note

	description: 
		"Implementation of XButtonEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BUTTON_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	time: INTEGER
			-- Timestamp in milliseconds
		do
			Result := c_event_time (handle)
		end;

	x: INTEGER
			-- X position in window
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER
			-- Y position in window
		do
			Result := c_event_y (handle)
		end;

	x_root: INTEGER
			-- X position relative to root
		do
			Result := c_event_x_root (handle)
		end;

	y_root: INTEGER
			-- Y position relative to root
		do
			Result := c_event_y_root (handle)
		end;

	state: INTEGER
			-- State of key and buttons
		do
			Result := c_event_state (handle)
		end;

	button: INTEGER
			-- Button that triggered the event 
			-- (Can be compared to Button1, Button2 ...)
		do
			Result := c_event_button (handle)
		end;

	is_button_press: BOOLEAN
			-- Is the event type `ButtonPress'?
		do
			Result := type = ButtonPress
		ensure
			valid_result: Result = not is_button_release
		end;

	is_button_release: BOOLEAN
			-- Is the event type `ButtonRelease'?
		do
			Result := type = ButtonRelease
		ensure
			valid_result: Result = not is_button_press
		end;

	is_button_one: BOOLEAN
			-- Is button 1 involved?
		do
			Result := button = Button1
		end;

	is_button_two: BOOLEAN
			-- Is button 2 involved?
		do
			Result := button = Button2
		end;

	is_button_three: BOOLEAN
			-- Is button 3 involved?
		do
			Result := button = Button3
		end;

	is_button_four: BOOLEAN
			-- Is button 4 involved?
		do
			Result := button = Button4
		end;

	is_button_five: BOOLEAN
			-- Is button 5 involved?
		do
			Result := button = Button5
		end;

	button_number: INTEGER
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

	same_screen: BOOLEAN
			-- Is the pointer is currently on the
			-- same screen as window
		do
			Result := c_event_same_screen (handle)
		end

	subwindow_widget: MEL_WIDGET
			-- Subwindow widget
		do
			Result := retrieve_widget_from_window (subwindow)
		end

feature -- Pointer access

	root: POINTER
			-- Root window 
		do
			Result := c_event_root (handle)
		end;

	subwindow: POINTER
			-- Child window 
		do
			Result := c_event_subwindow (handle)
		end;

feature {NONE} -- Implementation

	c_event_root (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_POINTER"
		end;

	c_event_subwindow (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_x_root (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_y_root (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_button (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_INTEGER"
		end;

	c_event_same_screen (event_ptr: POINTER): BOOLEAN
		external
			"C [macro %"events.h%"] (XButtonEvent *): EIF_BOOLEAN"
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




end -- class MEL_BUTTON_EVENT


