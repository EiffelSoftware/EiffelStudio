--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision message dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature {NONE} -- Initialization

--	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
--			-- Create a message box with `par' as parent, `a_title' as
--			-- title and `a_msg' as message.
--		require
--			valid_parent: is_valid (par)
--			valid_title: a_title /= Void
--			valid_message: a_msg /= Void
--		deferred
--		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create the default message dialog with `par' as
			-- parent, `a_title' as title and `a_msg' as message
			-- and displays it.
		require
			valid_parent: is_valid (par)
			valid_title: a_title /= Void
			valid_message: a_msg /= Void
		deferred
		end

feature {EV_MESSAGE_DIALOG} -- Initialization

--	build is
--			-- Fill the dialog with the basic elements.
--		deferred
--		end

feature -- Status report

	selected_button: STRING is
			-- Return the label of the selected button.
			-- Can be any string in :
			-- "OK", "Cancel", "Yes", "No", "Abort",
			-- "Retry", "Ignore", "Help".
		deferred
		end

feature -- Status setting

	show_ok_button is
			-- Show an "OK" button in the dialog.
		require
		deferred
		end

	show_ok_cancel_buttons is
			-- Show two buttons : "OK" and "Cancel".
		require
		deferred
		end

	show_yes_no_buttons is
			-- Show two buttons in the dialog: "Yes" and "No".
		require
		deferred
		end

	show_yes_no_cancel_buttons is
			-- Show three buttons in the dialog: "Yes", "No" and "Cancel".
		require
		deferred
		end

	show_abort_retry_ignore_buttons is
			-- Show three buttons in the dialog: "Abort", "Retry" and "Ignore".
		require
		deferred
		end

	show_retry_cancel_buttons is
			-- Show two buttons in the dialog: "Retry" and "Cancel".
		require
		deferred
		end

	add_help_button is
			-- Add an "Help" button to the other choosen buttons
			-- in the dialog box.
		require
		deferred
		end

feature -- Element change

	set_title (str: STRING) is
			-- Make `str' the new title of the dialog.
		require
			valid_title: str /= Void
		deferred
		end

	set_message (str: STRING) is
			-- Make `str' the new title of the dialog.
		require
			valid_message: str /= Void
		deferred
		end

feature -- Event - command association

--	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the OK button is pressed.
--			-- If there is no OK button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Cancel button is pressed.
--			-- If there is no Cancel button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_yes_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Yes button is pressed.
--			-- If there is no Yes button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_no_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the No button is pressed.
--			-- If there is no No button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_abort_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Abort button is pressed.
--			-- If there is no Abort button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_retry_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Retry button is pressed.
--			-- If there is no Retry button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_ignore_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Ignore button is pressed.
--			-- If there is no Ignore button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

--	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed when
--			-- the Help button is pressed.
--			-- If there is no Help button, the event never occurs.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

feature -- Event -- removing command association

--	remove_ok_commands is
--			-- Empty the list of commands to be executed when
--			-- "OK" button is pressed.
--		require
--		deferred
--		end

--	remove_cancel_commands is
--			-- Empty the list of commands to be executed when
--			-- "Cancel" button is pressed.
--		require
--		deferred
--		end

--	remove_yes_commands is
--			-- Empty the list of commands to be executed when
--			-- "Yes" button is pressed.
--		require
--		deferred
--		end

--	remove_no_commands is
--			-- Empty the list of commands to be executed when
--			-- "No" button is pressed.
--		require
--		deferred
--		end

--	remove_abort_commands is
--			-- Empty the list of commands to be executed when
--			-- "Abort" button is pressed.
--		require
--		deferred
--		end

--	remove_retry_commands is
--			-- Empty the list of commands to be executed when
--			-- "Retry" button is pressed.
--		require
--		deferred
--		end

--	remove_ignore_commands is
--			-- Empty the list of commands to be executed when
--			-- "Ignore" button is pressed.
--		require
--		deferred
--		end

--	remove_help_commands is
--			-- Empty the list of commands to be executed when
--			-- "Help" button is pressed.
--		require
--		deferred
--		end

feature {EV_MESSAGE_DIALOG, EV_MESSAGE_DIALOG_I} -- Implementation

	set_default (a_msg, a_title: STRING) is
			-- Set default settings
		deferred
		end

end -- class EV_MESSAGE_DIALOG_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.6  2000/02/04 21:35:43  oconnor
--| unreleased
--|
--| Revision 1.13.6.5  2000/02/04 07:55:11  oconnor
--| removed old command features
--|
--| Revision 1.13.6.4  2000/02/04 04:07:01  oconnor
--| released
--|
--| Revision 1.13.6.3  2000/01/27 19:29:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.2  1999/12/09 03:15:05  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.13.6.1  1999/11/24 17:30:09  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.3  1999/11/04 23:10:39  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.13.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
