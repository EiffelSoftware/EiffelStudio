indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Operator : "+"

class S_ADD 

inherit
	TERMINAL
	
	LEX_CONSTANTS

feature

	construct_name: STRING is
		once
			Result := "ADD"
		end

	token_type: INTEGER is
		do
			Result := Add
		end

end -- class S_ADD

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
