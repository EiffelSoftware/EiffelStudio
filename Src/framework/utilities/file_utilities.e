indexing
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

feature -- Query

	frozen is_path_applicable (a_path: STRING_GENERAL; a_include: ?RX_PCRE_MATCHER; a_exclude: ?RX_PCRE_MATCHER): BOOLEAN
			-- Determines if a path is applicable given inclusion/exclusion expressions.
			--
			-- `a_path': Path to determine inclusion.
			-- `a_include': An inclusive regular expression, or Void if an inclusion expression is not required.
			-- `a_exclude': An exclusion regular expression, or Void if an exclusion expression is not required.
			-- `Result': True if the path is an applicable inclusive path; False otherwise.
		require
			a_path_attached: a_path /= Void
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		local
			l_path: STRING
		do
			Result := a_include = Void and a_exclude = Void
			if not Result then
				l_path := a_path.as_string_8
				if a_exclude /= Void then
					Result := not a_exclude.matches (l_path)
				end
				if a_include /= Void then
					Result := a_include.matches (l_path)
				end
			end
		end

feature -- Basic operations

	frozen scan_for_folders (a_folder: STRING_GENERAL; a_levels: INTEGER_32; a_include: ?RX_PCRE_MATCHER; a_exclude: ?RX_PCRE_MATCHER): !DS_ARRAYED_LIST [!STRING]
			-- Scans a folder for matching folders.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			a_folder_attached: a_folder /= Void
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		do
			Result := scan_for_folders_internal (a_folder, a_levels, a_include, a_exclude, False)
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: !STRING; a_ia_include: ?RX_PCRE_MATCHER; a_ia_exclude: ?RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end)
		end

	frozen scan_for_files (a_folder: STRING_GENERAL; a_levels: INTEGER_32; a_include: ?RX_PCRE_MATCHER; a_exclude: ?RX_PCRE_MATCHER): !DS_ARRAYED_LIST [!STRING]
			-- Scans a folder for matching files.
			--
			-- `a_folder': Folder location to scan.
			-- `a_levels': Number of levels to recursively scan. 0 to scan the specified folder only, -1 to scan all folders.
			-- `a_include': Regular expression used to progressively include files/folders.
			-- `a_exclude': Regulat expression used to exclude files/folders.
		require
			a_folder_attached: a_folder /= Void
			not_a_folder_is_empty: not a_folder.is_empty
			a_folder_exists: file_system.directory_exists (a_folder.as_string_8)
			a_levels_is_valid: a_levels >= -1
			a_include_is_compiled: a_include /= Void implies a_include.is_compiled
			a_exclude_is_compiled: a_exclude /= Void implies a_exclude.is_compiled
		do
			Result := scan_for_files_internal (({!STRING_GENERAL}) #? a_folder, a_levels, a_include, a_exclude, False)
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: !STRING; a_ia_include: ?RX_PCRE_MATCHER; a_ia_exclude: ?RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end)
		end

feature {NONE} -- Basic operations

	frozen scan_for_folders_internal (a_folder: !STRING_GENERAL; a_levels: INTEGER_32; a_include: ?RX_PCRE_MATCHER; a_exclude: ?RX_PCRE_MATCHER; a_recursive: BOOLEAN): !DS_ARRAYED_LIST [!STRING]
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
			l_sub_results: !DS_ARRAYED_LIST [!STRING]
			l_path_name: DIRECTORY_NAME
		do
			if a_recursive then
				l_dn := a_folder.as_string_8
			else
				l_dn := absolute_path (a_folder.as_string_8, True)
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
						-- Note: checking applicablity of the path does not check the include expression. This is because
						--       directories can be excluded but not included. Files can be included.
					if {l_path: STRING} l_path_name.string and then is_path_applicable (l_path, Void, a_exclude) then
						Result.put_last (l_path)
					end
					i := i + 1
				end

				if a_levels /= 0 then
						-- Recurse directories
					create l_sub_results.make_default
					from Result.start until Result.after loop
						l_sub_results.append_last (scan_for_folders_internal (Result.item_for_iteration, (a_levels - 1).max (-1), a_include, a_exclude, True))
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
			result_contains_included_items: Result.for_all (agent (a_ia_item: !STRING; a_ia_include: ?RX_PCRE_MATCHER; a_ia_exclude: ?RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end)
		end

	frozen scan_for_files_internal (a_folder: !STRING_GENERAL; a_levels: INTEGER_32; a_include: RX_PCRE_MATCHER; a_exclude: RX_PCRE_MATCHER; a_recursive: BOOLEAN): !DS_ARRAYED_LIST [!STRING]
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
				l_dn := absolute_path (a_folder.as_string_8, True)
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
					if {l_file: STRING} l_path_name.string and then is_path_applicable (l_file, a_include, a_exclude) then
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
						if {l_path: STRING} l_path_name.string then
							Result.append_last (scan_for_files_internal (l_path, (a_levels - 1).max (-1), a_include, a_exclude, True))
						end
						i := i + 1
					end
				end
			else
				create Result.make (0)
			end
		ensure
			result_contains_included_items: Result.for_all (agent (a_ia_item: !STRING; a_ia_include: ?RX_PCRE_MATCHER; a_ia_exclude: ?RX_PCRE_MATCHER): BOOLEAN
				do
					Result := is_path_applicable (a_ia_item, a_ia_include, a_ia_exclude)
				end)
		end

feature -- Directory operations

	frozen create_directory (a_path: STRING_GENERAL)
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
				if not file_system.is_root_directory (l_path) and then {l_parent_path: STRING_GENERAL} file_system.dirname (l_path) then
						-- Create parent directory
					create_directory (l_parent_path)
				end
				create l_dir.make (l_path)
				l_dir.create_directory
			end
		ensure
			a_path_exists: file_system.directory_exists (a_path.as_string_8)
		end

	frozen create_directory_for_file (a_file_name: STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist, for a file path
			--
			-- `a_file_name': The suggested file name requiring a directory to exist.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			if {l_path: STRING_GENERAL} file_system.dirname (a_file_name.as_string_8) and then not l_path.is_empty then
				create_directory (l_path)
			end
		end

feature -- Formatting

	frozen absolute_path (a_path: STRING_GENERAL; a_compact: BOOLEAN): !STRING
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
			Result ?= file_system.absolute_pathname (a_path.as_string_8)
			if a_compact then
				l_path := compact_path (Result)
				if l_path /= Void then
					Result ?= l_path
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_exists: file_system.file_exists (Result) or file_system.directory_exists (Result)
			reuslt_is_absolute: file_system.is_absolute_pathname (Result)
		end

	frozen compact_path (a_path: STRING_GENERAL): ?STRING
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

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
