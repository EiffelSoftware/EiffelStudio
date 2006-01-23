indexing
	description: 
		"Implementation of XReparentEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_REPARENT_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	event_widget: MEL_WIDGET is
			-- Window that received the event
		do
			Result := retrieve_widget_from_window (event)
		end;

	parent_widget: MEL_WIDGET is
			-- New parent of `window'
		do
			Result := retrieve_widget_from_window (parent)
		end;

	x: INTEGER is
			-- X position in new parent
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER is
			-- Y position in new parent
		do
			Result := c_event_y (handle)
		end;

	override_redirect: BOOLEAN is
			-- Will the window manager not intercept the
			-- reparenting request
		do
			Result := c_event_override_redirect (handle)
		end;

feature -- Pointer access

	parent: POINTER is
		do
			Result := c_event_parent (handle)
		end;

	event: POINTER is
			-- Window pointer that received the event
		do
			Result := c_event_event (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XReparentEvent *): EIF_POINTER"
		end;

	c_event_parent (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XReparentEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XReparentEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XReparentEvent *): EIF_INTEGER"
		end;

	c_event_override_redirect (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XReparentEvent *): EIF_BOOLEAN"
		end;

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




end -- class MEL_REPARENT_EVENT


