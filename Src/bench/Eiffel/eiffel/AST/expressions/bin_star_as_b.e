class BIN_STAR_AS_B

inherit

	BIN_STAR_AS
		rename
			left as old_star_left,
			right as old_star_right
		end;

	ARITHMETIC_AS_B
		select 
			left, right
		end

feature

	byte_anchor: BIN_STAR_B is
			-- Byte code type
		do
			!!Result
		end;

end -- class BIN_STAR_AS_B
