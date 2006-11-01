indexing
	description: "Objects that demonstrate `select_actions'%
		%of EV_BUTTON."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_SELECT_ACTIONS_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create button.make_with_text ("Select me!")
			button.select_actions.extend (agent set_button_text)
			widget := button
		end

feature {NONE} -- Implementation
		
	set_button_text is
			-- Display current value of
			-- `select_actions_counter' on `button' and
			-- increase `select_actions_counter'.
		do
			select_actions_counter := select_actions_counter + 1
			button.set_text ("Button selected " + select_actions_counter.out + " times.")
		end
		
	button: EV_BUTTON
		-- Widget that test is to be performed on.
	
	select_actions_counter: INTEGER;
		-- Counter used to signify number of times button has been
		-- selected.

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


end -- class BUTTON_SELECT_ACTIONS_TEST
