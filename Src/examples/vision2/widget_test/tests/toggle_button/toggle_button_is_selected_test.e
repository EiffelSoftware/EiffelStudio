note
	description: "Objects that demonstrate `select_actions'%
		%of EV_TOGGLE_BUTTON."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_IS_SELECTED_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		do
			create toggle_button.make_with_text ("Not Selected")
			toggle_button.select_actions.extend (agent set_button_text)
	
			widget := toggle_button
		end

feature {NONE} -- Implementation
		
	set_button_text
			-- Update `text' of `toggle_button'.
		do
			if toggle_button.is_selected then
				toggle_button.set_text ("Selected")
			else
				toggle_button.set_text ("Not Selected")
			end
		end

	toggle_button: EV_TOGGLE_BUTTON;
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


end -- class TOGGLE_BUTTON_IS_SELECTED_TEST
