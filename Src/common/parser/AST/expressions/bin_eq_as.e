indexing
	description: "AST representation of binary `=' operation."
	date: "$Date$"
	revision: "$Revision $"

class
	BIN_EQ_AS

inherit
	BINARY_AS
		redefine
			operator_is_keyword, operator_is_special
		end

feature -- Properties

	infix_function_name: STRING is 
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_="
		end

	operator_is_keyword: BOOLEAN is False
	
	operator_is_special: BOOLEAN is True
	
end -- class BIN_EQ_AS
