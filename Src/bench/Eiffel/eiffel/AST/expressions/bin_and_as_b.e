class BIN_AND_AS_B

inherit

	BIN_AND_AS
		redefine
			left, right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		redefine
			bit_balanced, byte_anchor, left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_AND_B is
			-- Byte code type
		do
			!!Result;
		end;

end -- class BIN_AND_AS_B
