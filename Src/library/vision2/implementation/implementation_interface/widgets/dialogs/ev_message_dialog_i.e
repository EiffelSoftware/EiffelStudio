indexing
	description: "EiffelVision message dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG_I

inherit
	EV_DIALOG_I
		redefine
			build
		end

feature {EV_MESSAGE_DIALOG} -- Initialization

	build is
			-- Normal build and load icon
		do
			Precursor
			icon_build (display_area)			
		end

feature -- Status settings

	set_default (msg, dtitle: STRING) is
			-- Set default settings
		do
			set_message (msg)
			set_title (dtitle)
			add_ok_button
		end

	set_message (msg: STRING) is
			-- Set the message to be displayed
		do
			if message = Void then
				!!message.make_with_text (display_area, msg)
			else
				message.set_text(msg)
			end
		end

	add_ok_button is
			-- Add an OK button in the dialog.
		local
			cmd: EV_MESSAGE_DIALOG_CLOSE_COMMAND
			arg: EV_ARGUMENT1 [EV_MESSAGE_DIALOG_I]
		do
			if ok_button = Void then
				!!ok_button.make_with_text (action_area, "OK")
				ok_button.set_expand(True)
				!!cmd
				!!arg.make (Current)
				ok_button.add_click_command(cmd, arg)
			end
		end

	add_help_button is
			-- Add a Help button in the dialog.
		do
			if help_button = Void then
				!!help_button.make_with_text (action_area, "Help")
				help_button.set_expand(True)
			end
		end
	
	add_cancel_button is
			-- Add a cancel button in the dialog
		local
			cmd: EV_MESSAGE_DIALOG_CLOSE_COMMAND
			arg: EV_ARGUMENT1 [EV_MESSAGE_DIALOG_I]
		do
			if cancel_button = Void then
				!!cancel_button.make_with_text (action_area, "Cancel")
				cancel_button.set_expand(True)
				!!cmd
				!!arg.make (Current)
				cancel_button.add_click_command(cmd, arg)
			end
		end

	add_okcancel_buttons is
			-- Add two buttons : OK and Cancel.
		do
			add_ok_button
			add_cancel_button
		end

feature -- Miscellaneous

--	display (txt, title: STRING) is
--			-- Must be called to display a dialog that wasn't
--			-- created with default options.
--		do
--		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the OK button is pressed.
			-- If there is no OK button, the event never occurs.
		do
			ok_button.add_click_command(cmd, args)
		end

	add_cancel_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Cancel button is pressed.
			-- If there is no Cancel button, the event never occurs.
		do
			cancel_button.add_click_command(cmd, args)
		end

	add_help_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Help button is pressed.
			-- If there is no Help button, the event never occurs.
		do
			help_button.add_click_command(cmd, args)
		end

feature {NONE} -- Implementation

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
		deferred
		end

	message: EV_LABEL

	ok_button: EV_BUTTON

	help_button: EV_BUTTON

	cancel_button: EV_BUTTON

end -- class EV_MESSAGE_DIALOG_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
