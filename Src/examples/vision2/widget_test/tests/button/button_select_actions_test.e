indexing
	description: "Objects that demonstrate `select_actions'%
		%of EV_BUTTON."
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
	
	select_actions_counter: INTEGER
		-- Counter used to signify number of times button has been
		-- selected.

end -- class BUTTON_SELECT_ACTIONS_TEST
