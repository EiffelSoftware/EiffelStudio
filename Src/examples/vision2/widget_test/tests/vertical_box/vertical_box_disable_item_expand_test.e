indexing
	description: "Objects that demonstrate `disable_item_expand'%
		%for EV_VERTICAL_BOX"
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_BOX_DISABLE_ITEM_EXPAND_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			button: EV_BUTTON
		do
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
			from
				counter := 1
			until
				counter > 3
			loop
				create button.make_with_text ("Expanded")
				button.select_actions.extend (agent update_button (button))
				vertical_box.extend (button)
				counter := counter + 1
			end
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX
		-- Widget that test is to be performed on.
	
	update_button (button: EV_BUTTON) is
			-- Toggle expanded status of `button' in
			-- `vertical_box'.
		do
			if vertical_box.is_item_expanded (button) then
				vertical_box.disable_item_expand (button)
				button.set_text ("Not expanded")
			else
				vertical_box.enable_item_expand (button)
				button.set_text ("Expanded")
			end
		end

end -- class VERTICAL_BOX_DISABLE_ITEM_EXPAND_TEST
