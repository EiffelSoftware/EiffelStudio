indexing
	description: "Objects that demonstrate simple use of%
		%`border_width' for EV_HORIZONTAL_BOX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_BOX_BORDER_WIDTH_TEST
	
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
			horizontal_box.extend (
				create {EV_BUTTON}.make_with_text ("First item"))
			horizontal_box.extend (
				create {EV_BUTTON}.make_with_text ("Second item"))
			horizontal_box.extend (
				create {EV_BUTTON}.make_with_text ("Third item"))
			horizontal_box.set_border_width (20)
				
			widget := horizontal_box
		end
		
feature {NONE} -- Implementation

	horizontal_box: EV_HORIZONTAL_BOX
	padding_output_label: EV_LABEL
	increase_padding_button, decrease_padding_button: EV_BUTTON

end -- class HORIZONTAL_BOX_BORDER_WIDTH_TEST
