-- Syntax error for basic type with generic derivation

class BASIC_GEN_TYPE_ERR

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
			Result := "basic type can not have generic derivation"
        end;

end
