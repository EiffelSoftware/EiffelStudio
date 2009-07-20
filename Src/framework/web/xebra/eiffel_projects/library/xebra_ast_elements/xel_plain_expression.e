note
	description: "[
		{XEL_PLAIN_EXPRESSION}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_PLAIN_EXPRESSION

inherit
	XEL_EXPRESSION
		redefine
			serialize
		end

create
	make

feature -- Implementation

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>
		do
			a_buf.put_string (expr)
		end

	expr_for_concatenation: STRING
			-- <Precursor>
		do
			Result := expr
		end

end
