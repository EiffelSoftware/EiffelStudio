indexing
	description: "AST representation of binary division operation.";
	date: "$Date$";
	revision: "$Revision$"

class
	BIN_DIV_AS

inherit
	ARITHMETIC_AS
		redefine
			numeric_balance
		end

feature -- Properties

	infix_function_name: STRING is "_infix_div"
			-- Internal name of the infixed feature associated to the
			-- binary expression

	numeric_balance (left_type, right_type: TYPE_A): BOOLEAN is
		do
			Result := {ARITHMETIC_AS} Precursor (left_type, right_type) and then
				not (left_type.is_integer and then right_type.is_integer)
		end

	byte_anchor: BIN_DIV_B is
			-- Byte code type
		do
			!! Result
		end

end -- class BIN_DIV_AS
