class BIN_MOD_AS_B

inherit

	BIN_MOD_AS
		rename
			left as old_mod_left,
			right as old_mod_right
		end;

	ARITHMETIC_AS_B
		undefine
			balanced
		select
			left, right
		end

feature

	byte_anchor: BIN_MOD_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_MOD_AS_B
