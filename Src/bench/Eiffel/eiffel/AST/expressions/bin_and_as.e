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

feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?

	byte_anchor: BIN_AND_B is
			-- Byte code type
		do
			!! Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "and"
			-- Name without the infix keyword.

end -- class BIN_AND_AS
