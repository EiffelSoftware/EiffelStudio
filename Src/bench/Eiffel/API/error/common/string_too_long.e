indexing

	description: 
		"Syntax error for manifest string too long.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_TOO_LONG

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

create {ERROR_HANDLER}

	init

feature -- Property

	syntax_message: STRING is
			-- Specific syntax message.
        do
			Result := "string too long"
        end;

end -- class STRING_TOO_LONG
