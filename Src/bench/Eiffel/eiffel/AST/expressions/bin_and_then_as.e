indexing
	description: "AST representation of binary `and then' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_AND_THEN_AS

inherit
	BINARY_AS

	PREFIX_INFIX_NAMES

feature -- Properties

	byte_anchor: B_AND_THEN_B is
			-- Byte code type
		do
			!! Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "and then"
			-- Name without the infix keyword.

end -- class BIN_AND_THEN_AS
