indexing

	description: 
		"AST representation of binary `=' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_EQ_AS

inherit

	BINARY_AS
		redefine
			operator_is_keyword, operator_is_special, 
			operator_name
		end

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
		end; -- infix_function_name

	operator_name: STRING is
		do
			Result := constant_name;
		end;
	
	operator_is_keyword: BOOLEAN is false;
	
	operator_is_special: BOOLEAN is true;
	
feature {NONE}
	
	constant_name: STRING is "_infix_=";

end -- class BIN_EQ_AS
