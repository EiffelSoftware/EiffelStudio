indexing

	description: 
		"Syntax error when a string extension is bad.";
	date: "$Date$";
	revision: "$Revision $"

class STRING_EXTENSION

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
			-- Specific syntax message.
        do
			Result := "invalid character code after percent"
        end

end -- class STRING_EXTENSION
