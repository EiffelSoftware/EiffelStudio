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

	rename_file_if_exists (directory_path: FILE_NAME; old_name, new_name: STRING) is
			-- Rename file named `old_name' in directory `directory_path' to
			-- `new_name' in the same directory. Do nothing if the old file does not exist.
		local
			file: RAW_FILE
			new_file_name, old_file_name: FILE_NAME
		do
			create new_file_name.make_from_string (directory_path)
			new_file_name.extend (new_name)
			create old_file_name.make_from_string (directory_path)
			old_file_name.extend (old_name)
			create file.make (old_file_name)
			if file.exists then
				file.change_name (new_file_name.string)
			end
		end
		
	move_file_between_directories (original, new: FILE_NAME; file_name: STRING) is
			-- Move file named `file_name' from `original' directory to `new_directory'.
		local
			file: RAW_FILE
			new_file_name, old_file_name: FILE_NAME
		do
			create new_file_name.make_from_string (new)
			create old_file_name.make_from_string (original)
			new_file_name.extend (file_name)
			old_file_name.extend (file_name)
			create file.make (old_file_name)
			if file.exists then
				file.change_name (new_file_name.string)
			end
		end
		
	delete_file (directory: FILE_NAME; a_file_name: STRING) is
			-- Delete file named `a_file_name' from directory `directory'.
		local
			file: RAW_FILE
			file_name: FILE_NAME
		do
			create file_name.make_from_string (directory)
			file_name.extend (a_file_name)
			create file.make (file_name)
			if file.exists then
				file.delete
			end
		end
		
	restore_file (directory: FILE_NAME; a_file_name, contents: STRING) is
			--
		local
			file_name: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
			create file_name.make_from_string (directory)
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
