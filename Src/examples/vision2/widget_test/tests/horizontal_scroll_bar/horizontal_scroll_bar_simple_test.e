indexing
	description: "Objects that test EV_HORIZONTAL_SCROLL_BAR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SCROLL_BAR_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create scroll_bar
			scroll_bar.set_minimum_width (250)
			scroll_bar.set_value (50)
			
			widget := scroll_bar
		end

feature {NONE} -- Implementation

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


end -- class HORIZONTAL_SCROLL_BAR_SIMPLE_TEST
