indexing
	description: "Objects that test an EV_SCROLLABLE_AREA with an `item'%
		%contained that is smaller than its current size."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_AREA_SMALL_ITEM_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
		do
			create scrollable_area
			scrollable_area.set_minimum_size (200, 200)
			create button.make_with_text ("An item")
			button.set_minimum_size (100, 100)
			scrollable_area.extend (button)
			
			widget := scrollable_area
		end
		
feature {NONE} -- Implementation

	scrollable_area: EV_SCROLLABLE_AREA

end -- class SCROLLABLE_AREA_SMALL_ITEM_TEST
