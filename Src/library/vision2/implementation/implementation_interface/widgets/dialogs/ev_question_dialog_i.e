indexing
	description: "EiffelVision question dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_QUESTION_DIALOG_I

inherit
	EV_MESSAGE_DIALOG_I
		redefine
			set_default
		end

feature -- status settings

	set_default (msg, dtitle: STRING) is
			-- Set default settings
		do
			set_message (msg)
			set_title (dtitle)
			add_yesno_buttons
		end

	add_yes_button is
			-- Add a `Yes' button in the dialog
		do
			if yes_button = Void then
				!!yes_button.make_with_text (action_area, "Yes")
				yes_button.set_expand(True)
			end
		end

	add_no_button is
			-- Add a `No' button in the dialog
		do
			if no_button = Void then
				!!no_button.make_with_text (action_area, "No")
				no_button.set_expand(True)
			end
		end

	add_yesno_buttons is
			-- Add two buttons Yes and No.
		do
			add_yes_button
			add_no_button
		end

	add_yesnocancel_buttons is
			-- Add three buttons : Yes, No and Cancel.
		do
			add_yesno_buttons
			add_cancel_button
		end

feature -- Event - command association

	add_yes_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Yes button is pressed.
			-- If there is no Yes button, the event never occurs.
		do
			yes_button.add_click_command(cmd, args)
		end

	add_no_command (cmd: EV_COMMAND; args: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed when
			-- the No button is pressed.
			-- If there is no No button, the event never occurs.
		do
			no_button.add_click_command(cmd, args)
		end

feature {NONE} -- Implementation		

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
		local
			icon: EV_PIXMAP
		do
			--!!icon.make (par)
		end

	yes_button: EV_BUTTON

	no_button: EV_BUTTON

end -- class EV_QUESTION_DIALOG_I

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
