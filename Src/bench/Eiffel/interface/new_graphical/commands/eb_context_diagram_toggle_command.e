indexing
	description: "Objects that is a command with a toggle button for diagram tool"
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND
	
feature -- Status setting

	enable_select is
			-- Make `Current' selected.
		do
			if current_button /= Void then
				if not current_button.is_selected then
					current_button.select_actions.block
					current_button.toggle
					current_button.select_actions.resume
				end
				current_button.set_tooltip (tooltip + shortcut_string)
			end
		end
		
	disable_select is
			-- Make `Current' deselected.
		do
			if current_button /= Void then
				if current_button.is_selected then
					current_button.select_actions.block
					current_button.toggle
					current_button.select_actions.resume
				end
				current_button.set_tooltip (tooltip + shortcut_string)
			end
		end
		
feature -- Access

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
		deferred
		end
		
	tooltip: STRING is
		deferred
		end
		
	shortcut_string: STRING is
		deferred
		end
		
		

end -- class EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND
