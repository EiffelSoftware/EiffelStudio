indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Specific_control_statement

class S_SPECIFIC_CONTROL_STATEMENT 

inherit
	TERMINAL
	
	LEX_CONSTANTS

feature

	construct_name: STRING is
		once
			Result := "SPECIFIC_CONTROL_STATEMENT"
		end

	token_type: INTEGER is
		do
			Result := Specific_control_statement
		end

end -- class S_SPECIFIC_CONTROL_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
