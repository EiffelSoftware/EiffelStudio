indexing
	description: "Objects that test EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_SEPARATOR_TEST

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
			grid.disable_row_height_fixed
			grid.enable_single_row_selection
			grid.enable_column_separators
			grid.enable_row_separators
			add_items (4, 50)

			widget := grid
		end
		
	add_items (columns, rows: INTEGER) is
			-- Add items to `grid' occupying `columns' columns
			-- and `rows' rows with differing font heights.
		local
			grid_label_item: EV_GRID_LABEL_ITEM
			column_counter, row_counter: INTEGER
		do		
			from
				row_counter := 1
			until
				row_counter > rows
			loop
				from
					column_counter := 1
				until
					column_counter > columns
				loop
					create grid_label_item.make_with_text ("Item " + column_counter.out + ", " + row_counter.out)
					grid.set_item (column_counter, row_counter, grid_label_item)
					column_counter := column_counter + 1	
				end
				row_counter := row_counter + 1
			end
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID;
		-- Widget that test is to be performed on.

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


end -- class GRID_SEPARATOR_TEST
