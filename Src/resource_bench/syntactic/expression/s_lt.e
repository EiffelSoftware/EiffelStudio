indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Operator : "<"

class S_LT 

inherit
	TERMINAL
	
	LEX_CONSTANTS
		undefine
			is_equal, copy
		end

feature

	construct_name: STRING is
		once
			Result := "LT"
		end

	token_type: INTEGER is
		do
			Result := Lt
		end

end -- class S_LT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
