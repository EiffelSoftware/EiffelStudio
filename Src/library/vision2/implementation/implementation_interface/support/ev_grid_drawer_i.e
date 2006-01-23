indexing
	description: "Objects that draw the EV_GRID widget as required."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create temp_rectangle
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
			a_width_non_negative: a_width >= 0
		local
			internal_client_x: INTEGER
			horizontal_buffer_offset: INTEGER
			physical_column_indexes: SPECIAL [INTEGER]
			first_column_index: INTEGER
			last_column_index: INTEGER
			first_column_index_set, last_column_index_set: BOOLEAN
			column_offsets: ARRAYED_LIST [INTEGER]
			invalid_x_start, invalid_x_end: INTEGER
			i: INTEGER
			internal_client_width: INTEGER
		do
			create Result.make (20)
			
			physical_column_indexes := grid.physical_column_indexes
		
			internal_client_x := grid.internal_client_x
			internal_client_width := grid.viewable_width
			
			horizontal_buffer_offset := grid.viewport_x_offset
			
			
			if grid.column_count > 0 then
					-- If the grid has no columns, then there may not be any column indexes
					-- which span the area, so do nothing.

				invalid_x_start := an_x
				invalid_x_end := an_x + a_width
				if invalid_x_end >= 0 and invalid_x_start <= grid.virtual_width then
						-- There is nothing to perform if the positions to be checked
						-- fall completely outside of the virtual width.

						-- Limit the positions chacked to the virtual width if the area is intersected.
					invalid_x_start := invalid_x_start.max (0)
					invalid_x_end := invalid_x_end.min (grid.virtual_width)

					column_offsets := grid.column_offsets
						-- Retriece the offsets of all columns from `grid'.
						
					
						-- Calculate the columns that must be displayed.
					from
						column_offsets.start				
					until
						last_column_index_set or column_offsets.off
					loop
						i := column_offsets.item
						if not first_column_index_set and then i > invalid_x_start then
							first_column_index := column_offsets.index - 1
							first_column_index_set := True
						end
						if first_column_index_set and grid.column_displayed (column_offsets.index - 1) then
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
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	items_spanning_vertical_span (a_y, a_height: INTEGER): ARRAYED_LIST [INTEGER] is
			-- For a virtual position starting at `a_y' with a height of `a_height',
			-- return all of the row indexes which intersect this width.
		require
			a_height_non_negative: a_height >= 0
		local
			internal_client_y: INTEGER
			vertical_buffer_offset: INTEGER
			current_row: EV_GRID_ROW_I
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
			l_row_count: INTEGER
			start_pos: INTEGER
			found: BOOLEAN
			grid_row_count: INTEGER
		do
			dynamic_content_function := grid.dynamic_content_function
			create Result.make (20)
			grid_row_count := grid.row_count

			row_offsets := grid.row_offsets

			internal_client_y := grid.internal_client_y
			internal_client_height := grid.viewable_height

			vertical_buffer_offset := grid.viewport_y_offset
			
			if not grid.header.is_empty then
				
					-- Calculate the rows that must be displayed.
					-- Compute the virtual positions of the invalidated area.
				invalid_y_start := a_y
				invalid_y_end := a_y + a_height

				if invalid_y_end >= 0 and invalid_y_start <= grid.virtual_height then
						-- There is nothing to perform if the positions to be checked
						-- fall completely outside of the virtual height.

						-- Limit the positions chacked to the virtual height if the area is intersected.
					invalid_y_start := invalid_y_start.max (0)
					invalid_y_end := invalid_y_end.min (grid.virtual_height)




					if grid.is_row_height_fixed and not grid.is_tree_enabled then
							-- If row heights are fixed we can calculate instead of searching.
							-- Note that we cannot calculate if there is tree functionality enabled in
							-- the grid as nodes may be expanded or collapsed.
						first_row_index := (((invalid_y_start) // grid.row_height) + 1)
						last_row_index := (((invalid_y_end) // grid.row_height) + 1).min (grid_row_count)
						
						if first_row_index <= grid_row_count then
							l_row_count := grid_row_count
							from
								i := first_row_index
							until
								i > last_row_index
							loop
								Result.extend (i)
								check
									i_positive: i >= 0
								end
								i := i + 1
							end
						end
					else
						row_offsets := grid.row_offsets
						if grid_row_count >= 1 then
								-- Only compute the rows that span the area if there are rows
								-- are contained in `grid'. If not, there is nothing to perform here
								-- and `Result' is simply an empty list.
							from
								i := 1
							until
								i > grid_row_count or found
							loop
								if row_offsets @ i > invalid_y_start then
									found := True
								else
									i := i + pre_search_iteration_size
								end
							end
							start_pos := i - pre_search_iteration_size
		
								-- If the starting index has fallen within a tree structure,
								-- we must start from the beginning of the root parent.
							if start_pos <= grid_row_count and then grid.row_internal (start_pos).parent_row /= Void then
								start_pos := grid.row_internal (start_pos).parent_row_root.index
							end
		
							from
								row_counter := start_pos
								i := 0
							until
								last_row_index_set or row_counter > grid_row_count
							loop
								i := row_offsets @ (row_counter)
								current_row := grid.rows.i_th (row_counter)
								if grid.is_row_height_fixed then
									current_height := grid.row_height
								else
									current_height := current_row.height
								end
		
								if not first_row_index_set and then (i + current_height) > (invalid_y_start) then
									first_row_index := row_counter
									first_row_index_set := True
								end
								if first_row_index_set then
									Result.extend (row_counter)
								end
		
								if not last_row_index_set and then (invalid_y_end) < i + current_height then
									last_row_index := row_counter
									last_row_index_set := True
								end
								if current_row /= Void then
										-- If the mode is partially dynamic and a tree is enabled, it
										-- is possible that the current row may not exist.
									if current_row.subrow_count > 0 and not current_row.is_expanded then
										if not first_row_index_set then
											skipped_rows := skipped_rows + current_row.subrow_count_recursive	
										end
										row_counter := row_counter + current_row.subrow_count_recursive
									end
								end
								row_counter := row_counter + 1
							end
						end
					end
				end
				if last_row_index = 0 then
					last_row_index := grid_row_count
				end
				if first_row_index = 0 then
					first_row_index := grid_row_count
				end
			end
			
		ensure
			Result_not_void: Result /= Void
		end
		
	item_at_virtual_position (an_x, a_y: INTEGER): EV_GRID_ITEM_I is
			-- `Result' is item at virtual position `an_x', `a_y' relative to the top
			-- left hand corner of the virtual size.
		do
			Result := item_at_position (an_x - grid.internal_client_x + grid.viewport_x_offset, a_y - grid.internal_client_y + grid.viewport_y_offset)
		end

	item_coordinates_at_position (an_x, a_y: INTEGER): EV_COORDINATE is
			-- `Result' is coordinates of item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. The bounded item
			-- incorporates the tree node if any. No checking of whether the item at this posibion is `Void'.
		local
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
		do
			grid.perform_horizontal_computation
			grid.perform_vertical_computation
				-- Recompute vertical row heights and scroll bar positions before
				-- querying the item positions
			horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), 0)
			vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
			if not horizontal_span_items.is_empty and not vertical_span_items.is_empty then
				create Result.make (horizontal_span_items.first, vertical_span_items.first)
			end
		end

	item_at_position (an_x, a_y: INTEGER): EV_GRID_ITEM_I is
			-- `Result' is item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. The bounded item
			-- incorporates the tree node if any.
		local
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
		do
			grid.perform_horizontal_computation
			grid.perform_vertical_computation
				-- Recompute vertical row heights and scroll bar positions before
				-- querying the item positions
			horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), 0)
			vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
			if not horizontal_span_items.is_empty and not vertical_span_items.is_empty then
				Result := grid.item_internal (horizontal_span_items.first, vertical_span_items.first)
			end
		end
		
	item_at_position_strict (an_x, a_y: INTEGER): EV_GRID_ITEM_I is
			-- `Result' is item at position `an_x', `a_y' relative to the top left corner
			-- of the `grid.drawable' in which the grid is displayed. This version
			-- returns `Void' if the pointed_part of the item is part of a tree node.
		local
			horizontal_span_items, vertical_span_items: ARRAYED_LIST [INTEGER]
			item_indent: INTEGER
		do
			grid.perform_horizontal_computation
			grid.perform_vertical_computation
				-- Recompute vertical row heights and scroll bar positions before
				-- querying the item positions
			horizontal_span_items := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), 0)
			vertical_span_items := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), 0)
			if not horizontal_span_items.is_empty and not vertical_span_items.is_empty then
				Result := grid.item_internal (horizontal_span_items.first, vertical_span_items.first)
				if Result /= Void then
					item_indent := grid.item_indent (Result)
					if an_x - Result.virtual_x_position < 0 then
						Result := Void
					end
				end
			end
		end
		
	redraw_area_in_virtual_coordinates (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw grid contents at coordinates `an_x', `a_y', `a_width', `a_height'
			-- relative to the upper left corner of the virtual area.
		do
			redraw_area_in_drawable_coordinates (an_x - grid.internal_client_x + grid.viewable_x_offset, a_y - grid.internal_client_y + grid.viewport_y_offset, a_width, a_height)
		end

	redraw_area_in_drawable_coordinates (an_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw grid contents at coordinates `an_x', `a_y', `a_width', `a_height'
			-- relative to the upper left corner of the `drawable' widget of `grid'.
--		require
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
			
			physical_column_indexes: SPECIAL [INTEGER]
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
			current_tree_adjusted_item_x_position, current_tree_adjusted_column_width: INTEGER
			dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
			internal_client_width, internal_client_height: INTEGER
			current_subrow_indent: INTEGER
			visible_column_indexes: ARRAYED_LIST [INTEGER]
			visible_row_indexes: ARRAYED_LIST [INTEGER]
			standard_subrow_indent: INTEGER
			drawing_subrow, drawing_parentrow: BOOLEAN
			node_index, parent_node_index: INTEGER
			parent_subrow_indent: INTEGER
			parent_x_indent_position: INTEGER
			tree_node_spacing: INTEGER
			total_tree_node_width: INTEGER
			collapse_pixmap, expand_pixmap: EV_PIXMAP
			first_tree_node_indent: INTEGER
			node_pixmap_width, node_pixmap_height: INTEGER
			parent_row_i: EV_GRID_ROW_I
			l_pixmap: EV_PIXMAP
			
			row_vertical_center: INTEGER
			row_vertical_bottom: INTEGER
			vertical_node_pixmap_top_offset: INTEGER
			vertical_node_pixmap_bottom_offset: INTEGER
			horizontal_node_pixmap_left_offset: INTEGER
			node_pixmap_vertical_center: INTEGER
			l_x_start, l_x_end: INTEGER
			current_horizontal_pos: INTEGER
			loop_current_row, loop_parent_row: EV_GRID_ROW_I
			are_tree_node_connectors_shown: BOOLEAN
			current_physical_column_index: INTEGER
			translated_parent_x_indent_position: INTEGER
			tree_node_connector_color: EV_COLOR
			grid_rows_data_list: EV_GRID_ARRAYED_LIST [SPECIAL [EV_GRID_ITEM_I]]
			current_column: EV_GRID_COLUMN_I
			drawable: EV_DRAWABLE
			row_count, row_height: INTEGER
			is_tree_enabled, is_content_partially_dynamic : BOOLEAN
			first_item_in_row_drawn: BOOLEAN
			current_parent_row: EV_GRID_ROW_I
			v_y: INTEGER

		do
			if not grid.is_locked then
				-- Perform no re-drawing if the update of the grid is locked.
			
				grid.reset_redraw_item_counter
					-- Although this feature is connected to the `expose_actions' of a drawing area,
					-- there is currently a bug/feature on Windows where it is possible for the Wm_paint
					-- message to be generated even though there is no invalid area (width and height are 0).
					-- Therefore, we protect against this case and perform no re-drawing if there is no area
					-- to be re-drawn.
				if a_width > 0 and a_height > 0 then
					item_buffer_pixmap.set_copy_mode
					dynamic_content_function := grid.dynamic_content_function
					
					grid.perform_horizontal_computation
					grid.perform_vertical_computation
						-- Recompute vertical row heights and scroll bar positions before
						-- calculating the draw positions. The recomputation is only
						-- performed internally if they are flagged as requiring a re-compute.
					
					create column_widths.make (8)
					column_widths.extend (0)
					
					expand_pixmap := grid.expand_node_pixmap
					collapse_pixmap := grid.collapse_node_pixmap
		
					are_tree_node_connectors_shown := grid.are_tree_node_connectors_shown
					tree_node_connector_color := grid.tree_node_connector_color
					
					tree_node_spacing := grid.tree_node_spacing
						-- Retrieve the spacing around each node.
						
						-- Retrieve properties for drawing from the grid.
					node_pixmap_width := grid.node_pixmap_width
					node_pixmap_height := expand_pixmap.height
					standard_subrow_indent := grid.tree_subrow_indent
					total_tree_node_width := grid.total_tree_node_width
					first_tree_node_indent := grid.first_tree_node_indent
	
	
					physical_column_indexes := grid.physical_column_indexes
					
					internal_client_x := grid.internal_client_x
					internal_client_y := grid.internal_client_y
					internal_client_width := grid.viewable_width
					internal_client_height := grid.viewable_height
					
					vertical_buffer_offset := grid.viewport_y_offset
					horizontal_buffer_offset := grid.viewport_x_offset
					drawable := grid.drawable
					row_count := grid.row_count
					is_tree_enabled := grid.is_tree_enabled
					is_content_partially_dynamic := grid.is_content_partially_dynamic
					row_height := grid.row_height
					
					
					if row_count > 0 and grid.column_count > 0 then
						column_offsets := grid.column_offsets
						row_offsets := grid.row_offsets
	
							-- Note that here we need to remove 1 from `a_width' and `a_height' before
							-- calculating the visible column and row indexes, as one of the pixels
							-- is already included within the offset pixel.
						visible_column_indexes := items_spanning_horizontal_span (drawable_x_to_virtual_x (an_x), a_width - 1)
						visible_row_indexes := items_spanning_vertical_span (drawable_y_to_virtual_y (a_y), a_height - 1)
						if not (visible_column_indexes.is_empty or visible_row_indexes.is_empty) then
							first_column_index := visible_column_indexes.first
							last_column_index := visible_column_indexes.last
							
							
							first_row_index := visible_row_indexes.first
							current_item_y_position := 0
			
							from
								visible_row_indexes.start
								grid_rows_data_list := grid.internal_row_data
							until
								visible_row_indexes.off
							loop						
								current_row_index := visible_row_indexes.item
									-- Retrieve information regarding the rows that we must draw.
								current_row := grid.row_internal (current_row_index)
								current_row_list := grid_rows_data_list @ (current_row_index)
						
								if grid.is_row_height_fixed and not is_tree_enabled then
									current_item_y_position := (row_height * (current_row_index - 1)) - (internal_client_y - vertical_buffer_offset)
									current_row_height := row_height
								else
									current_item_y_position := (row_offsets @ (current_row_index)) - (internal_client_y - vertical_buffer_offset)
									if grid.is_row_height_fixed then
										current_row_height := row_height
									else
										current_row_height := current_row.height
									end
								end
								
								if is_tree_enabled then
									-- Only perform the following calculations if the tree is enabled
									-- as otherwise, they are not required.
									-- Note that `current_row' may be Void if we are in partially dynamic mode
									-- and a tree is enabled. If subrows were set, it is not possible for `current_row' to be Void.
								
									parent_row_i := current_row.parent_row_i
								
									drawing_subrow := parent_row_i /= Void
										-- Are we drawing a subrow of the tree?
		
									drawing_parentrow := current_row.is_expandable
										-- Are we drawing a row that is a parent of other rows?
									
									if drawing_subrow or drawing_parentrow then
										-- We are now about to draw a row that is a subrow of another row, so
										-- perform any calculations required.
	
										node_index := retrieve_node_index (current_row)
	
										if drawing_subrow then
											parent_node_index := retrieve_node_index (parent_row_i)
											from
												current_parent_row := parent_row_i
											until
												current_parent_row = Void
											loop
												parent_node_index := parent_node_index.max (current_parent_row.index_of_first_item)
												current_parent_row := current_parent_row.parent_row_i
											end
											parent_subrow_indent := grid.item_cell_indent (parent_node_index, parent_row_i.index) + ((node_pixmap_width + 1) // 2)
											parent_x_indent_position := parent_subrow_indent
											node_index := node_index.max (parent_node_index)
										end
									else
										node_index := 1
									end
									
										-- Now compute variables required for drawing tree structures.
										-- Note that here we only compute the vertical variables because as each row
										-- has a fixed height, they can be computed outside of the inner row iteration.
										-- The horizontal offsets must be computed within the inner loop.
									row_vertical_center := (current_row_height // 2)
									row_vertical_bottom := current_row_height
		
									vertical_node_pixmap_top_offset := ((current_row_height - node_pixmap_height + 1)// 2)
									vertical_node_pixmap_bottom_offset := vertical_node_pixmap_top_offset + node_pixmap_height
	
									current_subrow_indent := subrow_indent (current_row)
								end
								
								from
									visible_column_indexes.start
									current_item_x_position := 0
									first_item_in_row_drawn := False
								until
									visible_column_indexes.off
								loop
									check
										lists_valid_lengths: physical_column_indexes.count >= visible_column_indexes.count
									end
									current_column_index := visible_column_indexes.item
									current_column := grid.columns @ current_column_index
									current_column_width := column_offsets @ (current_column_index + 1) - column_offsets @ (current_column_index)
	
										-- If the current column has a width of 0, then there is no need to
										-- perform any drawing. This is especially beneficial to dynamic content
										-- in the grid as the dynamic content function is not called until
										-- the width of the column necessitates this.
									if current_column_width > 0 then
										current_physical_column_index := physical_column_indexes.item (visible_column_indexes.item - 1)
										
										
											-- Assume that there is no grid item at the current position.
											-- It is not possible to simply set `grid_item' to Void within the loop as otherwise
											-- this effectively inserts `Void' at the grid item's position within the grid's
											-- data structures. So we use a BOOLEAN to determine this instead.
										grid_item_exists := False
				
										if current_row_list /= Void and then current_physical_column_index < current_row_list.count then
												-- If the grid is set to retrieve completely dynamic content, then we do not execute this code
												-- as the current contents of the grid are never used. We also check that the current row and
												-- current row position are valid.
												
											grid_item := current_row_list @ (current_physical_column_index)
												-- In this case, we have found the grid item so we flag this fact
												-- so that the calculations for the partial dynamic content know that
												-- a new item must not be retrieved.
											if grid_item /= Void then
												grid_item_exists := True
											end
										end
					
										current_item_x_position  := (column_offsets @ (current_column_index)) - (internal_client_x - horizontal_buffer_offset)
										
										if is_content_partially_dynamic and then not grid_item_exists and dynamic_content_function /= Void then
												-- If we are dynamically computing the contents of the grid and we have not already retrieved an item for
												-- the grid, then we execute this code.
	
											grid_item_interface := dynamic_content_function.item ([current_column_index, current_row_index])
	
													-- We now check that the set item is the same as the one returned. If you both
													-- set an item and return a different item from the dynamic function, this is invalid
													-- so the following check prevents this:
											check
												item_set_implies_set_item_is_returned_item: grid.item_internal (visible_column_indexes.item, visible_row_indexes.item) /= Void
													implies grid.item_internal (visible_column_indexes.item, visible_row_indexes.item) = grid_item_interface.implementation
											end
											
											if grid_item_interface /= Void then
												grid_item := grid_item_interface.implementation
	
													-- Note that the item is added to the grid in both partial and complete dynamic modes.
													-- It is possible that a user called `set_item' with the returned item, as well
													-- as returning it, so in this case, we only call `set_item' if it was not set.
												if grid.item (visible_column_indexes.item, visible_row_indexes.item) = Void then
													grid.set_item (visible_column_indexes.item, visible_row_indexes.item, grid_item.interface)
												end
	
												grid_item_exists := True
											end
												-- We must now recompute the tree status of the current row as during the
												-- dynamic computation, a user may have performed something which modified the
												-- tree structure, therby invalidating our previously calculated tree information.
												-- Unfortunately, this must be computed for every item that is retrieved dynamically
												-- as it is not possible for us to know which item may modify the tree structure.
												-- The overhead of this should not be too high, but it is unfortunate. Julian
											if is_tree_enabled then
												parent_row_i := current_row.parent_row_i
											
												drawing_subrow := parent_row_i /= Void
													-- Are we drawing a subrow of the tree?
					
												drawing_parentrow := current_row.is_expandable
													-- Are we drawing a row that is a parent of other rows?
												
												if drawing_subrow or drawing_parentrow then
													-- We are now about to draw a row that is a subrow of another row, so
													-- perform any calculations required.
				
													node_index := retrieve_node_index (current_row)
				
													if drawing_subrow then
														parent_node_index := retrieve_node_index (parent_row_i)
														from
															current_parent_row := parent_row_i
														until
															current_parent_row = Void
														loop
															parent_node_index := parent_node_index.max (current_parent_row.index_of_first_item)
															current_parent_row := current_parent_row.parent_row_i
														end
														parent_subrow_indent := grid.item_cell_indent (parent_node_index, parent_row_i.index) + ((node_pixmap_width + 1) // 2)
														parent_x_indent_position := parent_subrow_indent
														node_index := node_index.max (parent_node_index)
													end
												else
													node_index := 1
												end
												
													-- Now compute variables required for drawing tree structures.
													-- Note that here we only compute the vertical variables because as each row
													-- has a fixed height, they can be computed outside of the inner row iteration.
													-- The horizontal offsets must be computed within the inner loop.
												row_vertical_center := (current_row_height // 2)
												row_vertical_bottom := current_row_height
					
												vertical_node_pixmap_top_offset := ((current_row_height - node_pixmap_height + 1)// 2)
												vertical_node_pixmap_bottom_offset := vertical_node_pixmap_top_offset + node_pixmap_height
				
												current_subrow_indent := subrow_indent (current_row)
											end
		
												-- Now retrieve `current_row_list' again. This is because as an item is added,
												-- the row list is resized, which produces a new object.
											current_row_list := grid_rows_data_list @ (current_row_index)							
										end
											-- Resize the bufer if required. The buffer is only every increased and never decreased
											-- as this prevents us from having to continuously change its size, which is an
											-- unecessary overhead.
										if item_buffer_pixmap.width < current_column_width or item_buffer_pixmap.height < current_row_height then
											item_buffer_pixmap.set_size (current_column_width, current_row_height)
										end
		
											-- Now compute horizontal variables for tree drawing.
										if drawing_parentrow then
											horizontal_node_pixmap_left_offset := current_subrow_indent - (tree_node_spacing * 2) - node_pixmap_width
										elseif drawing_subrow then
											horizontal_node_pixmap_left_offset := current_subrow_indent
										else
											horizontal_node_pixmap_left_offset := current_column_width
										end
										node_pixmap_vertical_center := current_subrow_indent - (tree_node_spacing * 2) - (node_pixmap_width + 1) // 2
		
										current_tree_adjusted_item_x_position := current_item_x_position
										current_tree_adjusted_column_width := current_column_width
		
										if grid_item_exists then
											item_buffer_pixmap.set_foreground_color (grid_item.displayed_background_color)
										else
											item_buffer_pixmap.set_foreground_color (grid.displayed_background_color (current_column_index, current_row_index))
										end
											-- Now draw the complete background area for the cell in the grid that is currently being drawn.
											fixme (Once "For drawable grid items, there is no need to do this, preventing overdraw.")
										item_buffer_pixmap.fill_rectangle (0, 0, current_column_width, current_row_height)
		
											-- Fire the `pre_draw_overlay_actions' which enable a user to draw on top of the background
											-- but bloe the features of drawn grid items before they are displayed.
										if grid.pre_draw_overlay_actions_internal /= Void then
											if grid_item_exists then
												grid.pre_draw_overlay_actions_internal.call ([item_buffer_pixmap, grid_item.interface, current_column_index, current_row_index])
											else
												grid.pre_draw_overlay_actions_internal.call ([item_buffer_pixmap, Void, current_column_index, current_row_index])
											end
										end
		
										if is_tree_enabled then
		
											if current_column_index = node_index then
		
												current_tree_adjusted_item_x_position := current_tree_adjusted_item_x_position + current_subrow_indent
												current_tree_adjusted_column_width := current_tree_adjusted_column_width - current_subrow_indent
													-- We adjust the horizontal position and width of the current item by the space required
													-- for the tree node.
		
													-- If the indent of the tree is less than `current_column_width', it must be visible so draw it.
												if current_row.is_expandable then
														-- Note we add 1 to account for rounding errors when odd values.
													if current_row.is_expanded then
														l_pixmap := collapse_pixmap
													else
														l_pixmap := expand_pixmap
													end
														-- Now check if we must clip the pixmap vertically
													fixme (Once "Add horizontal clipping for pixmaps.")
													if horizontal_node_pixmap_left_offset < current_column_width then
														if node_pixmap_height > current_row_height then
																-- In this situation, the height of the expand image is greater than the current row height,
																-- so we only draw the part that fits within the node.
															temp_rectangle.move_and_resize (0, (node_pixmap_height - current_row_height) // 2, node_pixmap_height, current_row_height)
															item_buffer_pixmap.draw_sub_pixmap (horizontal_node_pixmap_left_offset, 0, l_pixmap, temp_rectangle)
														else
															item_buffer_pixmap.draw_pixmap (horizontal_node_pixmap_left_offset, vertical_node_pixmap_top_offset, l_pixmap)
														end
													end
												end
													-- We must now draw the lines for the tree structure.
		
												if current_subrow_indent > 0 and are_tree_node_connectors_shown then
													if current_column_index > 1 or drawing_subrow then
														l_x_start := current_subrow_indent
														if current_row.is_expandable then
															l_x_end := horizontal_node_pixmap_left_offset + node_pixmap_width
														else
															if parent_node_index = node_index then
																l_x_end := node_pixmap_vertical_center
															else
																l_x_end := 0
															end
														end
														item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
														if l_x_start < current_column_width then
																-- If the edge of the horizontal line from the left edge of the item is within the position
																-- of the column, we must draw it, otherwise it is clipped below in the "elseif"
		
															item_buffer_pixmap.draw_segment (l_x_start, row_vertical_center, l_x_end, row_vertical_center)
																-- Draw a horizontal line from the left edge of the item to the either the node horizontal offset or the edge of the actual item position
															 	-- if the node to which we are connected is within a different column.
		
															 if parent_node_index /= node_index and current_row.is_expandable then
															 		-- Draw the horizontal line from the left edge of the expand icon to the start of
															 		-- the grid cell as the horizontal line spans into other grid cells.
															 	item_buffer_pixmap.draw_segment (0, row_vertical_center, horizontal_node_pixmap_left_offset, row_vertical_center)
															 end
														elseif l_x_end.min (current_item_x_position + current_column_width) /= current_item_x_position + current_column_width then
																-- Now we must clip the horizontal segment and draw.
															item_buffer_pixmap.draw_segment (l_x_end.min (current_column_width), row_vertical_center, current_column_width, row_vertical_center)
														end
													end
		
													if drawing_subrow and then parent_node_index = current_column_index then
		
														current_horizontal_pos := node_pixmap_vertical_center
														if are_tree_node_connectors_shown then
															item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
															if current_horizontal_pos < column_offsets @ (node_index + 1) then
																	-- Draw the vertical line at the node, connecting the top and bottom
																	-- of the tree row.
																if parent_row_i.subrow_count_recursive > ((current_row.index + current_row.subrow_count_recursive) - parent_row_i.index) then
																		-- In this case we are not the final row in the parents structure, so we must draw from the top of
																		-- the row to the bottom.
																	if current_row.is_expandable then
																			-- The row displays an expand or collapse pixmap, so draw the lines above and below. Subtract one as we
																			-- do not want to overwrite the first line of the pixmap.
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_top_offset - 1, node_pixmap_vertical_center, 0)
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_bottom_offset, node_pixmap_vertical_center, row_vertical_bottom)
																	else
																			-- Draw a single line from top to bottom.
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, 0, node_pixmap_vertical_center, row_vertical_bottom)
																	end
																else
																		-- We are the final row in the parents structure, so we draw from the center of the row to the top.
																	if current_row.is_expandable then
																			-- Draw from the top of the node. Subtract one as we do not want to overwrite the first line of the pixmap.
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, vertical_node_pixmap_top_offset - 1, node_pixmap_vertical_center, 0)
																	else
																			-- Draw from the center of the row as no node pixmap is displayed.
																		item_buffer_pixmap.draw_segment (node_pixmap_vertical_center, row_vertical_center, node_pixmap_vertical_center, 0)
																	end
																end
															end
		
																-- Now we draw all of the horizontal lines required to fill in the lines of parents at any level.
																-- We iterate backwards from the current position and for each subsequent parent node, determine
																-- if a line must be drawn.
															from
																loop_current_row := parent_row_i
																loop_parent_row := parent_row_i.parent_row_i
															until
																current_horizontal_pos < current_item_x_position or loop_parent_row = Void
															loop
																current_horizontal_pos := current_horizontal_pos - standard_subrow_indent
																if current_horizontal_pos < current_item_x_position + current_column_width then
																		-- It is possible that the current vertical line segment that we must draw is outside the right hand
																		-- edge of the item. In this case, we simply do not draw it. This reduces flicker and time spent
																		-- drawing.
		
																	if loop_parent_row.subrow_count_recursive > ((loop_current_row.index + loop_current_row.subrow_count_recursive) - loop_parent_row.index) then
																			-- If the current item is the last one contained within the parent then a line must be drawn. As this is
																			-- computed in a nested fashion, the subnode count is used recursively.
		
																		item_buffer_pixmap.draw_segment (current_horizontal_pos, row_vertical_bottom, current_horizontal_pos, 0)
																			-- Draw the vertical line from the bottom of the item to the top.
																	end
																end
		
																	-- Move one position upwards within the parenting node structure
																loop_current_row := loop_parent_row
																loop_parent_row := loop_parent_row.parent_row_i
															end
														end
													end
												end
											end
										end
										if grid_item_exists then
											if current_tree_adjusted_item_x_position - current_item_x_position < current_column_width then
												if current_column_index = node_index then
													grid_item.perform_redraw (current_tree_adjusted_item_x_position, current_item_y_position, current_tree_adjusted_column_width, current_row_height, current_subrow_indent, item_buffer_pixmap)
												else
													grid_item.perform_redraw (current_tree_adjusted_item_x_position, current_item_y_position, current_tree_adjusted_column_width, current_row_height, 0, item_buffer_pixmap)
												end
											end
											first_item_in_row_drawn := True
										else
		
											translated_parent_x_indent_position := (parent_x_indent_position + grid.subrow_indent - 1)
		
											if parent_node_index < current_column_index then
												translated_parent_x_indent_position := 0
											end
		
										item_buffer_pixmap.set_foreground_color (tree_node_connector_color)
											if drawing_subrow and ((current_column_index = current_row.index_of_first_item)) then
													-- Here we must extend the line drawn from the horizontal offsets of the parent to the start of this item.
													-- As the item is `Void', we set the end to the right hand edge of the column.
												l_x_end := current_column_width
												if parent_node_index /= current_column_index then
														-- In this case, there is no parent node connection from within this cell, so we
														-- set the left edge for drawing to the very left edge of the column.
													l_x_start := 0
												end
												item_buffer_pixmap.draw_segment (l_x_start, row_vertical_center, l_x_end, row_vertical_center)
											end
											if are_tree_node_connectors_shown and (drawing_subrow or drawing_parentrow) and current_column_index /= node_index and current_column_index >= parent_node_index then
		
													-- We must now draw the lines for the tree structure, as although there is no item
													-- at this location in the grid, a tree line may cross it horizontally.
												if current_column_index < node_index then
		
													item_buffer_pixmap.draw_segment (translated_parent_x_indent_position.min (current_column_width), row_vertical_center, current_column_width, row_vertical_center)
														-- The background area for the tree node must always be refreshed, even if the node is not visible.
														-- We draw no wider than `current_column_width' to ensure this.
												end
												if (parent_node_index = current_column_index) and (translated_parent_x_indent_position < current_column_width) then
														-- If the grid column being drawn matches that in which the
														-- node of `parent_row_i' is contained, then vertical lines must be drawn
														-- to connect the lines.
		
													if parent_row_i.subrow_count > (current_row.index - parent_row_i.index) then
															-- In this case, there are more subrows of `parent_row_i' to be drawn,
															-- so the vertical line is drawn to span the complete height of the current row.
														item_buffer_pixmap.draw_segment (translated_parent_x_indent_position, row_vertical_bottom, translated_parent_x_indent_position, 0)
		
													else
															-- There are no subsequent rows for `parent_row_i' so we must draw the vertical line
															-- from the start of the current row to the center only.
														item_buffer_pixmap.draw_segment (translated_parent_x_indent_position, row_vertical_center, translated_parent_x_indent_position, 0)
													end
		
												end
											end
										end
											-- Now draw the border for `grid_item'.
										draw_item_border (current_column, current_row, grid_item, current_item_x_position, current_item_y_position, current_column_width, current_row_height)
		
											-- Now call the post draw overlay actions on the grid, permitting overdraw as required.
										if grid.post_draw_overlay_actions_internal /= Void then
											if grid_item_exists then
												grid.post_draw_overlay_actions_internal.call ([item_buffer_pixmap, grid_item.interface, current_column_index, current_row_index])
											else
												grid.post_draw_overlay_actions_internal.call ([item_buffer_pixmap, Void, current_column_index, current_row_index])
											end
										end
		
											-- Now blit the buffered drawing for the item to `drawable'.
										temp_rectangle.move_and_resize (0, 0, current_column_width, current_row_height)
										drawable.draw_sub_pixmap (current_item_x_position, current_item_y_position, item_buffer_pixmap, temp_rectangle)
									end
									visible_column_indexes.forth
								end
								visible_row_indexes.forth
							end
						end
						-- Now draw in the background area where no items were displayed if required.
						-- Note that we perform the vertical and horizontal drawing seperately so there may be overlap if both are
						-- being drawn at once. This does not matter as it is simpler to implement, has no real performance impact as
						-- it is simply drawing a rectangle and does not flicker.
						
					rectangle_width := internal_client_width - (column_offsets @ (column_offsets.count) - internal_client_x)
						-- We compute the rectangle width based on the position of the final item within `column_offsets'.
					if rectangle_width > 0 then
						if item_buffer_pixmap.width < rectangle_width or item_buffer_pixmap.height < internal_client_height then
							item_buffer_pixmap.set_size (rectangle_width, internal_client_height)
						end
							-- Check to see if we must draw the background to the right of the items.
						if grid.fill_background_actions_internal /= Void and then not grid.fill_background_actions_internal.is_empty then
							grid.fill_background_actions_internal.call ([item_buffer_pixmap, column_offsets @ (column_offsets.count), internal_client_y, rectangle_width, internal_client_height])
						else
							item_buffer_pixmap.set_foreground_color (grid.background_color)
							item_buffer_pixmap.fill_rectangle (0, 0, rectangle_width, internal_client_height)
						end
						temp_rectangle.move_and_resize (0, 0, rectangle_width, internal_client_height)
						drawable.draw_sub_pixmap  (horizontal_buffer_offset + internal_client_width - rectangle_width, vertical_buffer_offset, item_buffer_pixmap, temp_rectangle)
					end
					if current_row = Void or else current_row.index >= row_count - grid.hidden_node_count then
						if grid.is_row_height_fixed and not is_tree_enabled then
								-- Special handling for fixed row heights as `row_offsets' does not exist.
							v_y := (row_height * (row_count))
							rectangle_height := internal_client_height - (v_y - internal_client_y)
						else
							v_y := row_offsets @ (row_count + 1)
							rectangle_height := internal_client_height - (v_y - internal_client_y)
						end
						if rectangle_height > 0 then
							-- Check to see if must draw the background below the items.
	
							if item_buffer_pixmap.width < internal_client_width or item_buffer_pixmap.height < rectangle_height then
								item_buffer_pixmap.set_size (internal_client_width, rectangle_height)
							end
							if grid.fill_background_actions_internal /= Void and then not grid.fill_background_actions_internal.is_empty then
								grid.fill_background_actions_internal.call ([item_buffer_pixmap, internal_client_x, v_y , internal_client_width, rectangle_height])
							else
								item_buffer_pixmap.set_foreground_color (grid.background_color)
								item_buffer_pixmap.fill_rectangle (0, 0, internal_client_width, rectangle_height)
							end
							temp_rectangle.move_and_resize (0, 0, internal_client_width, rectangle_height)
							drawable.draw_sub_pixmap (horizontal_buffer_offset, vertical_buffer_offset + internal_client_height - rectangle_height, item_buffer_pixmap, temp_rectangle)
						end
					end
					else
							-- In this situation, the grid is completely empty, so we simply fill the background color.
						drawable.set_foreground_color (grid.background_color)
						drawable.fill_rectangle (an_x, a_y, a_width, a_height)
					end
					if not grid.is_column_resize_immediate and grid.is_header_item_resizing and grid.is_resizing_divider_enabled then
							-- Put the resizing line back on the redrawn area so that it can be correctly erased
							-- by being inverted later.
						grid.redraw_resizing_line
					end
				end
			end
		end
		
feature {EV_GRID_DRAWABLE_ITEM_I} -- Implementation

	drawable_item_buffer_pixmap: EV_PIXMAP is
			-- Once access to a pixmap used for drawing into for drawable items.
			-- We do not use `item_buffer_pixmap' for this as this pixmap is exposed to
			-- the interface so, must be resized exactly to the size of the item before
			-- a user retrieves it. They can then query its dimensions to know where to draw to.
		once
			create Result
		end
		
feature {NONE} -- Implementation

	subrow_indent (current_row: EV_GRID_ROW_I): INTEGER is
			-- `Result' is indent of `current_row'.
		require
			current_row_not_void: current_row /= Void
		do
			Result := grid.item_cell_indent (current_row.index_of_first_item, current_row.index)
		ensure
			result_non_negative: Result >= 0
		end

	retrieve_node_index (current_row: EV_GRID_ROW_I): INTEGER is
			-- `Result' is index of first non-`Void' item within `current_row'
			-- or `grid.column_count' if none.
		require
			current_row_not_void: current_row /= Void
		do
			Result := current_row.index_of_first_item
			if Result = 0 then
				Result := 1
			end
		ensure
			valid_result: Result > 0 and Result <= grid.column_count
		end
		
	draw_item_border (current_column: EV_GRID_COLUMN_I; current_row: EV_GRID_ROW_I; current_item: EV_GRID_ITEM_I; current_item_x_position, current_item_y_position, current_column_width, current_row_height: INTEGER) is
			-- Draw a border for `current_item' with a position at `current_item_x_position', `current_item_y_position' and dimensions
			-- of `current_column_width' and `current_row_height'.
		require
			current_column_not_void: current_column /= Void
			current_row_not_void: current_row /= Void
			current_column_width_greater_than_zero: current_column_width > 0
		local
			drawable: EV_DRAWING_AREA
			all_remaining_columns_minimized: BOOLEAN
		do
			drawable := grid.drawable
			item_buffer_pixmap.set_foreground_color (grid.separator_color)
			if grid.are_column_separators_enabled then
				if current_column.index > 1 then
					item_buffer_pixmap.draw_segment (0, 0, 0, current_row_height - 1)
				end
				if current_column.index < grid.column_count then
					if grid.column_offsets.i_th (current_column.index + 1) = grid.column_offsets.i_th (grid.column_count + 1) then
						all_remaining_columns_minimized := True
					end
				end
				if current_column.index = grid.column_count or all_remaining_columns_minimized then
					item_buffer_pixmap.draw_segment (current_column_width - 1, 0,  current_column_width - 1, current_row_height - 1)
				end
			end
			if grid.are_row_separators_enabled then
				item_buffer_pixmap.draw_segment (0, current_row_height - 1, current_column_width, current_row_height - 1)
			end
		end
		
	white: EV_COLOR is
			-- Once access to the color white.
		once
			Result := (create {EV_STOCK_COLORS}).white
		end
		
	black: EV_COLOR is
			-- Once access to the color black.
		once
			Result := (create {EV_STOCK_COLORS}).black
		end
		
	horizontal_border_width: INTEGER is 3
		-- Border from edge of text to edge of grid items.

	pre_search_iteration_size: INTEGER is 1000
		-- When searching for an offset in `row_offsets', this is the value
		-- user to pre-search the data when looking for the first index to start the
		-- iteration from. By performing an intial loop, we can reduce the number of
		-- iterations to be performed in the main loop. Together, the total
		-- number of iterations of both loops is far less. There may be a better
		-- value, but this should give fairly good results. 
		-- The maximum number of iterations is given by (`row_count' / pre_search_iteration_size) + pre_search_iteration_size
		-- Julian 05/16/05

	item_buffer_pixmap: EV_PIXMAP is
			-- Once access to a pixmap used for buffering the drawing to prevent flicker.
		once
			create Result
			Result.set_size (100, 16)
		end
		
	temp_rectangle: EV_RECTANGLE
		-- A rectangle used temporarily by the drawing code.
		-- Prevents the need to keep creating new rectangle objects
		-- which may be a strain on the debugger as many are created unecessarily.

	drawable_x_to_virtual_x (an_x: INTEGER): INTEGER is
			-- Convert `an_x' in drawable coordinates to a virtual x coordinate.
		do
			Result := grid.internal_client_x + an_x - grid.viewport_x_offset
		end

	drawable_y_to_virtual_y (a_y: INTEGER): INTEGER is
			-- Convert `a_y' in drawable coordinates to a virtual y coordinate.
		do
			Result := grid.internal_client_y + a_y - grid.viewport_y_offset
		end

invariant
	grid_not_void: grid /= Void
	temp_rectangle_not_void: temp_rectangle /= Void

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




end
