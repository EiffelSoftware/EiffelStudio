indexing
	description: 
		"Implementation of XReparentEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_REPARENT_EVENT

inherit

	MEL_EVENT

creation
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

end -- class MEL_REPARENT_EVENT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
