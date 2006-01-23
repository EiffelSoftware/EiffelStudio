indexing

	description: 
		"Implementation of XKeyEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_KEY_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	time: INTEGER is
			-- Timestamp in milliseconds
		do
			Result := c_event_time (handle)
		end;

	x: INTEGER is
			-- X positive in window
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER is
			-- Y positive in window
		do
			Result := c_event_y (handle)
		end;

	x_root: INTEGER is
			-- X positive relative to root
		do
			Result := c_event_x_root (handle)
		end;
	y_root: INTEGER is
			-- Y positive relative to root
		do
			Result := c_event_y_root (handle)
		end;

	state: INTEGER is
			-- State of key and buttons
		do
			Result := c_event_state (handle)
		end;

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

	keycode: INTEGER is
			-- Keycode value of key pressed
		do
			Result := c_event_keycode (handle)
		end;

	keysym: INTEGER is
			-- Keysym value of key pressed
		do
			Result := c_event_keysym (handle)
		end;

	string: STRING is
			-- String value of key pressed
		do
			Result := c_event_string (handle)
		end;

feature -- Pointer access

	root: POINTER is
			-- Root window pointer
		do
			Result := c_event_root (handle)
		end;

	subwindow: POINTER is
			-- Pointer is in this child
		do
			Result := c_event_subwindow (handle)
		end;

feature {NONE} -- Implementation

	c_event_root (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_POINTER"
		end;

	c_event_subwindow (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_x_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_y_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_keycode (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_INTEGER"
		end;

	c_event_same_screen (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XKeyEvent *): EIF_BOOLEAN"
		end;

	c_event_string (event_ptr: POINTER): STRING is
		external
			"C"
		end

	c_event_keysym (event_ptr: POINTER): INTEGER is
		external
			"C"
		end

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




end -- class MEL_KEY_EVENT


