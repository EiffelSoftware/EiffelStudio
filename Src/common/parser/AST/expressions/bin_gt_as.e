class BIN_GT_AS

inherit

	COMPARISON_AS

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_gt";
		end;

end -- class BIN_GT_AS
