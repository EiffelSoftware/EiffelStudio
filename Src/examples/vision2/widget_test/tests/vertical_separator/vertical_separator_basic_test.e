indexing
	description: "Objects that test EV_VERTICAL_SEPARATOR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SEPARATOR_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			top_label, bottom_label: EV_LABEL
		do
			create horizontal_box
			horizontal_box.set_minimum_size (200, 200)
			create top_label.make_with_text ("Left")
			top_label.set_background_color (
				create {EV_COLOR}.make_with_8_bit_rgb (200, 200, 200))
			horizontal_box.extend (top_label)
			create vertical_separator
			horizontal_box.extend (vertical_separator)
			horizontal_box.disable_item_expand (vertical_separator)
			create bottom_label.make_with_text ("Right")
			bottom_label.set_background_color (top_label.background_color)
			horizontal_box.extend (bottom_label)

			widget := horizontal_box
		end
		
feature {NONE} -- Implementation

	vertical_separator: EV_VERTICAL_SEPARATOR

end -- class VERTICAL_SEPARATOR_BASIC_TEST