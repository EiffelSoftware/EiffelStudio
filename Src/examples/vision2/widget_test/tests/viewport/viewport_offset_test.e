indexing
	description: "Objects that test an EV_VIEWPORT by allowing%
		% you to adjust the offset."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_OFFSET_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

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
		
	modify_offset is
			-- Move `viewport' up and left 10 pixels in
			-- relation to `button'.
		do
			viewport.set_offset (viewport.x_offset - 10, viewport.y_offset - 10)
		end
		
		
feature {NONE} -- Implementation

	viewport: EV_VIEWPORT
	
	test_button, reset_button: EV_BUTTON

end -- class VIEWPORT_OFFSET_TEST
