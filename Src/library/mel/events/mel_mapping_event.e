indexing

	description: 
		"Implementation of XMappingEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAPPING_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	count: INTEGER is
			-- Number of keycode changed
		do
			Result := c_event_count (handle)
		end;

	request: INTEGER is
			-- Request value
		do
			Result := c_event_request (handle)
		end;

	first_keycode: INTEGER is
			-- First keycode that was changed
		do
			Result := c_event_first_keycode (handle)
		end;

feature {NONE} -- Implementation

	c_event_count (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMappingEvent *): EIF_INTEGER"
		end;

	c_event_request (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMappingEvent *): EIF_INTEGER"
		end;

	c_event_first_keycode (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XMappingEvent *): EIF_INTEGER"
		end;

end -- class MEL_MAPPING_EVENT


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

