indexing

	description: 
		"AST representation of binary `\' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_MOD_AS

inherit

	ARITHMETIC_AS
		redefine
			balanced
		end

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_mod";
		end;

	balanced: BOOLEAN is
			-- Is the bianry operation balanced ?
		do
			-- Do nothing
		end;

end -- class BIN_MOD_AS
