class BIN_MOD_AS_B

inherit

	BIN_MOD_AS
		redefine
			left, right
		end;

	ARITHMETIC_AS_B
		undefine
			balanced
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_MOD_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_MOD_AS_B
