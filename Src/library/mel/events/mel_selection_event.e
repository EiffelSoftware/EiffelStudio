indexing

	description: 
		"Implementation of XSelectionEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	time: INTEGER is
			-- Time when data was stored
		do
			Result := c_event_time (handle)
		end;

	requestor_widget: MEL_WIDGET is
			-- Widget requesting information
		do
			Result := retrieve_widget_from_window (requestor)
		end

	selection: MEL_ATOM is
			-- Name of selection
		do
			!! Result.make_from_existing (c_event_selection (handle))	
		ensure
			result_non_void: Result /= Void
		end;

	target: MEL_ATOM is
			-- Data type of value in `property'
		local
			p: POINTER
		do
			p := c_event_target (handle);
			if p /= Void then
				!! Result.make_from_existing (p)
			end
		end;

	property: MEL_ATOM is
			-- Property where data has been place
		local
			p: POINTER
		do
			p := c_event_property (handle);
			if p /= Void then
				!! Result.make_from_existing (p)
			end
		end;

feature -- Pointer access

	requestor: POINTER is
			-- Window requesting information
		do
			Result := c_event_requestor (handle)
		end;

feature {NONE} -- Implementation

	c_event_requestor (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_INTEGER"
		end;

	c_event_selection (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_target (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_property (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

end -- class MEL_SELECTION_EVENT


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

