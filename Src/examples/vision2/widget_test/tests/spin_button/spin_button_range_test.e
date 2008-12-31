note
	description: "Objects that demonstrate EV_SPIN_BUTTON."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SPIN_BUTTON_RANGE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		do
			create spin_button
			spin_button.set_minimum_size (250, 250)
			spin_button.value_range.adapt (create {INTEGER_INTERVAL}.make (1000, 2000))
			spin_button.set_text ("Range modified : 1000 - 2000")

			widget := spin_button
		end
		
feature {NONE} -- Implementation

	spin_button: EV_SPIN_BUTTON;
		-- Widget that test is to be performed on.
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SPIN_BUTTON_RANGE_TEST
