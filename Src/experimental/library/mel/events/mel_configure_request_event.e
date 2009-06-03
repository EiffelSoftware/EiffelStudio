note
	description: 
		"Implementation of XConfigureRequestEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CONFIGURE_REQUEST_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	parent_widget: MEL_WIDGET
			-- Parent widget of `window'
		do
			Result := retrieve_widget_from_window (parent)
		end;

	x: INTEGER
			-- X position in window
		do
			Result := c_event_x (handle)
		end

	y: INTEGER
			-- Y position in window
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER
			-- New widget of window
		do
			Result := c_event_width (handle)
		end

	height: INTEGER
			-- New height of window
		do
			Result := c_event_height (handle)
		end;

	border_width: INTEGER
			-- New border width of window
		do
			Result := c_event_border_width (handle)
		end;

	above_window_widget: MEL_WIDGET
			-- Sibling widget
		do
			Result := retrieve_widget_from_window (above_window)
		end;

	detail: INTEGER
			-- Detail value
		do
			Result := c_event_detail (handle)
		ensure
			valid_result: is_opposite or else is_above or else
				is_bottom_if or else is_top_if
		end;

	is_opposite: BOOLEAN
			-- Is the `default' set to opposite?
		do
			Result := detail = Opposite 
		end;

	is_above: BOOLEAN
			-- Is the `default' set to above?
		do
			Result := detail = Above 
		end;

	is_bottom_if: BOOLEAN
			-- Is the `default' set to bottom_if?
		do
			Result := detail = BottomIf 
		end;

	is_top_if: BOOLEAN
			-- Is the `default' set to top_if?
		do
			Result := detail = TopIf 
		end;

	value_mask: INTEGER
			-- Type of changes
		do
			Result := c_event_value_mask (handle)
		end;

feature -- Pointer access

	parent: POINTER
			-- Parent window of `window'
		do
			Result := c_event_parent (handle)
		end;

	above_window: POINTER
			-- Sibling widget
		do
			Result := c_event_above (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_above (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_POINTER"
		end;

	c_event_detail (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
		end;

	c_event_value_mask (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XConfigureRequestEvent *): EIF_INTEGER"
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




end -- class MEL_CONFIGURE_REQUEST_EVENT


