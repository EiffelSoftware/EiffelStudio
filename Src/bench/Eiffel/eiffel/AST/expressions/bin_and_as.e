indexing
	description: "AST representation of binary `and' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_AND_AS

inherit
	BINARY_AS
		redefine
			bit_balanced, byte_anchor
		end

	PREFIX_INFIX_NAMES
		rename
			and_infix as infix_function_name
		end


feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?

	byte_anchor: BIN_AND_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_AND_AS
