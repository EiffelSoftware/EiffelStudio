--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Integer constants

class INT_CONSTANT 

inherit

	TERMINAL;

	CONSTANTS

feature 

	token_type: INTEGER is
		do  
			Result := Integer_constant
		end

feature {NONE}

	construct_name: STRING is
		once
			Result := "INT_CONSTANT"
		end -- construct_name

end -- class INT_CONSTANT
