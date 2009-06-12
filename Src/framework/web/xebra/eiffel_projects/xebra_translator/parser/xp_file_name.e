note
	description: "[
		{XP_FILE_NAME}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_FILE_NAME

inherit
	FILE_NAME
		redefine
			set_file_name

		end

create
	make,
	make_from_string,
	make_temporary_name

create {XP_FILE_NAME}
	string_make

feature -- Access

	file_name: STRING assign set_file_name

	set_file_name (a_file_name: STRING)
			-- <Precursor>
			-- Additionally saves the filename so it can  be retrieved again
		do
			Precursor (a_file_name)
			file_name := a_file_name
		end
end
