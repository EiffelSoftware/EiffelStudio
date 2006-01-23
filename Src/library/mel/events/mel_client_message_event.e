indexing

	description: 
		"Implementation of XClientMessageEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CLIENT_MESSAGE_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	message_type: MEL_ATOM is
			-- Atom for Message type
		do
			create Result.make_from_existing (c_event_message_type (handle))
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_CLIENT_MESSAGE_EVENT


