indexing
	description: "Objects that demonstrate multiple instances of%
		%EV_RADIO_BUTTON in the same EV_CONTAINER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_MULTIPLE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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

	vertical_box: EV_VERTICAL_BOX;
		-- Widget used to hold test radio buttons.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RADIO_BUTTON_MULTIPLE_TEST
