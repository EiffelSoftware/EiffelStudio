indexing
	description: "AST representation of binary `or' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_AS

inherit
	BINARY_AS
		redefine
			bit_balanced
		end

	PREFIX_INFIX_NAMES
		rename
			or_infix as infix_function_name
		end

feature -- Properties

	bit_balanced: BOOLEAN is True
            -- Is the current binary operation subject to the
            -- balancing rule proper to bit types ?
	
	byte_anchor: BIN_OR_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_OR_AS
