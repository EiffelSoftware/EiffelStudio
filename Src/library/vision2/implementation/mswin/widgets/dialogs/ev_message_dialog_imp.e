indexing
	description: "EiffelVision message dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG_IMP

inherit
	EV_MESSAGE_DIALOG_I

	EV_EVENT_HANDLER_IMP

	EV_DIALOG_EVENTS_CONSTANTS_IMP

	WEL_MSG_BOX
		rename
			make as wel_make
		end

	WEL_MB_CONSTANTS
		export
			{NONE} all
		end

	WEL_LANGUAGE_CONSTANTS
		export
 			{NONE} all
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			parent_imp ?= par.implementation
			wel_make
			title := ""
			message := ""
			selected_button := ""
		end

	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message box with `par' as parent, `a_title' as
			-- title and `a_msg' as message.
		do
			parent_imp ?= par.implementation
			title := a_title
			message := a_msg
			selected_button := ""
			wel_make
		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create the default message dialog with `par' as
			-- parent, `a_title' as title and `a_msg' as message
			-- and displays it.
		do
			parent_imp ?= par.implementation
			title := a_title
			message := a_msg
			selected_button := ""
			wel_make
		end

feature -- Status report

	selected_button: STRING
			-- Return the label of the selected button.
			-- Can be any string in :
			-- "OK", "Cancel", "Yes", "No", "Abort",
			-- "Retry", "Ignore", "Help".

feature -- Status settings

	destroy is
			-- Destroy actual object.
		do
			destroyed := True
		end

	show_ok_button is
			-- Show one button in the dialog : "OK".
		do
			add_flag (Mb_ok)
		end

	show_ok_cancel_buttons is
			-- Show two buttons in the dilaog: "OK" and "Cancel".
		do
			add_flag (Mb_okcancel)
		end

	show_yes_no_buttons is
			-- Show two buttons in the dialog: "Yes" and "No".
		do
			add_flag (Mb_yesno)
		end

	show_yes_no_cancel_buttons is
			-- Show three buttons in the dialog: "Yes", "No" and "Cancel".
		do
			add_flag (Mb_yesnocancel)
		end

	show_abort_retry_ignore_buttons is
			-- Show three buttons in the dialog: "Abort", "Retry" and "Ignore".
		do
			add_flag (Mb_abortretryignore)
		end

	show_retry_cancel_buttons is
			-- Show two buttons in the dialog: "Retry" and "Cancel".
		do
			add_flag (Mb_retrycancel)
		end

	add_help_button is
			-- Add an "Help" button to the other choosen buttons
			-- in the dialog box.
		do
			add_flag (Mb_help)
		end

	show is
			-- Show the window.
			-- As the window is modal, nothing can be done
			-- until the user closed the window.
		local
			wel_imp: WEL_WINDOW
			a_msgboxparams: WEL_MSGBOXPARAMS
		do
			wel_imp ?= parent_imp
			!! a_msgboxparams.make_basic (wel_imp, message, title, dialog_style, LANG_ENGLISH, SUBLANG_ENGLISH_US)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
			dispatch_events (message_box_result)
		end

feature -- Element change

	set_title (str: STRING) is
			-- Make `str' the new title of the dialog.
		do
			title := str
		end

	set_message (str: STRING) is
			-- Make `str' the new title of the dialog.
		do
			message := str
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
			-- If there is no "OK" button, the event never occurs.
		do
			add_command (Cmd_ok, cmd, arg)
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Cancel" button is pressed.
			-- If there is no "Cancel" button, the event never occurs.
		do
			add_command (Cmd_cancel, cmd, arg)
		end

	add_yes_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Yes button is pressed.
			-- If there is no Yes button, the event never occurs.
		do
			add_command (Cmd_yes, cmd, arg)
		end

	add_no_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the No button is pressed.
			-- If there is no No button, the event never occurs.
		do
			add_command (Cmd_no, cmd, arg)
		end

	add_abort_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Abort button is pressed.
			-- If there is no Abort button, the event never occurs.
		do
			add_command (Cmd_abort, cmd, arg)
		end

	add_retry_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Retry button is pressed.
			-- If there is no Retry button, the event never occurs.
		do
			add_command (Cmd_retry, cmd, arg)
		end

	add_ignore_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Ignore button is pressed.
			-- If there is no Ignore button, the event never occurs.
		do
			add_command (Cmd_ignore, cmd, arg)
		end

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Help" button is pressed.
			-- If there is no "Help" button, the event never occurs.
		do
			add_command (Cmd_help, cmd, arg)
		end

feature {NONE} -- Basic operations

	add_flag (value: INTEGER) is
			-- Add `value' in `dialog_style'.
		do
			dialog_style := set_flag (dialog_style, value)
		ensure
			has_flag: flag_set (dialog_style, value)
		end

	remove_flag (value: INTEGER) is
			-- Remove `value' in `dialog_style'.
		do
			dialog_style := clear_flag (dialog_style, value)
		ensure
			has_not_flag: not flag_set (dialog_style, value)
		end

feature {NONE} -- Implementation for events handling

	dispatch_events (msg_box_result: INTEGER) is
			-- Execute the command associated to the action of the user.
			-- As in `process_message' of WEL_WINDOW, we can't use
			-- `inspect' here.
		do
			if msg_box_result = Idok then
				execute_command (Cmd_ok, Void)
				selected_button := "OK"
			elseif msg_box_result = Idcancel then
				execute_command (Cmd_cancel, Void)
				selected_button := "Cancel"
			elseif msg_box_result = Idyes then
				execute_command (Cmd_yes, Void)
				selected_button := "Yes"
			elseif msg_box_result = Idno then
				execute_command (Cmd_no, Void)
				selected_button := "No"
			elseif msg_box_result = Idabort then
				execute_command (Cmd_abort, Void)
				selected_button := "Abort"
			elseif msg_box_result = Idretry then
				execute_command (Cmd_retry, Void)
				selected_button := "Retry"
			elseif msg_box_result = Idignore then
				execute_command (Cmd_ignore, Void)
				selected_button := "Ignore"
--			elseif msg_box_result = Idhelp then
--				execute_command (Cmd_help, Void)
				selected_button := "Help"
			end
		end

feature {NONE} -- Implementation

	dialog_style: INTEGER
			-- Style of the dialog

	parent_imp: EV_CONTAINER_IMP
			-- Parent of the current dialog

	message: STRING
			-- Message to display in the dialog box

	title: STRING
			-- Title of the dialog box

	destroyed: BOOLEAN
			-- Is object destroy? Yes, only if the user call it.

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
