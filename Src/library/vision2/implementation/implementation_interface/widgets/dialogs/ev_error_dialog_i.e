indexing
	description: "EiffelVision error dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_ERROR_DIALOG_I

inherit
	EV_MESSAGE_DIALOG_I

feature -- Status settings

	add_abort_button is
			-- Add a `Abort' button in the dialog
		do
			if abort_button = Void then
				!!abort_button.make_with_text (action_area, "Abort")
				abort_button.set_expand(True)
			end
		end

	add_retry_button is
			-- Add a `Retry' button in the dialog
		do
			if retry_button = Void then
				!!retry_button.make_with_text (action_area, "Retry")
				retry_button.set_expand(True)
			end
		end

	add_ignore_button is
			-- Add a `Ignore' button in the dialog
		do
			if ignore_button = Void then
				!!ignore_button.make_with_text (action_area, "Ignore")
				ignore_button.set_expand(True)
			end
		end


	add_abortretryignore_buttons is
			-- Add three buttons Abort, Retry and Ignore.
		do
			add_abort_button
			add_retry_button
			add_ignore_button
		end

	add_retrycancel_buttons is
			-- Add two buttons Retry and Cancel.
		do
			add_retry_button
			add_cancel_button
		end

feature -- Event - command association

	add_abort_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Abort button is pressed.
			-- If there is no Abort button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			abort_button.add_click_command(cmd, args)
		end

	add_retry_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Retry button is pressed.
			-- If there is no Retry button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			retry_button.add_click_command(cmd, args)
		end

	add_ignore_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Ignore button is pressed.
			-- If there is no Ignore button, the event never occurs.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			ignore_button.add_click_command(cmd, args)
		end

feature {NONE} -- Implementation		

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
		local
			icon: EV_PIXMAP
		do
			--!!icon.make (par)
		end

	abort_button: EV_BUTTON

	retry_button: EV_BUTTON

	ignore_button: EV_BUTTON

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
