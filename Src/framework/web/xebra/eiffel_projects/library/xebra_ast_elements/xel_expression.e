note
	description: "[
		{XEL_EXPRESSION}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XEL_EXPRESSION

inherit
	XEL_SERVLET_ELEMENT

feature -- Initialization

	make (a_expr: STRING)
		require
			a_expr_valid: attached a_expr and then not a_expr.is_empty
		do
			expr := a_expr
		ensure
			expr_attached: attached expr
			expr_set: expr = a_expr
		end

feature -- Access

	expr: STRING
			-- The expression which should be printed

feature -- Implementation

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>
		do
			a_buf.put_string ("response.append (" + expr_for_concatenation + ")")
		end

	is_plain_string: BOOLEAN
			-- Does statement just output strings to the response?
		do
			Result := False
		end

	expr_for_concatenation: STRING
			-- Formatted expression to be added in the append feature of the response
		deferred
		ensure
			result_attached: attached Result
		end

end
