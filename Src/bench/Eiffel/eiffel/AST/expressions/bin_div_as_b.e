class BIN_DIV_AS

inherit

	ARITHMETIC_AS
		redefine
			numeric_balance
		select
			numeric_balance
		end;
	ARITHMETIC_AS
		rename
			numeric_balance as old_numeric_balance
		end;

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_div";
		end;

	numeric_balance (left_type, right_type: TYPE_A): BOOLEAN is
		do
			Result := old_numeric_balance (left_type, right_type) and then
				not (left_type.is_integer and then right_type.is_integer)
		end;

	byte_anchor: BIN_DIV_B is
			-- Byte code type
		do
			!!Result
		end;

end
