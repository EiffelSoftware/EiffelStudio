note
	description: "Representation of expression nodes referencing a variable, like `x'."
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE_EXPR_AST

inherit
	EXPR_AST

create
	make

feature {NONE} -- Initialization

	make (a_var: READABLE_STRING_8)
			-- Initialize Current with `a_var' as `name'.
		require
			a_var_not_empty: not a_var.is_empty
		do
			name := a_var
		ensure
			name_set: name.same_string (a_var)
		end

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name of variable represented by current node.

invariant
	name_not_empty: not name.is_empty

end
