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

end -- class BIN_LE_AS
