--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Demo class for sets implemented as sorted lists %
		% Only one routine to display the set is added."

class MSLS 

inherit
	TWO_WAY_SORTED_SET [INTEGER] 

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
				io.putint (item.item)
				forth
			end
		end

end -- class MSLS
