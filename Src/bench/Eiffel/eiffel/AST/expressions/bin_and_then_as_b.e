class BIN_AND_THEN_AS_B

inherit

	BIN_AND_THEN_AS
		rename
			left as old_left,
			right as old_right
		end;

	BINARY_AS_B
		select
			left, right
		end

feature

	byte_anchor: B_AND_THEN_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_AND_THEN_AS_B
