class BIN_NE_AS_B

inherit

	BIN_NE_AS
		redefine
			left, right
		end;

	BIN_EQ_AS_B
		undefine
			operator_name, infix_function_name
		redefine
			byte_anchor, left, right
		end

feature -- Properties

	left: EXPR_AS_B;

	right: EXPR_AS_B

feature

	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			!BIN_NE_B! Result
		end;

end -- class BIN_NE_AS_B
