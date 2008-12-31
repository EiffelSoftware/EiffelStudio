note
	description: "Objects that test an EV_SCROLLABLE_AREA with an `item'%
		%contained that is smaller than its current size."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_AREA_SMALL_ITEM_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
		do
			create scrollable_area
			scrollable_area.set_minimum_size (200, 200)
			create button.make_with_text ("An item")
			button.set_minimum_size (100, 100)
			scrollable_area.extend (button)
			
			widget := scrollable_area
		end
		
feature {NONE} -- Implementation

	scrollable_area: EV_SCROLLABLE_AREA;
		-- Widget that test is to be performed on.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SCROLLABLE_AREA_SMALL_ITEM_TEST
