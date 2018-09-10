note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_STATEMENT_ORIGIN

feature -- Access

	file: STRING
			-- Origin file.

	line: INTEGER
			-- Line number in `file'.

	column: INTEGER
			-- Column number in `file'.

	text_of_line: STRING
			-- Text of line `line' in file `file'.
		require
			has_line: line > 0
		local
			l_file: PLAIN_TEXT_FILE
			i: INTEGER
		do
			create l_file.make_open_read (file)
			from
				i := 1
			until
				i = line
			loop
				l_file.read_line
				i := i + 1
			end
			l_file.read_line
			Result := l_file.last_string
			Result.left_adjust
			l_file.close
		end

feature -- Element change

	set_file (a_file: STRING)
			-- Set `file' to `a_file'.
		do
			file := a_file.twin
		end

	set_line (a_line: INTEGER)
			-- Set `line' to `a_line'.
		do
			line := a_line
		end

	set_column (a_column: INTEGER)
			-- Set `column' to `a_column'.
		do
			column := a_column
		end

end
