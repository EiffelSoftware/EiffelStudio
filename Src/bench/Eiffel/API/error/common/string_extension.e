-- Syntax error when a string extension is bad

class STRING_EXTENSION

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

creation

	init

feature

	syntax_message: STRING is
			-- Specific syntax message.
        do
			Result := "invalid character code after percent"
        end

end
