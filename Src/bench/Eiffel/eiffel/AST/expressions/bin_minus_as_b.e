class BIN_MINUS_AS_B

inherit

	BIN_MINUS_AS
		rename
			left as old_minus_left,
			right as old_minus_right
		end;

	ARITHMETIC_AS_B
		select
			left, right
		end;

feature

	byte_anchor: BIN_MINUS_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_MINUS_AS_B
