indexing

	description: 
		"Implementation of XClientMessageEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CLIENT_MESSAGE_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	message_type: MEL_ATOM is
			-- Atom for Message type
		do
			!! Result.make_from_existing (c_event_message_type (handle))
		ensure
			result_not_void: Result /= Void
		end

	format: INTEGER is
			-- Data format
		do
			Result := c_event_format (handle)
		end

feature -- Pointer Access

	data: POINTER is
			-- Data field pointing to C union
		do
			Result := c_event_data (handle)
		end

feature {NONE} -- Implementation

	c_event_message_type (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XClientMessageEvent *): EIF_POINTER"
		end;

	c_event_format (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XClientMessageEvent *): EIF_INTEGER"
		end;

	c_event_data (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XClientMessageEvent *): EIF_POINTER"
		end;

end -- class MEL_CLIENT_MESSAGE_EVENT


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

