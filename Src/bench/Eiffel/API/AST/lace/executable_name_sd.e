indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class
	EXECUTABLE_NAME_SD

inherit
	LANGUAGE_NAME_SD
		redefine
			is_executable
		end

feature -- Properties

	is_executable: BOOLEAN is True
			-- Is the language name "Executable" ?

end -- class EXECUTABLE_NAME_SD
