indexing

	description: 
		"Syntax error for uncompleted string (final quote is missing).";
	date: "$Date$";
	revision: "$Revision $"

class STRING_UNCOMPLETED

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
			Result := "incomplete string: missing final quote"
        end

end -- class STRING_UNCOMPLETED
