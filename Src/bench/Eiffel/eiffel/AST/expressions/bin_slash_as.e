indexing
	description: "AST representation of binary `//' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_SLASH_AS

inherit
	ARITHMETIC_AS
		redefine
			numeric_balance
		end

	PREFIX_INFIX_NAMES

feature -- Properties

	numeric_balance (left_type, right_type: TYPE_A): BOOLEAN is
		do
			Result := {ARITHMETIC_AS} Precursor (left_type, right_type) and then
				not (left_type.is_integer and then right_type.is_integer)
		end

	byte_anchor: BIN_SLASH_B is
			-- Byte code type
		do
			!! Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "/"
			-- Name without the infix keyword.

end -- class BIN_SLASH_AS
