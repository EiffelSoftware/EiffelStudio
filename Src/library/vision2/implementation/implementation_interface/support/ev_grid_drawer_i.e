indexing
	description: "Objects that draw the EV_GRID widget as required."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWER_I
	
inherit
	REFACTORING_HELPER
	
create
	make_with_grid
	
feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I) is
			-- Create `Current' associated to `grid' `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			grid := a_grid
		ensure
			grid_set: grid = a_grid
		end

feature -- Access

	grid: EV_GRID_I

feature -- Basic operations
		
	items_spanning_horizontal_span (an_x, a_width: INTEGER): ARRAYED_LIST [INTEGER] is
			-- For a virtual position starting at `an_x' with a width of `a_width',
			-- return all of the column indexes which intersect this width.
		require
			an_x_non_negative: an_x >=0
			a_width_non_negative: a_width >= 0
		local
			internal_client_x: INTEGER
			horizontal_buffer_offset: INTEGER
			visible_physical_column_indexes: SPECIAL [INTEGER]
			first_column_index: INTEGER
			last_column_index: INTEGER
			first_column_index_set, last_column_index_set: BOOLEAN
			column_offsets: ARRAYED_LIST [INTEGER]
			invalid_x_start, invalid_x_end: INTEGER
			i: INTEGER
			internal_client_width: INTEGER
		do
			fixme ("Handle hidden columns and columns that have had their position moved.")
			fixme ("Use a binary search to find the positions if possible.")
			fixme ("Handle dynamic items in per item scrolling mode")
			create Result.make (20)
			
			visible_physical_column_indexes := grid.visible_physical_column_indexes
			
			internal_client_x := grid.internal_client_x
			internal_client_width := grid.internal_client_width
			
			horizontal_buffer_offset := grid.viewport.x_offset
			
			
			if grid.column_count > 0 then
					-- If the grid has no columns, then there may not be any column indexes
					-- which span the area, so do nothing.

				column_offsets := grid.column_offsets
					-- Retriece the offsets of all columns from `grid'.
					
				
					-- Calculate the columns that must be displayed.
				from
					column_offsets.start
						-- Compute the virtual positions of the invalidated area.
					invalid_x_start := internal_client_x + an_x - horizontal_buffer_offset
					invalid_x_end := internal_client_x + an_x - horizontal_buffer_offset + a_width		
				until
					last_column_index_set or column_offsets.off
				loop
					i := column_offsets.item
					if not first_column_index_set and then i > invalid_x_start then
						first_column_index := column_offsets.index - 1
						first_column_index_set := True
					end
					if first_column_index_set then
						Result.extend (column_offsets.index - 1)
					end
					if not last_column_index_set and then invalid_x_end < i then
						last_column_index := column_offsets.index - 1
						last_column_index_set := True
					end
					column_offsets.forth
				end
				if last_column_index = 0 then
					last_column_index := grid.column_count
				end
				if first_column_index = 0 then
					first_column_index := grid.column_count
				end
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	items_spanning_vertical_span (a_y, a_height: INTEGER): ARRAYED_LIST [INTEGER] is
			-- For a virtual position starting at `a_y' with a height of `a_height',
			-- return all of the row indexes which intersect this width.
		local
			internal_client_y: INTEGER
			vertical_buffer_offset: INTEGER
			current_row: EV_GRID_ROW_I
--			visible_physical_row_indexes: SPECIAL [INTEGER]
			first_row_index: INTEGER
			last_row_index: INTEGER
			first_row_index_set, last_row_index_set: BOOLEAN
			row_counter: INTEGER
			row_offsets: ARRAYED_LIST [INTEGER]
			invalid_y_start, invalid_y_end: INTEGER
			i: INTEGER
			dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
			internal_client_height: INTEGER
			skipped_rows: INTEGER
			current_height: INTEGER
		do
			fixme ("Implement the dynamic mode for items when in per item scrolling")
			dynamic_content_function := grid.dynamic_content_function
			create Result.make (20)
			
			--visible_physical_column_indexes := grid.visible_physical_column_indexes
			row_offsets := grid.row_offsets

			internal_client_y := grid.internal_client_y
			internal_client_height := grid.internal_client_height
			
			vertical_buffer_offset := grid.viewport.y_offset
			
			if not grid.header.is_empty then
				
					-- Calculate the rows that must be displayed.
					-- Compute the virtual positions of the invalidated area.
				invalid_y_start := internal_client_y + a_y - vertical_buffer_offset
				invalid_y_end := internal_client_y + a_y - vertical_buffer_offset + a_height
				if grid.is_row_height_fixed and not grid.is_tree_enabled then
						-- If row heights are fixed we can calculate instead of searching.
						-- Note that we cannot calculate if there is tree functionality enabled in
						-- the grid as nodes may be expanded or collapsed.
					first_row_index := (((invalid_y_start) // grid.row_height) + 1)
					last_row_index := (((invalid_y_end) // grid.row_height) + 1).min (grid.row_count)
					
					if first_row_index <= grid.row_count then
						
						from
							i := first_row_index
						until
							i > last_row_index
						loop
							Result.extend (i)
							i := i + 1
						end
					end
				else
					row_offsets := grid.row_offsets
					from
						row_counter := 1
						i := 0
					until
						last_row_index_set or row_counter > grid.rows.count
					loop
						i := row_offsets @ (row_counter)
						current_row := grid.rows.i_th (row_counter)
						if grid.is_row_height_fixed then
							current_height := grid.row_height
						else
							current_height := current_row.height
						end

						if not first_row_index_set and then i + current_height > invalid_y_start then
							first_row_index := row_counter
							first_row_index_set := True
						end
						if first_row_index_set then
							Result.extend (row_counter)
						end

						if not last_row_index_set and then invalid_y_end <= i + current_height then
							last_row_index := row_counter
							last_row_index_set := True
						end
						if current_row.subrow_count > 0 and not current_row.is_expanded then
							if not first_row_index_set then
								skipped_rows := skipped_rows + current_row.subnode_count_recursive	
							end
							row_counter := row_counter + current_row.subnode_count_recursive
						end
						row_counter := row_counter + 1
					end
				end
				if last_row_index = 0 then
					last_row_index := grid.row_count
				end
				if first_row_index = 0 then
					first_row_index := grid.row_count
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	item_at_position (an_x, a_y: INTEGER): EV_GRID_ITEM is
			-- `Result' is item at position `an_x', `a_y' relative to the top left corner
			-- of the viewport in which the grid is displayed.
		require
			an_x_positive: an_x >= 0
			a_y_positive: a_y >= 0
		local
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
		do
			horizontal_span_items := items_spanning_horizontal_span (an_x, 0)
			vertical_span_items := items_spanning_vertical_span (a_y, 0)
			if not horizontal_span_items.is_empty and not vertical_span_items.is_empty then
				Result := grid.item (horizontal_span_items.first, vertical_span_items.first)
			end
		end

	partial_redraw (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw part of client area within `grid' specified by
			-- coordinates `an_x', `a_y', `a_width', `a_height'.
		require
--			an_x_positive: an_x >= 0
--			a_y_positive: a_y >= 0
--			a_width_positive: a_width >= 0
--			a_height_positive: a_height >= 0
		local
			internal_client_x, internal_client_y: INTEGER
			vertical_buffer_offset: INTEGER
			horizontal_buffer_offset: INTEGER
			column_widths: ARRAYED_LIST [INTEGER]
			
			current_row_list: SPECIAL [EV_GRID_ITEM_I]
			current_row: EV_GRID_ROW_I
			
			visible_physical_column_indexes: SPECIAL [INTEGER]
			first_column_index, first_row_index: INTEGER
			last_column_index: INTEGER
			grid_item: EV_GRID_ITEM_I
			grid_item_interface: EV_GRID_ITEM
			current_column_index, current_row_index: INTEGER
			column_offsets, row_offsets: ARRAYED_LIST [INTEGER]
			current_column_width, current_row_height: INTEGER
			rectangle_width, rectangle_height: INTEGER
			grid_item_exists: BOOLEAN
			current_item_y_position, current_item_x_position: INTEGER
			dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
			internal_client_width, internal_client_height: INTEGER
			current_tree_indent: INTEGER
			skipped_rows: INTEGER
			visible_column_indexes: ARRAYED_LIST [INTEGER]
			visible_row_indexes: ARRAYED_LIST [INTEGER]
		do
			dynamic_content_function := grid.dynamic_content_function
			
			create column_widths.make (8)
			column_widths.extend (0)
			
			visible_physical_column_indexes := grid.visible_physical_column_indexes
			
			internal_client_x := grid.internal_client_x
			internal_client_y := grid.internal_client_y
			internal_client_width := grid.internal_client_width
			internal_client_height := grid.internal_client_height
			
			vertical_buffer_offset := grid.viewport.y_offset
			horizontal_buffer_offset := grid.viewport.x_offset
			
			
			if grid.row_count > 0 and grid.column_count > 0 then
				column_offsets := grid.column_offsets
				row_offsets := grid.row_offsets	
				visible_column_indexes := items_spanning_horizontal_span (an_x, a_width)
				visible_row_indexes := items_spanning_vertical_span (a_y, a_height)
				if not (visible_column_indexes.is_empty or visible_row_indexes.is_empty) then
					first_column_index := visible_column_indexes.first
					last_column_index := visible_column_indexes.last
					
					
					first_row_index := visible_row_indexes.first
					current_item_y_position := 0
	
					from
						visible_row_indexes.start
					until
						visible_row_indexes.off
					loop
						current_row_index := visible_row_indexes.item
							-- Retrieve information regarding the rows that we must draw.
						current_row_list := grid.row_list @ (current_row_index - 1)
						current_row := grid.rows @ current_row_index
	
						
						if grid.is_row_height_fixed and not grid.is_tree_enabled then
							current_item_y_position := (grid.row_height * (current_row_index - 1)) - (internal_client_y - vertical_buffer_offset)
							current_row_height := grid.row_height
						else
							current_item_y_position := (row_offsets @ (current_row_index)) - (internal_client_y - vertical_buffer_offset)
							if grid.is_row_height_fixed then
								current_row_height := grid.row_height
							else
								current_row_height := current_row.height
							end
						end
						from
							visible_column_indexes.start
							current_item_x_position := 0
						until
							visible_column_indexes.off
						loop
							current_column_index := visible_column_indexes.item
								-- Assume that there is no grid item at the current position.
								-- It is not possible to simply set `grid_item' to Void within the loop as otherwise
								-- this effectively inserts `Void' at the grid item's position within the grid's
								-- data structures. So we use a BOOLEAN to determine this instead.
							grid_item_exists := False
	
							if not grid.is_content_completely_dynamic and current_row_list /= Void and then current_row_list.count > (current_column_index - 1) then
									-- If the grid is set to retrieve completely dynamic content, then we do not execute this code
									-- as the current contents of the grid are never used. We also check that the current row and
									-- current row position are valid.
									
								grid_item := current_row_list @ (current_column_index - 1)
									-- In this case, we have found the grid item so we flag this fact
									-- so that the calculations for the partial dynamic content know that
									-- a new item must not be retrieved.
								if grid_item /= Void then
									grid_item_exists := True
								end
							end
		
							current_item_x_position  := (column_offsets @ (current_column_index)) - (internal_client_x - horizontal_buffer_offset)
							current_column_width := column_offsets @ (current_column_index + 1) - column_offsets @ (current_column_index)
							
							if (grid.is_content_partially_dynamic or grid.is_content_completely_dynamic) and then not grid_item_exists and dynamic_content_function /= Void then
									-- If we are dynamically computing the contents of the grid and we have not already retrieved an item for
									-- the grid, then we execute this code.
									
								dynamic_content_function.call ([visible_column_indexes.item, visible_row_indexes.item])
								grid_item_interface := dynamic_content_function.last_result
								if grid_item_interface /= Void then
									grid_item := grid_item_interface.implementation
										-- Note that the item is added to the grid in both partial and complete dynamic modes.
									grid.set_item (visible_column_indexes.item, visible_row_indexes.item, grid_item.interface)
									grid_item_exists := True
								end
							end
							
							if grid_item_exists then
									-- An item has been retrieved for the current drawing position so draw it.
								if current_column_index = 1 and grid.is_tree_enabled then
										-- Now draw tree node for root tree items if any.
									current_tree_indent := tree_indent * current_row.depth_in_tree
									
										-- The background area for the tree node must always be refreshed, even if the node is not visible.
										-- We draw no wider than `current_column_width' to ensure this.
									grid.drawable.set_foreground_color (grid.background_color)
									grid.drawable.fill_rectangle (current_item_x_position, current_item_y_position, current_tree_indent.max (current_column_width), current_row_height)
									
									if current_tree_indent < current_column_width then
											-- If the indent of the tree is less than `current_column_width', it must be visible so draw it.
										if current_row.subrow_count > 0 then
											if current_row.is_expanded then
												grid.drawable.draw_pixmap (current_tree_indent - tree_node_button_dimension - (tree_indent - tree_node_button_dimension) // 2, current_item_y_position + (current_row_height - tree_node_button_dimension) // 2, collapse_pixmap)
											else
												grid.drawable.draw_pixmap (current_tree_indent - tree_node_button_dimension - (tree_indent - tree_node_button_dimension) // 2, current_item_y_position + (current_row_height - tree_node_button_dimension) // 2, expand_pixmap)
											end
										end
									end
									if current_item_x_position + current_tree_indent < current_column_width then
										grid_item.redraw (current_item_x_position + current_tree_indent, current_item_y_position, current_column_width - current_tree_indent, current_row_height, grid.drawable)
									end
									fixme ("Must handle tree nodes that are not only in the first column")
								else
									grid_item.redraw (current_item_x_position, current_item_y_position, current_column_width, current_row_height, grid.drawable)
								end
							else
									-- As there is no current item, we must now fill the background with the
									-- parent background color.
								grid.drawable.set_foreground_color (grid.background_color)
								grid.drawable.fill_rectangle (current_item_x_position, current_item_y_position, current_column_width, current_row_height)
							end							
							
							visible_column_indexes.forth
						end
						visible_row_indexes.forth
					end
				end
				-- Now draw in the background area where no items were displayed if required.
				-- Note that we perform the vertical and horizontal drawing seperately so there may be overlap if both are
				-- being drawn at once. This does not matter as it is simpler to implement, has no real performance impact as
				-- it is simply drawing a rectangle and dows not flicker.
				
			if last_column_index = grid.column_count then				
				rectangle_width := internal_client_width - (column_offsets @ (column_offsets.count) - internal_client_x)
				if rectangle_width >= 0 then
						-- Check to see if we must draw the background to the right of the items.
					grid.drawable.set_foreground_color (grid.background_color)
					grid.drawable.fill_rectangle (horizontal_buffer_offset + internal_client_width - rectangle_width, vertical_buffer_offset, rectangle_width, internal_client_height)
				end
			end
			if current_row = Void or else current_row.index = grid.row_count then
				if grid.is_row_height_fixed and not grid.is_tree_enabled then
						-- Special handling for fixed row heights as `row_offsets' does not exist.
					rectangle_height := internal_client_height - ((grid.row_height * (grid.row_count - skipped_rows)) - internal_client_y)
				else
					rectangle_height := internal_client_height - (row_offsets @ (row_offsets.count) - internal_client_y)
				end
				if rectangle_height >= 0 then
						-- Check to see if must draw the background below the items.
					grid.drawable.set_foreground_color (grid.background_color)
					grid.drawable.fill_rectangle (horizontal_buffer_offset, vertical_buffer_offset + internal_client_height - rectangle_height, internal_client_width, rectangle_height)
				end
			end
			else
					-- In this situation, the grid is completely empty, so we simply fill the background color.
				grid.drawable.set_foreground_color (grid.background_color)
				grid.drawable.fill_rectangle (an_x, a_y, a_width, a_height)
			end
		end
		
	white: EV_COLOR is
			-- Once access to the color white.
		do
			Result := (create {EV_STOCK_COLORS}).white
		end
		
	black: EV_COLOR is
			-- Once acces to the color black.
		do
			Result := (create {EV_STOCK_COLORS}).black
		end
		
	expand_pixmap: EV_PIXMAP is
			-- A pixmap representing the image used for the expand pixmap.
		local
			start_offset, end_offset, middle_offset: INTEGER
		once
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create Result
			Result.set_size (tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (white)
			Result.clear
			Result.set_foreground_color (black)
			Result.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			Result.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
			Result.draw_segment (middle_offset, start_offset, middle_offset, end_offset)
		ensure
			result_not_void: Result /= Void
		end
		
	collapse_pixmap: EV_PIXMAP is
			-- A pixmap representing the image used for the collapse pixmap.
		local
			start_offset, end_offset, middle_offset: INTEGER
		once
			start_offset := 2
			end_offset := tree_node_button_dimension - start_offset - 1
			middle_offset := tree_node_button_dimension // 2
			create Result
			Result.set_size (tree_node_button_dimension, tree_node_button_dimension)
			Result.set_foreground_color (white)
			Result.clear
			Result.set_foreground_color (black)
			Result.draw_rectangle (0, 0, tree_node_button_dimension, tree_node_button_dimension)
			Result.draw_segment (start_offset, middle_offset, end_offset, middle_offset)
		end
	
	tree_node_button_dimension: INTEGER is 9	
		-- Dimension of the expand/collapse node used in the tree.
		
	horizontal_border_width: INTEGER is 3
		-- Border from edge of text to edge of grid items.
		
	tree_indent: INTEGER is 16
		-- The indent used for each subsequent depth in the tree.

feature {NONE} -- Implementation

invariant
	grid_not_void: grid /= Void

end
