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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_implies_as (Current)
		end

feature -- Properties

	bit_balanced: BOOLEAN is True
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "implies"
			-- Name without the infix keyword.

end -- class BIN_IMPLIES_AS
