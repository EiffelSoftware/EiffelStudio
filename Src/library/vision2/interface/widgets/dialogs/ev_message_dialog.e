indexing
	description: "EiffelVision message dialog. Deferred class,%
				% ancestor of the standard dialogs for warning,%
				% informations, error or question."
	note: "Once the dialog is create with the procedure `make_default'%
		% the status settings features have no effect. To use them,%
		% the dialog must be first created with `make' and then the%
		% user choose the buttons he wants in the dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG

feature -- Status settings

	add_ok_button is
			-- Add an OK button in the dialog
		do
			implementation.add_ok_button
		end

	add_help_button is
			-- Add an help button in the dialog.
		do
			implementation.add_help_button
		end

	add_okcancel_buttons is
			-- Add two buttons : OK and Cancel.
		do
			implementation.add_okcancel_buttons
		end

feature -- Miscellaneous

	display (txt, title: STRING) is
			-- Must be called to display a dialog that wasn't
			-- created with default options.
		do
			implementation.display (txt, title)
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the OK button is pressed.
			-- If there is no OK button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_ok_command (cmd, arg)
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Cancel button is pressed.
			-- If there is no Cancel button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_cancel_command (cmd, arg)
		end

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Help button is pressed.
			-- If there is no Help button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_help_command (cmd, arg)
		end

feature -- Implementation

	implementation: EV_MESSAGE_DIALOG_I

end -- class EV_MESSAGE_DIALOG

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

