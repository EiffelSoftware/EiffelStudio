indexing

	description: 
		"AST representation of binary division operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_DIV_AS

inherit

	ARITHMETIC_AS

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_div";
		end;

end -- class BIN_DIV_AS
