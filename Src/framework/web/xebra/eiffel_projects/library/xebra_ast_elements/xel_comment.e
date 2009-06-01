note
	description: "[
		{XEL_COMMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_COMMENT

inherit
	XEL_EXPRESSION
		redefine
			serialize
		end

create
	make

feature {NONE} -- Access

feature -- Implementation

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>
		do
			a_buf.indent
			a_buf.put_string ("-- " + expr )
			a_buf.unindent
		end

	expr_for_concatenation: STRING
			-- <Precursor>
		do
			Result := expr
		end

end
