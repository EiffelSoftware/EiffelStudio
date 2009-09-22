note
	description: "Simple representation of a SED error"
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

	error: STRING

end
