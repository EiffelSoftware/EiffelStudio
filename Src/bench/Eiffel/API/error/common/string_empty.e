-- Syntax error for empty lace string

class STRING_EMPTY

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
			Result := "empty string not permitted here"
        end;

end
