class BIN_POWER_AS_B

inherit

	BIN_POWER_AS
		rename
			left as old_power_left,
			right as old_power_right
		end;

	ARITHMETIC_AS_B
		undefine
			balanced
		redefine
			balanced
		select
			left, right
		end

feature

	byte_anchor: BIN_POWER_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_POWER_AS_B
