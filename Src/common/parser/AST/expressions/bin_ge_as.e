indexing
	description: "AST representation of binary `>=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_GE_AS

inherit
	COMPARISON_AS

	PREFIX_INFIX_NAMES

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_ge_as (Current)
		end

feature -- Properties

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is ">="
			-- Name without the infix keyword.

end -- class BIN_GE_AS
