indexing
	description: "Common routines used throughout the Wizard"

class
	WIZARD_ROUTINES

feature -- Basic Operations

	c_to_obj (a_file_name: STRING): STRING is
			-- Change file name extension from ".c" to ".obj".
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: a_file_name.substring (a_file_name.count - 1, a_file_name.count).is_equal (".c")
		do
			Result := clone (a_file_name)
			Result.replace_substring (".o", a_file_name.count - 1, a_file_name.count)
			Result.append ("bj")
		ensure
			changed: Result.substring (Result.count - 3, Result.count).is_equal (".obj")
		end

end -- class WIZARD_ROUTINES