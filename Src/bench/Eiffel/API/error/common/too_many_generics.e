-- Syntax error for more than 4 generic parameters

class TOO_MANY_GENERICS

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
			Result := "the number of generic parameters is limited to four"
        end;

end
