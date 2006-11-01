indexing
	description: "Objects that test EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_COLORS_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			i: INTEGER
		do
			create grid
			grid.set_minimum_size (300, 300)
			grid.enable_tree
			add_items (5, 100)
			grid.column (1).set_background_color (light_blue)
			grid.column (2).set_background_color (light_red)
			grid.set_background_color (light_green)
			from
				i := 5
			until
				i > 10
			loop
				grid.row (i).add_subrow (grid.row (i + 1))
				grid.row (i).expand
				i := i + 1
			end
			from
				i := 1
			until
				i > grid.row_count
			loop
				if i \\ 2 = 1 then
					grid.item (4, i).set_background_color (stock_colors.white)
				else
					grid.item (4, i).set_background_color (light_blue)
				end
				i := i + 1
			end
			from
				i := 15
			until
				i = 20
			loop
				grid.row (i).set_background_color (stock_colors.yellow)
				grid.row (i).set_item (2, Void)
				i := i + 1
			end
			grid.row (7).set_background_color (stock_colors.yellow)
			grid.row (8).set_background_color (stock_colors.yellow)
			
				-- Set all columns to their minimum width required to completely
				-- display their content.
			grid.column (1).resize_to_content
			grid.column (2).resize_to_content
			grid.column (3).resize_to_content
			grid.column (4).resize_to_content
			grid.column (5).resize_to_content
			
			widget := grid
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	stock_colors: EV_STOCK_COLORS is
			-- Once access to EiffelVision2 stock colors
			-- (from GRID_ACCESSOR)
		once
			create Result
		end
		
	light_red: EV_COLOR is
			-- Color light red.
		once
			create Result.make_with_8_bit_rgb (255, 230, 230)
		end

	light_blue: EV_COLOR is
			-- Color light blue.
		once
			create Result.make_with_8_bit_rgb (230, 230, 255)
		end

	light_green: EV_COLOR is
			-- Color light green.
		once
			create Result.make_with_8_bit_rgb (230, 255, 230)
		end
		
	add_items (columns, rows: INTEGER) is
			-- Add items to `grid' occupying `columns' columns
			-- and `rows.
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
					create grid_label_item.make_with_text (column_counter.out + ", " + row_counter.out )
					grid.set_item (column_counter, row_counter, grid_label_item)
					column_counter := column_counter + 1	
				end
				row_counter := row_counter + 1
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


end -- class GRID_COLORS_TEST
