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
			x, y: INTEGER
			height: INTEGER
			
			virtual_x_position: INTEGER
			vertical_buffer_offset: INTEGER
			horizontal_buffer_offset: INTEGER
			virtual_buffer_x_position: INTEGER
			column_widths: ARRAYED_LIST [INTEGER]
			
			current_row: SPECIAL [EV_GRID_ITEM_I]
			visible_physical_column_indexes: SPECIAL [INTEGER]
			temp: INTEGER
			first_column_index: INTEGER
			last_column_index: INTEGER
			first_column_index_set, last_column_index_set: BOOLEAN
			grid_label_item: EV_GRID_LABEL_ITEM_I
			current_index_in_row: INTEGER
			column_counter: INTEGER
			bool: BOOLEAN
			row_counter: INTEGER
			printing_values: BOOLEAN
			column_offsets: ARRAYED_LIST [INTEGER]
			invalid_x_start, invalid_x_end: INTEGER
		do
			printing_values := False
			if printing_values then
				print ("%N%NPartial redraw an_x : " + an_x.out + "a_y : " + a_y.out + "a_width : " + a_width.out + "a_height : " + a_height.out + "%N%N")
			end
			
			create column_widths.make (8)
			column_widths.extend (0)
			
			visible_physical_column_indexes := grid.visible_physical_column_indexes

			height := 16
			
			virtual_x_position := grid.virtual_x_position
			
			vertical_buffer_offset := grid.viewport.y_offset
			horizontal_buffer_offset := grid.viewport.x_offset
			
			virtual_buffer_x_position := virtual_x_position - horizontal_buffer_offset
			
			
			if not grid.header.is_empty then
				if printing_values then
					print ("%NCalculating columns to draw%N")
				end
				column_offsets := grid.column_offsets
					-- Retrieve the column offsets from `grid'.
				check
					column_offsets_count_equal_to_columns: column_offsets.count = grid.column_count
				end
				
				from
					column_offsets.start
						-- Compute the virtual positions of the invalidated area.
					invalid_x_start := virtual_x_position + an_x - horizontal_buffer_offset
					invalid_x_end := virtual_x_position + an_x - horizontal_buffer_offset + a_width
				until
					last_column_index_set or column_offsets.off
				loop
					temp := column_offsets.item
					if not first_column_index_set and then temp > invalid_x_start then
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
				if printing_values then
					print ("Columns : " + first_column_index.out + " " + last_column_index.out + "%N")
				end

				from
					row_counter := 0
					y := vertical_buffer_offset - (vertical_buffer_offset \\ height)
				until
					(row_counter - grid.vertical_item_offset) * 16 > grid.height or 
					row_counter = grid.row_count or first_column_index = 0
				loop
					if not bool and printing_values then
						print ("%N%NStarting to draw row%N")
					end
					current_row := grid.row_list @ (row_counter)
					current_index_in_row := first_column_index
					from
						column_counter := first_column_index
						temp := 0
					until
						column_counter > last_column_index or
						column_counter > column_offsets.count
					loop
						if not bool and printing_values then
							print ("%N%NColumn Counter : " + column_counter.out + "%N")
							print ("Column widths @ column_counter : " + (column_offsets @ (column_counter)).out + "%N")
							print ("An_x : " + an_x.out + "%N")
							print ("a_width : " + a_width.out + "%N")
						end
						if current_index_in_row <= column_offsets.count - 1 then
							
							grid_label_item ?= current_row @ (current_index_in_row - 1)
							
							
							temp := (column_offsets @ (current_index_in_row)) - (virtual_x_position - horizontal_buffer_offset)
							
							grid.drawable.set_foreground_color (red)
							grid.drawable.fill_rectangle (temp, y, column_offsets @ (column_counter + 1), height)
							grid.drawable.set_foreground_color (black)
							grid.drawable.draw_text_top_left (temp, y, grid_label_item.text)
						else
						
						end
						column_counter := column_counter + 1
						current_index_in_row := current_index_in_row + 1
					end
					bool := True
					row_counter := row_counter + 1
					y := y + height
				end
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
		

feature {NONE} -- Implementation

invariant
	grid_not_void: grid /= Void

end
