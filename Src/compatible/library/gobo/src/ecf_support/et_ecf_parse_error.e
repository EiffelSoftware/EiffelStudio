indexing
	description: "Error: Problem during the parsing of an ecf file."
	author: "Patrick Ruckstuhl <patrick@tario.org>"
	date: "$Date$"
	revision: "$Revision$"

class
	ET_ECF_PARSE_ERROR

inherit
	UT_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_error: STRING) is
			-- Create a new error reporting that error.
		require
			a_error_ok: a_error /= Void and then not a_error.is_empty
		do
			create parameters.make (1, 1)
			parameters.put (a_error, 1)
		end

feature -- Access

	default_template: STRING is "$0: ECF parsing error: '$1'."
			-- Default template used to built the error message

	code: STRING is "ECF0001"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = error

end
