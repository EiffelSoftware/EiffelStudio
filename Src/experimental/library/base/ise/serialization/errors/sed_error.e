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

	make_with_string (a_string: STRING)
			-- Create `Current' and set `error' to `a_string'.
		do
			error := a_string
		ensure
			error_set: error = a_string
		end

feature -- Access

	error: STRING;

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
