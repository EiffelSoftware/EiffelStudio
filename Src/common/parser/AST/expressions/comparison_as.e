indexing

	description: 
		"AST representation of binary comparison operation.";
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARISON_AS

inherit

	BINARY_AS
		redefine
			balanced, operator_is_special, operator_is_keyword
		end

feature -- Properties

	balanced: BOOLEAN is
			-- Is the current binary operation subject to the balancing
			-- rule proper to simple numeric types ?
		do
			Result := True;
		end;

	operator_is_special: BOOLEAN is true;
	
	operator_is_keyword: BOOLEAN is false;

end -- class COMPARISON_AS
