indexing
	description: "AST representation of binary `and' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_AND_AS

inherit
	BINARY_AS
		redefine
			bit_balanced
		end

feature -- Properties

	infix_function_name: STRING is "_infix_and"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?

end -- class BIN_AND_AS
