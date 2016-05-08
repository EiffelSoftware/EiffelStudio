note

	description:

		"Error: Cannot read file"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 1999-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class UT_CANNOT_READ_FILE_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (a_filename: STRING)
			-- Create a new error reporting that file
			-- `a_filename' cannot be opened in read mode.
		require
			a_filename_not_void: a_filename /= Void
		do
			create parameters.make_filled (empty_string, 1, 1)
			parameters.put (a_filename, 1)
		end

feature -- Access

	default_template: STRING = "$0: cannot read '$1'"
			-- Default template used to built the error message

	code: STRING = "UT0003"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = filename

end
