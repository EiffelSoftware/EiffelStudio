class BIN_GE_AS_B

inherit

	BIN_GE_AS
		rename
			left as old_ge_left,
			right as old_ge_right
		end;

	COMPARISON_AS_B
		select
			left, right
		end

feature

	byte_anchor: BIN_GE_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_GE_AS_B
