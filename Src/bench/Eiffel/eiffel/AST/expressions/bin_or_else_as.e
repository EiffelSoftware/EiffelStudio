indexing
	description: "AST representation of binary `or else' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_ELSE_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES
		rename
			or_else_infix as infix_function_name
		end

feature -- Properties


	byte_anchor: B_OR_ELSE_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_OR_ELSE_AS
