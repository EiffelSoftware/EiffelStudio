class BIN_IMPLIES_AS_B

inherit

	BIN_IMPLIES_AS
		rename
			left as old_implies_left,
			right as old_implies_right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		select
			left, right
		end

feature

	byte_anchor: B_IMPLIES_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_IMPLIES_AS_B
