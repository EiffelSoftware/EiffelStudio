indexing
	description: "AST representation of binary `and' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_AND_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Properties

	byte_anchor: BIN_AND_B is
			-- Byte code type
		do
			create Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "and"
			-- Name without the infix keyword.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_and_as (Current)
		end

end -- class BIN_AND_AS
