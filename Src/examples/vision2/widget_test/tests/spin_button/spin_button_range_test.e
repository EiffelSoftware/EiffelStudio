indexing
	description: "Objects that demonstrate EV_SPIN_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SPIN_BUTTON_RANGE_TEST
	
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
			spin_button.set_minimum_size (250, 250)
			spin_button.value_range.adapt (create {INTEGER_INTERVAL}.make (1000, 2000))
			spin_button.set_text ("Range modified : 1000 - 2000")

			widget := spin_button
		end
		
feature {NONE} -- Implementation

	spin_button: EV_SPIN_BUTTON
	
end -- class SPIN_BUTTON_RANGE_TEST
