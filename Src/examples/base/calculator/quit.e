--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class QUIT

inherit
	STATE
		redefine 
			process
		end

feature
	
	operation is
			-- Useless.
		do
		end;

	process is
			-- Useless.
		do
		end;

end -- class QUIT
