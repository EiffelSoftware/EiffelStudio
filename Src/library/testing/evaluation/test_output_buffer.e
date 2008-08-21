indexing
	description: "[
		Objects that redirect file output into a buffer. If the output exceeds the size of the buffer,
		only the first and the last part of the output are kept in the buffer.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OUTPUT_BUFFER

inherit
	PLAIN_TEXT_FILE
		rename
			make as make_file,
			wipe_out as wipe_out_file
		redefine
			count,
			exists,
			flush,
			put_boolean,
			put_character,
			put_double,
			putdouble,
			put_new_line,
			new_line,
			put_real,
			putreal,
			put_string
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
		local
			l_split: INTEGER
		do
			buffer_size := a_size
			create buffer.make (buffer_size)
			mode := write_file
			name := "test_output_buffer"
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
		require
			not_truncated: not is_truncated
		do
			create Result.make_from_string (buffer)
		end

	leading_content: like buffer
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

feature {NONE} -- Access

	buffer: !STRING
			-- Buffer containing first part of output

	split_position: INTEGER
			-- Position where content is truncated
		do
			Result := buffer_size // 2
		end

	truncated_start_position: INTEGER
			-- Position in `closing_content' representing beginning of actual content

feature -- Status setting

	wipe_out
			-- Empty buffer
		do
			buffer.wipe_out
			truncated_start_position := 0
		end

feature -- Status report

	is_truncated: BOOLEAN
			-- Has middle part of content been truncated?
		do
			Result := truncated_start_position > 0
		end

	exists: BOOLEAN = False
			-- <Precursor>	

feature -- Output

	put_string (a_string: STRING) is
			-- Append string to `buffer'.
			--
			-- `a_string': String to be appended to `buffer'.
			--
			--| Note: Instead of using `replace_substring', {STRING} should have a feature where one can
			--|       also provide a range on the input string. That would save allocating the substring
			--|       in the following code.
		local
			l_split, l_capacity, l_count, l_start, l_length, l_newpos: INTEGER
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
					l_length := buffer_size - truncated_start_position
					l_newpos := l_split + 1 + l_count - l_length
					buffer.replace_substring (a_string.substring (l_start, l_start + l_length), truncated_start_position, buffer.count)
					buffer.replace_substring (a_string.substring (l_start + l_length + 1, a_string.count), l_split + 1, l_newpos - 1)
					truncated_start_position := l_newpos
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

	put_character (c: CHARACTER)
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

	put_boolean (b: BOOLEAN)
			-- <Precursor>
		do
			put_string (b.out)
		end

	put_new_line, new_line
			-- <Precursor>
		do
			put_character ('%N')
		end

	put_double, putdouble (d: REAL_64)
			-- <Precursor>
		do
			put_string (d.out)
		end

	put_real, putreal (r: REAL_32)
			-- <Precursor>
		do
			put_string (r.out)
		end

	flush
			-- <Precursor>
		do
		end

invariant
	buffer_capacity_at_least_buffer_size: buffer.capacity >= buffer_size
	buffer_count_not_greater_buffer_size: buffer.count <= buffer_size
	valid_truncated_start_position: truncated_start_position <= buffer.count and
		(truncated_start_position = 0 or truncated_start_position > split_position)
	truncated_implies_buffer_full: is_truncated implies (buffer.count = buffer_size)

end
