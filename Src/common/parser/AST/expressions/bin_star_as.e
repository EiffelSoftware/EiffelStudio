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

end -- class BIN_STAR_AS
