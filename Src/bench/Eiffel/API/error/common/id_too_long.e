indexing

	description: 
		"Syntax error for identifier too long.";
	date: "$Date$";
	revision: "$Revision $"

class ID_TOO_LONG

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
			Result := "identifier too long"
        end;

end -- class ID_TOO_LONG
