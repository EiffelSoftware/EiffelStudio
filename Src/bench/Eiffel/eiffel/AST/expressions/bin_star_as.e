indexing
	description: "AST representation of binary `*' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_STAR_AS

inherit
	ARITHMETIC_AS

feature -- Properties

	infix_function_name: STRING is "_infix_star"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	byte_anchor: BIN_STAR_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_STAR_AS
