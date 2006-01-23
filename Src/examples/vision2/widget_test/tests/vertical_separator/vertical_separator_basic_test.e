indexing
	description: "Objects that test EV_VERTICAL_SEPARATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SEPARATOR_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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

	vertical_separator: EV_VERTICAL_SEPARATOR;
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


end -- class VERTICAL_SEPARATOR_BASIC_TEST
