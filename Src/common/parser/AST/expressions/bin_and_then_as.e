indexing
	description: "AST representation of binary `and then' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_AND_THEN_AS

inherit
	BINARY_AS

feature -- Properties

	infix_function_name: STRING is "_infix_and_then"
			-- Internal name of the infixed feature associated to the
			-- binary expression

end -- class BIN_AND_THEN_AS
