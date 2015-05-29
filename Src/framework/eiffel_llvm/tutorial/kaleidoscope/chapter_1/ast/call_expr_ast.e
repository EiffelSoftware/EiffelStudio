note
	description: "Representation of expression nodes referencing a function call."
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_EXPR_AST

inherit
	EXPR_AST

create
	make

feature {NONE} -- Initialization

	make (a_callee: READABLE_STRING_8; a_args: ARRAYED_LIST [EXPR_AST])
			-- Initialize Current with a function `a_callee' with arguments `a_args'.
		require
			a_callee_not_empty: not a_callee.is_empty
		do
			callee := a_callee
			arguments := a_args
		ensure
			callee_set: callee.same_string (a_callee)
			arguments_set: arguments = a_args
		end

feature -- Access

	callee: IMMUTABLE_STRING_8
			-- Name of function.

	arguments: ARRAYED_LIST [EXPR_AST]
			-- Arguments if any.

invariant
	callee_not_empty: not callee.is_empty
	
end
