class BIN_AND_AS_B

inherit

	BIN_AND_AS
		rename
			left as old_left,
			right as old_right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		redefine
			bit_balanced, byte_anchor
		select
			left, right
		end

feature

	byte_anchor: BIN_AND_B is
			-- Byte code type
		do
			!!Result;
		end;

end -- class BIN_AND_AS_B
