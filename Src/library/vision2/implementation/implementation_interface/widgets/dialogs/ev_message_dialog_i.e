indexing
	description: "EiffelVision message dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG_I

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		require
			parent_not_void: par /= Void
		deferred
		end

	make_default (par: EV_CONTAINER; txt, title: STRING) is
		require
			parent_not_void: par /= Void
			text_not_void: txt /= Void
			title_not_void: title /= Void
		deferred
		end

feature -- Status settings

	add_ok_button is
			-- Add an OK button in the dialog.
		deferred
		end

	add_help_button is
			-- Add an Help button in the dialog.
		deferred
		end

	add_okcancel_buttons is
			-- Add two buttons : OK and Cancel.
		deferred
		end

feature -- Miscellaneous

	display (txt, title: STRING) is
			-- Must be called to display a dialog that wasn't
			-- created with default options.
		deferred
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the OK button is pressed.
			-- If there is no OK button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Cancel button is pressed.
			-- If there is no Cancel button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Help button is pressed.
			-- If there is no Help button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

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
