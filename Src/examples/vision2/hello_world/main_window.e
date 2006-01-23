indexing
	description: 
		"MAIN_WINDOW class of the hello world example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make_top_level

feature --Access

	button: EV_BUTTON
			-- Push buttons

feature -- Initialization
	
	make_top_level is
			-- Creation of the window.
		do
			Precursor {EV_WINDOW}
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


end -- class MAIN_WINDOW

