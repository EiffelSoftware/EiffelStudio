class BIN_GE_AS_B

inherit

	BIN_GE_AS
		redefine
			left, right
		end;

	COMPARISON_AS_B
		redefine
			left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_GE_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_GE_AS_B
