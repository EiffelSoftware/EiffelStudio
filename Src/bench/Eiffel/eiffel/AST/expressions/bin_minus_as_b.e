class BIN_MINUS_AS

inherit

	ARITHMETIC_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			Result := "_infix_minus";
		end;

	byte_anchor: BIN_MINUS_B is
			-- Byte code type
		do
			!!Result
		end;

end
