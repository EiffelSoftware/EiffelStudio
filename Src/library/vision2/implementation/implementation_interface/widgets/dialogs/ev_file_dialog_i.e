indexing 
	description: "EiffelVision file selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_SELECTION_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	title: STRING is
			-- Title of the current dialog
		require
			exists: not destroyed
		deferred
		end

	file: STRING is
			-- Path and name of the currently selected file
			-- (including path).
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	file_name: STRING is
			-- Name of the currently selected file
			-- (without path).
		require
			exists: not destroyed
		deferred
		end

	directory: STRING is
			-- Path of the current selected file
		require
			exists: not destroyed
		deferred
		end

	selected_filter: STRING is
			-- Currently selected filter
		require
			exists: not destroyed
		deferred
		end

	selected_filter_name: STRING is
			-- Name of the currently selected filter
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	select_filter (filter: STRING) is
			-- Select `filter' in the list of filter.
		require
--			valid_filter: filters.hae (filter)
		deferred
		ensure
--			filter_index_set: filter_index = index
		end

	select_filter_by_name (name: STRING) is
			-- Select the filter called `name'.
		require
--			valid_filter: filters.hae (filter)
		deferred
		ensure
--			filter_index_set: filter_index = index
		end

feature -- Element change

	set_title (a_title: STRING) is
			-- Make `a_title' the new title of the current dialog.
		require
			exists: not destroyed
			valid_title: a_title /= Void
		deferred
		end

	set_file (name: STRING) is
			-- Make the file named `name' the new selected file.
		require
			exists: not destroyed
			valid_name: name /= Void
		deferred
		end

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		require
			exists: not destroyed
			valid_path: path /= Void
		deferred
		end

	set_default_extension (extension: STRING) is
			-- Make `extension' the new default extension if no
			-- filter is selected.
			-- This extension will be automatically added to the
			-- file name if the user fails to type an extension.
		require
			exists: not destroyed
			valid_extension: extension /= Void
		deferred
		end

	set_filter (filter_names, filter_patterns: ARRAY [STRING]) is
			-- Set the file type combo box.
			-- `filter_names' is an array of string containing
			-- the filter names and `filter_patterns' is an
			-- array of string containing the filter patterns.
			-- Example:
			--	filter_names = <<"Text file", "All file">>
			--	filter_patterns = <<"*.txt", "*.*">>
		require
			filter_names_not_void: filter_names /= Void
			filter_patterns_not_void: filter_patterns /= Void
			same_count: filter_names.count = filter_patterns.count
			no_void_name: not filter_names.has (Void)
			no_void_pattern: not filter_patterns.has (Void)
		deferred
		end

end -- class EV_FILE_SELECTION_DIALOG_I

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
