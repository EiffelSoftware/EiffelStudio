indexing
	description: "Objects that demonstrate simple use of%
		%`border_width' for EV_HORIZONTAL_BOX"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	horizontal_box: EV_HORIZONTAL_BOX;
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


end -- class HORIZONTAL_BOX_BORDER_WIDTH_TEST
