indexing
	description: "AST representation of binary `^' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_POWER_AS

inherit
	ARITHMETIC_AS
		redefine
			balanced
		end

	PREFIX_INFIX_NAMES

feature -- Properties

	balanced: BOOLEAN is False
			-- Is the operation balanced ?

	byte_anchor: BIN_POWER_B is
			-- Byte code type
		do
			!! Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "^"
			-- Name without the infix keyword.

end -- class BIN_POWER_AS
