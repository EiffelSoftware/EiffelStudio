indexing
	description: "Objects that demonstrate `set_item_position'%
		%and `set_item_size' of EV_FIXED."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_SET_ITEM_POSITION_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button1, button2: EV_BUTTON
		do
			create fixed
			create button1.make_with_text ("Item 1")
			create button2.make_with_text ("Item 2")
			fixed.extend (button1)
			fixed.extend (button2)
			
				-- Add this item without a reference
			fixed.extend (create {EV_BUTTON}.make_with_text ("Item 3"))
			
				-- Size and position `button1' and `button' within
				-- `fixed.
			fixed.set_minimum_size (300, 300)
			fixed.set_item_position (button1, 0, 0)
			fixed.set_item_size (button1, 50, 50)
			fixed.set_item_position (button2, 50, 50)
			fixed.set_item_size (button2, 50, 50)
			
				-- As the third item was added without a reference,
				-- we query `fixed' to find the third item.
			fixed.set_item_position (fixed.i_th (3), 100, 100)
			fixed.set_item_size (fixed.i_th (3), 50, 50)
			
			widget := fixed
		end
		
feature {NONE} -- Implementation

	fixed: EV_FIXED

end -- class FIXED_SET_ITEM_POSITION_TEST
