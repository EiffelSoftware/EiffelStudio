indexing
	description: "Objects that test EV_HORIZONTAL_SCROLL_BAR."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SCROLL_BAR_VALUE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
		do
			create vertical_box
			create scroll_bar
			scroll_bar.set_minimum_width (250)
			vertical_box.extend (scroll_bar)
			create label
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			scroll_bar.change_actions.extend (agent display_value)
			scroll_bar.set_value (50)
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	display_value (value: INTEGER) is
			-- Display `value' on `label'.
		do
			label.set_text ("value : " + value.out)
		end
		
	label: EV_LABEL
		-- A label for output.

	scroll_bar: EV_HORIZONTAL_SCROLL_BAR
		-- Widget that test is to be performed on.

end -- class HORIZONTAL_SCROLL_BAR_VALUE_TEST
