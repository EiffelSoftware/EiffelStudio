-- Error for bad character recognition

class BAD_CHARACTER

inherit

	SYNTAX_ERROR
		redefine
			syntax_message
		end

creation

	init

feature

	syntax_message: STRING is
			-- Specific syntax message
		do
			Result := "invalid character"
		end

end
