indexing
	description: "Enhanced PLAIN_TEXT_FILE"
	author: "David Schwartz, VMS diehard"
	note: "[
		This class, written for ES5SH, provides enhancements to Eiffelbase PLAIN_TEXT_FILE.
		1. it removes the spurious <CR> characters left in (some) lines by the runtime on VMS
		2. it counts input lines
		3. for debugging, it tracks the last string written to the file in last_string_output
	]"

class ES5SH_TEXT_FILE

inherit
	PLAIN_TEXT_FILE
		export {NONE} readline, putstring, new_line
		redefine
			read_line, readline,
			put_string, putstring,
			put_new_line, new_line,
			open_read, open_write, open_append, open_read_write, open_read_append
		end

create
	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Initialization

	open_read is
		do
			Precursor
			initialize
		end
	open_write is
		do
			Precursor
			initialize
		end
	open_append is
		do
			Precursor
			initialize
		end
	open_read_write is
		do
			Precursor
			initialize
		end
	open_read_append is
		do
			Precursor
			initialize
		end

feature -- Access

	line_count: INTEGER
		-- count of lines read
	last_string_output: STRING
		-- last string output to file (this is an example of a classically useless

feature -- Input

	read_line is
		-- Read a string until new line or end of file.
		-- Count number of lines read in `line_count'
		-- Remove spurious trailing carriage return and output warning message
		do
			Precursor
			line_count := line_count + 1
			if last_string.count > 0 and then last_string @ (last_string.count) = '%R' then
				last_string.set_count (last_string.count - 1)
				print_spurious_message (last_string)
			end
		end

	readline is
			-- synonym for read_line; must be separate to call Precursor
		do  read_line  end

feature -- Output

	put_string (s: STRING) is
			-- save `s' as last_string_output and write to file
		do
			last_string_output := s.twin
			Precursor (s)
			line_count := line_count + last_string_output.occurrences ('%N')
		end

	putstring (s: STRING) is
			-- synonym for put_string; must be distinct from put_string to use Precursor
		do  put_string (s)  end

	put_new_line is
			-- save newline as last_string_output and write to file
		do
			last_string_output := "%N"
			Precursor
			line_count := line_count + 1
		end

	new_line is
			-- synonym for put_new_line
		do  put_new_line  end

feature {NONE} -- Implementation

	initialize is
		do
			line_count := 0
			last_string_output := Void
		end

	print_spurious_message (a_line: STRING) is
		once
			debug ("spurious_cr_message")
				print (generating_type + ": spurious <cr> eliminated from line #" + line_count.out + ": " + a_line + "%N")
			end -- debug
		end

end -- class ES5SH_TEXT_FILE
