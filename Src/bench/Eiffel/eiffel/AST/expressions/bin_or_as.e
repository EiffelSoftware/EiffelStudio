indexing
	description: "AST representation of binary `or' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Properties

	byte_anchor: BIN_OR_B is
			-- Byte code type
		do
			create Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "or"
			-- Name without the infix keyword.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_or_as (Current)
		end

end -- class BIN_OR_AS
