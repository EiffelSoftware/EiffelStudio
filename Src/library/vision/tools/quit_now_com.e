--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Command to quit immediatly the application.

class QUIT_NOW_COM 

inherit

	COMMAND;

	GRAPHICS
		export
			{NONE} all
		end

feature 

	execute (argument: ANY) is
			-- Quit the application.
		do
			exit
		end

end
