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

	full_redraw is
			-- Redraw complete client area of `grid'.
		do
			to_implement ("EV_GRID_DRAWER_I.full_redraw")
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
			virtual_x_position, virtual_y_position: INTEGER
			vertical_buffer_offset: INTEGER
			horizontal_buffer_offset: INTEGER
			column_widths: ARRAYED_LIST [INTEGER]
			
			current_row: SPECIAL [EV_GRID_ITEM_I]
			visible_physical_column_indexes: SPECIAL [INTEGER]
			first_column_index, first_row_index: INTEGER
			last_column_index, last_row_index: INTEGER
			first_column_index_set, last_column_index_set, first_row_index_set, last_row_index_set: BOOLEAN
			grid_item: EV_GRID_ITEM_I
			grid_item_interface: EV_GRID_ITEM
			current_index_in_row, current_index_in_column: INTEGER
			column_counter, row_counter: INTEGER
			bool: BOOLEAN
			printing_values: BOOLEAN
			column_offsets, row_offsets: ARRAYED_LIST [INTEGER]
			invalid_x_start, invalid_x_end, invalid_y_start, invalid_y_end: INTEGER
			current_column_width, current_row_height: INTEGER
			rectangle_width, rectangle_height: INTEGER
			i: INTEGER
			grid_item_exists: BOOLEAN
			current_item_y_position, current_item_x_position: INTEGER
			dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
		do
			dynamic_content_function := grid.dynamic_content_function
			printing_values := False
			if printing_values then
				print ("%N%NPartial redraw an_x : " + an_x.out + "a_y : " + a_y.out + "a_width : " + a_width.out + "a_height : " + a_height.out + "%N%N")
			end
			
			create column_widths.make (8)
			column_widths.extend (0)
			
			visible_physical_column_indexes := grid.visible_physical_column_indexes
			
			virtual_x_position := grid.virtual_x_position
			virtual_y_position := grid.virtual_y_position
			
			vertical_buffer_offset := grid.viewport.y_offset
			horizontal_buffer_offset := grid.viewport.x_offset
			
			
			if not grid.header.is_empty then
				if printing_values then
					print ("%NCalculating columns to draw%N")
				end
				column_offsets := grid.column_offsets
					-- Retrieve the column offsets from `grid'.
				check
					column_offsets_count_equal_to_columns: column_offsets.count = grid.column_count + 1
					-- If this fails it means that somebody did not call `grid.recompute_column_offsets' when
					-- they should have done.
				end
				
					-- Calculate the columns that must be displayed.
					-- If row heights are fixed we can perform a quick search.
				
				row_offsets := grid.row_offsets					
					fixme ("implement using a binary search")
				from
					column_offsets.start
						-- Compute the virtual positions of the invalidated area.
					invalid_x_start := virtual_x_position + an_x - horizontal_buffer_offset
					invalid_x_end := virtual_x_position + an_x - horizontal_buffer_offset + a_width		
				until
					last_column_index_set or column_offsets.off
				loop
					i := column_offsets.item
					if not first_column_index_set and then i > invalid_x_start then
						first_column_index := column_offsets.index - 1
						first_column_index_set := True
					end
					if not last_column_index_set and then invalid_x_end < column_offsets.item then
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
				
					-- Calculate the rows that must be displayed.
					-- Compute the virtual positions of the invalidated area.
				invalid_y_start := virtual_y_position + a_y - vertical_buffer_offset
				invalid_y_end := virtual_y_position + a_y - vertical_buffer_offset + a_height
				if grid.is_row_height_fixed then
						-- If row heights are fixed we can calculate instead of searching.
					first_row_index := ((invalid_y_start) // grid.row_height) + 1
					last_row_index := (((invalid_y_end) // grid.row_height) + 1).min (grid.row_count)
				else
					fixme ("implement using a binary search")
					from
						row_offsets.start
					until
						last_row_index_set or row_offsets.off
					loop
						i := row_offsets.item
						if not first_row_index_set and then i > invalid_y_start then
							first_row_index := row_offsets.index - 1
							first_row_index_set := True
						end
						if not last_row_index_set and then invalid_y_end < row_offsets.item then
							last_row_index := row_offsets.index - 1
							last_row_index_set := True
						end
						row_offsets.forth
					end
				end
				if last_row_index = 0 then
					last_row_index := grid.row_count
				end
				if first_row_index = 0 then
					first_row_index := grid.row_count
				end
				
				
				
				if printing_values then
					print ("Columns : " + first_column_index.out + " " + last_column_index.out + "%N")
					print ("Rows : " + first_row_index.out + " " + last_row_index.out + "%N")
				end

				from
					row_counter := first_row_index
					current_item_y_position := 0
					current_index_in_column := first_row_index
				until
					row_counter > last_row_index or
					(grid.is_row_height_fixed and row_counter > (grid.row_count)) or
					(not grid.is_row_height_fixed and row_counter > row_offsets.count) or
					first_row_index = 0
				loop
					
					if not bool and printing_values then
						print ("%N%NStarting to draw row%N")
					end
					current_row := grid.row_list @ (row_counter - 1)
					current_index_in_row := first_column_index
					if grid.is_row_height_fixed then
						current_item_y_position := (grid.row_height * (current_index_in_column - 1)) - (virtual_y_position - vertical_buffer_offset)
						current_row_height := grid.row_height
					else
						current_item_y_position := (row_offsets @ (current_index_in_column)) - (virtual_y_position - vertical_buffer_offset)
						current_row_height := row_offsets @ (row_counter + 1) - row_offsets @ (row_counter)
					end
					from
						column_counter := first_column_index
						current_item_x_position := 0
					until
						column_counter > last_column_index or
						column_counter > column_offsets.count or first_column_index = 0
					loop
							-- Assume that there is no grid item at the current position.
							-- It is not possible to simply set `grid_item' to Void within the loop as otherwise
							-- this effectively inserts `Void' at the grid item's position within the grid's
							-- data structures. So we use a BOOLEAN to determine this instead.
						grid_item_exists := False
						
						if not bool and printing_values then
							print ("%N%NColumn Counter : " + column_counter.out + "%N")
							print ("Column widths @ column_counter : " + (column_offsets @ (column_counter)).out + "%N")
							print ("An_x : " + an_x.out + "%N")
							print ("a_width : " + a_width.out + "%N")
						end
						if not grid.is_content_completely_dynamic and current_row /= Void and then current_row.count > (current_index_in_row - 1) then
								-- If the grid is set to retrieve completely dynamic content, then we do not execute this code
								-- as the current contents of the grid are never used. We also check that the current row and
								-- current row position are valid.
								
							grid_item := current_row @ (current_index_in_row - 1)
								-- In this case, we have found the grid item so we flag this fact
								-- so that the calculations for the partial dynamic content know that
								-- a new item must not be retrieved.
							if grid_item /= Void then
								grid_item_exists := True
							end
						end
	
						current_item_x_position  := (column_offsets @ (current_index_in_row)) - (virtual_x_position - horizontal_buffer_offset)
						current_column_width := column_offsets @ (column_counter + 1) - column_offsets @ (column_counter)
						
						if (grid.is_content_partially_dynamic or grid.is_content_completely_dynamic) and then not grid_item_exists and dynamic_content_function /= Void then
								-- If we are dynamically computing the contents of the grid and we have not already retrieved an item for
								-- the grid, then we execute this code.
								
							dynamic_content_function.call ([current_index_in_row.min (grid.row_count), current_index_in_column])
							grid_item_interface := dynamic_content_function.last_result
							if grid_item_interface /= Void then
								grid_item := grid_item_interface.implementation
									-- Note that the item is added to the grid in both partial and complete dynamic modes.
								grid.set_item (current_index_in_row, current_index_in_column, grid_item.interface)
								grid_item_exists := True
							end
						end
						
						if grid_item_exists then
								-- An item has been retrieved for the current drawing position so draw it.
							grid_item.redraw (current_item_x_position , current_item_y_position, current_column_width, current_row_height, grid.drawable)
						else
								-- As there is no current item, we must now fill the background with the
								-- parent background color.
							grid.drawable.set_foreground_color (grid.background_color)
							grid.drawable.fill_rectangle (current_item_x_position, current_item_y_position, current_column_width, current_row_height)
						end							
						
						column_counter := column_counter + 1
						current_index_in_row := current_index_in_row + 1
					end
					bool := True
					row_counter := row_counter + 1
					current_index_in_column := current_index_in_column + 1
				end
				-- Now draw in the background area where no items were displayed if required.
				-- Note that we perform the vertical and horizontal drawing seperately so there may be overlap if both are
				-- being drawn at once. This does not matter as it is simpler to implement, has no real performance impact as
				-- it is simply drawing a rectangle and dows not flicker.
				
			if last_column_index = grid.column_count then				
				rectangle_width := grid.viewport.width - (column_offsets @ (column_offsets.count) - virtual_x_position)
				if rectangle_width >= 0 then
						-- Check to see if we must draw the background to the right of the items.
					grid.drawable.set_foreground_color (grid.background_color)
					grid.drawable.fill_rectangle (horizontal_buffer_offset + grid.viewport.width - rectangle_width, vertical_buffer_offset, rectangle_width, grid.viewport.height)
				end
			end
			if last_row_index = grid.row_count then
				if grid.is_row_height_fixed then
						-- Special handling for fixed row heights as `row_offsets' does not exist.
					rectangle_height := grid.viewport.height - ((grid.row_height * grid.row_count) - virtual_y_position)
				else
					rectangle_height := grid.viewport.height - (row_offsets @ (row_offsets.count) - virtual_y_position)
				end
				if rectangle_height >= 0 then
						-- Check to see if must draw the background below the items.
					grid.drawable.set_foreground_color (grid.background_color)
					grid.drawable.fill_rectangle (horizontal_buffer_offset, vertical_buffer_offset + grid.viewport.height - rectangle_height, grid.viewport.width, rectangle_height)
				end
			end
			else
					-- In this situation, the grid is completely empty, so we simply fill the background color.
				grid.drawable.set_foreground_color (grid.background_color)
				grid.drawable.fill_rectangle (an_x, a_y, a_width, a_height)
			end
		end
		
	white: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).white
		end
		
	red: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).red
		end
		
	black: EV_COLOR is
			--
		do
			Result := (create {EV_STOCK_COLORS}).black
		end
		
	horizontal_border_width: INTEGER is 3
		-- Border from edge of text to edge of grid items.

feature {NONE} -- Implementation

invariant
	grid_not_void: grid /= Void

end
