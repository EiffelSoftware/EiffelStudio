class BIN_DIV_AS

inherit

	ARITHMETIC_AS
		redefine
			balanced
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_div";
		end;

	balanced: BOOLEAN is
			-- Is the operation balanced ?
		do
			-- Do nothing
		end;

	byte_anchor: BIN_DIV_B is
			-- Byte code type
		do
			!!Result
		end;

end
