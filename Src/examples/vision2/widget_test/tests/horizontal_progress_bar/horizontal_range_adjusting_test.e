indexing
	description: "Objects that test EV_HORIZONTAL_RANGE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_RANGE_ADJUSTING_TEST

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
			
			create range
			range.set_minimum_width (250)
			range.pointer_motion_actions.force_extend (agent adjust_progress)
			
			vertical_box.extend (range)
			create label.make_with_text ("Move mouse over range")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			widget := vertical_box
		end
		
	adjust_progress (x, y: INTEGER) is
			-- Set `value' of `range' based on `x'.
			-- The default value_range of a progress bar is 0-100.
		do
			range.set_value (((x / range.width) * 100).truncated_to_integer)
		end
		
		
feature {NONE} -- Implementation

	range: EV_HORIZONTAL_RANGE

end -- class HORIZONTAL_RANGE_ADJUSTING_TEST
