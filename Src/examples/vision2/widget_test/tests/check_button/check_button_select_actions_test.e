indexing
	description: "Objects that demonstrate usage of `select_actions'%
		%of EV_CHECK_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BUTTON_SELECT_ACTIONS_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create check_button.make_with_text ("Select me!")
			check_button.select_actions.extend (agent update_text)
			widget := check_button
		end
	
	update_text is
			-- Update `text' of `check_button' to display checked
			-- state.
		do
			if check_button.is_selected then
				check_button.set_text ("Selected")
			else
				check_button.set_text ("Not selected")
			end
		end	
				
feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
	
end -- class CHECK_BUTTON_SELECT_ACTIONS_TEST
