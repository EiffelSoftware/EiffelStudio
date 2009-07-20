note
	description: "[
		{XEL_OUTPUT_TEXT_EXPRESSION}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_OUTPUT_TEXT_EXPRESSION

inherit
	XEL_EXPRESSION
		redefine
			is_plain_string
		end

create
	make

feature -- Implementation

	expr_for_concatenation: STRING
			-- Formatted expression to be added in the append feature of the response
		do
			Result := "%"" + expr + "%""
		end

	is_plain_string: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end
