indexing

	description: 
		"Error for bad character recognition.";
	date: "$Date$";
	revision: "$Revision $"

class BAD_CHARACTER

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
			-- Specific syntax message
		do
			Result := "invalid character"
		end

end -- class BAD_CHARACTER
