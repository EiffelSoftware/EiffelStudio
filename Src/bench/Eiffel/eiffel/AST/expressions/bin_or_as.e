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

feature -- Properties

	infix_function_name: STRING is "_infix_or"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	bit_balanced: BOOLEAN is True
            -- Is the current binary operation subject to the
            -- balancing rule proper to bit types ?
	
	byte_anchor: BIN_OR_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_OR_AS
