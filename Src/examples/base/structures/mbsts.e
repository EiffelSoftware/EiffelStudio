--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	desciption: "Demo class for trees implemented as binary search trees %
		%  Only one routine to display the set is added %
		% The generic parameter is INT_COMP." 

class 
	MBSTS

inherit
	BINARY_SEARCH_TREE_SET [INTEGER] 

create
	make

feature

	display is
		do
			io.set_error_default
			if not left_child.Void then
				left_child.display
			end
			if not tree_item.Void then
				io.putchar (' ')
				io.putint (tree_item.item)
			end
			if not right_child.Void then
				right_child.display
			end
		end

end -- class MBSTS
