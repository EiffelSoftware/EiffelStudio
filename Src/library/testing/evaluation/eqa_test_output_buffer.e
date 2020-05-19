note
	description: "[
		Objects that redirect file output into a buffer. If the output exceeds the size of the buffer,
		only the first and the last part of the output are kept in the buffer.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_TEST_OUTPUT_BUFFER

inherit
	PLAIN_TEXT_FILE
		rename
			make as make_file,
			wipe_out as wipe_out_file
		redefine
			count, exists, readable,
			put_boolean, put_real, put_double, put_string, put_character,
			put_new_line, new_line, end_of_file, file_close,
			putbool, putreal, putdouble, putstring, putchar,
			dispose, back, flush
		end

create
	make

feature {NONE} -- Initialization

	make (a_size: like buffer_size)
			-- Initialize `Current'.
			--
			-- `a_size': Buffer size limiting amount of text which will be buffered
		require
			a_size_greater_one: a_size > 3
		do
			make_with_name ("test_output_buffer")
			buffer_size := a_size
			create buffer.make (buffer_size)
			mode := write_file
		end

feature -- Access

	buffer_size: INTEGER
			-- Buffer size limiting amount of text which will be buffered

	count: INTEGER
			-- <Precursor>
		do
			Result := buffer.count
		end

	content: like buffer
			-- Not truncated content printed to buffer
		require
			not_truncated: not is_truncated
		do
			create Result.make_from_string (buffer)
		end

	leading_content: like buffer
			-- First part of buffer (before truncated section)
		require
			truncated: is_truncated
		local
			l_pos: like split_position
		do
			l_pos := split_position
			create Result.make (l_pos)
			Result.append (buffer.substring (1, l_pos))
		end

	closing_content: like buffer
			-- Second part of buffer (after truncated section)
		require
			truncated: is_truncated
		local
			l_pos: like split_position
		do
			l_pos := split_position
			create Result.make (buffer_size - l_pos)
			Result.append (buffer.substring (truncated_start_position, buffer.count))
			if truncated_start_position > l_pos + 1 then
				Result.append (buffer.substring (l_pos + 1, truncated_start_position - 1))
			end
		end

	formatted_content: like buffer
			-- Buffered content formatted in a printable way
		do
			if is_truncated then
				create Result.make (buffer_size + 100)
				Result.append (leading_content)
				Result.append (m_truncated)
				Result.append (closing_content)
			else
				Result := content
			end
		end

feature {NONE} -- Access

	buffer: STRING_8
			-- Buffer containing first part of output

	split_position: INTEGER
			-- Position where content is truncated
		do
			Result := buffer_size // 2
		end

	truncated_start_position: INTEGER
			-- Position in `closing_content' representing beginning of actual content

feature -- Status report

	is_truncated: BOOLEAN
			-- Has middle part of content been truncated?
		do
			Result := truncated_start_position > 0
		end

	exists: BOOLEAN = False
			-- <Precursor>

	readable: BOOLEAN
			-- <Precursor>
		do
			Result := writable
		end

feature -- Status setting

	wipe_out
			-- Empty buffer
		do
			buffer.wipe_out
			truncated_start_position := 0
		end

feature -- Output

	put_string, putstring (a_string: READABLE_STRING_8)
			-- Append string to `buffer'.
			--
			-- `a_string': String to be appended to `buffer'.
			--
			--| Note: Instead of using `replace_substring', {STRING} should have a feature where one can
			--|       also provide a range on the input string. That would save allocating the substring
			--|       in the following code.
		local
			l_split, l_capacity, l_count, l_start, l_new_tsp: INTEGER
			l_ccount1: INTEGER
			l_chunk1, l_chunk2: STRING_8
		do
			if buffer.count + a_string.count > buffer_size then
				l_split := split_position
				if truncated_start_position = 0 then
					truncated_start_position := l_split + 1
					buffer.append (a_string.substring (1, buffer_size - buffer.count))
				end
				l_capacity := buffer_size - l_split
				if a_string.count > l_capacity then
					l_start := a_string.count - l_capacity + 1
					l_count := l_capacity
				else
					l_start := 1
					l_count := a_string.count
				end
				if truncated_start_position + l_count > buffer_size + 1 then
					l_ccount1 := buffer_size - truncated_start_position + 1
					l_new_tsp := l_split + 1 + l_count - l_ccount1

					l_chunk1 := a_string.substring (l_start, l_start + l_ccount1 - 1).to_string_8
					buffer.replace_substring (l_chunk1, truncated_start_position, buffer.count)

					l_chunk2 := a_string.substring (l_start + l_ccount1, a_string.count).to_string_8
					buffer.replace_substring (l_chunk2, l_split + 1, l_new_tsp - 1)

					truncated_start_position := l_new_tsp
				else
					buffer.replace_substring (a_string.substring (l_start, a_string.count), truncated_start_position, truncated_start_position + l_count - 1)
					if truncated_start_position + l_count > buffer_size then
						truncated_start_position := l_split + 1
					else
						truncated_start_position := truncated_start_position + l_count
					end
				end
			else
				buffer.append_string (a_string)
			end
		end

	put_character, putchar (c: CHARACTER_8)
			-- Append character to buffer.
			--
			-- `c': Character to be appended to `buffer'.
		local
			l_split, l_pos: INTEGER
		do
			if buffer.count + 1 > buffer_size then
				l_split := split_position
				if truncated_start_position = 0 then
					l_pos := l_split + 1
					truncated_start_position := l_split + 2
				else
					l_pos := truncated_start_position
					if truncated_start_position = buffer.count then
						truncated_start_position := l_split + 1
					else
						truncated_start_position := truncated_start_position + 1
					end
				end
				buffer.put (c, l_pos)
			else
				buffer.append_character (c)
			end
		end

	put_boolean, putbool (b: BOOLEAN)
			-- <Precursor>
		do
			put_string (if b then once "True" else once "False" end)
		end

	put_new_line, new_line
			-- <Precursor>
		do
			put_character ('%N')
		end

	put_double, putdouble (d: REAL_64)
			-- <Precursor>
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_double (d)
			put_string (s)
		end

	put_real, putreal (r: REAL_32)
			-- <Precursor>
		local
			s: STRING_8
		do
			create s.make (10)
			s.append_real (r)
			put_string (s)
		end

	flush
			-- <Precursor>
		do
		end

feature -- Basic functionality: file

	dispose
			-- <Precursor>
		do
		end

	back
			-- <Precursor>
		do
		end

	end_of_file: BOOLEAN
			-- <Precursor>
		do
		end

	file_close (file: POINTER)
			-- <Precursor>
		do
		end

feature {NONE} -- Constants

	m_truncated: STRING_8 = "%N%N---------------------------%NTruncated section%N---------------------------%N%N"

invariant
	buffer_capacity_at_least_buffer_size: buffer.capacity >= buffer_size
	buffer_count_not_greater_buffer_size: buffer.count <= buffer_size
	valid_truncated_start_position: truncated_start_position <= buffer.count and
		(truncated_start_position = 0 or truncated_start_position > split_position)
	truncated_implies_buffer_full: is_truncated implies (buffer.count = buffer_size)

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
