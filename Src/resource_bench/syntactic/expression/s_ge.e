indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- operator : ">="

class S_GE 

inherit
	TERMINAL
	
	LEX_CONSTANTS
		undefine
			is_equal, copy
		end

feature

	construct_name: STRING is
		once
			Result := "GE"
		end

	token_type: INTEGER is
		do
			Result := Ge
		end

end -- class S_GE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
