indexing
	description: "Objects that demonstrate adding items%
		%to EV_VERTICAL_SPLIT_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SPLIT_AREA_EXTEND_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create split_area
			split_area.set_minimum_height (200)
			split_area.extend (create {EV_BUTTON}.make_with_text ("First"))
			split_area.extend (create {EV_BUTTON}.make_with_text ("Second"))
			
			widget := split_area
		end
		
feature {NONE} -- Implementation

	split_area: EV_VERTICAL_SPLIT_AREA;
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


end -- class VERTICAL_SPLIT_AREA_EXTEND_TEST
