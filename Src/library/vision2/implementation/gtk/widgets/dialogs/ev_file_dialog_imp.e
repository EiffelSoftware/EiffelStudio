indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_SELECTION_DIALOG_IMP

inherit
	EV_FILE_SELECTION_DIALOG_I
	EV_STANDARD_DIALOG_IMP

feature -- Access

	file: STRING is
			-- Path and name of the currently selected file
			-- (including path).
		do
		end

feature -- Status report

	file_name: STRING is
			-- Name of the currently selected file
			-- (without path).
		do
		end

	directory: STRING is
			-- Path of the current selected file
		do
		end

	selected_filter: STRING is
			-- Currently selected filter
		do
		end

feature -- Status setting

	select_filter (filter: STRING) is
			-- Select `filter' in the list of filter.
		do
		end

feature -- Element change

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		do
		end

	set_default_extension (extension: STRING) is
			-- Make `extension' the new default extension if no
			-- filter is selected.
			-- This extension will be automatically added to the
			-- file name if the user fails to type an extension.
		do
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
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
			-- If there is no "OK" button, the event never occurs.
		do
		end

	add_cancel_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Cancel" button is pressed.
			-- If there is no "Cancel" button, the event never occurs.
		do
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		do
		end

end -- class EV_FILE_SELECTION_DIALOG_IMP

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
