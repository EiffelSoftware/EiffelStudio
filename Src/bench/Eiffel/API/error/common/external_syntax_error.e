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

create {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS}

	init

feature -- Property

	external_error_message: STRING
			-- Specific syntax message

feature {EXTERNAL_LANG_AS, EXTERNAL_EXTENSION_AS} -- Setting

	set_external_error_message (message: STRING) is
			-- Assign `external_error_message' with `message'.
		require
			message_not_void: message /= Void
		do
			external_error_message := message.twin
		end

	set_file_name (new_filename: FILE_NAME) is
			-- Assign `new_filename' to `file_name'.
		do
			file_name := new_filename
		end

	set_line (i: INTEGER) is
			-- Assign `i' to `line'.
		do
			line := i
		ensure
			line_set: line = i
		end

	set_column (i: INTEGER) is
			-- Assign `i' to `column'.
		do
			column := i
		ensure
			column_set: column = i
		end

end -- class EXTERNAL_SYNTAX_ERROR
