indexing
	description: "Objects that display events executed on text fields."
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
			create cmd.make (~return_command)
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

end -- class TEXT_FIELD_COMMANDS

 


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

