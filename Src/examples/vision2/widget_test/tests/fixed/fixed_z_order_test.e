indexing
	description: "Objects that demonstrate z order in EV_FIXED."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_Z_ORDER_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create fixed
			create button1.make_with_text ("Click to bring to top")
			create button2.make_with_text ("Click to bring to top")
			create button3.make_with_text ("Click to bring to top")
			button1.select_actions.extend (agent raise_button (button1))
			button2.select_actions.extend (agent raise_button (button2))
			button3.select_actions.extend (agent raise_button (button3))
			fixed.extend (button1)
			fixed.extend (button2)
			fixed.extend (button3)
			fixed.set_minimum_size (300, 300)
			set_item_positions
			
			widget := fixed
		end
		
feature {NONE} -- Implementation

	set_item_positions is
			-- Position buttons within `fixed'.
		do
			fixed.set_item_position (button1, 0, 0)
			fixed.set_item_height (button1, 75)
			fixed.set_item_position (button2, 50, 50)
			fixed.set_item_height (button2, 75)
			fixed.set_item_position (button3, 100, 100)
			fixed.set_item_height (button3, 75)
		end
		

	raise_button  (a_button: EV_BUTTON) is
			-- Ensure `a_button' is displayed topmost.
			-- Note that it must be removed and inserted to the
			-- last position within `fixed', as the z order of
			-- items within a fixed depends on their position.
		do
			fixed.prune (a_button)
			fixed.extend (a_button)
			set_item_positions
		end
		

	fixed: EV_FIXED
		-- Widget that test is to be performed on.
	
	button1, button2, button3: EV_BUTTON;
		-- Widgets used to show the operation of `fixed'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class FIXED_Z_ORDER_TEST
