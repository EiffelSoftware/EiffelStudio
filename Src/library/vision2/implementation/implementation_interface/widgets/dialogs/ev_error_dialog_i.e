indexing
	description: "EiffelVision error dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ERROR_DIALOG_I

inherit
	EV_MESSAGE_DIALOG_I

feature -- Status settings

	add_abortretryignore_buttons is
			-- Add three buttons `abort', `retry' and `ignore'.
		deferred
		end

	add_retrycancel_buttons is
			-- Add two buttons `retry' and `cancel'
		deferred
		end

feature -- Event - command association

	add_abort_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `ok' button
			-- is pressed. If there is no `ok' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		deferred
		end

	add_retry_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `cancel' button
			-- is pressed. If there is no `cancel' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		deferred
		end

	add_ignore_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `help' button
			-- is pressed. If there is no `help' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		deferred
		end

end -- class EV_ERROR_DIALOG_I

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
