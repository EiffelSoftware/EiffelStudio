indexing
	description: "AST representation of binary `>=' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_GE_AS

inherit
	COMPARISON_AS

feature -- Properties

	infix_function_name: STRING is "_infix_ge"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	byte_anchor: BIN_GE_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_GE_AS
