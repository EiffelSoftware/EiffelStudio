indexing
	description: "Objects that test EV_GRID."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_ROW_HEIGHT_TEST

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
			grid.disable_row_height_fixed
			grid.enable_single_row_selection
			add_items (2, 24)
			grid.set_minimum_size (300, 300)
			grid.column (1).set_width (120)
			grid.column (2).set_width (120)
			
			widget := grid
		end
		
	add_items (columns, rows: INTEGER) is
			-- Add items to `grid' occupying `columns' columns
			-- and `rows' rows with differing font heights.
		local
			l_ycount, l_xcount: INTEGER
			grid_label_item: EV_GRID_LABEL_ITEM
			counter: INTEGER
			column_counter, row_counter: INTEGER
			font: EV_FONT
		do		
			from
				row_counter := 1
			until
				row_counter > rows
			loop
					-- Note that we share the same font object for each
					-- item in the row.
				create font
				font.set_height (row_counter + 6)
				
				from
					column_counter := 1
				until
					column_counter > columns
				loop
					create grid_label_item
					grid_label_item.set_font (font)
					grid_label_item.set_text ("Font Height " + font.height.out)
					grid.set_item (column_counter, row_counter, grid_label_item)
					grid.row (row_counter).set_height (grid_label_item.text_height)
					
					column_counter := column_counter + 1	
				end
				row_counter := row_counter + 1
			end
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.

end -- class GRID_ROW_HEIGHT_TEST
