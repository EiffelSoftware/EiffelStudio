indexing

	description: 
		"Syntax error for more than 4 generic parameters.";
	date: "$Date$";
	revision: "$Revision $"

class TOO_MANY_GENERICS

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

creation {ERROR_HANDLER}

	init

feature -- Property

	syntax_message: STRING is
			-- Specific syntax message.
        do
			Result := "the number of generic parameters is limited to eight"
        end;

end -- class TOO_MANY_GENERICS
