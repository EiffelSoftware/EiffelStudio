indexing
	description: "Event, to be outputed. Either a message or an error."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_EVENT

create
	make

feature {NONE} -- Initialization

	make (a_message: STRING; a_is_error: BOOLEAN) is
			-- Initialize instance.
		require
			non_void_message: a_message /= Void
		do
			message := a_message
			is_error := a_is_error
		ensure
			message_set: message = a_message
			is_error_set: is_error = a_is_error
		end

feature -- Access

	is_error: BOOLEAN
			-- Is event an error?

	message: STRING
			-- Event message

end -- class TESTER_EVENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------