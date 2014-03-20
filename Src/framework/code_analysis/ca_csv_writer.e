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

	make (a_file_name, a_header: attached STRING)
			-- Initialization for `Current'. The csv writer will write to the file with name
			-- `a_file_name'. `a_header' is the first line containing the column names.
		require
			a_file_name.ends_with (".csv")
			no_new_lines: not a_header.has ('%N')
		do
			create output_file.make_open_write (a_file_name)
			file_open := True
				-- Write the header.
			add_line (a_header)
		ensure
			file_open
		end

feature -- Logging

	add_line (a_line: attached STRING)
			-- Writes `a_line' to the CSV file. A new line will be
			-- added automatically afterwards.
		require
			file_open
			no_new_lines: not a_line.has ('%N')
		do
			output_file.putstring (a_line + "%N")
		end

	close_file
			-- Closes the log file and forbids any further writing to it. (Non-reversible. Create
			-- new CSV class with same file name in order to append there again.)
		require
			file_open
		do
			output_file.close
			file_open := False
		ensure
			not file_open
		end

			-- Is the file still open?
	file_open: BOOLEAN

feature {NONE} -- Implementation

			-- The file that is written to.
	output_file: PLAIN_TEXT_FILE

end
