class BIN_LT_AS

inherit

	COMPARISON_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_lt";
		end;

	byte_anchor: BIN_LT_B is
			-- Byte code type
		do
			!!Result
		end;

end
