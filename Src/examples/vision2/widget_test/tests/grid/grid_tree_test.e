indexing
	description: "Objects that test EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_TREE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			grid_label_item: EV_GRID_LABEL_ITEM
		do
			create grid
			grid.enable_tree
			grid.set_minimum_size (300, 300)
			create grid_label_item.make_with_text ("Root Node")
			grid.set_item (1, 1, grid_label_item)
			add_tree_items (grid_label_item.row, 3)
			
			widget := grid
		end
		
	add_tree_items (parent_row: EV_GRID_ROW; child_count: INTEGER) is
			-- Add `child_count' subrows to `row' of `parent_item'.
		local
			counter: INTEGER
			new_subrow: EV_GRID_ROW
		do
			from
				counter := 1
			until
				counter > child_count
			loop
				parent_row.insert_subrow (counter)
				new_subrow := parent_row.subrow (counter)
				new_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subrow " + counter.out))
				new_subrow.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Data"))
				
					-- Now perform addition of items recursively, reducing the number of
					-- subrows each time.
				add_tree_items (parent_row.subrow (counter), child_count - 1)
				counter := counter + 1
			end
		end
		
		
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.

end -- class GRID_TREE_TEST
