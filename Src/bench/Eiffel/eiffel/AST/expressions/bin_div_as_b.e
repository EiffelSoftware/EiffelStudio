class BIN_DIV_AS_B

inherit

	BIN_DIV_AS
		redefine
			left, right 
		end;

	ARITHMETIC_AS_B
		redefine
			numeric_balance, right, left
		select
			numeric_balance
		end;

	ARITHMETIC_AS_B
		rename
			numeric_balance as old_numeric_balance
		redefine
			right, left
		end;

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B;

feature

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

end -- class BIN_DIV_AS_B
