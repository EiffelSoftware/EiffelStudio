indexing
	description: "Objects that demonstrate multiple instances of%
		%EV_RADIO_BUTTON in the same EV_CONTAINER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_MULTIPLE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			radio_button: EV_RADIO_BUTTON
			counter: INTEGER
		do
			create vertical_box
			from
				counter := 1
			until
				counter > 9
			loop
				create radio_button.make_with_text ("Radio button " + counter.out)
				vertical_box.extend (radio_button)
				counter := counter + 1
			end
	
			widget := vertical_box
		end

feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX

end -- class RADIO_BUTTON_MULTIPLE_TEST
