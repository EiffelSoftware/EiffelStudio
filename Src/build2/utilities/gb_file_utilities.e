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

end -- class GB_FILE_UTILITIES
