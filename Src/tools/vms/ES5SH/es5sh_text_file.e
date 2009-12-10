indexing
	description: "Enhanced PLAIN_TEXT_FILE"
	author: "David Schwartz, VMS diehard"
	notes: "[
		This class, written for ES5SH, provides enhancements to Eiffelbase PLAIN_TEXT_FILE:
			1. removes the spurious <CR> characters left in (some) lines by the runtime on VMS,
			2. counts input lines,
			3. tracks the last string written to the file in last_string_output (helpful for debugging)
	]"

class ES5SH_TEXT_FILE

inherit
	PLAIN_TEXT_FILE
		export {NONE} readline, putstring, new_line
		redefine
			read_line, readline,
			put_string, putstring,
			put_new_line, new_line,
			make, make_open_read, make_open_write, make_open_append, make_open_read_write,
			open_read, open_write, open_append, open_read_write, open_read_append
		end

	DEBUG_OUTPUT

create
	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write, make_open_read_append

feature -- Initialization

	make (a_filnam: STRING)
		do
			Precursor (a_filnam)
			initialize
		end

	make_open_read (a_filnam: STRING)
		do
			Precursor (a_filnam)
			initialize
		end

	make_open_write (a_filnam: STRING)
		do
			Precursor (a_filnam)
			initialize
		end

	make_open_append (a_filnam: STRING)
		do
			Precursor (a_filnam)
			initialize
		end

	make_open_read_write (a_filnam: STRING)
		do
			Precursor (a_filnam)
			initialize
		end

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

	put_line (a_ray: ARRAY[STRING]) is
			-- write each element of `a_ray' to file terminated by newline
		local
			l_big: STRING -- a really big string
		do
			create l_big.make (1000) -- I said it was big
			if a_ray /= Void then
				a_ray.do_all (agent append_item_agent (?, l_big))
			end
			l_big.append ("%N")
			put_string (l_big)
		end

	put_text (a_ray: ARRAY[STRING])
			-- write each element of `a_ray' to file
		local
			l_big: STRING
		do
			create l_big.make (1000) -- bigger'n Texas, even!
			if a_ray /= Void then
				a_ray.do_all (agent append_item_agent (?, l_big))
			end
			put_string (l_big)
		end

	put_string (s: STRING) is
			-- write `s' to file, save as `last_string_output', update line_count
		do
			Precursor (s)
			last_string_output := s  -- was s.twin; I don't think we need the .twin...
			line_count := line_count + last_string_output.occurrences ('%N')
		end

	putstring (s: STRING) is
			-- synonym for put_string; must be distinct from put_string to use Precursor
		do
			put_string (s)
		end

	put_new_line is
			-- output new_line, append to last_string_output
		do
			Precursor
			create last_string_output.make_from_string (last_string_output)
			last_string_output.append_character ('%N')
			line_count := line_count + 1
		end

	new_line is
			-- output new_line, append to last_string_output
		do
			put_new_line
		end

	debug_output: STRING
			-- display in debugger
		do
			Result := name
			if Result = Void then
				Result := "<Void>"
			end
		end

feature {NONE} -- Implementation

	initialize is
		do
			line_count := 0
			create last_string_output.make_empty
		end

	print_spurious_message (a_line: STRING) is
		once
			debug ("spurious_cr_message")
				print (generating_type + ": spurious <cr> eliminated from line #" + line_count.out + ": " + a_line + "%N")
			end -- debug
		end

	append_item_agent (a_item, a_other: STRING)
			-- append `a_item' to `a_other'
		require
			other_not_ovid: a_other /= Void
		do
			if a_item /= Void then
				a_other.append (a_item)
			end
		ensure
			other_not_smaller: a_other.count >= old a_other.count
		end

invariant
	last_string_output_not_void: last_string_output /= Void

end -- class ES5SH_TEXT_FILE
