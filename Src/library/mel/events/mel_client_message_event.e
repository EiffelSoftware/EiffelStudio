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
