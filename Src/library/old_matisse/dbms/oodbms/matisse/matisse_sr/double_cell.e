indexing

	description:
 		"Cells containing two items"

class DOUBLE_CELL[G,H]

Creation

	put

feature -- Access

	first_item: G -- Content of first cell.

	second_item: H  -- Content of second cell.
	
feature -- Element change

	put_first, replace_first(v : like first_item) is
		-- Make `v' the cell's `first_item'.
		do
			first_item := v
		ensure
			fisrt_item_inserted: first_item = v
		end -- put_first, replace_first

	put_second, replace_second (v : like second_item) is
		-- Make `v' the cell's `second_item'.
		do
			second_item := v
		ensure
			second_item_inserted: second_item = v
		end -- put_second, replace_second

	put, replace (v : like first_item;u : like second_item) is
 		-- Make `v' the cell's `first_item' and 'y' the cell's 'second_item'
		do
			put_first(v)
			put_second(u)
		end -- put, replace

end -- class DOUBLE_CELL

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

