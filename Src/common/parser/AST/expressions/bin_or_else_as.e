class BIN_OR_ELSE_AS

inherit

	BINARY_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_or_else";
		end;

	byte_anchor: B_OR_ELSE_B is
			-- Byte code type
		do
			!!Result
		end; 

end
