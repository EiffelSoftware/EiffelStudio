class BIN_OR_ELSE_AS_B

inherit

	BIN_OR_ELSE_AS
		rename
			left as old_or_else_left,
			right as old_or_else_right
		end;

	BINARY_AS_B
		select
			left, right
		end

feature

	byte_anchor: B_OR_ELSE_B is
			-- Byte code type
		do
			!!Result
		end; 

end -- class BIN_OR_ELSE_AS_B
