indexing
	description: "Objects that demonstrate an EV_RADIO_BUTTON"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create radio_button.make_with_text ("A radio button")			
		
			widget := radio_button
		end
		
feature {NONE} -- Implementation

	radio_button: EV_RADIO_BUTTON

end -- class RADIO_BUTTON_BASIC_TEST
