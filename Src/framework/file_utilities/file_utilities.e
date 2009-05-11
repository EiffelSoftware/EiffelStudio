note
	description: "[
		File utilities, for retrieving files and folders and formatting paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	FILE_UTILITIES

inherit
	ANY

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
			{ANY} file_system
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
			l_fs: like file_system
			l_base_path: STRING
			l_parent_path: STRING
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

			l_fs := file_system
			l_base_path := a_base_path.as_string_8.as_attached
			l_parent_path := l_fs.dirname (l_base_path)
			if l_parent_path /= Void and then not l_parent_path.is_empty and then l_fs.directory_exists (l_parent_path) then
					-- A file/folder is potentially in the directory.

					-- Fetch the first indexed file, for comparison.
				l_indexed_path := internal_indexed_path (l_base_path, a_separator, 1)
				if
					l_fs.file_exists (l_base_path) or else l_fs.directory_exists (l_base_path) or else
					l_fs.file_exists (l_indexed_path) or else l_fs.directory_exists (l_indexed_path)
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
					l_paths.append_last (scan_for_folders (l_parent_path, 0, l_include_expr, Void))
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

	frozen absolute_path (a_path: attached READABLE_STRING_GENERAL; a_compact: BOOLEAN): attached STRING
			-- Creates an absolute compacted path (provided the path could be compacted).
			--
			-- `a_path': The source path to convert to an absolute path.
			-- `a_compact': True to reduce current and parent directory path parts.
			-- `Result': The absolute, compacted path.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: file_system.file_exists (a_path.as_string_8) or file_system.directory_exists (a_path.as_string_8)
		local
			l_path: STRING
		do
			Result := file_system.absolute_pathname (a_path.as_string_8).as_attached
			if a_compact then
				l_path := compact_path (Result)
				if l_path /= Void then
					Result := l_path
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_exists: file_system.file_exists (Result) or file_system.directory_exists (Result)
			reuslt_is_absolute: file_system.is_absolute_pathname (Result)
		end

	frozen compact_path (a_path: attached READABLE_STRING_GENERAL): detachable STRING
			-- Compacts a file path, removing . and ..
			--
			-- `a_path': A path to compact.
			-- `Result': The compacted path or Void if the path could not be compacted.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_sep: CHARACTER
			l_parts: LIST [STRING]
			l_part: STRING
			l_error: BOOLEAN
		do
			l_sep := (create {OPERATING_ENVIRONMENT}).directory_separator

				-- Separate path
			l_parts := a_path.as_string_8.split (l_sep)
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

	frozen scan_for_folders (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER): attached DS_ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
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

	frozen scan_for_files (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER): attached DS_ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
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

	frozen internal_scan_for_folders (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: detachable RX_PCRE_MATCHER; a_exclude: detachable RX_PCRE_MATCHER; a_recursive: BOOLEAN): attached DS_ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_dn: STRING
			l_dir: KL_DIRECTORY
			l_directories: ARRAY [STRING]
			l_count, i: INTEGER
			l_sub_results: attached DS_ARRAYED_LIST [attached STRING]
			l_path_name: DIRECTORY_NAME
		do
			if a_recursive then
				l_dn := a_folder.as_string_8
			else
				l_dn := absolute_path (a_folder, True)
			end

			create l_dir.make (l_dn)
			if l_dir.exists and then l_dir.is_readable then
					-- Scan an include directories
				l_directories := l_dir.directory_names
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
						Result.put_last (l_path)
					end
					i := i + 1
				end

				if a_levels /= 0 then
						-- Recurse directories
					create l_sub_results.make_default
					from Result.start until Result.after loop
						l_sub_results.append_last (internal_scan_for_folders (Result.item_for_iteration, (a_levels - 1).max (-1), a_include, a_exclude, True))
						Result.forth
					end

					if not l_sub_results.is_empty then
							-- Append results
						Result.append_last (l_sub_results)
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

	frozen internal_scan_for_files (a_folder: attached READABLE_STRING_GENERAL; a_levels: INTEGER_32; a_include: RX_PCRE_MATCHER; a_exclude: RX_PCRE_MATCHER; a_recursive: BOOLEAN): attached DS_ARRAYED_LIST [attached STRING]
			-- Scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_dn: STRING
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			l_directories: ARRAY [STRING]
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
						Result.put_last (l_file)
					end
					i := i + 1
				end

				if a_levels /= 0 then
						-- Recurse directories
					l_directories := l_dir.directory_names
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
							Result.append_last (internal_scan_for_files (l_path, (a_levels - 1).max (-1), a_include, a_exclude, True))
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

feature -- Directory operations

	frozen create_directory (a_path: attached READABLE_STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist.
			--
			-- `a_path': The directory to create.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			l_path: STRING
			l_dir: KL_DIRECTORY
		do
			l_path := a_path.as_string_8
			if not file_system.directory_exists (l_path) then
				if not file_system.is_root_directory (l_path) and then attached {STRING_GENERAL} file_system.dirname (l_path) as l_parent_path then
						-- Create parent directory
					create_directory (l_parent_path)
				end
				create l_dir.make (l_path)
				l_dir.create_directory
			end
		ensure
			a_path_exists: file_system.directory_exists (a_path.as_string_8)
		end

	frozen create_directory_for_file (a_file_name: attached READABLE_STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist, for a file path
			--
			-- `a_file_name': The suggested file name requiring a directory to exist.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			if attached {STRING_GENERAL} file_system.dirname (a_file_name.as_string_8) as l_path and then not l_path.is_empty then
				create_directory (l_path)
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
