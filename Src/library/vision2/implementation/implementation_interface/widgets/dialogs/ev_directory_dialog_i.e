indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DIRECTORY_SELECTION_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	title: STRING is
			-- Title of the current dialog
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	directory: STRING is
			-- Path of the current selected file
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_title (a_title: STRING) is
			-- Make `a_title' the new title of the current dialog.
		require
			exists: not destroyed
			valid_title: a_title /= Void
		deferred
		end

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		require
			exists: not destroyed
			valid_path: path /= Void
		deferred
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
			-- If there is no "OK" button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Cancel" button is pressed.
			-- If there is no "Cancel" button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		require
			exists: not destroyed
		deferred
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		require
			exists: not destroyed
		deferred
		end

end -- class EV_DIRECTORY_SELECTION_DIALOG_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
