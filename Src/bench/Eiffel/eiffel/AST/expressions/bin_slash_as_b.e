class BIN_SLASH_AS_B

inherit

	BIN_SLASH_AS
		rename
			left as old_slash_left,
			right as old_slash_right
		end;

	ARITHMETIC_AS_B
		redefine
			numeric_balance
		select
			numeric_balance, left, right
		end;

	ARITHMETIC_AS_B
		rename
			numeric_balance as old_numeric_balance
		end;

feature

	numeric_balance (left_type, right_type: TYPE_A): BOOLEAN is
		do
			Result := old_numeric_balance (left_type, right_type) and then
				not (left_type.is_integer and then right_type.is_integer)
		end;

	byte_anchor: BIN_SLASH_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_SLASH_AS_B
