indexing
	description: "Objects that display events executed on text fields."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_FIELD_COMMANDS
	
feature -- Initialization

	add_text_field_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for buttons
		local
			cmd: EV_ROUTINE_COMMAND
			field: EV_TEXT_FIELD
		do
			text_field_current_name := name
			text_field_e_window := e
			field ?= w
			create cmd.make (agent return_command)
			field.add_return_command (cmd, Void)
		end

feature -- Access

	text_field_e_window: EVENT_WINDOW

	text_field_current_name: STRING

feature -- Basic operations

	return_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When return is pressed then inform user in `text_field_e_window'
		local
			temp_string: STRING
		do
			temp_string := "Return pressed in "
			temp_string.append_string(text_field_current_name)
			temp_string.append_string(".")
			text_field_e_window.display (temp_string)
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


end -- class TEXT_FIELD_COMMANDS

 


