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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_xor_as (Current)
		end

feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to b

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "xor"
			-- Name without the infix keyword.

end -- class BIN_XOR_AS
