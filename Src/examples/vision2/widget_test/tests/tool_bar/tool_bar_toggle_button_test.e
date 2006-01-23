indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_TOGGLE_BUTTON_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			tool_bar_button: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			create tool_bar
			from
				counter := 1
			until
				counter > 5
			loop
				create tool_bar_button
				tool_bar_button.set_text ("Not selected")
				tool_bar_button.select_actions.extend (agent update_button_text (tool_bar_button))
				tool_bar.extend (tool_bar_button)
				counter := counter + 1
			end
			
			widget := tool_bar
		end
		
feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
		-- Toolbar that toggle buttons are held within.
	
	update_button_text (toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Display `toggle_button's selected state on itself.
		do
			if toggle_button.is_selected then
				toggle_button.set_text ("Selected")
			else
				toggle_button.set_text ("Not selected")
			end
		end

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


end -- class TOOL_BAR_TOGGLE_BUTTON_TEST
