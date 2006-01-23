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
			if not left_child /= Void then
				left_child.display
			end
			if not tree_item /= Void then
				io.putchar (' ')
				io.putint (tree_item.item)
			end
			if not right_child /= Void then
				right_child.display
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MBSTS

