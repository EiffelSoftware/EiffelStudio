class BIN_LE_AS_B

inherit

	BIN_LE_AS
		rename
			left as old_le_left,
			right as old_le_right
		end;

	COMPARISON_AS_B
		select
			left, right
		end

feature

	byte_anchor: BIN_LE_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_LE_AS_B
