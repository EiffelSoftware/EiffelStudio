indexing

	description: 
		"Syntax error for basic type with generic derivation.";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_GEN_TYPE_ERR

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
			Result := "basic type cannot have generic derivation"
        end;

end -- class BASIC_GEN_TYPE_ERR
