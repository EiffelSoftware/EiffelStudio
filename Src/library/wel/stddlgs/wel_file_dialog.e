indexing
	description: "Ancestor of WEL_OPEN_FILE_DIALOG and %
		%WEL_SAVE_FILE_DIALOG."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_FILE_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_dialog_make
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end


feature {NONE} -- Initialization

	make is
			-- Make and setup the structure
		do
			standard_dialog_make
			cwel_open_file_name_set_lstructsize (item, structure_size)
			create str_file_name.make_empty (Max_file_name_length)
			str_file_name.set_string (create {STRING}.make (0))
			create str_file_title.make_empty (Max_file_title_length)
			str_file_title.set_string (create {STRING}.make (0))
			create str_title.make_empty (Max_title_length)
			str_title.set_string (create {STRING}.make (0))
			cwel_open_file_name_set_lpstrfile (item, str_file_name.item)
			cwel_open_file_name_set_nmaxfile (item, Max_file_name_length - 10)
			cwel_open_file_name_set_lpstrfiletitle (item, str_file_title.item)
			cwel_open_file_name_set_nmaxfiletitle (item, Max_file_title_length - 10)
			set_default_title
			add_flag (feature {WEL_OFN_CONSTANTS}.Ofn_hidereadonly)
		end

feature -- Access

	flags: INTEGER is
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in 
			-- class WEL_OFN_CONSTANTS.
		do
			Result := cwel_open_file_name_get_flags (item)
		end

	file_name: STRING is
			-- File name selected (including path).
		require
			selected: selected
		do
			Result := str_file_name.string
		ensure
			result_not_void: Result /= Void
		end

	multiple_file_names: LINKED_LIST [STRING] is
			-- return the full path name of all selected files.
		require
			multiple_files_flag_set: has_flag (feature {WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
		local
			directory_name: STRING
		do
			if has_flag (feature {WEL_OFN_CONSTANTS}.Ofn_explorer) then
					-- Explorer-like dialog returns a buffer where
					-- filename are NULL separated.
				Result := str_file_name.null_separated_strings
			else
					-- non Explorer-like dialog returns a buffer where
					-- filename are space separated. Only "short"
					-- filename are returned (i.e 8.3 dos format)
				Result := str_file_name.space_separated_strings
			end

				-- If the user has selected only one file, Windows returns
				-- this only file, otherwise...(see below)

			if Result.count > 1 then
					-- The first string of `Result' is the selected
					-- directory, the following strings are the name
					-- of the selected files
				from
					Result.start
					directory_name := Result.item
						-- add the final backslash if not present
					if (directory_name @ directory_name.count) /= '\' then
						directory_name.append_character('\')
					end
					if not Result.after then
						Result.forth
					end
				until
					Result.after
				loop
						-- prepend the directory to the filename
					Result.item.prepend(directory_name)
					Result.forth
				end
					-- Remove the directory from the string list.
				Result.start
				Result.remove
			end
		ensure
			result_not_void: Result /= Void
		end

	file_title: STRING is
			-- Title of the selected file (without path).
		require
			selected: selected
		do
			Result := str_file_title.string
		ensure
			result_not_void: Result /= Void
		end

	title: STRING is
			-- Title of the current dialog
		do
			Result := str_title.string
		ensure
			result_not_void: Result /= Void
		end

	file_name_offset: INTEGER is
			-- Specifies the offset from the beginning of the path
			-- to the file name in the string `file_name'.
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfileoffset (item) + 1
		ensure
			result_greater_than_or_equal_to_one: Result >= 1
		end

	file_extension_offset: INTEGER is
			-- Specifies the offset from the beginning of the path
			-- to the file name extension in the string `file_name'.
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfileextension (item) + 1
		ensure
			result_greater_than_or_equal_to_one: Result >= 1
		end

	filter_index: INTEGER is
			-- Index of the selected filter
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfilterindex (item)
		ensure
			positive_result: Result >= 0
		end

	Max_file_name_length: INTEGER is 1024
			-- Maximum file name length

feature -- Element change

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			cwel_open_file_name_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER) is
			-- Add `a_flags' to `flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER) is
			-- Remove `a_flags' from `flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

	set_file_name (a_file_name: STRING) is
			-- Set `file_name' with `a_file' and initialize
			-- the file name edit control.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_count_ok: a_file_name.count <= Max_file_name_length
		do
			str_file_name.set_string (a_file_name)
			cwel_open_file_name_set_lpstrfile (item,
				str_file_name.item)
		ensure
			file_name_set: file_name.is_equal (a_file_name)
		end

	set_title (a_title: STRING) is
			-- Set `title' with `a_title' and use this string to
			-- display the title.
		require
			a_title_not_void: a_title /= Void
		do
			str_title.set_string (a_title)
			cwel_open_file_name_set_lpstrtitle (item,
				str_title.item)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_default_title is
			-- Set the title bar with the default value ("Save As"
			-- or "Open")
		do
			str_title.set_string (create {STRING}.make (0))
			cwel_open_file_name_set_lpstrtitle (item,
				default_pointer)
		ensure
			default_title_set: title.is_equal (create {STRING}.make (0))
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
		local
			i: INTEGER
			s: STRING
		do
			-- Make a string containing pairs of string.
			-- The first string in each pair describe the
			-- filter name and the second specifies the filter
			-- pattern. Each pair must be separated by a null
			-- character. The string must be terminated by two
			-- null characters.
			create s.make (0)
			from
				i := filter_names.lower
			until
				i > filter_names.upper
			loop
				s.append (filter_names.item (i))
				s.extend ('%U')
				s.append (filter_patterns.item (i))
				s.extend ('%U')
				i := i + 1
			end
			s.extend ('%U')
			s.extend ('%U')
			create str_filter.make (s)
			cwel_open_file_name_set_lpstrfilter (item,
				str_filter.item)
		end

	set_filter_index (a_filter_index: INTEGER) is
			-- Set `filter_index' with `a_filter_index'.
		require
			positive_filter_index: a_filter_index >= 0
		do
			cwel_open_file_name_set_nfilterindex (item,
				a_filter_index)
		ensure
			filter_index_set: filter_index = a_filter_index
		end

	set_initial_directory (directory: STRING) is
			-- Set the initial directory with `directory'.
		require
			directory_not_void: directory /= Void
		do
			create str_intial_directory.make (directory)
			cwel_open_file_name_set_lpstrinitialdir (item,
				str_intial_directory.item)
		end

	set_initial_directory_as_current is
			-- Set the initial directory as the current one.
		do
			cwel_open_file_name_set_lpstrinitialdir (item,
				default_pointer)
		end

	set_default_extension (extension: STRING) is
			-- Set the default extension with `extension'.
			-- This extension will be automatically added to the
			-- file name if the user fails to type an extension.
		require
			extension_not_void: extension/= Void
		do
			create str_default_extension.make (extension)
			cwel_open_file_name_set_lpstrdefext (item,
				str_default_extension.item)
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN is
			-- Is `a_flags' set in `flags'?
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			Result := flag_set (flags, a_flags)
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Set the parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_open_file_name_set_hwndowner (item, a_parent.item)
		end

	str_file_name: WEL_STRING
			-- C string to save the file name

	str_file_title: WEL_STRING
			-- C string to save the file title

	str_filter: WEL_STRING
			-- C string to save the filters

	str_title: WEL_STRING
			-- C string to save the title

	str_intial_directory: WEL_STRING
			-- C string to save the initial directory

	str_default_extension: WEL_STRING
			-- C string to save the default extension

	Max_file_title_length: INTEGER is 256
			-- Maximum file title length

	Max_title_length: INTEGER is 256
			-- Maximum title length

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_open_file_name
		end

feature {NONE} -- Externals

	c_size_of_open_file_name: INTEGER is
		external
			"C [macro <ofn.h>]"
		alias
			"sizeof (OPENFILENAME)"
		end

	cwel_open_file_name_set_lstructsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_hwndowner (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfilter (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nfilterindex (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfile (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nmaxfile (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfiletitle (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nmaxfiletitle (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrinitialdir (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrtitle (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nfileextension (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrdefext (ptr, value: POINTER) is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_hwndowner (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_lpstrfilter (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nfilterindex (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrfile (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nmaxfile (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrfiletitle (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nmaxfiletitle (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrinitialdir (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_lpstrtitle (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_nfileoffset (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_nfileextension (ptr: POINTER): INTEGER is
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrdefext (ptr: POINTER): POINTER is
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

invariant

	str_file_name_not_void: str_file_name /= Void
	str_file_name_exists: str_file_name.exists
	str_file_title_not_void: str_file_title /= Void
	str_file_title_exists: str_file_title.exists
	str_title_not_void: str_title /= Void
	str_title_exists: str_title.exists

end -- class WEL_FILE_DIALOG


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

