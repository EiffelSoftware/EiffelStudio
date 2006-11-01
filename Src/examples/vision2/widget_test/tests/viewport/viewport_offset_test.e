indexing
	description: "Objects that test an EV_VIEWPORT by allowing%
		% you to adjust the offset."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_OFFSET_TEST

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
			create viewport
			vertical_box.extend (viewport)
			create reset_button.make_with_text ("Reset")
			reset_button.select_actions.extend (agent viewport.set_offset (0, 0))
			vertical_box.extend (reset_button)
			vertical_box.disable_item_expand (reset_button)
			viewport.set_minimum_size (200, 200)
			
			create test_button.make_with_text ("Select me!")
			test_button.select_actions.extend (agent modify_offset)
			test_button.set_minimum_size (100, 100)
			viewport.extend (test_button)
			
			widget := vertical_box
		end

feature {NONE} -- Implementation
		
	modify_offset is
			-- Move `viewport' up and left 10 pixels in
			-- relation to `button'.
		do
			viewport.set_offset (viewport.x_offset - 10, viewport.y_offset - 10)
		end
		
	viewport: EV_VIEWPORT
		-- Widget that test is to be performed on.
	
	test_button, reset_button: EV_BUTTON;
		-- Buttons used to test and reset state of `viewport'.

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


end -- class VIEWPORT_OFFSET_TEST
