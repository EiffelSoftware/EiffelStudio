class BIN_GE_AS

inherit

	COMPARISON_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_ge";
		end;

	byte_anchor: BIN_GE_B is
			-- Byte code type
		do
			!!Result
		end;

end
