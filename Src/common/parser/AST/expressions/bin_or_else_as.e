indexing

	description: 
		"AST representation of binary `or else' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_OR_ELSE_AS

inherit

	BINARY_AS

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_or_else";
		end;

end -- class BIN_OR_ELSE_AS
