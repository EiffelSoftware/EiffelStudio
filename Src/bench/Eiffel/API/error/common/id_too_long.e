-- Syntax error for identifier too long

class ID_TOO_LONG

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
			Result := "identifier too long"
        end;

end
