indexing
	description: "Objects that test EV_HORIZONTAL_PROGRESS_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_PROGRESS_BAR_ADJUSTING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			create vertical_box
			
			create progress_bar
			progress_bar.set_minimum_width (250)
			progress_bar.pointer_motion_actions.force_extend (agent adjust_progress)
			
			vertical_box.extend (progress_bar)
			create label.make_with_text ("Move mouse over bar")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			widget := vertical_box
		end
		
	adjust_progress (x, y: INTEGER) is
			-- Set `value' of `progress_bar' based on `x'.
			-- The default value_range of a progress bar is 0-100.
		do
			progress_bar.set_value (((x / progress_bar.width) * 100).truncated_to_integer)
		end
		
		
feature {NONE} -- Implementation

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR

end -- class HORIZONTAL_PROGRESS_BAR_ADJUSTING_TEST
