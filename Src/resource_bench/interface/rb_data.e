indexing
	description: "Data for resource bench"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	RB_DATA

feature -- Access

	Title: STRING is "Resource Bench"
			-- Window's title.

	Help_file: STRING is "rb.hlp"
			-- Name of the help file.

	Grammar_name: STRING is "rb.gram"
			-- Name of the grammar file.

	Tmp_directory: STRING is "c:\temp"
			-- Name of the temporary directory.

	application_directory: STRING
			-- Path to the application directory.

	working_directory: STRING
			-- Path to the current directory.

feature -- Element change

	set_application_directory (a_path: STRING) is
			-- Set `application_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: a_path.count > 0
		do
			application_directory := clone (a_path)
		ensure
			application_directory_set: application_directory.is_equal (a_path)
		end

	set_working_directory (a_path: STRING) is
			-- Set `working_directory' to `a_path'.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: a_path.count > 0
		do
			working_directory := clone (a_path)
		ensure
			working_directory_set: working_directory.is_equal (a_path)
		end

end -- class RB_DATA
