indexing
	description: "Objects that test EV_HORIZONTAL_PROGRESS_BAR."
	date: "$Date$"
	revision: "$Revision$"

class
	HORIZONTAL_PROGRESS_BAR_SIMPLE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create progress_bar
			progress_bar.set_minimum_width (250)
			progress_bar.set_value (50)
			
			widget := progress_bar
		end
		
feature {NONE} -- Implementation

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
		-- Widget that test is to be performed on.

end -- class HORIZONTAL_PROGRESS_BAR_SIMPLE_TEST
