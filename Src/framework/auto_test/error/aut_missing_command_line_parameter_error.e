indexing

	description:

		"Error: Missing command line parameter"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_MISSING_COMMAND_LINE_PARAMETER_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (a_parameter_name: STRING) is
			-- Create a new error reporting that parameter
			-- `a_parameter_name' has not been provided.
		require
			a_parameter_name_not_void: a_parameter_name /= Void
		do
			create parameters.make (1, 1)
			parameters.put (a_parameter_name, 1)
		end

feature -- Access

	default_template: STRING is "$0: You must specify '$1'"
			-- Default template used to built the error message

	code: STRING is "GERL0001"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = parameter name

end
