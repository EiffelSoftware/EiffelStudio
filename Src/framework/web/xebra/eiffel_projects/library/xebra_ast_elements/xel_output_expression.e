note
	description: "[
		{XEL_OUTPUT_EXPRESSION}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_OUTPUT_EXPRESSION

inherit
	XEL_EXPRESSION

create
	make

feature -- Implementation

	expr_for_concatenation: STRING
			-- <Precursor>
		do
			Result := expr
		end

end
