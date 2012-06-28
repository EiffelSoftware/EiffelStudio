indexing

	description:

		"Error: The use of variable trailing context is %
		%incompatible with full tables"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new error reporting that the use
			-- of variable trailing context is incompatible
			-- with full tables.
		do
			create parameters.make (1, 0)
		end

feature -- Access

	default_template: STRING is "$0: variable trailing context rules cannot be used with -f"
			-- Default template used to built the error message

	code: STRING is "LX0029"
			-- Error code

invariant

--	dollar0: $0 = program name

end
