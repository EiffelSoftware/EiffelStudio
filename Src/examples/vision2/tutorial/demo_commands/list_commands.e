indexing
	description: "Objects that display events executed on a list."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_COMMANDS
	
feature -- Initialization

	add_list_commands (w: EV_ANY; e: EVENT_WINDOW; name: STRING) is
			-- Initialize commands for buttons
		local
			cmd: EV_ROUTINE_COMMAND
			list: EV_LIST
		do
			list_current_name := name
			list_e_window := e
			list ?= w
			create cmd.make (~select_command)
			list.add_select_command (cmd, Void)
			create cmd.make (~unselect_command)
			list.add_unselect_command (cmd, Void)
		end

feature -- Access

	list_e_window: EVENT_WINDOW

	list_current_name: STRING

feature -- Basic operations

	select_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When `list' is clicked then inform user in `list_e_window'
		local
			temp_string: STRING
		do
			temp_string := clone (list_current_name)
			temp_string.append_string(" select command.")
			list_e_window.display (temp_string)
		end


	unselect_command (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- When `list' is clicked then inform user in `list_e_window'
		local
			temp_string: STRING
		do
			temp_string := clone (list_current_name)
			temp_string.append_string(" unselect command.")
			list_e_window.display (temp_string)
		end

end -- class LIST_COMMANDS

