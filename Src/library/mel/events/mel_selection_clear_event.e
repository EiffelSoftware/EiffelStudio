indexing

	description: 
		"Implementation of XSelectionClearEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_CLEAR_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	time: INTEGER is
			-- Time when ownership was lost
		do
			Result := c_event_time (handle)
		end;

	selection: MEL_ATOM is
			-- Name of selection
		do
			!! Result.make_from_existing (c_event_selection (handle))
		ensure
			result_non_void: Result /= Void
		end;

feature {NONE} -- Implementation

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XSelectionClearEvent *): EIF_INTEGER"
		end;

	c_event_selection (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionClearEvent *): EIF_POINTER"
		end;

end -- class MEL_SELECTION_CLEAR_EVENT


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

