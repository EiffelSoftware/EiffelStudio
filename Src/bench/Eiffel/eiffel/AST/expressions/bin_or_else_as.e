indexing
	description: "AST representation of binary `or else' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_ELSE_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

feature -- Properties


	byte_anchor: B_OR_ELSE_B is
			-- Byte code type
		do
			!! Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "or else"
			-- Name without the infix keyword.

end -- class BIN_OR_ELSE_AS
