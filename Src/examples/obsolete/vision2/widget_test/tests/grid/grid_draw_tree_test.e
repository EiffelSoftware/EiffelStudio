indexing
	description: "[
		Objects that test EV_GRID tree functionality. Press and hold the left mouse button
		on any item in the tree and drag the mouse to draw a subrow tree structure which is
		filled into the tree upon release of the mouse button.
		Clicking the header of the first column clears all rows except the first.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_DRAW_TREE_TEST

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
		do
			create grid
			grid.enable_tree
			grid.set_minimum_size (300, 300)
			create grid_label_item.make_with_text ("Root Node")
			grid.set_item (1, 1, grid_label_item)
			grid.column (1).set_width (grid.width)
			grid.pointer_button_press_item_actions.extend (agent draw_tree_item_press)
			grid.pointer_button_release_item_actions.extend (agent draw_tree_item_release)
			grid.pointer_motion_item_actions.extend (agent draw_tree_item_motion)
			grid.column (1).header_item.pointer_button_press_actions.force_extend (agent clear_all_rows_except_first)
			
			widget := grid
		end
				
feature {NONE} -- Implementation

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	pixmaps: ARRAYED_LIST [EV_PIXMAP]
		-- Pixmaps for addition to items.
		
	offsets: ARRAY [INTEGER]
		-- All offsets recorded from the mouse motion.
	
	start_x, start_y: INTEGER
		-- Start positions of the mouse pointer.
	
	start_item: EV_GRID_ITEM
		-- Item on which the motion started.
	
	max_set: INTEGER
		-- Total number of new rows drawn.
		
	draw_tree_item_press (an_x, a_y, button: INTEGER; an_item: EV_GRID_ITEM) is
			-- A mouse button has been pressed on `grid' so if it is the left mouse
			-- button and the press started on an item, start the motion recording.
		do
			if button = 1 and an_item /= Void then
				create offsets.make (1, 100)
				start_x := an_x
				start_y := a_y
				start_item := an_item
				max_set := 0
			else
				start_item := Void
			end
		end
		
	draw_tree_item_release (an_x, a_y, button: INTEGER; an_item: EV_GRID_ITEM) is
			-- A mouse button has been released on `grid' so calculate and
			-- add all the new tree items that have been drawn.
		local
			counter: INTEGER
			current_indent: INTEGER
			previous_indent: INTEGER
			new_row: EV_GRID_ROW
			parent_row: EV_GRID_ROW
			column_to_check: INTEGER
			column_counter: INTEGER
			total_column_indent: INTEGER
			row_counter: INTEGER
			i: INTEGER
			j: INTEGER
			found: BOOLEAN
			new_row_index: INTEGER
		do
			if button = 1 and start_item /= Void then

				previous_indent := 0
				from
					counter := 1
				until
					counter > max_set
				loop
					
					current_indent := offsets.item (counter) - start_x
					if offsets.item (counter) = 360 then
						do_nothing
					end

					new_row_index := start_item.row.index + counter
					
					current_indent := current_indent.max (0)
					parent_row := Void
					column_to_check := start_item.column.index
					total_column_indent := 0
					from
						column_counter := column_to_check
					until
						column_counter > grid.column_count or total_column_indent > current_indent
					loop
						if current_indent > total_column_indent then
							column_to_check := column_counter
						end						
						total_column_indent := total_column_indent + grid.column (column_counter).width
						column_counter := column_counter + 1
					end
					i := 0
					from
						j := 1
					until
						j = column_to_check
					loop
						i := i + grid.column (j).width
						j := j + 1
					end
					found := False
					if parent_row = Void then		
						from
							row_counter := new_row_index - 1
						until
							found or row_counter = start_item.row.index
						loop
							if (grid.item (column_to_check, row_counter) /= Void and grid.row (row_counter).index + grid.row (row_counter).subrow_count_recursive + 1 = new_row_index) then
								if (grid.item (column_to_check, row_counter)).horizontal_indent <= offsets.item (counter) - i then--current_indent then
									found := True
								end						
							end
							if not found then
								row_counter := row_counter - 1
							end
						end
						parent_row := grid.row (row_counter)
					end
						
					grid.insert_new_row_parented (new_row_index, parent_row)
					new_row := grid.row (start_item.row.index + counter)
					grid.set_item (column_to_check, new_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (offsets.item (counter).out))
					if not parent_row.is_expanded then
						parent_row.expand
					end
					counter := counter + 1
					previous_indent := current_indent
				end
				start_item := Void
			end
		end
		
	draw_tree_item_motion (an_x, a_y: INTEGER; an_item: EV_GRID_ITEM) is
			-- A mouse motion has occured in `grid' so recored the
			-- positions into `offsets' ready for item building.
		local
			distance_down: INTEGER
			item_index: INTEGER
		do
			if start_item /= Void then
				distance_down := a_y - start_item.virtual_y_position
				if distance_down > 0 then
					item_index := (distance_down // 16) + 1
					if item_index >= offsets.count or else offsets @ item_index < an_x then
						offsets.force (an_x, item_index)
						max_set := item_index.max (item_index)
					end
				end
			end
		end
		
	clear_all_rows_except_first is
			-- Remove all rows from `grid' except the first.
		local
			i: INTEGER
		do
			from
				i := grid.row_count
			until
				i = 1
			loop
				grid.remove_row (i)
				i := i - 1
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


end -- class GRID_DRAW_TREE_TEST
