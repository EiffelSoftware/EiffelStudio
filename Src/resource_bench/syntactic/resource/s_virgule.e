indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Ponctuation : ","

class S_VIRGULE

inherit
	TERMINAL
	
	LEX_CONSTANTS

feature

	construct_name: STRING is
		once
			Result := "VIRGULE"
		end

	token_type: INTEGER is
		do
			Result := Ponctuation
		end

end -- class S_VIRGULE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
