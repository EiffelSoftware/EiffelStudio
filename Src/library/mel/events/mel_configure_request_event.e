indexing
	description: 
		"Implementation of XConfigureRequestEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CONFIGURE_REQUEST_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	parent_widget: MEL_WIDGET is
			-- Parent widget of `window'
		do
			Result := retrieve_widget_from_window (parent)
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
			-- New widget of window
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

	detail: INTEGER is
			-- Detail value
		do
			Result := c_event_detail (handle)
		ensure
			valid_result: is_opposite or else is_above or else
				is_bottom_if or else is_top_if
		end;

	is_opposite: BOOLEAN is
			-- Is the `default' set to opposite?
		do
			Result := detail = Opposite 
		end;

	is_above: BOOLEAN is
			-- Is the `default' set to above?
		do
			Result := detail = Above 
		end;

	is_bottom_if: BOOLEAN is
			-- Is the `default' set to bottom_if?
		do
			Result := detail = BottomIf 
		end;

	is_top_if: BOOLEAN is
			-- Is the `default' set to top_if?
		do
			Result := detail = TopIf 
		end;

	value_mask: INTEGER is
			-- Type of changes
		do
			Result := c_event_value_mask (handle)
		end;

feature -- Pointer access

	parent: POINTER is
			-- Parent window of `window'
		do
			Result := c_event_parent (handle)
		end;

	above_window: POINTER is
			-- Sibling widget
		do
			Result := c_event_above (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_above (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_POINTER"
		end;

	c_event_detail (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_value_mask (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

end -- class MEL_CONFIGURE_REQUEST_EVENT

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

