--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	TOP_DEMO 

inherit

	STORABLE
	STD_FILES

feature

	driver : DEMO_DRIVER
	
	fill_menu is
		do
		end -- fill_menu

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		do
		end -- execute

	cycle is
		do
		end -- cycle

end -- class TOP_DEMO
