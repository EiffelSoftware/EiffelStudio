class BIN_LE_AS

inherit

	COMPARISON_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			Result := "_infix_le";
		end;

	byte_anchor: BIN_LE_B is
			-- Byte code type
		do
			!!Result
		end;

end
