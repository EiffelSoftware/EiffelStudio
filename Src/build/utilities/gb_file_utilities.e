note
	description:
		"[
			Objects that provide common useful features for file handling.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_UTILITIES

inherit
	OPERATING_ENVIRONMENT

feature -- Basic operations

	rename_file_if_exists (directory_path: DIRECTORY; old_name, new_name: STRING)
			-- Rename file named `old_name' in directory `directory_path' to
			-- `new_name' in the same directory. Do nothing if the old file does not exist
			-- or the file names are identical.
		local
			file: RAW_FILE
			new_file_name, old_file_name: PATH
		do
			if not old_name.same_string (new_name) then
				new_file_name := directory_path.path.extended (new_name)
				old_file_name := directory_path.path.extended (old_name)
				create file.make_with_path (old_file_name)
				if file.exists then
					file.rename_path (new_file_name)
				end
			end
		end

	move_file_between_directories (original, new: DIRECTORY; file_name: STRING)
			-- Move file named `file_name' from `original' directory to `new_directory'.
			-- Do nothing if `original' is equivalent to `new'.
		require
			original_directory_exists: original.exists
			new_directory_exists: new.exists
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			new_file_name, old_file_name: PATH
		do
			if not original.name.same_string (new.name) then
				create new_file_name.make_from_string (new.name)
				create old_file_name.make_from_string (original.name)

				new_file_name := new.path.extended (file_name)
				old_file_name := original.path.extended (file_name)
				create file.make_with_path (old_file_name)
				if file.exists then
					file.rename_path (new_file_name)
				end
			end
		end

	directory_exists (name: STRING): BOOLEAN
			-- Does a directory named `name' exist?
		local
			directory: DIRECTORY
		do
			create directory.make (name)
			Result := directory.exists
		end

	delete_file (directory: DIRECTORY; a_file_name: STRING)
			-- Delete file named `a_file_name' from directory `directory'.
		local
			file: RAW_FILE
			file_name: PATH
		do
			file_name := directory.path.extended (a_file_name)
			create file.make_with_path (file_name)
			if file.exists then
				file.delete
			end
		end

	restore_file (directory: DIRECTORY; a_file_name, contents: STRING)
			-- Restore plain text file file named `a_file_name' in
			-- `directory' with contents `contents'.
		local
			file_name: PATH
			file: PLAIN_TEXT_FILE
		do
			file_name := directory.path.extended (a_file_name)
			create file.make_with_path (file_name)
			file.open_write
			file.start
			file.putstring (contents)
			file.close
		end

	delete_directory (directory: DIRECTORY)
			-- Remove `directory'.
		require
			directory_exists: directory.exists
			directory_empty: directory.is_empty
		do
			directory.delete
		end

	create_directory (directory: DIRECTORY)
			-- Create `directory'.
		require
			directory_not_exists: not directory.exists
		do
			directory.create_dir
		ensure
			directory_exists: directory.exists
		end

	delete_directory_and_content (directory: DIRECTORY)
			-- Removed `directory' and all content from disk.
		do
			if directory.exists then
				directory.delete_content
				directory.delete
			end
		end

	directory_with_separator (a_directory: STRING): STRING
			-- `Result' is directory `a_directory' with directory separator
			-- appended if necessary.
		require
			a_directory_not_void: a_directory /= Void and then not a_directory.is_empty
		do
			if a_directory.item (a_directory.count).is_equal (Directory_separator) then
				Result := a_directory
			else
				Result := a_directory + Directory_separator.out
			end
		ensure
			Result_consistent: Result.count = a_directory.count or Result.count = a_directory.count + 1
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class GB_FILE_UTILITIES
