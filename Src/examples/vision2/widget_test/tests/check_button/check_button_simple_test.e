indexing
	description: "Objects that demonstrate simple creation%
		%of EV_CHECK_BUTTON"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BUTTON_SIMPLE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create check_button.make_with_text ("A Check button")
			widget := check_button
		end
				
feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
	
end -- class CHECK_BUTTON_SIMPLE_TEST
