indexing
	description: "Common routines used throughout the Wizard"

class
	WIZARD_ROUTINES

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

feature -- Access

	Temporary_input_file_name: STRING is "Input_File"
			-- Input file

feature -- Basic Operations

	c_to_obj (a_file_name: STRING): STRING is
			-- Change file name extension from ".c" or ".cpp" to ".obj".
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: is_c_file (a_file_name)
		local
			dot_index: INTEGER
		do
			Result := clone (a_file_name)
			dot_index := Result.index_of ('.', 1)
			Result.head (dot_index)
			Result.append ("obj")
		ensure
			changed: Result.substring (Result.count - 3, Result.count).is_equal (".obj")
		end

	is_c_file (a_file_name: STRING): BOOLEAN is
			-- Is `a_file_name' a valid c/c++ file name?
		do
			Result := a_file_name.substring (a_file_name.count - 1, a_file_name.count).is_equal (C_file_extension) or
						a_file_name.substring (a_file_name.count - 3, a_file_name.count).is_equal (Cpp_file_extension)
		end

	is_object_file (a_file: STRING): BOOLEAN is
			-- Is `a_file' an object (.obj) file?
		do
			Result := a_file.substring (a_file.count - 3, a_file.count).is_equal (Object_file_extension)
		end

	is_valid_folder_name (a_folder_name: STRING): BOOLEAN is
			-- Is `a_folder_name' a valid folder name?
		local
			a_directory: DIRECTORY
		do
			create a_directory.make (a_folder_name)
			Result := a_directory.exists
		end

end -- class WIZARD_ROUTINES