indexing
	description: "Objects that demonstrate `select_actions'%
		%of EV_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_SELECT_ACTIONS_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create button.make_with_text ("Select me!")
			button.select_actions.extend (agent set_button_text)
			widget := button
		end
		
	set_button_text is
			-- Display current value of
			-- `select_actions_counter' on `button' and
			-- increase `select_actions_counter'.
		do
			select_actions_counter := select_actions_counter + 1
			button.set_text ("Button selected " + select_actions_counter.out + " times.")
		end
		
feature {NONE} -- Implementation

	button: EV_BUTTON
	
	select_actions_counter: INTEGER

end -- class BUTTON_SELECT_ACTIONS_TEST
