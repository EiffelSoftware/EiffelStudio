indexing
	description: "AST representation of binary `/=' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_NE_AS

inherit
	BIN_EQ_AS
		redefine
			infix_function_name
		end

feature -- Properties

	infix_function_name: STRING is "_infix_/="
			-- Internal name of the infixed feature associated to the
			-- binary expression

end -- class BIN_NE_AS
