-- Syntax error for uncompleted string (final quote is missing)

class STRING_UNCOMPLETED

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
			Result := "incomplete string: missing final quote"
        end

end
