class BIN_IMPLIES_AS_B

inherit

	BIN_IMPLIES_AS
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

	byte_anchor: B_IMPLIES_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_IMPLIES_AS_B
