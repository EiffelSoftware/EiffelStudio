indexing

	description: "Syntax error for invalid external declaration."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_SYNTAX_ERROR

inherit

	SYNTAX_ERROR
		rename
			syntax_message as external_error_message
		redefine
			external_error_message
		end

creation {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS}

	init

feature -- Property

	external_error_message: STRING
			-- Specific syntax message

feature {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS} -- Setting

	set_external_error_message (message: STRING) is
		do
			external_error_message := clone (message)
		end

	set_file_name (new_filename: FILE_NAME) is
			-- Assign `new_filename' to `file_name'.
		do
			file_name := new_filename
		end

	set_start_position (i: INTEGER) is
			-- Assign `i' to `start_position'.
		do
			start_position := i
		end

	set_end_position (i: INTEGER) is
			-- Assign `i' to `end_position'.
		do
			end_position := i
		end

end -- class EXTERNAL_SYNTAX_ERROR
