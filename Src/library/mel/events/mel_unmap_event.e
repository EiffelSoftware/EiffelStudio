indexing
	description: 
		"Implementation of XUnmapEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_UNMAP_EVENT

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

	from_configure: BOOLEAN is
			-- Was event generated because of parent's `win_gravity'
			-- was set to `UnmapGravity'
		do
			Result := c_event_from_configure (handle)
		end

feature -- Pointer access

	event: POINTER is
			-- Window that received the event
		do
			Result := c_event_event (event)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XUnmapEvent *): EIF_POINTER"
		end;

	c_event_from_configure (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XUnmapEvent *): EIF_BOOLEAN"
		end;

end -- class MEL_UNMAP_EVENT

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
