indexing
	description: "Objects that test EV_VERTICAL_RANGE."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_RANGE_VALUE_TEST

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
			create range
			range.set_minimum_height (250)
			vertical_box.extend (range)
			create label
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			range.change_actions.extend (agent display_value)
			range.set_value (50)
			
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

	range: EV_VERTICAL_RANGE
		-- Widget that test is to be performed on.

end -- class VERTICAL_RANGE_VALUE_TEST
