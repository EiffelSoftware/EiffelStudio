--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Identifiers

class IDENTIFIER 

inherit

	TERMINAL;

	CONSTANTS

create

	make

feature {NONE}

	default_identifier_name: STRING is 
		once
			Result := "IDENTIFIER"
		end; -- default_identifier_name

	construct_name: STRING is
		do
			Result := default_identifier_name
		end -- construct_name

feature 

	token_type: INTEGER is
		do
			Result := Simple_identifier
		end -- token_type

end -- class IDENTIFIER
