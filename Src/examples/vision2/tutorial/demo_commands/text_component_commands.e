indexing
	description: "Objects that display events exectued on text components."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_COMPONENT_COMMANDS
	
feature -- Initialization

	add_text_component_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for buttons
		local
			cmd: EV_ROUTINE_COMMAND
			component: EV_TEXT_COMPONENT
		do
			text_component_current_name := name
			text_component_e_window := e
			component ?= w
			create cmd.make (agent change_command)
			component.add_change_command (cmd, Void)
		end

feature -- Access

	text_component_e_window: EVENT_WINDOW

	text_component_current_name: STRING

feature -- Basic operations

	change_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When `button' text is changed then inform user in `text_component_e_window'
		local
			temp_string: STRING
		do
			temp_string := clone (text_component_current_name)
			temp_string.append_string(" text changed.")
			text_component_e_window.display (temp_string)
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


end -- class TEXT_COMPONENT_COMMANDS


