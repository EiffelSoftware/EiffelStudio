class BIN_AND_THEN_AS_B

inherit

	BIN_AND_THEN_AS
		redefine
			left, right
		end;

	BINARY_AS_B
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: B_AND_THEN_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_AND_THEN_AS_B
