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

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

