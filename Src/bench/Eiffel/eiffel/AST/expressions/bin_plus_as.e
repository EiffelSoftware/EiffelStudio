indexing
	description: "AST representation of binary `+' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_PLUS_AS

inherit
	ARITHMETIC_AS

	PREFIX_INFIX_NAMES
		rename
			plus_infix as infix_function_name
		end

feature -- Properties

	byte_anchor: BIN_PLUS_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_PLUS_AS
