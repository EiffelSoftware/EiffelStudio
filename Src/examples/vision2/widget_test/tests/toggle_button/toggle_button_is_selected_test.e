indexing
	description: "Objects that demonstrate `select_actions'%
		%of EV_BUTTON."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_IS_SELECTED_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create toggle_button.make_with_text ("Not Selected")
			toggle_button.select_actions.extend (agent set_button_text)
	
			widget := toggle_button
		end
		
	set_button_text is
			-- Update `text' of `toggle_button'.
		do
			if toggle_button.is_selected then
				toggle_button.set_text ("Selected")
			else
				toggle_button.set_text ("Not Selected")
			end
		end
		
feature {NONE} -- Implementation

	toggle_button: EV_TOGGLE_BUTTON

end -- class TOGGLE_BUTTON_IS_SELECTED_TEST
