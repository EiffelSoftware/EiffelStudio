indexing
	description: "Objects that demonstrate `disable_item_expand'%
		%for EV_HORIZONTAL_BOX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_BOX_DISABLE_ITEM_EXPAND_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			button: EV_BUTTON
		do
			create horizontal_box
			horizontal_box.set_minimum_size (300, 300)
			from
				counter := 1
			until
				counter > 3
			loop
				create button.make_with_text ("Expanded")
				button.select_actions.extend (agent update_button (button))
				horizontal_box.extend (button)
				counter := counter + 1
			end
			widget := horizontal_box
		end
		
feature {NONE} -- Implementation

	horizontal_box: EV_HORIZONTAL_BOX
	
	update_button (button: EV_BUTTON) is
			-- Toggle expanded status of `button' in
			-- `horizontal_box'.
		do
			if horizontal_box.is_item_expanded (button) then
				horizontal_box.disable_item_expand (button)
				button.set_text ("Not expanded")
			else
				horizontal_box.enable_item_expand (button)
				button.set_text ("Expanded")
			end
		end

end -- class HORIZONTAL_BOX_DISABLE_ITEM_EXPAND_TEST
