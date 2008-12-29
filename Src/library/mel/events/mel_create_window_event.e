note

	description: 
		"Implementation of XCreateWindowEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CREATE_WINDOW_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	parent_widget: MEL_WIDGET
			-- Parent widget of `window_widget'
		do
			Result := retrieve_widget_from_window (parent)
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

	width: INTEGER
			-- Width of window
		do
			Result := c_event_width (handle)
		end

	height: INTEGER
			-- Height of window
		do
			Result := c_event_height (handle)
		end;

	border_width: INTEGER
			-- Border width of window
		do
			Result := c_event_border_width (handle)
		end;

	override_redirect: BOOLEAN
			-- Will the window manager not intercept the
			-- creation request?
		do
			Result := c_event_override_redirect (handle)
		end

feature -- Pointer access

	parent: POINTER
		do
			Result := c_event_parent (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_border_width (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_INTEGER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN
		external
			"C [macro %"events.h%"] (XCreateWindowEvent *): EIF_BOOLEAN"
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




end -- class MEL_CREATE_WINDOW_EVENT


