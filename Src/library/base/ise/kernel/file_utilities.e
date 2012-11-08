note
	description: "[
		File utilities, for retrieving files and folders and formatting paths.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

expanded class
	FILE_UTILITIES

feature -- Query

	frozen compact_path (a_path: READABLE_STRING_32): detachable STRING_32
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
			l_sep := operating_environment.directory_separator

				-- Separate path
			l_parts := a_path.split (l_sep)
			from l_parts.start until l_parts.after or l_error loop
				l_part := l_parts.item
				if l_part.same_string_general (".") then
						-- Current directory, simple remove
					l_parts.remove
				elseif l_part.same_string_general ("..") then
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

	frozen file_extension (a_file_name: READABLE_STRING_GENERAL): STRING
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
					l_extension := l_file_name.substring (l_separator_i + 1, l_count)
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

	frozen internal_indexed_path (a_base_path: READABLE_STRING_GENERAL; a_separator: detachable READABLE_STRING_GENERAL; a_index: NATURAL): STRING
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
			Result := a_base_path.as_string_8
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

feature -- File name operations

	make_directory_name_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- A directory name for directory `name' in directory `location'.
		do
			Result := make_file_name_in (name, location)
		end

	make_file_name_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- A file name for file `name' in directory `location'.
		do
			Result := (create {PATH}.make_from_string (location)).extended (name).string_representation
		end

feature -- Directory operations

 	directory_path_exists (p: PATH): BOOLEAN
			-- Does directory of path `p' exist?
		do
			Result := not p.is_empty and then (create {DIRECTORY}.make_with_path (p)).exists
		end

	directory_exists (n: READABLE_STRING_GENERAL): BOOLEAN
			-- Does directory of name `n' exist?
		do
			Result := not n.is_empty and then (create {DIRECTORY}.make (n)).exists
		end

	file_names (n: READABLE_STRING_32): detachable LIST [STRING_32]
			-- List of file names in directory with name `n'.
			-- Or void if directory is not readable (does not exist, cannot be accessed, etc.).
		local
			d: detachable DIRECTORY
			l: ARRAYED_LIST [STRING_32]
			is_retried: BOOLEAN
			f: RAW_FILE
		do
			if not is_retried then
				create d.make (n)
				if d.exists and then d.is_readable then
					d.open_read
					from
						create f.make_with_name ({STRING_32} ".")
						create l.make (0)
						d.readentry
					until
						not attached d.last_entry_32 as e
					loop
						create f.make_with_path ((create {PATH}.make_from_string (n)).extended (e))
						if f.exists and then f.is_readable and then f.is_plain then
							l.extend (e)
						end
						d.readentry
					end
					Result := l
					d.close
				end
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
			d: detachable DIRECTORY
			l: ARRAYED_LIST [STRING_32]
			is_retried: BOOLEAN
			f: DIRECTORY
		do
			if not is_retried then
				create d.make (n)
				if d.exists and then d.is_readable then
					d.open_read
					from
						create l.make (0)
						d.readentry
					until
						not attached d.last_entry_32 as e
					loop
						if
							(e.count = 1 and then e [1] = '.') or else
							(e.count = 2 and then e [1] = '.' and then e [2] = '.')
						then
								-- This is a reference to the current or to the parent directory.
						else
							create f.make_with_path ((create {PATH}.make_from_string (n)).extended (e))
							if f.exists and then f.is_readable then
								l.extend (e)
							end
						end
						d.readentry
					end
					Result := l
					d.close
				end
			elseif attached d and then not d.is_closed then
				d.close
			end
		rescue
			is_retried := True
			retry
		end

	create_directory (a_path: READABLE_STRING_GENERAL)
			-- Creates a directory and any parent directories if they do not exist.
			--
			-- `a_path': The directory to create.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		local
			is_retried: BOOLEAN
			d: DIRECTORY
		do
			if not is_retried then
				create d.make (a_path)
				if not d.exists then
					d.recursive_create_dir
				end
			end
		rescue
			is_retried := True
			retry
		end

feature -- File operations

	make_raw_file (n: READABLE_STRING_GENERAL): RAW_FILE
			-- New {RAW_FILE} for file name `n'.
		do
			create Result.make_with_name (n)
		end

	make_raw_file_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): RAW_FILE
			-- New {RAW_FILE} for file `name' in directory `location'.
		do
			Result := make_raw_file (make_file_name_in (name, location))
		end

	make_text_file (n: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- New {PLAIN_TEXT_FILE} for file name `n'.
		do
			create Result.make_with_name (n)
		end

	make_text_file_in (name: READABLE_STRING_GENERAL; location: READABLE_STRING_GENERAL): PLAIN_TEXT_FILE
			-- New {PLAIN_TEXT_FILE} for file `name' in directory `location'.
		do
			Result := make_text_file (make_file_name_in (name, location))
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

	copy_file_path (old_path, new_path: PATH)
			-- Copy file named `old_path' to `new_path'.
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
				create f.make_with_path (old_path)
				f.open_read
				create t.make_with_path (new_path)
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
		do
			create f.make_with_name (old_name)
			f.rename_file (new_name)
		end

	rename_file_path (old_path, new_path: PATH)
			-- Rename file named `old_path' to `new_path'.
		local
			f: RAW_FILE
		do
			create f.make_with_path (old_path)
			f.rename_file (new_path.string_representation)
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
			Result := f.name_32
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

	file_path_exists (p: PATH): BOOLEAN
			-- Does file of path `p' exist?
		local
			f: RAW_FILE
			is_retried: BOOLEAN
		do
			if not p.is_empty and then not is_retried then
				create f.make_with_path (p)
				Result := f.exists and then f.is_plain
			end
		rescue
			is_retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
