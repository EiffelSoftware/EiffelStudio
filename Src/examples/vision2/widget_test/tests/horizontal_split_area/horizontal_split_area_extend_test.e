indexing
	description: "Objects that demonstrate adding items%
		%to EV_HORIZONTAL_SPLIT_AREA."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_SPLIT_AREA_EXTEND_TEST
	
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
			split_area.set_minimum_width (200)
			split_area.extend (create {EV_BUTTON}.make_with_text ("First"))
			split_area.extend (create {EV_BUTTON}.make_with_text ("Second"))
			
			widget := split_area
		end
		
feature {NONE} -- Implementation

	split_area: EV_HORIZONTAL_SPLIT_AREA

end -- class HORIZONTAL_SPLIT_AREA_EXTEND_TEST
