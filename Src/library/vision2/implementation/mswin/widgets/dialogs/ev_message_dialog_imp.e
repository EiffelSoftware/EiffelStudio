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

	WEL_ID_CONSTANTS

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a dialog, but do not display it.
		do
			parent_imp ?= par.implementation
		ensure then
			parent_not_void: parent_imp /= Void
		end

	make_default (par: EV_CONTAINER; txt, title: STRING) is
			-- Create the default dialog with `par' as
			-- parent, `title' as title and `txt' as message
			-- an displays it.
		do
			parent_imp ?= par.implementation
		ensure then
			parent_not_void: parent_imp /= Void
		end

feature -- Acces

	parent_imp: EV_CONTAINER_IMP

feature -- Status settings

	add_ok_button is
			-- Add an `OK' button in the dialog
		do
			dialog_style := dialog_style + Mb_ok
		end

	add_help_button is
			-- Add a help button in the dialog
		do
			dialog_style := dialog_style + Mb_help
		end

	add_okcancel_buttons is
			-- Add two buttons : one `OK' and one `Cancel'.
		do
			dialog_style := dialog_style + Mb_okcancel
		end

feature -- Miscellaneous

	display (txt, title: STRING) is
			-- Must be called to display a dialog that wasn't
			-- created with default options.
		local
			a_msgboxparams: WEL_MSGBOXPARAMS
			wel_imp: WEL_WINDOW
		do
			wel_make
			wel_imp ?= parent_imp
			!! a_msgboxparams.make_basic (wel_imp, txt, title, dialog_style, language, sublanguage)
			message_box_result := cwin_message_box_indirect (a_msgboxparams.item)
			dispatch_events (message_box_result)
		end

feature -- Event - command association

	add_ok_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `ok' button
			-- is pressed. If there is no `ok' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			add_command (Cmd_ok, a_command, arguments)
		end

	add_cancel_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `cancel' button or the
			-- `Esc' key are pressed . If there is no `cancel' button, this
			-- event never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			add_command (Cmd_cancel, a_command, arguments)
		end

	add_help_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the `help' button
			-- is pressed. If there is no `help' button, the event
			-- never occurs and then the command isn't execute,
			-- yet, the user can add a command if he wish it.
		do
			add_command (Cmd_help, a_command, arguments)
		end

feature {NONE} -- Implementation for events handling

	initialize_list is
			-- Create the `command_list' and the `arguments_list'.
		do
			!! command_list.make (1, 6)
			!! argument_list.make (1, 6)
		end

	dispatch_events (msg_box_result: INTEGER) is
			-- Execute the command associated to the action of the user.
			-- As in `process_message' of WEL_WINDOW, we can't use
			-- `inspect' here.
		do
			if msg_box_result = Idok then
				execute_command (Cmd_ok, Void)
			elseif msg_box_result = Idcancel then
				execute_command (Cmd_cancel, Void)
	--		elseif msg_box_result = Idhelp then
	
			end
		end

--feature {NONE} -- Implementation for preconditions

--	has_option (flag: INTEGER): BOOLEAN is
--			-- Does dialog_style has `flag' in its options.
--		do
--			Result := ((((dialog_style // flag ) - 1) \\ 2) = 1)
--		end

feature {NONE} -- Implementation

	dialog_style: INTEGER
			-- Style of the dialog.

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
