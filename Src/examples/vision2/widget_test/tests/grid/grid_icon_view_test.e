indexing
	description: "[
		Objects that demonstrate how to set up an EV_GRID in an item view
		layout.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_ICON_VIEW_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			a_x, a_y: INTEGER
			grid_label_item: EV_GRID_EDITABLE_ITEM
			pixmaps: ARRAYED_LIST [EV_PIXMAP]
			stock_pixmaps: EV_STOCK_PIXMAPS
		do
			create grid
			grid.set_minimum_size (300, 300)
			create pixmaps.make (4)
			create stock_pixmaps
			pixmaps.extend (stock_pixmaps.error_pixmap.twin)
			pixmaps.extend (stock_pixmaps.information_pixmap.twin)
			pixmaps.extend (stock_pixmaps.question_pixmap.twin)
			pixmaps.extend (stock_pixmaps.warning_pixmap.twin)

			grid.hide_header
			from
				a_x := 1
				pixmaps.start
			until
				a_x > 5
			loop
				from	
					a_y :=1
				until
					a_y > 5
				loop
					create grid_label_item.make_with_text ("Item " + a_x.out + ",  " + a_y.out)
					grid_label_item.set_pixmap (pixmaps.item)
					grid_label_item.disable_full_select
					grid_label_item.set_layout_procedure (agent icon_item_layout)
					grid.set_item (a_x, a_y, grid_label_item)
					pixmaps.forth
					if pixmaps.off then
						pixmaps.start
					end
					a_y := a_y + 1
				end
				a_x := a_x + 1
			end
			grid.set_row_height (grid.column (1).width)
			grid.resize_actions.force_extend (agent move_items)
			
			widget := grid
		end

	icon_item_layout (an_item: EV_GRID_LABEL_ITEM; layout: EV_GRID_LABEL_ITEM_LAYOUT) is
			-- `an_item' is being redrawn by the grid, so fill in `layout' to specify
			-- the exact positioning of both the text and pixmap. This lets us set then
			-- in the icon style layout.
		require
			an_item_not_void: an_item /= Void
			layout_not_void: layout /= Void
		local
			total_heights: INTEGER
		do
			total_heights := an_item.pixmap.height + an_item.text_height + an_item.spacing
			layout.set_pixmap_x ((an_item.width - an_item.pixmap.width) // 2)
			layout.set_pixmap_y ((an_item.height - total_heights) // 2)
			layout.set_text_x ((an_item.width - an_item.text_width) // 2)
			layout.set_text_y (layout.pixmap_y + an_item.pixmap.height + an_item.spacing)
		end

	move_items is
			-- Respond to the resizing of the grid, by updating the positions
			-- of all items contained so that they always occupy the total width.
			-- This may not be visible in the example, as the width of the grid is
			-- fixed horizontally. 
		local
			l_width: INTEGER
			an_x, a_y: INTEGER
			items: ARRAYED_LIST [EV_GRID_ITEM]
		do
			create items.make (10)
			l_width := grid.width
			from
				an_x := 1
			until
				an_x > grid.row_count
			loop
				from
					a_y := 1
				until
					a_y > grid.column_count
				loop
					if grid.item (a_y, an_x) /= Void then
						items.extend (grid.item (a_y, an_x))
						grid.set_item (a_y, an_x, Void)
					end
					a_y := a_y + 1
				end
				an_x := an_x + 1
			end
			an_x := 1
			a_y := 1
			from
				items.start
			until
				items.off
			loop
				grid.set_item (an_x, a_y, items.item)
				an_x := an_x + 1
				if an_x * 80 > l_width - 20 then
					from
					until
						grid.column_count < an_x
					loop
						grid.remove_column (grid.column_count)
					end
					an_x := 1
					a_y := a_y + 1
				end
				items.forth
			end
			from
			until
				grid.row_count < a_y
			loop
				grid.remove_row (grid.row_count)
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


end -- class GRID_ICON_VIEW_TEST
