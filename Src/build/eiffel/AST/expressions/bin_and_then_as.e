class BIN_AND_THEN_AS

inherit

	BINARY_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_and_then";
		end;

end
