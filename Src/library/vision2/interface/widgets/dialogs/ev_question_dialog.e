indexing
	description: "EiffelVision warning dialog. This dialog%
			% displays a window with a question bitmap,%
			% a text inside and a title."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_QUESTION_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			implementation,
			make_default,
			make
		end
creation
	make,
	make_default

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create the dialog box.
		do
			!EV_QUESTION_DIALOG_IMP!implementation.make (par)
			{EV_MESSAGE_DIALOG} Precursor (par)
		end

	make_default (par: EV_WINDOW; msg, dtitle: STRING) is
			-- Create with default_options
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make (par)
			{EV_MESSAGE_DIALOG} Precursor (par, msg, dtitle)
		end

feature -- status settings

	add_yesno_buttons is
			-- Add two buttons Yes and No.
		do
			implementation.add_yesno_buttons
		end

	add_yesnocancel_buttons is
			-- Add three buttons : Yes, No and Cancel.
		do
			implementation.add_yesnocancel_buttons
		end

feature -- Event - command association

	add_yes_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Yes button is pressed.
			-- If there is no Yes button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_yes_command (cmd, arg)
		end

	add_no_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the No button is pressed.
			-- If there is no No button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_no_command (cmd, arg)
		end

feature {NONE} -- Implementation

	implementation: EV_QUESTION_DIALOG_I

end -- class EV_QUESTION_DIALOG

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
