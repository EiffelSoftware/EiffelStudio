indexing
	description: "[
		Objects that test the dynamic capabilities of EV_GRID.
		This prevents all grid items from being created until
		they are required to be drawn.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_DYNAMIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create grid
			grid.set_minimum_size (300, 300)
			grid.enable_partial_dynamic_content
			grid.set_row_count_to (1000000)
			grid.set_column_count_to (3)
			grid.set_dynamic_content_function (agent compute_item)
			
			widget := grid
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	compute_item (column_index, row_index: INTEGER): EV_GRID_ITEM is
			-- `grid' has been scrolled so an item at `column_index'
			-- `row_index' is visible. Compute and return this item.
		do
			create {EV_GRID_LABEL_ITEM} Result.make_with_text ("Item " + column_index.out + ", " + row_index.out)
		end
		

end -- class GRID_DYNAMIC_TEST
