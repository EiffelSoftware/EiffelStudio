indexing
	description: "[
		Objects that test EV_GRID, using `ensure_expandable' to
		create a dynamic tree.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_DYNAMIC_TREE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			grid_label_item: EV_GRID_LABEL_ITEM
			stock_pixmaps: EV_STOCK_PIXMAPS
			l_pixmap: EV_PIXMAP
		do
			create grid
			grid.enable_tree
			grid.set_minimum_size (300, 300)
			create grid_label_item.make_with_text ("Root Node")
			grid.set_item (1, 1, grid_label_item)
			grid.row (1).ensure_expandable
			grid.row (1).expand_actions.extend (agent row_expanded (grid.row (1)))
			
			
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
			pixmaps.start
			
			widget := grid
		end
		
	row_expanded (parent_row: EV_GRID_ROW) is
			-- Add `3' subrows to `parent_row'.
		local
			counter: INTEGER
			new_subrow: EV_GRID_ROW
			label_item: EV_GRID_LABEL_ITEM
		do
			from
				counter := 1
			until
				counter > 3
			loop
				parent_row.insert_subrow (counter)
				new_subrow := parent_row.subrow (counter)
				pixmaps.forth
				if pixmaps.off then
					pixmaps.start
				end
				create label_item.make_with_text ("Subrow " + counter.out)
				label_item.set_pixmap (pixmaps.item)
				new_subrow.set_item (1, label_item)
				create label_item.make_with_text ("Data")
				label_item.set_pixmap (pixmaps.item)
				new_subrow.set_item (2, label_item)
				
					-- Make all new rows exapndable.
				new_subrow.ensure_expandable
				new_subrow.expand_actions.extend (agent row_expanded (new_subrow))

				counter := counter + 1
			end
			
				-- Prevent new items from being added if the row is collapsed and expanded again.
			parent_row.expand_actions.wipe_out
		end
		
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	pixmaps: ARRAYED_LIST [EV_PIXMAP];
		-- Pixmaps for addition to items.

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


end -- class GRID_DYNAMIC_TREE_TEST
