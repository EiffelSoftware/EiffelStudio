indexing
	description: "Objects that test EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_PIXMAP_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			stock_pixmaps: EV_STOCK_PIXMAPS
			l_pixmap: EV_PIXMAP
		do
			create grid
			grid.set_minimum_size (300, 300)
			create pixmaps.make (4)
			create stock_pixmaps
			pixmaps.extend (stock_pixmaps.error_pixmap.twin)
			pixmaps.extend (stock_pixmaps.information_pixmap.twin)
			pixmaps.extend (stock_pixmaps.question_pixmap.twin)
			pixmaps.extend (stock_pixmaps.warning_pixmap.twin)
			from
				pixmaps.start
			until
				pixmaps.off
			loop
				l_pixmap := pixmaps.item
				l_pixmap.stretch (grid.row_height - 2, grid.row_height - 2)
				pixmaps.forth
			end
			
			create grid
			grid.set_minimum_size (300, 300)
			grid.disable_row_height_fixed
			grid.enable_single_row_selection
			add_items (5, 50)

			widget := grid
		end
		
	add_items (columns, rows: INTEGER) is
			-- Add items to `grid' occupying `columns' columns
			-- and `rows' rows with differing font heights.
		local
			grid_label_item: EV_GRID_LABEL_ITEM
			column_counter, row_counter: INTEGER
			counter: INTEGER
		do		
			from
				row_counter := 1
				counter := 1
			until
				row_counter > rows
			loop
				from
					column_counter := 1
				until
					column_counter > columns
				loop
					create grid_label_item.make_with_text ("Item " + column_counter.out + ", " + row_counter.out)
					grid_label_item.set_pixmap (pixmaps.i_th (counter \\ 4 + 1))
					grid.set_item (column_counter, row_counter, grid_label_item)
					column_counter := column_counter + 1	
					counter := counter + 1
				end
				row_counter := row_counter + 1
			end
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	pixmaps: ARRAYED_LIST [EV_PIXMAP];

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


end -- class GRID_PIXMAP_TEST
