indexing

	description: 
		"Syntax error for empty lace string.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_EMPTY

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

create {ERROR_HANDLER}

	init

create

	make

feature -- Property

	syntax_message: STRING is
			-- Specific syntax message.
        do
			Result := "empty string not permitted here"
        end;

end -- class STRING_EMPTY
