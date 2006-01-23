indexing
	description: "[
		Objects that demonstrate how to use drawable grid items.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_DRAWABLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
	RANDOM
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			grid_label_item: EV_GRID_LABEL_ITEM
		do
			create grid
			grid.enable_tree
			grid.set_minimum_size (300, 300)
			create grid_label_item.make_with_text ("Progress")
			grid.set_item (1, 1, grid_label_item)
			add_tree_items (grid_label_item.row, subrow_count)
			grid.row (1).expand
			create all_progress.make (subrow_count)
			create all_progress_speed.make (subrow_count)
			set_seed (763458)
			from
				counter := 1
			until
				counter > subrow_count
			loop
				all_progress_speed.extend ((next_random (counter) \\ 100) / 50)
				all_progress.extend (0)
				counter := counter + 1
			end
			create compute_timer.make_with_interval (100)
			compute_timer.actions.extend (agent update_progress)
			
			widget := grid
		end
		
	add_tree_items (parent_row: EV_GRID_ROW; child_count: INTEGER) is
			-- Add `child_count' subrows to `row' of `parent_item'.
		local
			counter: INTEGER
			new_subrow: EV_GRID_ROW
			drawable_item: EV_GRID_DRAWABLE_ITEM
		do
			from
				counter := 1
			until
				counter > child_count
			loop
				parent_row.insert_subrow (counter)
				new_subrow := parent_row.subrow (counter)
				new_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Thread " + counter.out))
				create drawable_item
				drawable_item.expose_actions.extend (agent redraw_item (?, drawable_item))
				new_subrow.set_item (2, drawable_item)
				counter := counter + 1
			end
		end
		
feature {NONE} -- Implementation

	subrow_count: INTEGER is 16
		-- Number of "Thread" subrows to be used in this example.

	grid: EV_GRID
		-- Widget that test is to be performed on.
		
	compute_timer: EV_TIMEOUT
		-- A timer used to trigger the recalculation of the progrss bars.
		
	redraw_item (drawable: EV_DRAWABLE; drawable_item: EV_GRID_DRAWABLE_ITEM) is
			-- Redraw `drawable_item' into `drawable' by looking up the current progress
			-- for that item and displaying it as as status bar.
		local
			data_index: INTEGER
			progress_width: INTEGER
			next_progress_width: INTEGER
			item_height, item_width: INTEGER
		do
				-- Assign to temporary variables for speed
			item_height := drawable_item.height
			item_width := drawable_item.width
			
				-- Calculate lookup based on row index.
			data_index := drawable_item.row.index - 1
			
				-- Calculate the width of the progress relative to `drawable_item'
			progress_width := (item_width * (all_progress.i_th (data_index) / 100)).truncated_to_integer
			
			if data_index < subrow_count then
					-- Now calculate the relative width of the next bar so the dividing
					-- line may be drawn correctly.
				next_progress_width := (item_width * (all_progress.i_th (data_index + 1) / 100)).truncated_to_integer
			end
			
				-- Fill the progress part of the rectangle
			drawable.set_foreground_color (light_green)
			drawable.fill_rectangle (0, 0, progress_width, item_height)
			
				-- Now write the percentage on top of the progress section. This is
				-- to be clipped to the dimensions of the bar through overdraw.
			drawable.set_foreground_color (stock_colors.black)
			drawable.draw_text_top_left (5, 0, (all_progress.i_th (data_index)).truncated_to_integer.out + "%%")
			
				-- Now clear the remaining section of the item where there is no progress bar.
			drawable.set_foreground_color (stock_colors.white)
			drawable.fill_rectangle (progress_width, 0, item_width - progress_width, item_height)
			
				-- Now fill the border around the item.
			drawable.set_foreground_color (stock_colors.black)
			drawable.draw_segment (0, 0, 0, item_height)
			drawable.draw_segment (progress_width, 0, progress_width, item_height)
			drawable.draw_segment (0, item_height - 1, progress_width.max (next_progress_width), item_height - 1)
			
			if data_index = 1 then
					-- For the first item only, a horizontal separator must be drawn at the top.
				drawable.draw_segment (0, 0, progress_width, 0)
			end			
		end
		
	update_progress is
			-- Update progress of all status bars and force
			-- each item to redraw.
		local
			counter: INTEGER
			value: DOUBLE
			first_row: EV_GRID_ROW
		do
			if grid.is_displayed then
				from
					counter := 1
					first_row := grid.row (1)
				until
					counter > subrow_count
				loop
					value := all_progress.i_th (counter)
					value := value + all_progress_speed.i_th (counter)
					if value > 100 then
						value := 0
					end
					all_progress.put_i_th (value, counter)
					first_row.subrow (counter).redraw
					counter := counter + 1
				end
			end
		end
		
	all_progress: ARRAYED_LIST [DOUBLE]
		-- All progress values in order.
	
	all_progress_speed: ARRAYED_LIST [DOUBLE]
		-- All progress speeds in order.
	
	light_green: EV_COLOR is
			-- Color light green.
		once
			create Result.make_with_8_bit_rgb (230, 255, 230)
		end
		
	stock_colors: EV_STOCK_COLORS is
			-- Once access to EiffelVision2 stock colors
			-- (from GRID_ACCESSOR)
		once
			create Result
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


end -- class GRID_DRAWABLE_TEST
