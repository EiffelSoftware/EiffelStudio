indexing
	description: "Objects that test EV_HORIZONTAL_SCROLL_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SCROLL_BAR_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create scroll_bar
			scroll_bar.set_minimum_width (250)
			scroll_bar.set_value (50)
			
			widget := scroll_bar
		end
		
feature {NONE} -- Implementation

	scroll_bar: EV_HORIZONTAL_SCROLL_BAR

end -- class HORIZONTAL_SCROLL_BAR_SIMPLE_TEST
