indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_IMP

inherit
	EV_FILE_DIALOG_I

	EV_SELECTION_DIALOG_IMP
		redefine
			add_dialog_close_command
		end

feature -- Access

	file: STRING is
			-- Path and name of the currently selected file
			-- (including path).
		local
			p: POINTER
		do
			create Result.make (0)
			p := gtk_file_selection_get_filename (widget)
			Result.from_c (p)
		end

	ok_widget: POINTER is
			-- Pointer to the gtk_button `OK' of the dialog.
		do
			Result := c_gtk_file_selection_get_ok_button (widget)
		end

	cancel_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		do
			Result := c_gtk_file_selection_get_cancel_button (widget)
		end

feature -- Status report

	file_name: STRING is
			-- Name of the currently selected file
			-- (without path).
		local
			p: POINTER
		do
			p := c_gtk_selection_get_selection_entry (widget)
			create Result.make (0)
			Result.from_c (p)
		end

	directory: STRING is
			-- Path of the current selected file
		local
			p: POINTER
		do
			p := c_gtk_file_selection_get_dir (widget)
			create Result.make (0)
			Result.from_c (p)
		end

	selected_filter: STRING is
			-- Currently selected filter
		do
			check
				not_implemented: False
			end
		end

	selected_filter_name: STRING is
			-- Name of the currently selected filter
		do
			check
				not_implemented: False
			end
		end

feature -- Status setting

	select_filter (filter: STRING) is
			-- Select `filter' in the list of filter.
		do
			check
				not_implemented: False
			end
		end

	select_filter_by_name (name: STRING) is
			-- Select the filter called `name'.
		do
			check
				not_implemented: False
			end
		end

feature -- Element change

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		do
			check
				not_implemented: False
			end
		end

	set_default_extension (extension: STRING) is
			-- Make `extension' the new default extension if no
			-- filter is selected.
			-- This extension will be automatically added to the
			-- file name if the user fails to type an extension.
		do
			check
				not_implemented: False
			end
		end

	set_filter (filter_names, filter_patterns: ARRAY [STRING]) is
			-- Set the file type combo box.
			-- `filter_names' is an array of string containing
			-- the filter names and `filter_patterns' is an
			-- array of string containing the filter patterns.
			-- Example:
			--	filter_names = <<"Text file", "All file">>
			--	filter_patterns = <<"*.txt", "*.*">>
		do
			check
				not_implemented: False
			end
		end

	set_file (name: STRING) is
			-- Make the file named `name' the new selected file.
		local
			a: ANY
		do
                        a := name.to_c
			gtk_file_selection_set_filename (widget, $a)
		end

feature {NONE} -- Basic operation

	add_dialog_close_command (p: POINTER) is
			-- Add a close command to the given pointer (gtk_button)
			-- on a `clicked' signal.
			-- redefined because for file dialogs, clicking on
			-- the `ok' button should only only close the dialog
			-- if there is a file selected.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EV_FILE_DIALOG_IMP]

			list_com: EV_GTK_COMMAND_LIST			
		do
			if (p = ok_widget) then
				create cmd.make (~ok_widget_execute)
			else
				create cmd.make (~execute)
			end

			create arg.make (Current)
			add_command (p, "clicked", cmd, arg, default_pointer)
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
			-- If there is no "OK" button, the event never occurs.
		local
			ok_close_command: EV_COMMAND
			list_com: EV_GTK_COMMAND_LIST
		do
--			-- We have to remove the close command and put it back
--			-- to have it executed after all commands.
--
--			-- Remove the close command.
--			(event_command_array @ ok_clicked_id).finish
--			ok_close_command := (event_command_array @ ok_clicked_id).command_list.item
--			remove_single_command (ok_widget, ok_clicked_id, ok_close_command)

			-- Add the command.
			add_command (ok_widget, "clicked", cmd, arg, default_pointer)

--			-- re-add a new close command.
--			add_dialog_close_command (ok_widget)
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
			-- remove commands
			remove_commands (ok_widget, ok_clicked_id)

			-- re-add a new close command.
			add_dialog_close_command (ok_widget)
		end

feature {EV_FILE_DIALOG_IMP} -- Execute procedure

	ok_widget_execute (argument: EV_ARGUMENT1[EV_STANDARD_DIALOG_I]; data: EV_EVENT_DATA) is
			-- Command to close the dialog when the user clicks
			-- on the `ok' button, only if there is a file selected.
		local
			dialog_imp: EV_STANDARD_DIALOG_IMP
		do
			if (not file_name.is_equal ("")) then
				dialog_imp ?= argument.first
				dialog_imp.hide
					-- Hide the gtk object
					-- The user must no forget to destroy
					-- the dialog when no more needed.
			end
		end

end -- class EV_FILE_DIALOG_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
