class BIN_PLUS_AS_B

inherit

	BIN_PLUS_AS
		redefine
			left, right
		end;

	ARITHMETIC_AS_B
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_PLUS_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_PLUS_AS_B
