indexing
	description: "EiffelVision warning dialog. This dialog%
			% displays a window with an error bitmap,%
			% a text inside and a title."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ERROR_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			implementation
		end

creation
	make,
	make_default

feature -- Status settings

	add_abortretryignore_buttons is
			-- Add three buttons Abort, Retry and Ignore.
		do
			implementation.add_abortretryignore_buttons
		end

	add_retrycancel_buttons is
			-- Add two buttons Retry and Cancel.
		do
			implementation.add_retrycancel_buttons
		end

feature -- Event - command association

	add_abort_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Abort button is pressed.
			-- If there is no Abort button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_abort_command (cmd, arg)
		end

	add_retry_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Retry button is pressed.
			-- If there is no Retry button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_retry_command (cmd, arg)
		end

	add_ignore_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Ignore button is pressed.
			-- If there is no Ignore button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			Implementation.add_ignore_command (cmd, arg)
		end

feature {NONE} -- Implementation

	implementation: EV_ERROR_DIALOG_I

end -- class EV_ERROR_DIALOG

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

