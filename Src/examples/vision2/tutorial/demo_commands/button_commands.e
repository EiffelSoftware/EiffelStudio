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

