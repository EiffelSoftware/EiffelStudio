indexing
	description: "AST representation of binary `=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_EQ_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_eq_as (Current)
		end

feature -- Properties

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is
			-- Name without the infix keyword.
		once
			Result := "="
		end

end -- class BIN_EQ_AS
