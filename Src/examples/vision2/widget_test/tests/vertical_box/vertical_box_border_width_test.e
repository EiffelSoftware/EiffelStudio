indexing
	description: "Objects that demonstrate simple use of%
		%`border_width' for EV_VERTICAL_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_BOX_BORDER_WIDTH_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create vertical_box
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("First item"))
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("Second item"))
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("Third item"))
			vertical_box.set_border_width (20)
				
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX
		-- Widget that test is to be performed on.

	padding_output_label: EV_LABEL
		-- Label to show level of padding.

	increase_padding_button, decrease_padding_button: EV_BUTTON;
		-- Buttons used to alter padding.

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


end -- class VERTICAL_BOX_BORDER_WIDTH_TEST
