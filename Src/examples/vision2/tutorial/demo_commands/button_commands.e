indexing
	description: "Objects that display events exectued on a button."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_COMMANDS
	
feature -- Initialization

	add_button_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for buttons
		local
			cmd: EV_ROUTINE_COMMAND
			button: EV_BUTTON
		do
			button_current_name := name
			button_e_window := e
			button ?= w
			create cmd.make (~click_command)
			button.add_click_command (cmd, Void)
		end

feature -- Access

	button_e_window: EVENT_WINDOW

	button_current_name: STRING

feature -- Basic operations

	click_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When `button' is clicked then inform user in `button_e_window'
		local
			temp_string: STRING
		do
			temp_string := clone (button_current_name)
			temp_string.append_string(" clicked.")
			button_e_window.display (temp_string)
		end

end -- class BUTTON_COMMANDS
