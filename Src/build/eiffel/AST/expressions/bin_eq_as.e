class BIN_EQ_AS

inherit

	BINARY_AS
		redefine
			operator_is_keyword, operator_is_special, 
			operator_name
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
		end; -- infix_function_name

feature -- Type check, byte code and dead code removal

	operator_name: STRING is
		do
			Result := constant_name;
		end;
	
	operator_is_keyword: BOOLEAN is false;
	
	operator_is_special: BOOLEAN is true;
	
feature {}
	
	constant_name: STRING is "_infix_=";

end
