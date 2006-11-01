indexing
	description: "Objects that display events exectued on a toggle button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_BUTTON_COMMANDS
	
feature -- Initialization

	add_toggle_button_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for buttons
		local
			cmd: EV_ROUTINE_COMMAND
			button: EV_TOGGLE_BUTTON
		do
			toggle_button_current_name := name
			toggle_button_e_window := e
			button ?= w
			create cmd.make (agent toggle_command)
			button.add_toggle_command (cmd, Void)
		end

feature -- Access

	toggle_button_e_window: EVENT_WINDOW

	toggle_button_current_name: STRING

feature -- Basic operations

	toggle_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When `button' is toggled then inform user in `toggle_button_e_window'
		local
			temp_string: STRING
		do
			temp_string := clone (toggle_button_current_name)
			temp_string.append_string(" toggled.")
			toggle_button_e_window.display (temp_string)
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


end -- class TOGGLE_BUTTON_COMMANDS
 


