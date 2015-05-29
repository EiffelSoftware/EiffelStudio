note
	description: "Representation of a function definition."
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_AST

inherit
	AST

create
	make

feature {NONE} -- Initialization

	make (a_prototype: PROTOTYPE_EXPR_AST; a_body: ARRAYED_LIST [EXPR_AST])
			-- Initialize current with prototype `a_prototype' and body `a_body'.
		do
			-- Left non-implemented in Chapter 1.
		end

end
