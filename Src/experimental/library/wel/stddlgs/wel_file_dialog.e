note
	description: "Ancestor of WEL_OPEN_FILE_DIALOG and %
		%WEL_SAVE_FILE_DIALOG."
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

	NATIVE_STRING_HANDLER
		undefine
			copy, is_equal
		end

feature {NONE} -- Initialization

	make
			-- Make and setup the structure
		do
			standard_dialog_make
			cwel_open_file_name_set_lstructsize (item, structure_size)

			create str_file_name.make_empty (Max_file_name_length)
			cwel_open_file_name_set_lpstrfile (item, str_file_name.item)
			cwel_open_file_name_set_nmaxfile (item, str_file_name.character_capacity)

			create str_file_title.make_empty (Max_file_title_length)
			cwel_open_file_name_set_lpstrfiletitle (item, str_file_title.item)

			create str_title.make_empty (Max_title_length)
			cwel_open_file_name_set_nmaxfiletitle (item, str_title.character_capacity)

			set_default_title
			add_flag ({WEL_OFN_CONSTANTS}.Ofn_hidereadonly)
		end

feature -- Access

	flags: INTEGER
			-- Dialog box creation flags.
			-- Can be a combination of the values defined in
			-- class WEL_OFN_CONSTANTS.
		do
			Result := cwel_open_file_name_get_flags (item)
		end

	file_name: STRING_32
			-- File name selected (including path).
		obsolete
			"Use `file_path' instead."
		do
			Result := str_file_name.string
		ensure
			result_not_void: Result /= Void
		end

	file_path: PATH
			-- Full file path of selected file.
		do
			create Result.make_from_pointer (str_file_name.item)
		ensure
			result_not_void: Result /= Void
		end

	multiple_file_names: LIST [STRING_32]
			-- return the full path name of all selected files.
		obsolete
			"Use `multiple_file_paths' instead."
		require
			multiple_files_flag_set: has_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
		local
			directory_name: STRING_32
		do
			if has_flag ({WEL_OFN_CONSTANTS}.Ofn_explorer) then
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

	multiple_file_paths: ARRAYED_LIST [PATH]
			-- return the full path name of all selected files.
		require
			multiple_files_flag_set: has_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
			has_explorer_flag: has_flag ({WEL_OFN_CONSTANTS}.Ofn_explorer)
		local
			directory_name: PATH
		do
				-- Explorer-like dialog returns a buffer where
				-- filename are NULL separated.
			Result := str_file_name.null_separated_paths

				-- If the user has selected only one file, Windows returns
				-- this only file, otherwise...(see below)
			if Result.count > 1 then
					-- The first string of `Result' is the selected
					-- directory, the following strings are the name
					-- of the selected files
				from
					Result.start
					directory_name := Result.item
					if not Result.after then
						Result.forth
					end
				until
					Result.after
				loop
						-- prepend the directory to the filename
					Result.replace (directory_name.extended_path (Result.item))
					Result.forth
				end
					-- Remove the directory from the string list.
				Result.start
				Result.remove
			end
		ensure
			result_not_void: Result /= Void
		end

	file_title: STRING_32
			-- Title of the selected file (without path).
		require
			selected: selected
		do
			Result := str_file_title.string
		ensure
			result_not_void: Result /= Void
		end

	title: STRING_32
			-- Title of the current dialog
		do
			Result := str_title.string
		ensure
			result_not_void: Result /= Void
		end

	file_name_offset: INTEGER
			-- Specifies the offset from the beginning of the path
			-- to the file name in the string `file_name'.
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfileoffset (item) + 1
		ensure
			result_greater_than_or_equal_to_one: Result >= 1
		end

	file_extension_offset: INTEGER
			-- Specifies the offset from the beginning of the path
			-- to the file name extension in the string `file_name'.
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfileextension (item) + 1
		ensure
			result_greater_than_or_equal_to_one: Result >= 1
		end

	filter_index: INTEGER
			-- Index of the selected filter
		require
			selected: selected
		do
			Result := cwel_open_file_name_get_nfilterindex (item)
		ensure
			positive_result: Result >= 0
		end

	Max_file_name_length: INTEGER = 1024
			-- Maximum file name length

feature -- Element change

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			cwel_open_file_name_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER)
			-- Add `a_flags' to `flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER)
			-- Remove `a_flags' from `flags'.
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

	set_file_name (a_file_name: READABLE_STRING_GENERAL)
			-- Set `file_name' with `a_file' and initialize
			-- the file name edit control.
		obsolete
			"Use `set_file_path' instead."
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_count_ok: a_file_name.count <= Max_file_name_length
		do
			str_file_name.set_string (a_file_name)
			cwel_open_file_name_set_lpstrfile (item,
				str_file_name.item)
		ensure
			file_name_set: file_name.same_string_general (a_file_name)
		end

	set_file_path (a_file_path: PATH)
			-- Set `file_path' with `a_file_path' and initialize
			-- the file name edit control.
		require
			a_file_path_not_void: a_file_path /= Void
		do
				-- We do not recreated `str_file_name' as we want to preserve
				-- the original minimal size of `Max_file_name_length'. However,
				-- if `a_file_path' is greater, we need to updated the underlying
				-- structure with the new reallocated pointer and its new size.
			str_file_name.set_string (a_file_path.name)
			cwel_open_file_name_set_lpstrfile (item, str_file_name.item)
			cwel_open_file_name_set_nmaxfile (item, str_file_name.character_capacity)
		ensure
			file_name_set: file_path ~ a_file_path
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set `title' with `a_title' and use this string to
			-- display the title.
		require
			a_title_not_void: a_title /= Void
		do
			str_title.set_string (a_title)
			cwel_open_file_name_set_lpstrtitle (item,
				str_title.item)
		ensure
			title_set: title.same_string_general (a_title)
		end

	set_default_title
			-- Set the title bar with the default value ("Save As"
			-- or "Open")
		do
			str_title.set_count (0)
			cwel_open_file_name_set_lpstrtitle (item,
				default_pointer)
		ensure
			default_title_set: title.is_empty
		end

	set_filter (filter_names, filter_patterns: ARRAY [READABLE_STRING_GENERAL])
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
		local
			i: INTEGER
			s: STRING_32
			l_filter: like str_filter
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
				s.append_string_general (filter_names.item (i))
				s.extend ('%U')
				s.append_string_general (filter_patterns.item (i))
				s.extend ('%U')
				i := i + 1
			end
			s.extend ('%U')
			s.extend ('%U')
			create l_filter.make (s)
				-- For GC reference
			str_filter := l_filter
			cwel_open_file_name_set_lpstrfilter (item, l_filter.item)
		end

	set_filter_index (a_filter_index: INTEGER)
			-- Set `filter_index' with `a_filter_index'.
		require
			positive_filter_index: a_filter_index >= 0
		do
			cwel_open_file_name_set_nfilterindex (item,
				a_filter_index)
		ensure
			filter_index_set: filter_index = a_filter_index
		end

	set_initial_directory (directory: READABLE_STRING_GENERAL)
			-- Set the initial directory with `directory'.
		obsolete
			"Use `set_initialial_path' instead."
		require
			directory_not_void: directory /= Void
		do
			set_initial_path (create {PATH}.make_from_string (directory))
		end

	set_initial_path (directory: PATH)
			-- Set the initial directory with `directory'.
		require
			directory_not_void: directory /= Void
		local
			l_str: like str_initial_path
		do
			create l_str.make_from_path (directory)
				-- For GC reference
			str_initial_path := l_str
			cwel_open_file_name_set_lpstrinitialdir (item, l_str.item)
		end

	set_initial_directory_as_current
			-- Set the initial directory as the current one.
		obsolete
			"Use `set_initial_path_as_current' instead."
		do
			cwel_open_file_name_set_lpstrinitialdir (item, default_pointer)
		end

	set_initial_path_as_current
			-- Set the initial directory as the current one.
		do
			cwel_open_file_name_set_lpstrinitialdir (item, default_pointer)
		end

	set_default_extension (extension: READABLE_STRING_GENERAL)
			-- Set the default extension with `extension'.
			-- This extension will be automatically added to the
			-- file name if the user fails to type an extension.
		require
			extension_not_void: extension/= Void
		local
			l_extension: like str_default_extension
		do
			create l_extension.make (extension)
				-- For GC reference
			str_default_extension := l_extension
			cwel_open_file_name_set_lpstrdefext (item, l_extension.item)
		end

feature -- Status report

	has_flag (a_flags: INTEGER): BOOLEAN
			-- Is `a_flags' set in `flags'?
			-- See class WEL_OFN_CONSTANTS for `a_flags' values.
		do
			Result := flag_set (flags, a_flags)
		end

feature {NONE} -- Implementation

	set_parent (a_parent: WEL_COMPOSITE_WINDOW)
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

	str_filter: detachable WEL_STRING
			-- C string to save the filters

	str_title: WEL_STRING
			-- C string to save the title

	str_initial_path: detachable WEL_STRING
			-- C string to save the initial directory

	str_default_extension: detachable WEL_STRING
			-- C string to save the default extension

	Max_file_title_length: INTEGER = 256
			-- Maximum file title length

	Max_title_length: INTEGER = 256
			-- Maximum title length

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_open_file_name
		end

feature {NONE} -- Externals

	c_size_of_open_file_name: INTEGER
		external
			"C [macro <ofn.h>]"
		alias
			"sizeof (OPENFILENAME)"
		end

	cwel_open_file_name_set_lstructsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_hwndowner (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfilter (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nfilterindex (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfile (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nmaxfile (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrfiletitle (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nmaxfiletitle (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrinitialdir (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrtitle (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_nfileextension (ptr: POINTER; value: INTEGER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_set_lpstrdefext (ptr, value: POINTER)
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_hwndowner (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_lpstrfilter (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nfilterindex (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrfile (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nmaxfile (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrfiletitle (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_nmaxfiletitle (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrinitialdir (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_lpstrtitle (ptr: POINTER): POINTER
		external
			"C [macro <ofn.h>] (OPENFILENAME *): EIF_POINTER"
		end

	cwel_open_file_name_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_nfileoffset (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_nfileextension (ptr: POINTER): INTEGER
		external
			"C [macro <ofn.h>]"
		end

	cwel_open_file_name_get_lpstrdefext (ptr: POINTER): POINTER
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

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_FILE_DIALOG

