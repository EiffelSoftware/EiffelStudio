--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Demo class for SLP_QUEUE %
		% Only one feature added: display"

class MY_SLP 

inherit
	LINKED_PRIORITY_QUEUE [INTEGER]
		rename
			make as lpq_make
		end

create
	make

feature -- Creation

	make is
		do
			io.set_error_default
			lpq_make
		end

feature -- Routine

	display is
		do
			from
				start
			until
				offright
			loop
				io.putint (sorted_list_item.item)
				io.putstring (" ")
				forth
			end
		end

end -- class MY_SLP
