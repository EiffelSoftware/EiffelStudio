indexing
	description: "Objects that test an EV_VIEWPORT with an `item'%
		%contained that is smaller than its current size."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_SMALL_ITEM_TEST

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
			create viewport
			viewport.set_minimum_size (200, 200)
			create button.make_with_text ("An item")
			button.set_minimum_size (100, 100)
			viewport.extend (button)
			
			widget := viewport
		end
		
feature {NONE} -- Implementation

	viewport: EV_VIEWPORT

end -- class VIEWPORT_SMALL_ITEM_TEST
