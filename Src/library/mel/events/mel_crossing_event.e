indexing

	description: 
		"Implementation of XCrossingEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CROSSING_EVENT

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

	state: INTEGER is
			-- State of key and buttons
		do
			Result := c_event_state (handle)
		end;

	mode: INTEGER is
			-- Crossing mode
		do
			Result := c_event_mode (handle)
		ensure
			valid_result: is_notify_normal or else is_notify_grab or else
					is_notify_ungrab
		end;

	is_notify_normal: BOOLEAN is
			-- Is `mode' set to notify_normal?
		do	
			Result := mode = NotifyNormal
		end;

	is_notify_grab: BOOLEAN is
			-- Is `mode' set to notify_grab?
		do	
			Result := mode = NotifyGrab
		end;

	is_notify_ungrab: BOOLEAN is
			-- Is `mode' set to notify_ungrab?
		do	
			Result := mode = NotifyUngrab
		end;

	detail: INTEGER is
			-- Crossing detail
		do
			Result := c_event_detail (handle)
		ensure
			valid_result: is_notify_ancestor or else is_notify_virtual or else
					is_notify_inferior or else is_notify_non_linear or else
					is_notify_non_linear_virtual
		end;

	is_notify_ancestor: BOOLEAN is
			-- Is the `detail' notify_ancestor?
		do
			Result := detail = NotifyAncestor
		end;

	is_notify_virtual: BOOLEAN is
			-- Is the `detail' notify_virtual?
		do
			Result := detail = NotifyVirtual
		end;

	is_notify_inferior: BOOLEAN is
			-- Is the `detail' notify_inferior?
		do
			Result := detail = NotifyInferior
		end;

	is_notify_non_linear: BOOLEAN is
			-- Is the `detail' notify_non_linear?
		do
			Result := detail = NotifyNonlinear
		end;

	is_notify_non_linear_virtual: BOOLEAN is
			-- Is the `detail' notify_non_linear_virtual?
		do
			Result := detail = NotifyNonlinearVirtual
		end;

	same_screen: BOOLEAN is
			-- Is the pointer and `window' in the same screen?
		do
			Result := c_event_same_screen (handle)
		end;

	focus: BOOLEAN is
			-- Is there an input focus on `window'?
		do
			Result := c_event_focus (handle)
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
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_POINTER"
		end;

	c_event_subwindow (event_ptr: POINTER): POINTEr is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_x_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_y_root (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_state (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_mode (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_detail (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_INTEGER"
		end;

	c_event_same_screen (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_BOOLEAN"
		end;

	c_event_focus (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XCrossingEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_CROSSING_EVENT


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

