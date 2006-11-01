indexing
	description: "Objects that test EV_HORIZONTAL_SEPARATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SEPARATOR_BASIC_TEST

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
			top_label, bottom_label: EV_LABEL
		do
			create vertical_box
			vertical_box.set_minimum_size (200, 200)
			create top_label.make_with_text ("Above")
			top_label.set_background_color (
				create {EV_COLOR}.make_with_8_bit_rgb (200, 200, 200))
			vertical_box.extend (top_label)
			create horizontal_separator
			vertical_box.extend (horizontal_separator)
			vertical_box.disable_item_expand (horizontal_separator)
			create bottom_label.make_with_text ("Below")
			bottom_label.set_background_color (top_label.background_color)
			vertical_box.extend (bottom_label)

			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	horizontal_separator: EV_HORIZONTAL_SEPARATOR;
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


end -- class HORIZONTAL_SEPARATOR_BASIC_TEST
