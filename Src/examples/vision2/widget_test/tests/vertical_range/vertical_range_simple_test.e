indexing
	description: "Objects that test EV_VERTICAL_RANGE."
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_RANGE_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create range
			range.set_minimum_height (250)
			range.set_value (50)
			
			widget := range
		end
		
feature {NONE} -- Implementation

	range: EV_VERTICAL_RANGE
		-- Widget that test is to be performed on.

end -- class VERTICAL_RANGE_SIMPLE_TEST
