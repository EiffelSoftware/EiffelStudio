indexing
	description: "AST representation of binary `<=' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_LE_AS

inherit
	COMPARISON_AS

feature -- Properties

	infix_function_name: STRING is "_infix_le"
			-- Internal name of the infixed feature associated to the
			-- binary expression

end -- class BIN_LE_AS
