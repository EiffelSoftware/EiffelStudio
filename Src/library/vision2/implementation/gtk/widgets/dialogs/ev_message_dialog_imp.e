indexing
	description: "EiffelVision message dialog. Implemenation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_MESSAGE_DIALOG_IMP

inherit
	EV_MESSAGE_DIALOG_I

	EV_DIALOG_IMP
		rename
			make as old_make,
			interface as old_interface,
			set_interface as old_set_interface
		redefine
			build
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the dialog box.
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
			plateform_build (par.implementation)
		end

	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message box with `par' as parent, `a_title' as
			-- title and `a_msg' as message.
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
			plateform_build (par.implementation)
			set_message (a_msg)
			set_title (a_title)
		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
		do
			widget := gtk_window_new (GTK_WINDOW_TOPLEVEL)
			initialize
			plateform_build (par.implementation)
			show
		end

	build is
			-- Normal build and load icon
		local
			dbox: EV_VERTICAL_BOX
			container_interface: EV_DIALOG
			parent: EV_WINDOW
			color: EV_COLOR
		do
			-- First the build of the window
			set_background_color (Color_dialog)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)

			-- We cannot use the precursor, but it is
			-- almost the same. The build of the dialog
			parent ?= parent_imp.interface
			!! container_interface.make (parent)
			container_interface.set_implementation (Current)
			check
				container_not_void: container_interface /= Void
			end

			!! dbox.make (container_interface)
			dbox.set_homogeneous (False)
			dbox.set_border_width (12)
			dbox.set_spacing (4)

			!! display_area.make (dbox)
			display_area.set_spacing (3)
			display_area.set_minimum_height (100)
			display_area.set_minimum_width (250)

			!! action_area.make (dbox)
			action_area.set_border_width (3)
			action_area.set_spacing (4)
			action_area.set_expand (False)
			action_area.set_minimum_height (30)
			action_area.set_minimum_width (250)

			-- Current build
			icon_build (display_area)		
		end

feature -- Status report

	selected_button: STRING is
			-- Return the label of the selected button.
			-- Can be any string in :
			-- "OK", "Cancel", "Yes", "No", "Abort",
			-- "Retry", "Ignore", "Help".
		do
		end

feature -- Status settings

	show_ok_button is
			-- Show an "OK" button in the dialog.
		do
			set_button (1, "OK")
			unset_button (2)
			unset_button (3)
			add_dialog_close_command (first_button)
		end

	show_ok_cancel_buttons is
			-- Show two buttons : "OK" and "Cancel".
		do
			set_button (1, "OK")
			set_button (2, "Cancel")
			unset_button (3)
			add_dialog_close_command (first_button)
			add_dialog_close_command (second_button)
		end

	show_yes_no_buttons is
			-- Show two buttons in the dialog: "Yes" and "No".
		do
			set_button (1, "Yes")
			set_button (2, "No")
			unset_button (3)
		end

	show_yes_no_cancel_buttons is
			-- Show three buttons in the dialog: "Yes", "No" and "Cancel".
		do
			set_button (1, "Yes")
			set_button (2, "No")
			set_button (3, "Cancel")
			add_dialog_close_command (third_button)
		end

	show_abort_retry_ignore_buttons is
			-- Show three buttons in the dialog: "Abort", "Retry" and "Ignore".
		do
			set_button (1, "Abort")
			set_button (2, "Retry")
			set_button (3, "Ignore")
			add_dialog_close_command (third_button)
		end

	show_retry_cancel_buttons is
			-- Show two buttons in the dialog: "Retry" and "Cancel".
		do
			set_button (1, "Retry")
			set_button (2, "Cancel")
			unset_button (3)
			add_dialog_close_command (second_button)
		end

	add_help_button is
			-- Add a Help button in the dialog.
		do
			if help_button = Void then
				!!help_button.make_with_text (action_area, "Help")
				help_button.set_expand(True)
			end
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the OK button is pressed.
			-- If there is no OK button, the event never occurs.
		do
			add_user_command ("OK", cmd, arg)
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Cancel button is pressed.
			-- If there is no Cancel button, the event never occurs.
		do
			add_user_command ("Cancel", cmd, arg)
		end

	add_yes_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Yes button is pressed.
		do
			add_user_command ("Yes", cmd, arg)
		end

	add_no_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the No button is pressed.
			-- If there is no No button, the event never occurs.
		do
			add_user_command ("No", cmd, arg)
		end

	add_abort_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Abort button is pressed.
			-- If there is no Abort button, the event never occurs.
		do
			add_user_command ("Abort", cmd, arg)
		end

	add_retry_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Retry button is pressed.
			-- If there is no Retry button, the event never occurs.
		do
			add_user_command ("Retry", cmd, arg)
		end

	add_ignore_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Ignore button is pressed.
			-- If there is no Ignore button, the event never occurs.
		do
			add_user_command ("Ignore", cmd, arg)
		end

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the Help button is pressed.
			-- If there is no Help button, the event never occurs.
		do
			help_button.add_click_command(cmd, arg)
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
			check False end
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		do
			check False end
		end

	remove_yes_commands is
			-- Empty the list of commands to be executed when
			-- "Yes" button is pressed.
		do
			check False end
		end

	remove_no_commands is
			-- Empty the list of commands to be executed when
			-- "No" button is pressed.
		do
			check False end
		end

	remove_abort_commands is
			-- Empty the list of commands to be executed when
			-- "Abort" button is pressed.
		do
			check False end
		end

	remove_retry_commands is
			-- Empty the list of commands to be executed when
			-- "Retry" button is pressed.
		do
			check False end
		end

	remove_ignore_commands is
			-- Empty the list of commands to be executed when
			-- "Ignore" button is pressed.
		do
			check False end
		end

	remove_help_commands is
			-- Empty the list of commands to be executed when
			-- "Help" button is pressed.
		do
			check False end
		end

feature {NONE} -- Basic operation

	set_button (number: INTEGER; label: STRING) is
			-- Add a button to the window if necessary.
		do
			inspect number
			when 1 then
				if first_button = Void then
					!! first_button.make_with_text (action_area, label)
					first_button.set_expand(True)
				else
					first_button.set_text (label)
				end
			when 2 then
				if second_button = Void then
					!! second_button.make_with_text (action_area, label)
					second_button.set_expand(True)
				else
					second_button.set_text (label)
				end
			when 3 then
				if third_button = Void then
					!! third_button.make_with_text (action_area, label)
					third_button.set_expand(True)
				else
					third_button.set_text (label)
				end
 			end
		end

	unset_button (number: INTEGER) is
			-- Destroy the given button if it exists.
		local
			button: EV_BUTTON
		do
			inspect number
			when 1 then
				if first_button /= Void then
					first_button.destroy
					first_button := Void
				end
			when 2 then
				if second_button /= Void then
					second_button.destroy
					second_button := Void
				end
			when 3 then
				if third_button /= Void then
					third_button.destroy
					third_button := Void
				end
 			end
		end

	add_dialog_close_command (button: EV_BUTTON) is
			-- Add a close command to the button if it doesn't
			-- has it already
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_MESSAGE_DIALOG_I]
		do
--			if button.get_click_commands /= Void then
				!! cmd.make (~execute)
				!! arg.make (Current)
				button.add_click_command(cmd, arg)
--			end
		end

	add_user_command (name: STRING; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add the given `cmd' and `arg' to the button called
			-- `name'.
		do
			if first_button /= Void and then first_button.text.is_equal (name) then
				first_button.add_click_command (cmd, arg)
			elseif second_button /= Void and then second_button.text.is_equal (name) then
				second_button.add_click_command (cmd, arg)
			elseif third_button /= Void and then third_button.text.is_equal (name) then
				third_button.add_click_command (cmd, arg)
			end
		end

feature {NONE} -- Implementation

	set_default (a_msg, a_title: STRING) is
			-- Set default settings
		do
			set_message (a_msg)
			set_title (a_title)
			show_ok_button
		end

	set_message (msg: STRING) is
			-- Set the message to be displayed
		do
			if message = Void then
				!!message.make_with_text (display_area, msg)
			else
				message.set_text(msg)
			end
		end

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
			-- Nedd to be redefine by each dialog.
		deferred
		end

	message: EV_LABEL
		-- Message of the dialog

	first_button: EV_BUTTON
		-- First button of the dialog

	second_button: EV_BUTTON
		-- Second button of the dialog

	third_button: EV_BUTTON
		-- Third button of the dialog

	help_button: EV_BUTTON
		-- Help button of the dialog

feature {EV_MESSAGE_DIALOG_IMP} -- Execute procedure

	execute (argument: EV_ARGUMENT1[EV_MESSAGE_DIALOG_I]; data: EV_EVENT_DATA) is
			-- Command to close the dialog
		do
			argument.first.interface.destroy
		end

end -- class EV_MESSAGE_DIALOG_IMP

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
