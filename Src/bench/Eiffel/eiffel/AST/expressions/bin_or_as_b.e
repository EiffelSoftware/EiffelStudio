class BIN_OR_AS_B

inherit

	BIN_OR_AS
		rename
			left as old_or_left,
			right as old_or_right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		select
			left, right
		end

feature

	byte_anchor: BIN_OR_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_OR_AS_B
