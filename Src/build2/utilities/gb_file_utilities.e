indexing
	description:
		"[
			Objects that provide common useful features for file handling.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_UTILITIES

feature -- Basic operations

	rename_file_if_exists (directory_path: DIRECTORY; old_name, new_name: STRING) is
			-- Rename file named `old_name' in directory `directory_path' to
			-- `new_name' in the same directory. Do nothing if the old file does not exist
			-- or the file names are identical.
		local
			file: RAW_FILE
			new_file_name, old_file_name: FILE_NAME
		do
			if not old_name.is_equal (new_name) then
				create new_file_name.make_from_string (directory_path.name)
				new_file_name.extend (new_name)
				create old_file_name.make_from_string (directory_path.name)
				old_file_name.extend (old_name)
				create file.make (old_file_name)
				if file.exists then
					file.change_name (new_file_name.string)
				end
			end
		end
		
	move_file_between_directories (original, new: DIRECTORY; file_name: STRING) is
			-- Move file named `file_name' from `original' directory to `new_directory'.
			-- Do nothing if `original' is equivalent to `new'.
		require
			original_directory_exists: original.exists
			new_directory_exists: new.exists
			file_name_not_void: file_name /= Void
		local
			file: RAW_FILE
			new_file_name, old_file_name: FILE_NAME
		do
			if not original.name.is_equal (new.name) then
				create new_file_name.make_from_string (new.name)
				create old_file_name.make_from_string (original.name)
				new_file_name.extend (file_name)
				old_file_name.extend (file_name)
				create file.make (old_file_name)
				if file.exists then
					file.change_name (new_file_name.string)
				end
			end
		end
		
	directory_exists (name: STRING): BOOLEAN is
			-- Does a directory named `name' exist?
		local
			directory: DIRECTORY
		do
			create directory.make (name)
			Result := directory.exists
		end
		
	delete_file (directory: DIRECTORY; a_file_name: STRING) is
			-- Delete file named `a_file_name' from directory `directory'.
		local
			file: RAW_FILE
			file_name: FILE_NAME
		do
			create file_name.make_from_string (directory.name)
			file_name.extend (a_file_name)
			create file.make (file_name)
			if file.exists then
				file.delete
			end
		end
		
	restore_file (directory: DIRECTORY; a_file_name, contents: STRING) is
			-- Restore plain text file file named `a_file_name' in
			-- `directory' with contents `contents'.
		local
			file_name: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
			create file_name.make_from_string (directory.name)
			file_name.extend (a_file_name)
			create file.make (file_name)
			file.open_write
			file.start
			file.putstring (contents)
			file.close
		end

	delete_directory (directory: DIRECTORY) is
			-- Remove `directory'.
		require
			directory_exists: directory.exists
			directory_empty: directory.is_empty
		do	
			directory.delete
		end
		
	create_directory (directory: DIRECTORY) is
			-- Create `directory'.
		require
			directory_not_exists: not directory.exists
		do
			directory.create_dir
		ensure
			directory_exists: directory.exists
		end
		
	delete_directory_and_content (directory: DIRECTORY) is
			-- Removed `directory' and all content from disk.
		do
			if directory.exists then
				directory.delete_content
				directory.delete
			end
		end

end -- class GB_FILE_UTILITIES
