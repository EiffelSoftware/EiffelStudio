indexing
	description: 
		"MAIN_WINDOW class of the hello world example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine	
			make_top_level
		end

creation
	make_top_level

feature --Access

	button: EV_BUTTON
			-- Push buttons

feature -- Initialization
	
	make_top_level is
			-- Creation of the window.
		do
			{EV_WINDOW} Precursor
			create button.make (Current)
			set_values
			set_commands
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets.
		do
			button.set_text ("Hello World")
		end

	set_commands is
			-- Set the commands on the widgets.
		local
			cmd: HELLO_COMMAND
			arg: EV_ARGUMENT1 [STRING]
			accelerator: EV_ACCELERATOR
			key: EV_KEY_CODE
		do
			create cmd
			create key.make

			-- A direct command
			create arg.make (button.text)
			button.add_click_command (cmd, arg)

			-- A command linked to an accelerator
			create accelerator.make (key.Key_f1, False, False, False)
			create arg.make ("F1 Key pressed")
			button.add_accelerator_command (accelerator, cmd, arg)
		end

end -- class MAIN_WINDOW

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

