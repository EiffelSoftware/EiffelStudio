class BIN_POWER_AS_B

inherit

	BIN_POWER_AS
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

	byte_anchor: BIN_POWER_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_POWER_AS_B
