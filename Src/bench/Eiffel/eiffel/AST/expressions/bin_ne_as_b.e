class BIN_NE_AS_B

inherit

	BIN_NE_AS
		rename
			left as old_ne_left,
			right as old_ne_right
		end;

	BIN_EQ_AS_B
		undefine
			operator_name
		redefine
			byte_anchor
		select
			left, right
		end

feature

	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			!BIN_NE_B! Result
		end;

end -- class BIN_NE_AS_B
