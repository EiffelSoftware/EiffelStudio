note
	description: "Summary description for {APP_OUTPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APP_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (f: FILE)
		do
			output := f
			was_opened := f.is_open_append or is_open_write
			create offset.make_empty
			tab := "    "

			if not attached {CONSOLE} f and then attached {PLAIN_TEXT_FILE} f as tf then
				output_path := tf.path
			end
		end

feature -- Access

	output: FILE

	offset: STRING

	tab: STRING

	output_path: detachable PATH

feature -- Status report

	was_opened: BOOLEAN

	is_open_write: BOOLEAN
		do
			Result := output.is_open_write
		end

feature -- File operations

	open_append
		do
			output.open_append
		end

	open_write
		do
			output.open_write
		end

	close
		do
			output.close
		end

feature -- Operation

	indent
		do
			offset.append (tab)
		ensure
			old (offset.count) + tab.count = offset.count
		end

	exdent
		require
			offset.count >= tab.count
		do
			offset.remove_tail (tab.count)
		end

	flush
		do
			output.flush
		end

	last_was_newline: BOOLEAN


	put_new_line
		do
			output.put_new_line
			last_was_newline := True
		end

	put_string (s: READABLE_STRING_32)
		local
			i,j,n: INTEGER
			c: CHARACTER
		do
			if last_was_newline then
				last_was_newline := False
				output.put_string (offset)
			end
			if s.has ('%N') then
				from
					i := 1
					j := 1
					n := s.count
				until
					i <= 0 or j > n
				loop
					i := s.index_of ('%N', j)
					if i > 0 then
						output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s.substring (j, i)))
						if i = n then
							last_was_newline := True
						else
							output.put_string (offset)
						end
						j := i + 1
					else
						output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s.substring (j, n)))
					end
				end
				if s [s.count] = '%N' then
					last_was_newline := True
				end
			else
				output.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
			end
		end

	put_line_divider
		local
			s: like line_divider
		do
			if not last_was_newline then
				output.put_new_line
			end
			s := line_divider
			output.put_string (s)
			last_was_newline := True
			check s[s.count] = '%N' end
--			put_string (line_divider)
		end

	line_divider: STRING_8
		local
			level: INTEGER
			tb: like dividing_lines
			c: CHARACTER
			n: INTEGER
		do
			level := offset.count // tab.count
			tb := dividing_lines
			if tb = Void then
				create tb.make (3)
				dividing_lines := tb
			end
			Result := tb [level]
			if Result = Void then
				n := 60
				inspect level
				when 0 then c := '='
				when 1 then c := '-'
				when 2 then c := '.'
				else
					n := 0 -- blank line
				end
				Result := new_line_divider (c, offset.count, n)
				tb [level] := Result
			end
		end

	dividing_lines: detachable HASH_TABLE [like line_divider, INTEGER]

	new_line_divider (c: CHARACTER; pos: INTEGER; nb: INTEGER): STRING_8
		local
			i: INTEGER
		do
			from
				i := 1
				create Result.make (nb + 1)
			until
				i > nb
			loop
				if i <= pos then
					Result.append_character (' ')
				else
					Result.append_character (c)
				end
				i := i + 1
			end
			Result.append_character ('%N')
		end

end
