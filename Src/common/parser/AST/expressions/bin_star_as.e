class BIN_STAR_AS

inherit

	ARITHMETIC_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_star";
		end;

	byte_anchor: BIN_STAR_B is
			-- Byte code type
		do
			!!Result
		end;

end
