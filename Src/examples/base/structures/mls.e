--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Demo class for linked sets. %
		% Only one routine to display the set is added %
		% The generic parameter is INTEGER."

class 
	MLS

inherit
	LINKED_SET [INTEGER] 

create
	make

feature

	display is
		do
			io.set_error_default
			from
				start
			until
				exhausted
			loop
				io.putchar (' ')
				io.putint (item)
				forth
			end
			io.putchar ('%N')
		end

end -- class MLS
