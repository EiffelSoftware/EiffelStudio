indexing
	description: "Objects that demonstrate an EV_RADIO_BUTTON"
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create radio_button.make_with_text ("A radio button")			
		
			widget := radio_button
		end
		
feature {NONE} -- Implementation

	radio_button: EV_RADIO_BUTTON
		-- Widget that test is to be performed on.

end -- class RADIO_BUTTON_BASIC_TEST
