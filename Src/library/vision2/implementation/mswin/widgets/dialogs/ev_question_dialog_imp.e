indexing
	description: "EiffelVision question dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_QUESTION_DIALOG_IMP

inherit
	EV_QUESTION_DIALOG_I

	EV_MESSAGE_DIALOG_IMP
		redefine
			make, 
			make_default,
			dispatch_events
		end

creation
	make, make_default

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a dialog, but do not displays it.
			-- This dialog has no buttons.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par)
			dialog_style := Mb_iconquestion
		end

	make_default (par: EV_CONTAINER; txt, title: STRING) is
			-- Create the default error dialog with `par' as
			-- parent, `title' as title and `txt' as message.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, txt, title)
			dialog_style := Mb_iconquestion + Mb_yesno
			display (txt, title)
		end

feature -- status settings

	add_yesno_buttons is
			-- Add two buttons `yes' and `no'
		do
			dialog_style := dialog_style + Mb_yesno
		end

	add_yesnocancel_buttons is
			-- Add three buttons : `yes', `no' and `cancel'.
		do
			dialog_style := dialog_style + Mb_yesnocancel
		end

feature -- Event - command association

	add_yes_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `ok' button
			-- is pressed. If there is no `ok' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			add_command (Cmd_yes, a_command, arguments)
		end

	add_no_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `cancel' button
			-- is pressed. If there is no `cancel' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			add_command (Cmd_no, a_command, arguments)
		end

feature {NONE} -- Implementation for events handling

	dispatch_events (msg_box_result: INTEGER) is
			-- Execute the command associated to the action of the user.
		do
			if msg_box_result = Idok then
				execute_command (Cmd_ok, Void)
			elseif msg_box_result = Idcancel then
				execute_command (Cmd_cancel, Void)
	--		elseif msg_box_result = Idhelp then
	
			elseif msg_box_result = Idyes then
				execute_command (Cmd_yes, Void)
			elseif msg_box_result = Idno then
				execute_command (Cmd_no, Void)
			end
		end

end -- class EV_QUESTION_DIALOG_IMP

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
