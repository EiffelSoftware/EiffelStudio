﻿note
	description: "[
		File utilities, for retrieving files and folders and formatting paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	FILE_UTILITIES

inherit

	ANY

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
			{FILE_UTILITIES} deep_twin, is_deep_equal, standard_is_equal
		end

feature -- Status report

	frozen is_path_applicable (a_path: attached READABLE_STRING_GENERAL; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER): BOOLEAN
			-- Determines if a path is applicable given inclusion/exclusion expressions.
			--
			-- `a_path': Path to determine inclusion.
			-- `a_include': An inclusive regular expression, or Void if an inclusion expression is not required.
			-- `a_exclude': An exclusion regular expression, or Void if an exclusion expression is not required.
			-- `Result': True if the path is an applicable inclusive path; False otherwise.
		require
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_path: STRING
		do
			Result := a_include = Void and a_exclude = Void
			if not Result then
				l_path := a_path.as_string_8
				check removed_when_using_attached_base: l_path /= Void end
				if a_exclude /= Void then
					Result := not a_exclude.matches (l_path)
				end
				if a_include /= Void then
					Result := a_include.matches (l_path)
				end
			end
		end

feature -- Query

	frozen indexed_path (a_base_path: attached READABLE_STRING_GENERAL; a_separator: detachable READABLE_STRING_GENERAL; a_index_first: BOOLEAN): attached STRING
			-- Retrieves an indexed path for a file or directory, given a base path.
			--
			-- For instance, using the base path "new_file", if "new_file" or "new_file1" exists then
			-- "new_file2" will be returned. File name extensions are also supported.
			--
			-- `a_base_path': The original path to index.
			-- `a_separator': An optional separator between the file name and index number
			-- `a_index_first': True to index the original path, even if not other file exists.
		require
			not_a_base_path_is_empty: not a_base_path.is_empty
			not_a_separator_is_empty: a_separator /= Void implies not a_separator.is_empty
		local
			l_base_path: STRING
			l_parent_path: READABLE_STRING_GENERAL
			l_base_path_extension: STRING
			l_indexed_path: STRING
			l_base_path_count: INTEGER
			l_paths: like scan_for_files
			l_path: STRING
			l_index: NATURAL
			l_index_string: STRING
			l_exp_path: STRING
			l_include_expr: RX_PCRE_MATCHER
			l_count, i: INTEGER
		do
			l_index := 1

			l_base_path := a_base_path.as_string_8.as_attached
			l_parent_path := file_directory_path (l_base_path)
			if l_parent_path /= Void and then not l_parent_path.is_empty and then directory_exists (l_parent_path) then
					-- A file/folder is potentially in the directory.

					-- Fetch the first indexed file, for comparison.
				l_indexed_path := internal_indexed_path (l_base_path, a_separator, 1)
				if
					file_exists (l_base_path) or else directory_exists (l_base_path) or else
					file_exists (l_indexed_path) or else directory_exists (l_indexed_path)
				then
						-- The initial base file or first indexed file already exists
					l_base_path_extension := file_extension (l_base_path)
					l_base_path_count := a_base_path.count

						-- Escape the path name for regular expression matching.
					l_exp_path := l_base_path.twin
					from
						i := 1
					until
						i > l_count
					loop
						if l_exp_path.item (i).is_alpha_numeric then
								-- Escape all punctuation and other characters.
							l_exp_path.insert_character ('\', i)
							i := i + 2
							l_count := l_count + 1
						else
							i := i + 1
						end
					end

					if not l_base_path_extension.is_empty then
						l_base_path_count := l_base_path_count - l_base_path_extension.count - 1
					end

					if l_base_path_extension.is_empty then
						if a_separator /= Void then
							l_exp_path.append_string_general (a_separator)
						end
						l_exp_path.append ("([0-9]+)")
					else
							-- Look for the last period to inject the indexing.
						i := l_exp_path.last_index_of ('.', l_exp_path.count)
						check should_have_extension: i > 0 end
						if i > 0 and then i > l_parent_path.count + 2 then
							i := i - 1
							check l_exp_path_escape: l_exp_path.item (i) = '\' end
							if a_separator /= Void then
								l_exp_path.insert_string (a_separator.as_string_8, i)
								i := i + a_separator.count
							end
							l_exp_path.insert_string ("([0-9]+)", i)
						else
							check False end
						end
					end
					l_exp_path.append_character ('$')

					create l_include_expr.make
					l_include_expr.compile (l_exp_path)

						-- An initial indexed file exists, scan for the next available index.
					l_paths := scan_for_files (l_parent_path, 0, l_include_expr, Void)
					l_paths.append (scan_for_folders (l_parent_path, 0, l_include_expr, Void))
					from l_paths.start until l_paths.after loop
						l_path := l_paths.item_for_iteration

							-- Remove the extension and period
						l_path.keep_head (l_path.count - (l_base_path_extension.count + 1))
							-- Extract the number
						l_index_string := l_path.substring (l_base_path_count + 1, l_path.count)
						if l_index_string.is_natural_32 then
							l_index := l_index.max (l_index_string.to_natural_32)
						end
						l_paths.forth
					end
					l_index := l_index + 1
				end
			end

			if l_index > 1 or else a_index_first then
				check l_index_positive: l_index > 0 end
				Result := internal_indexed_path (a_base_path, a_separator, l_index)
			else
				Result := a_base_path.as_string_8.as_attached
			end
		ensure
			result_count_is_bigger: Result.count >= a_base_path.count
		end

	frozen absolute_path (a_path: attached READABLE_STRING_GENERAL; a_compact: BOOLEAN): attached STRING_32
			-- Creates an absolute compacted path (provided the path could be compacted).
			--
			-- `a_path': The source path to convert to an absolute path.
			-- `a_compact': True to reduce current and parent directory path parts.
			-- `Result': The absolute, compacted path.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: make_raw_file (a_path).exists or make_directory (a_path).exists
		local
			u: UTF_CONVERTER
		do
				-- Convert path to UTF-8, compute absolute path name and convert it back to UTF-32.
			Result := u.utf_8_string_8_to_string_32 (file_system.absolute_pathname
				(u.string_32_to_utf_8_string_8 (a_path.to_string_32)))
				-- Perform compaction if required and possible.
			if a_compact and then attached compact_path (Result) as p then
				Result := p
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_exists: make_raw_file (Result).exists or make_directory (Result).exists
			result_is_absolute: file_system.is_absolute_pathname (Result)
		end

	frozen compact_path (a_path: attached READABLE_STRING_32): detachable STRING_32
			-- Compacts a file path, removing . and ..
			--
			-- `a_path': A path to compact.
			-- `Result': The compacted path or Void if the path could not be compacted.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_sep: CHARACTER_32
			l_parts: LIST [READABLE_STRING_32]
			l_part: STRING_32
			l_error: BOOLEAN
		do
			l_sep := (create {OPERATING_ENVIRONMENT}).directory_separator

				-- Separate path
			l_parts := a_path.split (l_sep)
			from l_parts.start until l_parts.after or l_error loop
				l_part := l_parts.item
				if l_part.is_equal (".") then
						-- Current directory, simple remove
					l_parts.remove
				elseif l_part.is_equal ("..") then
						-- Remove parent
					l_parts.remove
					if not l_parts.is_empty then
						l_parts.back
						if not l_parts.before and not l_parts.item.is_empty then
							l_parts.remove
						else
							l_error := True
						end
					end
				else
					l_parts.forth
				end
			end

			if not l_error then
					-- Rebuild the path
				create Result.make (a_path.count)
				from l_parts.start until l_parts.after loop
					Result.append (l_parts.item)
					if not l_parts.islast then
						Result.append_character (l_sep)
					end
					l_parts.forth
				end
			end
		end

	frozen file_extension (a_file_name: attached READABLE_STRING_GENERAL): attached STRING
			-- Extracts a real file extension from a file, taking into consideration Unix file names
			-- and directories beginning starting with a '.'.
			--
			-- `a_file_name': The name or path of the file to extract an extension from.
			-- `Result': A file extension or an empty string if no extension was found.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_file_name: STRING
			l_extension: detachable STRING
			l_separator_i: INTEGER
			l_non_dot_i: INTEGER
			l_count: INTEGER
		do
			l_file_name := a_file_name.as_string_8
			l_count := l_file_name.count

				-- Find loop up terminating directory separator
			l_separator_i := l_file_name.last_index_of (operating_environment.directory_separator, l_count)

				-- Find the first non-dot character, used to determine the next termination lookup point.
			l_non_dot_i := l_separator_i + 1
			from until
				l_non_dot_i > l_count or
				l_file_name.item (l_non_dot_i) /= '.'
			loop
				l_non_dot_i := l_non_dot_i + 1
			end
			if l_non_dot_i < l_count then
					-- There is at least one character after the dot
				l_separator_i := l_file_name.last_index_of ('.', l_count)
				if l_separator_i > l_non_dot_i and then l_separator_i < l_count then
						-- Not a . at the beginning of the file name, so we have an extension
					l_extension := l_file_name.substring (l_separator_i + 1, l_count).as_attached
				end
			end
			if l_extension = Void then
				create l_extension.make_empty
			end
			Result := l_extension
		ensure
			result_contains_no_extension_qualifier: not Result.has ('.')
		end

feature {NONE} -- Query

	frozen internal_indexed_path (a_base_path: attached READABLE_STRING_GENERAL; a_separator: detachable READABLE_STRING_GENERAL; a_index: NATURAL): attached STRING
			-- Suffixes an index to an existing file name.
			--
			-- `a_base_path': The original path to index.
			-- `a_separator': An optional separator between the file name and index number.
			-- `a_index': An index value to suffix to the base path.
			-- `Result': A resulting indexed path.
		require
			not_a_base_path_is_empty: not a_base_path.is_empty
			not_a_separator_is_empty: a_separator /= Void implies not a_separator.is_empty
			a_index_positive: a_index > 0
		local
			l_extension: like file_extension
			l_count: INTEGER
		do
			Result := a_base_path.as_string_8.as_attached
			if Result = a_base_path then
				Result := Result.twin
			end
			l_count := Result.count
			l_extension := file_extension (Result)
			if not l_extension.is_empty then
					-- Remove the extension and . for indexing.
				l_count := l_count - (l_extension.count - 1)
				Result.keep_head (l_count)
			end

			if a_separator /= Void then
				Result.append_string_general (a_separator)
			end
			Result.append_natural_32 (a_index)

			if not l_extension.is_empty then
				Result.append_character ('.')
				Result.append (l_extension)
			end
		ensure
			result_count_is_bigger: Result.count > a_base_path.count
		end

feature -- Basic operations

	frozen scan_for_folders (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER): attached ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: directory_exists (a_folder)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		do
			Result := internal_scan_for_folders (a_folder, a_levels, a_include, a_exclude, False)
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: attached STRING; a_ia_include: detachable RX_PCRE_MATCHER; a_ia_exclude: detachable RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end (?, a_include, a_exclude))
		end

	frozen scan_for_files (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER): attached ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: directory_exists (a_folder)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		do
			Result := internal_scan_for_files (a_folder, a_levels, a_include, a_exclude, False)
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: attached STRING; a_ia_include: detachable RX_PCRE_MATCHER; a_ia_exclude: detachable RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end (?, a_include, a_exclude))
		end

feature {NONE} -- Basic operations

	frozen internal_scan_for_folders (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER; a_recursive: BOOLEAN): attached ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: directory_exists (a_folder)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_dn: STRING
			l_dir: KL_DIRECTORY
			l_count, i: INTEGER
			l_sub_results: attached ARRAYED_LIST [attached STRING]
			l_path_name: DIRECTORY_NAME
		do
			if a_recursive then
				l_dn := a_folder.as_string_8
			else
				l_dn := absolute_path (a_folder, True)
			end

			create l_dir.make (l_dn)
			if l_dir.exists and then l_dir.is_readable and then attached l_dir.directory_names as l_directories then
					-- Scan an include directories
				create Result.make (l_directories.count)
				from
					i := l_directories.lower
					l_count := l_directories.upper
				until
					i > l_count
				loop
					create l_path_name.make_from_string (l_dn)
					l_path_name.extend (l_directories.item (i))
					if attached {STRING} l_path_name.string as l_path and then is_path_applicable (l_path, a_include, a_exclude) then
						Result.extend (l_path)
					end
					i := i + 1
				end

				if a_levels /= 0 then
						-- Recurse directories
					create l_sub_results.make (10)
					from Result.start until Result.after loop
						l_sub_results.append (internal_scan_for_folders (Result.item_for_iteration, (a_levels - 1).max (-1), a_include, a_exclude, True))
						Result.forth
					end

					if not l_sub_results.is_empty then
							-- Append results
						Result.append (l_sub_results)
					end
				end
			else
				create Result.make (0)
			end
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: attached STRING; a_ia_include: detachable RX_PCRE_MATCHER; a_ia_exclude: detachable RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end (?, a_include, a_exclude))
		end

	frozen internal_scan_for_files (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: RX_PCRE_MATCHER; a_exclude: RX_PCRE_MATCHER; a_recursive: BOOLEAN): attached ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: directory_exists (a_folder)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_dn: STRING
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			l_count, i: INTEGER
			l_path_name: DIRECTORY_NAME
		do
			if a_recursive then
				l_dn := a_folder.as_string_8
			else
				l_dn := absolute_path (a_folder, True)
			end

			create l_dir.make (l_dn)
			if l_dir.exists and then l_dir.is_readable then
					-- Scan files
				l_files := l_dir.filenames
				create Result.make (l_files.count)
				from
					i := l_files.lower
					l_count := l_files.upper
				until
					i > l_count
				loop
					create l_path_name.make_from_string (l_dn)
					l_path_name.extend (l_files.item (i))
					if attached {STRING} l_path_name.string as l_file and then is_path_applicable (l_file, a_include, a_exclude) then
						Result.extend (l_file)
					end
					i := i + 1
				end

				if a_levels /= 0 and then attached l_dir.directory_names as l_directories then
						-- Recurse directories
					from
						i := l_directories.lower
						l_count := l_directories.upper
					until
						i > l_count
					loop
						create l_path_name.make_from_string (l_dn)
						l_path_name.extend (l_directories.item (i))
						if attached {STRING} l_path_name.string as l_path and then is_path_applicable (l_path, Void, a_exclude) then
								-- Note: checking applicablity of the path does not check the include expression. This is because
								--       directories can be excluded but not included. Files can be included.
							Result.append (internal_scan_for_files (l_path, (a_levels - 1).max (-1), a_include, a_exclude, True))
						end
						i := i + 1
					end
				end
			else
				create Result.make (0)
			end
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: attached STRING; a_ia_include: detachable RX_PCRE_MATCHER; a_ia_exclude: detachable RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end (?, a_include, a_exclude))
		end

feature -- File name operations

	make_directory_name_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- A directory name for directory `name' in directory `location'.
		local
			d: DIRECTORY_NAME
			d32: DIRECTORY_NAME_32
		do
			if attached {READABLE_STRING_32} location as l then
				create d32.make_from_string (l)
				d32.extend (name.as_string_32)
				Result := d32.to_string_32
			else
				create d.make_from_string (location.as_string_8)
				d.extend (name.as_string_8)
				Result := d
			end
		end

	make_file_name_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- A file name for file `name' in directory `location'.
		local
			f: FILE_NAME
			f32: FILE_NAME_32
		do
			if attached {READABLE_STRING_32} location as l then
				create f32.make_from_string (l)
				f32.set_file_name (name.as_string_32)
				Result := f32
			else
				create f.make_from_string (location.as_string_8)
				f.set_file_name (name.as_string_8)
				Result := f
			end
		end

	adapt_unix_to_windows (n: READABLE_STRING_32): STRING_32
			-- Adapt file name `n' in unix file system to windows file system.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32
				(windows_file_system.pathname_from_file_system
					(u.string_32_to_utf_8_string_8 (n), unix_file_system))
		end

	adapt_windows_to_current (n: READABLE_STRING_32): STRING_32
			-- Adapt file name `n' in windows file system to the current file system.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32
				(file_system.pathname_from_file_system
					(u.string_32_to_utf_8_string_8 (n), windows_file_system))
		end

feature -- Directory operations

	frozen create_directory (a_path: attached READABLE_STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist.
			--
			-- `a_path': The directory to create.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_path: STRING_8
			d: DIRECTORY
			u: UTF_CONVERTER
			is_retried: BOOLEAN
		do
			if not is_retried then
				d := make_directory (a_path)
				if not d.exists then
					if attached {READABLE_STRING_32} a_path as p then
						l_path := u.string_32_to_utf_8_string_8 (p)
						if not file_system.is_root_directory (l_path) and then attached file_system.dirname (l_path) as l_parent_path then
								-- Create parent directory
							create_directory (u.utf_8_string_8_to_string_32 (l_parent_path))
						end
					else
						l_path := a_path.as_string_8
						if not file_system.is_root_directory (l_path) and then attached file_system.dirname (l_path) as l_parent_path then
								-- Create parent directory
							create_directory (l_parent_path)
						end
					end
					d.create_dir
				end
			end
		rescue
			is_retried := True
			retry
		end

	frozen create_directory_for_file (a_file_name: attached READABLE_STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist, for a file path
			--
			-- `a_file_name': The suggested file name requiring a directory to exist.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			if attached file_directory_path (a_file_name) as l_path and then not l_path.is_empty then
				create_directory (l_path)
			end
		end

	make_directory (n: READABLE_STRING_GENERAL): DIRECTORY
			-- New {DIRECTORY} for directory name `n'.
		do
			if attached {READABLE_STRING_32} n as s then
				create {DIRECTORY_32} Result.make (s)
			else
				create Result.make (n.as_string_8)
			end
		end

	directory_exists (n: READABLE_STRING_GENERAL): BOOLEAN
			-- Does directory of name `n' exist?
		do
			Result := not n.is_empty and then make_directory (n).exists
		end

	file_names (n: READABLE_STRING_32): detachable LIST [STRING_32]
			-- List of file names in directory with name `n'.
			-- Or void if directory is not readable (does not exist, cannot be accessed, etc.).
		local
			d: DIRECTORY_32
			l: ARRAYED_LIST [STRING_32]
			is_retried: BOOLEAN
			f: RAW_FILE_32
			fn: FILE_NAME_32
		do
			if not is_retried then
				create d.make (n)
				d.open_read
				if not d.is_closed then
					from
						create f.make (".")
						create fn.make_from_string (".")
						create l.make (0)
						d.readentry
					until
						not attached d.lastentry as e
					loop
						fn.reset (n)
						fn.set_file_name (e)
						f.reset (fn)
						if  f.exists and then f.is_readable and then f.is_plain then
							l.extend (e)
						end
						d.readentry
					end
					Result := l
				end
				d.close
			elseif attached d and then not d.is_closed then
				d.close
			end
		rescue
			is_retried := True
			retry
		end

	directory_names (n: READABLE_STRING_32): detachable LIST [STRING_32]
			-- List of directory names (excluding current and parent directory) in directory with name `n'.
			-- Or void if directory is not readable (does not exist, cannot be accessed, etc.).
		local
			d: DIRECTORY_32
			l: ARRAYED_LIST [STRING_32]
			is_retried: BOOLEAN
			f: DIRECTORY_32
			fn: DIRECTORY_NAME_32
		do
			if not is_retried then
				create d.make (n)
				d.open_read
				if not d.is_closed then
					from
						create fn.make_from_string (".")
						create l.make (0)
						d.readentry
					until
						not attached d.lastentry as e
					loop
						if
							(e.count = 1 and then e [1] = '.') or else
							(e.count = 2 and then e [1] ='.' and then e [2] = '.')
						then
								-- This is a reference to the current or to the parent directory.
						else
							fn.reset (n)
							fn.extend (e)
							create f.make (fn)
							if f.exists and then f.is_readable then
								l.extend (e)
							end
						end
						d.readentry
					end
					Result := l
				end
				d.close
			elseif attached d and then not d.is_closed then
				d.close
			end
		rescue
			is_retried := True
			retry
		end

feature -- File operations

	make_raw_file (n: READABLE_STRING_GENERAL): RAW_FILE
			-- New {RAW_FILE} for file name `n'.
		do
			if attached {READABLE_STRING_32} n as s then
				create {RAW_FILE_32} Result.make (s)
			else
				create Result.make (n.as_string_8)
			end
		end

	make_raw_file_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): RAW_FILE
			-- New {RAW_FILE} for file `name' in directory `location'.
		do
			Result := make_raw_file (make_file_name_in (name, location))
		end

	make_text_file (n: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- New {PLAIN_TEXT_FILE} for file name `n'.
		do
			if attached {READABLE_STRING_32} n as s then
				create {PLAIN_TEXT_FILE_32} Result.make (s)
			else
				create Result.make (n.as_string_8)
			end
		end

	make_text_file_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- New {PLAIN_TEXT_FILE} for file `name' in directory `location'.
		do
			Result := make_text_file (make_file_name_in (name, location))
		end

	make_binary_input_file (n: READABLE_STRING_GENERAL): KL_BINARY_INPUT_FILE
			-- New {KL_BINARY_INPUT_FILE} for file name `n'.
		do
			if attached {READABLE_STRING_32} n as s then
				create {KL_BINARY_INPUT_FILE_32} Result.make (s)
			else
				create Result.make (n.as_string_8)
			end
		end

	make_text_output_file (n: READABLE_STRING_GENERAL): KL_TEXT_OUTPUT_FILE
			-- New {KL_TEXT_OUTPUT_FILE} for file `n'.
		local
			p: READABLE_STRING_GENERAL
		do
			if attached {READABLE_STRING_32} n as s then
				create {KL_TEXT_OUTPUT_FILE_32} Result.make (s)
			else
				create Result.make (p.as_string_8)
			end
		end

	make_text_output_file_in (n, d: READABLE_STRING_GENERAL): KL_TEXT_OUTPUT_FILE
			-- New {KL_TEXT_OUTPUT_FILE} for file name `n' in directory `d'.
		do
			Result := make_text_output_file (make_file_name_in (n, d))
		end

	copy_file (old_name, new_name: READABLE_STRING_GENERAL)
			-- Copy file named `old_name' to `new_name'.
		local
			f: detachable RAW_FILE
			t: detachable RAW_FILE
			is_rescued: BOOLEAN
		do
			if is_rescued then
				if attached f and then f.is_open_read then
					f.close
				end
				if attached t and then t.is_open_write then
					t.close
				end
			else
				f := make_raw_file (old_name)
				f.open_read
				t := make_raw_file (new_name)
				t.open_write
				f.copy_to (t)
				f.close
				t.close
			end
		rescue
			if not is_rescued then
				is_rescued := True
				retry
			end
		end

	rename_file (old_name, new_name: READABLE_STRING_GENERAL)
			-- Rename file named `old_name' to `new_name'.
		local
			f: RAW_FILE
			f32: RAW_FILE_32
		do
			if attached {READABLE_STRING_32} old_name or else attached {READABLE_STRING_32} new_name then
				create f32.make (old_name.as_string_32)
				f32.change_name (new_name.as_string_32)
			else
				create f.make (old_name.as_string_8)
				f.change_name (new_name.as_string_8)
			end
		end

	open_read_raw_file (n: READABLE_STRING_GENERAL): RAW_FILE
			-- Open {RAW_FILE} of name `n' for reading.
		do
			Result := make_raw_file (n)
			Result.open_read
		ensure
			file_open: Result.is_open_read
		end

	open_write_raw_file (n: READABLE_STRING_GENERAL): RAW_FILE
			-- Open {RAW_FILE} of name `n' for writing.
		do
			Result := make_raw_file (n)
			Result.open_write
		ensure
			file_open: Result.is_open_write
		end

	open_write_raw_file_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): RAW_FILE
			-- Open {RAW_FILE} of name `name' in `location'.
		do
			Result := make_raw_file_in (name, location)
			Result.open_write
		ensure
			file_open: Result.is_open_write
		end

	open_write_text_file (n: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- Open {PLAIN_TEXT_FILE} of name `n'.
		do
			Result := make_text_file (n)
			Result.open_write
		ensure
			file_open: Result.is_open_write
		end

	file_name (f: FILE): READABLE_STRING_GENERAL
			-- Name associated with `f'.
		do
			if attached {FILE_32} f as f32 then
				Result := f32.name
			else
				Result := f.name
			end
		end

	file_directory_path (n: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Directory path of file name `n'.
		local
			u: UTF_CONVERTER
		do
			if attached {READABLE_STRING_32} n as n32 then
					-- Convert to UTF-8, calculate path and convert back.
				Result := u.utf_8_string_8_to_string_32 (file_system.dirname (u.string_32_to_utf_8_string_8 (n32)))
			else
				Result := file_system.dirname (n.as_string_8)
			end
		end

	file_exists (n: READABLE_STRING_GENERAL): BOOLEAN
			-- Does file of name `n' exist?
		local
			f: RAW_FILE
			is_retried: BOOLEAN
		do
			if not n.is_empty and then not is_retried then
				f := make_raw_file (n)
				Result := f.exists and then f.is_plain
			end
		rescue
			is_retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
