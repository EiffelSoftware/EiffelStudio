indexing
	description: "AST representation of binary `implies' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_IMPLIES_AS

inherit
	BINARY_AS
		redefine
			bit_balanced
		end


	PREFIX_INFIX_NAMES
		rename
			implies_infix as infix_function_name
		end

feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?

	byte_anchor: B_IMPLIES_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_IMPLIES_AS
