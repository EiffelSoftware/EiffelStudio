indexing

	description: 
		"AST representation of binary `and then' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_AND_THEN_AS

inherit

	BINARY_AS

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_and_then";
		end;

end -- class BIN_AND_THEN_AS
