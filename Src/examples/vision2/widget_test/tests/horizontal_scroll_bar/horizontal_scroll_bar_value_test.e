indexing
	description: "Objects that test EV_HORIZONTAL_SCROLL_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SCROLL_BAR_VALUE_TEST

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
			create scroll_bar
			scroll_bar.set_minimum_width (250)
			vertical_box.extend (scroll_bar)
			create label
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			scroll_bar.change_actions.extend (agent display_value)
			scroll_bar.set_value (50)
			
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

	scroll_bar: EV_HORIZONTAL_SCROLL_BAR;
		-- Widget that test is to be performed on.

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


end -- class HORIZONTAL_SCROLL_BAR_VALUE_TEST
