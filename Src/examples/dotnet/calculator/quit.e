--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	QUIT

inherit
	STATE
		redefine 
			process
		end

create
	make

feature
	
	operation is
			-- Useless.
		do
		end

	process is
			-- Useless.
		do
		end

end -- class QUIT
