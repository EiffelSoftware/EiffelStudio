class BIN_OR_AS_B

inherit

	BIN_OR_AS
		redefine
			left, right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_OR_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_OR_AS_B
