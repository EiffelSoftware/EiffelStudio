indexing
	description: "AST representation of binary `or else' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_OR_ELSE_AS

inherit
	BINARY_AS

feature -- Properties

	infix_function_name: STRING is "_infix_or_else"
			-- Internal name of the infixed feature associated to the
			-- binary expression

end -- class BIN_OR_ELSE_AS
