indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- end -> "END" | "}"

class S_END_BLOCK

inherit
	TERMINAL
	
	LEX_CONSTANTS

feature

	construct_name: STRING is
		once
			Result := "END_BLOCK"
		end

	token_type: INTEGER is
		do
			Result := End_block
		end

end -- class END_BLOCK

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
