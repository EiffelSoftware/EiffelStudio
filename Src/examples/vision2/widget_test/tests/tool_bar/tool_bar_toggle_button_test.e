indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_TOGGLE_BUTTON_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
	EXECUTION_ENVIRONMENT
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

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
	
	update_button_text (toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Display selected state of `toggle_button' on `toggle_button'.
		do
			if toggle_button.is_selected then
				toggle_button.set_text ("Selected")
			else
				toggle_button.set_text ("Not selected")
			end
		end

end -- class TOOL_BAR_TOGGLE_BUTTON_TEST
