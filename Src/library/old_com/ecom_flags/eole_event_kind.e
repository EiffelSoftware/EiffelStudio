indexing

	description: "Event Kinds"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class	
	EOLE_EVENT_KIND

feature -- Access

	event, request, notification: INTEGER is unique
			-- Possible event kind

	is_valid_event_kind (kind: INTEGER): BOOLEAN is
			-- Is `kind' a valid event kind?
		do
			Result := kind = event or
						kind = request or
						kind = notification
		end
		
end -- EOLE_EVENT_KIND

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1998. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------