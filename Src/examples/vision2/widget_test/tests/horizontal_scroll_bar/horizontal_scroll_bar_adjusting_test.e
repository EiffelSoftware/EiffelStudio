indexing
	description: "Objects that test EV_HORIZONTAL_SCROLL_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SCROLL_BAR_ADJUSTING_TEST

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
			
			create scroll_bar
			scroll_bar.set_minimum_width (250)
			scroll_bar.pointer_motion_actions.force_extend (agent adjust_progress)
			
			vertical_box.extend (scroll_bar)
			create label.make_with_text ("Move mouse over scroll_bar")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			widget := vertical_box
		end
		
	adjust_progress (x, y: INTEGER) is
			-- Set `value' of `scroll_bar' based on `x'.
			-- The default value of a scroll bar is 0-100.
		do
			scroll_bar.set_value (((x / scroll_bar.width) *
				(scroll_bar.value_range.capacity - scroll_bar.leap + 1)).truncated_to_integer)
		end
		
		
feature {NONE} -- Implementation

	scroll_bar: EV_HORIZONTAL_SCROLL_BAR

end -- class HORIZONTAL_SCROLL_BAR_ADJUSTING_TEST
