indexing
	description: "AST representation of binary `\' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_MOD_AS

inherit
	ARITHMETIC_AS
		redefine
			balanced
		end

feature -- Properties

	infix_function_name: STRING is "_infix_mod"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	balanced: BOOLEAN is False
			-- Is the bianry operation balanced ?

end -- class BIN_MOD_AS
