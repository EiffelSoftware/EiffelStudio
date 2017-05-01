note
	description: "Browse for folder dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_FOLDER_DIALOG

inherit
	WEL_STANDARD_DIALOG
		rename
			make as standard_make
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_BIF_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	NATIVE_STRING_HANDLER
		undefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	make
			-- Initialize structure
		do
			standard_make
			create str_folder_name.make_empty (max_path)
			create str_title.make_empty (max_title_length)
			cwel_browse_info_set_pszdisplayname (item, str_folder_name.item)
			cwel_browse_info_set_lpsztitle (item, str_title.item)
			cwel_browse_info_set_lpfn (item, cwel_browse_callback_proc)
			set_default_title
		end

feature -- Access

	folder_name: STRING_32
			-- Selected folder name
			-- Empty if no folder was selected.
		obsolete
			"Use `folder_path' instead [2017-05-31]."
		do
			Result := str_folder_name.string
		end

	folder_path: PATH
			-- Selected folder path
			-- Empty if no folder was selected.
		do
			if selected then
				create Result.make_from_pointer (str_folder_name.item)
			else
				create Result.make_empty
			end
		end

	display_name: STRING_32
			-- Display name of selected folder
			-- Empty if no folder was selected.
		obsolete
			"Use `folder_path' instead [2017-05-31]."
		do
			Result := folder_name
		end

	title: STRING_32
			-- Dialog title
		do
			Result := str_title.string
		end

	starting_folder: STRING_32
			-- Initial folder name
		obsolete
			"Use `starting_path' instead [2017-05-31]."
		do
			Result := starting_path.name
		end

	starting_path: PATH
			-- Initial folder name
		do
			if attached str_starting_folder as l_folder then
				create Result.make_from_pointer (l_folder.item)
			else
				create Result.make_empty
			end
		ensure
			consistent: attached str_starting_folder as l_folder implies Result.name.same_string (l_folder.string)
		end

	flags: INTEGER
			-- Dialog box creation flags
			-- Can be a combination of values defined in
			-- class WEL_BIF_CONSTANTS.
		do
			Result := cwel_browse_info_get_ulflags (item)
		end

	has_flag (a_flags: INTEGER): BOOLEAN
			-- Is `a_flags' set in `flags'?
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			Result := flag_set (flags, a_flags)
		end

feature -- Element Change

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set `title' with `a_title'
		require
			a_title_not_void: a_title /= Void
		do
			str_title.set_string (a_title)
		ensure
			title_set: title.same_string_general (a_title)
		end

	set_default_title
			-- Set `title' with default title ("Please choose a folder")
		do
			set_title ("Please choose a folder.")
		end

	set_starting_folder (a_folder_name: READABLE_STRING_GENERAL)
			-- Set the initial folder name
		obsolete
			"Use `set_starting_path' instead [2017-05-31]."
		require
			valid_folder_name: a_folder_name /= Void and then not a_folder_name.is_empty
		do
			create str_starting_folder.make (a_folder_name)
			cwel_browse_info_set_lparam (item, str_starting_folder.item)
		ensure
			starting_folder_set: starting_folder.same_string_general (a_folder_name)
		end

	set_starting_path (a_path: PATH)
			-- Set the initial folder name
		require
			valid_folder_name: a_path /= Void and then not a_path.is_empty
		do
			create str_starting_folder.make_from_path (a_path)
			cwel_browse_info_set_lparam (item, str_starting_folder.item)
		ensure
			starting_path_set: starting_path ~ a_path
		end

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			cwel_browse_info_set_ulflags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	add_flag (a_flags: INTEGER)
			-- Add `a_flags' to `flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			set_flags (set_flag (flags, a_flags))
		ensure
			has_flag: has_flag (a_flags)
		end

	remove_flag (a_flags: INTEGER)
			-- Remove `a_flags' from `flags'.
			-- See class WEL_BIF_CONSTANTS for `a_flags' values.
		do
			set_flags (clear_flag (flags, a_flags))
		ensure
			has_not_flag: not has_flag (a_flags)
		end

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW)
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		local
			browse_folder_result: INTEGER
		do
			set_parent (a_parent)
			browse_folder_result := cwel_sh_browse_for_folder (item, str_folder_name.item)

			if browse_folder_result = 0 and not str_folder_name.string.is_empty then
				selected := True
			else
				selected := False
				str_folder_name.set_count (0)
			end
		end

	cwel_sh_browse_for_folder (p: POINTER; str: POINTER): INTEGER
			-- Open dialog in a different thread with COM properly initialized
			-- to single threaded appartment. `Result' is 1 if user cancelled dialog,
			-- 0 otherwise.
		external
			"C signature (LPBROWSEINFO, LPTSTR): LPITEMIDLIST use %"choose_folder.h%""
		end

feature {NONE} -- Implementation

	str_folder_name: WEL_STRING
			-- Chosen folder name

	str_starting_folder: detachable WEL_STRING note option: stable attribute end
			-- Starting folder name

	str_title: WEL_STRING
			-- Dialog title

	set_parent (a_parent: WEL_COMPOSITE_WINDOW)
			-- Set parent window with `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			cwel_browse_info_set_hwndowner (item, a_parent.item)
		end

	hwnd_parent: POINTER
		require
			exists: exists
		do
			Result := cwel_browse_info_get_hwndowner (item)
		end

	max_title_length: INTEGER = 256
			-- Max title string length

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_browse_info
		end

feature {NONE} -- External

	c_size_of_browse_info: INTEGER
		external
			"C [macro %"choose_folder.h%"]"
		alias
			"sizeof (BROWSEINFO)"
		end

	max_path: INTEGER
			external
				"C [macro %"wel.h%"]"
			alias
				"MAX_PATH"
			end

	cwel_browse_callback_proc: POINTER
		external
			"C [macro %"choose_folder.h%"]: EIF_POINTER"
		end

	cwel_browse_info_get_ulflags (ptr: POINTER): INTEGER
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_get_hwndowner (ptr: POINTER): POINTER
		external
			"C inline use <windows.h>"
		alias
			"return ((LPBROWSEINFO) $ptr)->hwndOwner;"
		end

	cwel_browse_info_set_hwndowner (ptr, parent: POINTER)
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_pszdisplayname (ptr, name: POINTER)
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_ulflags (ptr: POINTER; a_flags: INTEGER)
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_lpsztitle (ptr, a_title: POINTER)
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_lpfn (ptr, value: POINTER)
			external
				"C [macro %"choose_folder.h%"]"
			end

	cwel_browse_info_set_lparam (ptr, value: POINTER)
			external
				"C [macro %"choose_folder.h%"]"
			end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_CHOOSE_DIRECTORY_DIALOG

