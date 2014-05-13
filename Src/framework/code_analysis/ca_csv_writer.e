note
	description: "Writes to a CSV file."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_CSV_WRITER

create
	make

feature {NONE} -- Initialization

	make (a_file_name: PATH; a_header: attached STRING)
			-- Initialization for `Current'. The csv writer will write to the file with name
			-- `a_file_name'. `a_header' is the first line containing the column names.
		require
			no_new_lines: not a_header.has ('%N')
		do
			create output_file.make_with_path (a_file_name)
			output_file.open_write
				-- Write the header.
			add_line (a_header)
		ensure
			is_open: output_file.is_open_write
		end

feature -- Logging

	add_line (a_line: STRING)
			-- Writes `a_line' to the CSV file. A new line will be
			-- added automatically afterwards.
		require
			is_open: is_file_open
			no_new_lines: not a_line.has ('%N')
		do
			output_file.putstring (a_line + "%N")
		end

	close_file
			-- Closes the log file and forbids any further writing to it. (Non-reversible. Create
			-- new CSV class with same file name in order to append there again.)
		require
			is_open: is_file_open
		do
			output_file.close
		ensure
			is_closed: output_file.is_closed
		end

feature -- Status Report

	is_file_open: BOOLEAN
		do
			Result := output_file.is_open_write
		end

feature {NONE} -- Implementation

	output_file: PLAIN_TEXT_FILE
			-- The file that is written to.

end
