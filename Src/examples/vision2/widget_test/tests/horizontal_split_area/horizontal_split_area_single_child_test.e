indexing
	description: "Objects that demonstrate a single child in%
		%an EV_HORIZONTAL_SPLIT_AREA."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SPLIT_AREA_SINGLE_CHILD_TEST
	
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
			split_area.set_minimum_width (200)
				-- Only one item is inserted, and therefore, the splitter is not visible.
			split_area.extend (create {EV_BUTTON}.make_with_text ("First"))
			
			widget := split_area
		end
		
feature {NONE} -- Implementation

	split_area: EV_HORIZONTAL_SPLIT_AREA
		-- Widget that test is to be performed on.

end -- class HORIZONTAL_SPLIT_AREA_SINGLE_CHILD_TEST
