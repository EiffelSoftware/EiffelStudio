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

