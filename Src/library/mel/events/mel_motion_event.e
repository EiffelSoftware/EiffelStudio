indexing
	description: 
		"Implementation of XMotionEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MOTION_EVENT

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

	hint: INTEGER is
			-- Hint value
		do
			Result := c_event_is_hint (handle)
		ensure
			value_result: is_notify_normal or else is_notify_hint
		end;

	is_notify_normal: BOOLEAN is
			-- Is `hint' set to NotifyNormal?
		do
			Result := hint = NotifyNormal
		end;

	is_notify_hint: BOOLEAN is
			-- Is `hint' set to NotifyHint?
		do
			Result := hint = NotifyHint
		end;

	state: INTEGER is
			-- State of key and buttons
		do
			Result := c_event_state (handle);
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
			"C [macro %"events.h%"] (XMotionEvent *): EIF_POINTER"
		end;

	c_event_subwindow (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_x_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_y_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_is_hint (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_INTEGER"
		end;

	c_event_same_screen (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XMotionEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_MOTION_EVENT


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

