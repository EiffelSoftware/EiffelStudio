note
	description: "Representation of expression nodes referencing the prototype for a function which captures its name%
		%, and its formal argument names (thus implicitly the number of arguments the function takes)."
	date: "$Date$"
	revision: "$Revision$"

class
	PROTOTYPE_EXPR_AST

inherit
	EXPR_AST

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; a_args: ARRAYED_LIST [EXPR_AST])
			-- Initialize Current with a function `a_name' with arguments `a_args'.
		require
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name
			arguments := a_args
		ensure
			name_set: name.same_string (a_name)
			arguments_set: arguments = a_args
		end

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name of function.

	arguments: ARRAYED_LIST [EXPR_AST]
			-- Arguments if any.

invariant
	name_not_empty: not name.is_empty

end
