--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	HELP

inherit 
	STATE 
		redefine 
			do_one_state
		end
	SET_UP

feature 
	
	do_one_state is
			-- Print help header.
		do
			keys_messages
		end

	operation is 
		do 
		end
	
end -- class HELP 
