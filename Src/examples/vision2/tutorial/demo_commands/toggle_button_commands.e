indexing
	description: "Objects that display events exectued on a toggle button."
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
			create cmd.make (~toggle_command)
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

end -- class TOGGLE_BUTTON_COMMANDS
 


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

