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

creation {ERROR_HANDLER}

	init

creation

	make

feature -- Property

	syntax_message: STRING is
			-- Specific syntax message
		do
			Result := "invalid character"
		end

end -- class BAD_CHARACTER
