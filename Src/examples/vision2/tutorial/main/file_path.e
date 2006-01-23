indexing
	description:
		" A class that gives all the paths needed in the%
		% tutorial."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_PATHS

feature -- Access

	class_name: STRING
			-- Current name of the class

	example_name: STRING
			-- Current name of the example file
	
feature -- Basic operation

	documentation_file: STRING is
			-- Return the full name of the documentation file.
		do

			Result := clone (library_path)
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("documentation")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (class_name)
			Result.append (".txt")

		end

	class_file: STRING  is
			-- Return the full name of the new class file.
		do
			Result := clone (library_path)
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("short_forms")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (class_name)
			Result.append (".rtf")

		end

	example_file: STRING is
			-- sets example path string
		do
			Result := clone (example_path)
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("demo_windows")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (example_name)
			Result.append (".e")
		end

feature {NONE} -- Implementation

	library_path : STRING is
			-- directory of all vision2 library short-form interfaces
		local
			env: EXECUTION_ENVIRONMENT
		once
			create env
			Result := env.get ("ISE_EIFFEL")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("library")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("vision2")
		end


	example_path: STRING is
			-- path of example class text.
		local
			env: EXECUTION_ENVIRONMENT
		once
			create env
			Result := env.get ("ISE_EIFFEL")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("examples")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("vision2")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("tutorial")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class FILE_PATHS

