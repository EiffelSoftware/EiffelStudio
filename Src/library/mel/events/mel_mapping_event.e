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
