indexing
	description: "Objects that demonstrate EV_SPIN_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPIN_BUTTON_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create spin_button

			widget := spin_button
		end
		
feature {NONE} -- Implementation

	spin_button: EV_SPIN_BUTTON
	
end -- class SPIN_BUTTON_BASIC_TEST
