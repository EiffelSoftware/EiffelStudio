indexing
	description: "Objects that demonstrate adjustment of%
		%`padding_width' for EV_HORIZONTAL_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_BOX_PADDING_WIDTH_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create horizontal_box
			create increase_padding_button.make_with_text_and_action (
				"Increase", agent adjust_padding (8))
			create decrease_padding_button.make_with_text_and_action (
				"Decrease", agent adjust_padding (-8))
				
			create padding_output_label			
			horizontal_box.extend (decrease_padding_button)
			horizontal_box.extend (padding_output_label)
			horizontal_box.extend (increase_padding_button)
			
			adjust_padding (0)
			
			widget := horizontal_box
		end
		
	adjust_padding (adjustment: INTEGER) is
			-- Adjust `padding_width' of `horizontal_box'
			-- by `adjustment'. Update controls accordingly.
		require
			valid_new_width: horizontal_box.padding_width + adjustment >= 0
		do
			horizontal_box.set_padding_width (horizontal_box.padding_width + adjustment)
			if adjustment <= 0 then
				if horizontal_box.padding_width = 0 then
					decrease_padding_button.disable_sensitive
				elseif not increase_padding_button.is_sensitive then
					increase_padding_button.enable_sensitive
				end
			else
				if horizontal_box.padding_width = maximum_padding then
					increase_padding_button.disable_sensitive
				elseif not decrease_padding_button.is_sensitive then
					decrease_padding_button.enable_sensitive
				end
			end
			padding_output_label.set_text ("Padding width : " + horizontal_box.padding_width.out)
		end
		
		
feature {NONE} -- Implementation

	maximum_padding: INTEGER is 40
		-- Maximum padding width allowed for test.

	horizontal_box: EV_HORIZONTAL_BOX
		-- Widget that test is to be performed on.

	padding_output_label: EV_LABEL
		-- Label used to show padding status.

	increase_padding_button, decrease_padding_button: EV_BUTTON;
		-- Buttons used to change padding balue.

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


end -- class HORIZONTAL_BOX_PADDING_WIDTH_TEST
