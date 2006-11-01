indexing
	description: "Objects that test an EV_VIEWPORT with an `item'%
		%contained that is smaller than its current size."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_SMALL_ITEM_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
		do
			create viewport
			viewport.set_minimum_size (200, 200)
			create button.make_with_text ("An item")
			button.set_minimum_size (100, 100)
			viewport.extend (button)
			
			widget := viewport
		end
		
feature {NONE} -- Implementation

	viewport: EV_VIEWPORT;
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


end -- class VIEWPORT_SMALL_ITEM_TEST
