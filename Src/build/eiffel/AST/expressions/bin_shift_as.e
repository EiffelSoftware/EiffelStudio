class BIN_SHIFT_AS

inherit

	BINARY_AS
		redefine
			operator_is_keyword, operator_is_special
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_shift";
		end;

	operator_is_keyword: BOOLEAN is false;

	operator_is_special: BOOLEAN is true;

end
