indexing

	description: 
		"AST representation of binary `/=' operation.";
	date: "$Date$";
	revision: "$Revision $"

class BIN_NE_AS

inherit

	BIN_EQ_AS
		redefine
			operator_name 
		end

feature -- Properties

	operator_name: STRING is "_infix_/=";

end -- class BIN_NE_AS
