-- Syntax error for manifest string too long

class STRING_TOO_LONG

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
			Result := "string too long"
        end;

end
