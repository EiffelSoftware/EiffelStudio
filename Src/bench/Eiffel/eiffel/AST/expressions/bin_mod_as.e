indexing
	description: "AST representation of binary `\' operation."
	date: "$Date$"
	revision: "$Revision$"

class BIN_MOD_AS

inherit
	ARITHMETIC_AS

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Properties

	byte_anchor: BIN_MOD_B is
			-- Byte code type
		do
			create Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "\\"
			-- Name without the infix keyword.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_mod_as (Current)
		end

end -- class BIN_MOD_AS
