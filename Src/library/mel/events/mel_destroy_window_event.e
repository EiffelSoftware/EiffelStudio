indexing

	description: 
		"Implementation of XDestroyWindowEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DESTROY_WINDOW_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Pointer access

	event_widget: MEL_WIDGET is
			-- Widget that received the event
		do
			Result := retrieve_widget_from_window (event_window)
		end;

feature -- Pointer access

	event_window: POINTER is
			-- Window that received the event
		do
			Result := c_event_event (handle)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XDestroyWindowEvent *): EIF_INTEGER"
		end

end -- class MEL_DESTROY_WINDOW_EVENT

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
