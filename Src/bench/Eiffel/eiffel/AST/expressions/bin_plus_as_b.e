class BIN_PLUS_AS_B

inherit

	BIN_PLUS_AS
		rename
			left as old_plus_left,
			right as old_plus_right
		end;

	ARITHMETIC_AS_B
		select
			left, right
		end

feature

	byte_anchor: BIN_PLUS_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_PLUS_AS_B
