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


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

