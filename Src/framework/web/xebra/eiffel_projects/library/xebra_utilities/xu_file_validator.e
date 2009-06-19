note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_FILE_VALIDATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

feature -- Status report

	is_readable_file (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid filename and the file can be read
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_readable
		end

	is_executable_file (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid filename and the file can be executed
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_executable
		end


	is_dir (a_path: STRING): BOOLEAN
			-- Checks if the path is a valid directory
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_path)
			Result := l_file.exists and l_file.is_directory
		end



feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

