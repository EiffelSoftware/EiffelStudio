indexing
	description: "Objects that demonstrate adding items%
		%to EV_VERTICAL_SPLIT_AREA."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_SPLIT_AREA_SINGLE_CHILD_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create split_area
			split_area.set_minimum_height (200)
				-- Only one item is inserted, and therefore, the splitter is not visible.
			split_area.extend (create {EV_BUTTON}.make_with_text ("First"))
			
			widget := split_area
		end
		
feature {NONE} -- Implementation

	split_area: EV_VERTICAL_SPLIT_AREA

end -- class VERTICAL_SPLIT_AREA_SINGLE_CHILD_TEST
