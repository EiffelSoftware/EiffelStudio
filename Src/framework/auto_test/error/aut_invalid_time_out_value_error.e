indexing

	description:

		"Error: Invalid time-out value"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_INVALID_TIME_OUT_VALUE_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (a_value: STRING) is
			-- Create a new error reporting that parameter
			-- `a_value' is not a valid time-out value.
		require
			a_value: a_value /= Void
		do
			create parameters.make (1, 1)
			parameters.put (a_value, 1)
		end

feature -- Access

	default_template: STRING is "$0: '$1' is not a valid time-out value. Only integers are allowed (they represent minutes)."
			-- Default template used to built the error message

	code: STRING is "AUT0001"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = value

end
