indexing
	description: "Objects that demonstrate adjustment of%
		%`padding_width' for EV_HORIZONTAL_BOX"
	author: ""
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
			padding_output_label.set_background_color (
				create {EV_COLOR}.make_with_8_bit_rgb (215, 251, 230))
			
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
	padding_output_label: EV_LABEL
	increase_padding_button, decrease_padding_button: EV_BUTTON

end -- class HORIZONTAL_BOX_PADDING_WIDTH_TEST
