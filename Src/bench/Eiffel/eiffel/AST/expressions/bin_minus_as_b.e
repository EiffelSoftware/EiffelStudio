class BIN_MINUS_AS_B

inherit

	BIN_MINUS_AS
		redefine
			left, right
		end;

	ARITHMETIC_AS_B
		redefine
			left, right
		end;

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B
	
feature

	byte_anchor: BIN_MINUS_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_MINUS_AS_B
