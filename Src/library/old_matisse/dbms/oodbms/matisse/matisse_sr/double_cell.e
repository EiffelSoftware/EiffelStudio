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
