indexing 
	description: "EiffelVision file selection dialog."
	note: "Equivalent of the WEL_FILE_DIALOG class."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_SELECTION_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_IMP

feature -- Access

	file: STRING is
			-- Path and name of the currently selected file
			-- (including path).
		do
			if selected then
				Result := wel_file_name
			else
				Result := Void
			end
		end

feature -- Status report

	file_name: STRING is
			-- Name of the currently selected file
			-- (without path).
		do
			if selected then
				Result := file_title
			else
				Result := Void
			end
		end

	directory: STRING is
			-- Path of the current selected file
		do
			if selected then
				Result := file.substring (1, file_name_offset - 1)
			else
				Result := Void
			end
		end

	selected_filter: STRING is
			-- Currently selected filter
		do
			if selected then
				Result := filpatterns.item (filter_index)
			else
				Result := Void
			end
		end

	selected_filter_name: STRING is
			-- Name of the currently selected filter
		do
			if selected then
				Result := filnames.item (filter_index)
			else
				Result := Void
			end
		end

feature -- Status setting

	select_filter (filter: STRING) is
			-- Select `filter' in the list of filter.
		local
			index: INTEGER
		do
			index := find_index (filpatterns, filter)
			set_filter_index (index)
		end

	select_filter_by_name (name: STRING) is
			-- Select the filter called `name'.
		local
			index: INTEGER
		do
			index := find_index (filnames, name)
			set_filter_index (index)
		end

feature -- Element change

	set_file (absolute_name: STRING) is
			-- Make the file given by `absolute_name' the
			-- new selected file.
		do
			set_file_name (absolute_name)
		end

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed..
		do
			set_initial_directory (path)
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
			wel_set_filter (filter_names, filter_patterns)
			filpatterns := filter_patterns
			filnames := filter_names
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

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
			remove_command (Cmd_ok)
		end

	remove_cancel_commands is
			-- Empty the list of commands to be executed when
			-- "Cancel" button is pressed.
		do
			remove_command (Cmd_cancel)
		end

feature {NONE} -- Implementation

	filpatterns: ARRAY [STRING]
		-- Patterns of the filters of the dialog

	filnames: ARRAY [STRING]
		-- Names of the filters of the dialog

	find_index (list: ARRAY [STRING]; item: STRING): INTEGER is
			-- Return the index of `item' in `list'
		local
			i: INTEGER
			found: BOOLEAN
		do
			from
				i := list.lower
				Result := 1
			until
				found or (i = list.upper + 1)
			loop
				 if item.is_equal(list.item (i)) then
					found := True
				else
					Result := Result + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation for events handling

	dispatch_events is
			-- Execute the command associated to the action of the user.
			-- As in `process_message' of WEL_WINDOW, we can't use
			-- `inspect' here.
		do
			if selected then
				execute_command (Cmd_ok, Void)
			else
				execute_command (Cmd_cancel, Void)
			end
		end

feature {NONE} -- Deferred features

	flags: INTEGER is
		deferred
		end

	wel_file_name: STRING is
		deferred
		end

	file_title: STRING is
		deferred
		end

	title: STRING is
		deferred
		end

	file_name_offset: INTEGER is
		deferred
		end

	file_extension_offset: INTEGER is
		deferred
		end

	filter_index: INTEGER is
		deferred
		end

	Max_file_name_length: INTEGER is
		deferred
		end

	set_flags (a_flags: INTEGER) is
		deferred
		end

	add_flag (a_flags: INTEGER) is
		deferred
		end

	remove_flag (a_flags: INTEGER) is
		deferred
		end

	set_file_name (a_file_name: STRING) is
		deferred
		end

	set_title (a_title: STRING) is
		deferred
		end

	set_default_title is
		deferred
		end

	wel_set_filter (filter_names, filter_patterns: ARRAY [STRING]) is
		deferred
		end

	set_filter_index (a_filter_index: INTEGER) is
		deferred
		end

	set_initial_directory (a_directory: STRING) is
		deferred
		end

	set_initial_directory_as_current is
		deferred
		end

	set_default_extension (extension: STRING) is
		deferred
		end

	has_flag (a_flags: INTEGER): BOOLEAN is
		deferred
		end

	str_filter: WEL_STRING is
		deferred
		end

	str_title: WEL_STRING is
		deferred
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
