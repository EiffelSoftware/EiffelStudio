indexing
	description: "AST representation of binary `xor' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_XOR_AS

inherit
	BINARY_AS
		redefine
			bit_balanced
		end

	PREFIX_INFIX_NAMES
		rename
			xor_infix as infix_function_name
		end

feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to b

	byte_anchor: BIN_XOR_B is
			-- Byte code type
		do
			!!Result
		end

end -- class BIN_XOR_AS
