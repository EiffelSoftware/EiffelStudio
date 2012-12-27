note
	description: "Simple representation of a SED error"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julian Rogers"
	last_editor: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_ERROR

create {SED_ERROR_FACTORY}
	make_with_string

feature {NONE} -- Initialization

	make_with_string (a_string: READABLE_STRING_GENERAL)
			-- Create `Current' and set `error' to `a_string'.
		do
			message := a_string.as_string_32
		ensure
			error_set: message.same_string_general (a_string)
		end

feature -- Access

	error: STRING
			-- Error
		obsolete
			"Use `message' instead."
		do
			Result := message.as_string_8
		end

	message: STRING_32;
			-- Message of the error.

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
