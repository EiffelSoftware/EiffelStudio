note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_FILE_TOO_BIG

inherit
	ERROR_ERROR_INFO
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_file_name: READABLE_STRING_8)
		do
			create file_name.make_from_string (a_file_name)
			make_error ([a_file_name]);
		end

feature -- Access

	file_name: IMMUTABLE_STRING_8
			-- File name on which the error occurred

feature {NONE} -- Access

	dollar_description: STRING
			-- <Precursor>
		do
			Result := "File is too big to process {1}"
		end
end
