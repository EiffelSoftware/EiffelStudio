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
