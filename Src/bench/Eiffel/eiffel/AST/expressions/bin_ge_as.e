indexing
	description: "AST representation of binary `>=' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_GE_AS

inherit
	COMPARISON_AS

	PREFIX_INFIX_NAMES
		rename
			ge_infix as infix_function_name
		end

feature -- Properties

	byte_anchor: BIN_GE_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_GE_AS
