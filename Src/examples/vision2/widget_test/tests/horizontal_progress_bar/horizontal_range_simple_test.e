indexing
	description: "Objects that test EV_HORIZONTAL_RANGE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_RANGE_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create range
			range.set_minimum_width (250)
			range.set_value (50)
			
			widget := range
		end
		
feature {NONE} -- Implementation

	range: EV_HORIZONTAL_RANGE

end -- class HORIZONTAL_RANGE_SIMPLE_TEST
