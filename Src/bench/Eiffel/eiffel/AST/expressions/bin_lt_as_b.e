class BIN_LT_AS_B

inherit

	BIN_LT_AS
		rename
			left as old_lt_left,
			right as old_lt_right
		end;

	COMPARISON_AS_B
		select
			left, right
		end

feature

	byte_anchor: BIN_LT_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_LT_AS_B
