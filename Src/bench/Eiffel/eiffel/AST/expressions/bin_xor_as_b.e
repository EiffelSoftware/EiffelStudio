class BIN_XOR_AS_B

inherit

	BIN_XOR_AS
		rename
			left as old_xor_left,
			right as old_xor_right
		end;

	BINARY_AS_B
		undefine
			bit_balanced
		select
			left, right
		end

feature

	byte_anchor: BIN_XOR_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_XOR_AS_B
