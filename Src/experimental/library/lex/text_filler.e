note
	description: "Buffered files or strings for lexical analysis"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TEXT_FILLER

feature -- Access

	buffer: STRING
			-- Buffer filled by fill_buffer.

	source_file_path: detachable PATH
			-- The source file path if `source_is_file'.

	file_name: detachable STRING
			-- Name of input file.
		obsolete
			"Use source_file_path. [2017-05-31]"
		do
			if attached file as l_file then
				Result := l_file.name
			elseif attached source_file_path as p then
				Result := p.name.as_string_8
			end
		end

	line_nb_array: LEX_ARRAY [INTEGER]
			-- Array recording the line numbers of each buffered
			-- character (the line number of the `i'-th character in the
			-- buffer is the `i'-th entry of `line_nb_array').

	column_nb_array: LEX_ARRAY [INTEGER]
			-- Array recording the column numbers of each buffered
			-- character (the column number of the `i'-th character in the
			-- buffer is the `i'-th entry of `column_nb_array').

	char_buffered_number: INTEGER
	-- Number of characters read and written
	-- in buffer since the beginning.

feature -- Status setting

	create_buffers (buf, lin: INTEGER)
			-- Create buffers and mask.
		do
			buffer_size := buf
			line_length := lin
			create buffer.make (buffer_size)
			buffer.fill_blank
			create line_nb_array.make_filled (0, 1, buffer_size)
			create column_nb_array.make_filled (0, 1, buffer_size)
		ensure
			buffer_size = buf
			line_length = lin
		end

	resize_and_fill_buffer (buf, b: INTEGER)
			-- When increasing `buffer_size': resize the buffer and then
			-- fill the new buffer.
			-- When decreasing `buffer_size': fill the buffer and then
			-- resize it.
			-- When filling the buffer: Copy the characters from the
			-- `b'+1-st to the last one (of the buffer before resizing) in
			-- the beginning of the buffer and then fill
			-- the end of the buffer (after resizing) with the text.
			-- This routine skips the columns
			-- forbidden by exclude, but always puts '\n' at the end
			-- of a line; the line and column numbers are those of
			-- the characters in the real file.
		require
			buffer_created: buffer /= Void
			c_buffer_created: column_nb_array /= Void
			l_buffer_created: line_nb_array /= Void
			b_not_too_large: b <= buffer_size
			b_positive: b >= 0
		local
			previous_buffer_size: INTEGER
			previous_buffer: STRING
		do
			if buf >= buffer_size then
				previous_buffer_size := buffer_size
				buffer_size := buf
				previous_buffer := buffer.twin
				buffer.resize (buffer_size)
				buffer.append (previous_buffer)
				line_nb_array.conservative_resize_with_default (0, 1, buffer_size)
				column_nb_array.conservative_resize_with_default (0, 1, buffer_size)
				if attached file as f then
					fill_from_file (f, b, previous_buffer_size, buffer_size)
				elseif attached string as s then
					fill_from_string (s, b, previous_buffer_size, buffer_size)
				end
			else
				if attached file as f then
					fill_from_file (f, b, buffer_size, buf)
				elseif attached string as s then
					fill_from_string (s, b, buffer_size, buf)
				end
				buffer_size := buf
				buffer.resize (buffer_size)
				line_nb_array.conservative_resize_with_default (0, 1, buffer_size)
				column_nb_array.conservative_resize_with_default (0, 1, buffer_size)
			end
		ensure
			buffer_size = buf
		end

	exclude (i, j: INTEGER)
			-- Discard columns `i' to `j' from the input.
			-- A zero value for `j' means all the way to the
			-- end of the line.
		require
			i_positive: i > 0
			j_null_or_greater_than_i: j = 0 or j >= i
		local
			index, last_index: INTEGER
			l_mask: like mask
		do
			l_mask := mask
			if l_mask = Void then
				create l_mask.make (line_length)
				l_mask.all_true
				mask := l_mask
			end
			if j = 0 then
				last_index := line_length + 1
			else
				last_index := j + 1
			end
			from
				index := i
			until
				index = last_index
			loop
				l_mask.remove (index)
				index := index + 1
			end
		end

	set_file (f_name: READABLE_STRING_GENERAL)
			-- Use `f_name' as input file.
		require
			file_name_not_void: f_name /= Void
		local
			l_file: like file
		do
			close_file
			create l_file.make_with_name (f_name)
			l_file.open_read
			file := l_file
			reset
			char_buffered_number := 0
			source_file_path := l_file.path
			source_size := l_file.count
			initialize
			reset_data
		ensure
			source_is_file: source_is_file
			has_file: attached file
			has_source_file_path: source_file_path /= Void
		end

	set_string (s: STRING)
			-- Use `s' as the input string.
		require
			string_not_void: s /= Void
		do
			close_file
			string := s
			reset
			char_buffered_number := 0
			source_file_path := Void
			source_size := s.capacity
			initialize
			reset_data
		ensure
			source_is_string: not source_is_file
			has_string: attached string
		end

	fill_buffer (b: INTEGER)
			-- Copy the characters from the `b'+1-st to the last one in
			-- the beginning of the buffer and then fill the end of
			-- the buffer with the text. This routine skips the columns
			-- forbidden by exclude, but always puts '\n' at the end
			-- of a line; the line and column numbers are those of
			-- the characters in the real file.
		require
			buffer_created: buffer /= Void
			c_buffer_created: column_nb_array /= Void
			l_buffer_created: line_nb_array /= Void
			b_not_too_large: b <= buffer_size
			b_positive: b >= 0
		do
			if attached file as f then
				fill_from_file (f, b, buffer_size, buffer_size)
			elseif attached string as s then
				fill_from_string (s, b, buffer_size, buffer_size)
			end
		end

	fill_whole_buffer
			-- Fill with new characters.
		do
			fill_buffer (buffer_size)
		end

	close_file
			-- Close input file if any.
		local
			l_file: like file
		do
			l_file := file
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
			file := Void
		ensure
			file_is_void: file = Void
		end

feature -- Implementation

	buffer_size: INTEGER
			-- Buffer size.

feature {NONE} -- Implementation

	line_length: INTEGER
		-- Maximal number of characters in a line.

	source_size: INTEGER
		-- Character number in file or string source.

	file: detachable PLAIN_TEXT_FILE
			-- File to be buffered.

	string: detachable STRING
		-- String to be buffered.

	mask: detachable FIXED_INTEGER_SET
		-- Set of readable columns.

	source_is_file: BOOLEAN
			-- Is the source a file? (If not it is a string).
		do
			Result := source_file_path /= Void
		end

	line_number: INTEGER
			-- Character line position in document.

	column_number: INTEGER
			-- Character column position in document.

	position_in_string: INTEGER
			-- Position of last character read in `string'.

	initialize
			-- Set buffers.
		deferred
		end

	reset_data
			-- Initialize datas when set_file or set_string is used.
		deferred
		end

	reset
			-- Initialize character position in document.
		do
			line_number := 1
			column_number := 1
			position_in_string := 0
		end

	fill_from_file (l_file: attached like file; position, old_size, new_size: INTEGER)
			-- Copy the characters from `position'+1-th to `old_size'-th
			-- in beginning of `buffer', and fill other part of `buffer'
			-- with characters from `file'.
		require
			buffer_created: buffer /= Void
			c_buffer_created: column_nb_array /= Void
			l_buffer_created: line_nb_array /= Void
			position_not_too_large: position <= buffer_size
			position_positive: position >= 0
			valid_old_size: old_size >= 0 and old_size <= buffer_size
			valid_new_size: new_size >= 0 and new_size <= buffer_size
		local
			c: CHARACTER
			i, nb: INTEGER
			eof: BOOLEAN
			lines, columns: LEX_ARRAY [INTEGER]
			cmask: like mask
			file_nb: INTEGER
			file_last_string: detachable STRING
		do
			lines := line_nb_array
			columns := column_nb_array
			if position /= 0 and position < old_size then
				buffer.subcopy (buffer, position + 1, old_size, 1)
				lines.subcopy (lines, position + 1, old_size, 1)
				columns.subcopy (columns, position + 1, old_size, 1)
			end
			nb := old_size - position
			i := nb + 1
			cmask := mask
			if cmask = Void then
				file_nb := new_size - nb
				l_file.read_stream (file_nb)
				file_last_string := l_file.last_string
				if file_last_string.count < file_nb then
					file_nb := file_last_string.count
					buffer.put ('%/255/', i + file_nb)
					char_buffered_number := char_buffered_number + file_nb + 1
				else
					char_buffered_number := char_buffered_number + file_nb
				end
				buffer.subcopy (file_last_string, 1, file_nb, i)
				from
				until
					eof or i > new_size
				loop
					inspect buffer.item (i)
					when '%/255/' then
						lines.put (-1, i)
						columns.put (-1, i)
						close_file
						eof := True
					when '%N' then
						lines.put (line_number, i)
						columns.put (column_number, i)
						line_number := line_number + 1
						column_number := 1
					else
						lines.put (line_number, i)
						columns.put (column_number, i)
						column_number := column_number + 1
					end
					i := i + 1
				end
			else
				from
				until
					eof or i > new_size
				loop
					if l_file.end_of_file then
						buffer.put ('%/255/', i)
						lines.put (-1, i)
						columns.put (-1, i)
						close_file
						eof := True
					else
						l_file.read_character
						c := l_file.last_character
						if c = '%N' then
							buffer.put (c, i)
							lines.put (line_number, i)
							columns.put (column_number, i)
							line_number := line_number + 1
							column_number := 1
							i := i + 1
						else
							if
								column_number <= cmask.count and then
								cmask.item (column_number)
							then
								buffer.put (c, i)
								lines.put (line_number, i)
								columns.put (column_number, i)
								i := i + 1
							end
							column_number := column_number + 1
						end
					end
				end
				char_buffered_number := char_buffered_number + i - nb
			end
		end

	fill_from_string (l_string: attached like string; position, old_size, new_size: INTEGER)
			-- Copy the characters from `position'+1-th to `old_size'-th
			-- in beginning of `buffer', and fill other part of `buffer'
			-- with characters from `string'.
		require
			buffer_created: buffer /= Void
			c_buffer_created: column_nb_array /= Void
			l_buffer_created: line_nb_array /= Void
			position_not_too_large: position <= buffer_size
			position_positive: position >= 0
			valid_old_size: old_size >= 0 and old_size <= buffer_size
			valid_new_size: new_size >= 0 and new_size <= buffer_size
			string_not_void: string /= Void
		local
			c: CHARACTER
			i, nb: INTEGER
			eof: BOOLEAN
			lines, columns: LEX_ARRAY [INTEGER]
			cmask: like mask
			str_nb: INTEGER
		do
			lines := line_nb_array
			columns := column_nb_array
			if position /= 0 and position < old_size then
				buffer.subcopy (buffer, position + 1, old_size, 1)
				lines.subcopy (lines, position + 1, old_size, 1)
				columns.subcopy (columns, position + 1, old_size, 1)
			end
			nb := old_size - position
			i := nb + 1
			cmask := mask
			if cmask = Void then
				str_nb := new_size - nb
				if l_string.count - position_in_string < str_nb then
					str_nb := l_string.count - position_in_string
					buffer.put ('%/255/', i + str_nb)
					char_buffered_number := char_buffered_number + str_nb + 1
				else
					char_buffered_number := char_buffered_number + str_nb
				end
				buffer.subcopy (l_string, position_in_string + 1, position_in_string + str_nb, i)
				position_in_string := position_in_string + str_nb
				from
				until
					eof or i > new_size
				loop
					inspect buffer.item (i)
					when '%/255/' then
						lines.put (-1, i)
						columns.put (-1, i)
						eof := True
					when '%N' then
						lines.put (line_number, i)
						columns.put (column_number, i)
						line_number := line_number + 1
						column_number := 1
					else
						lines.put (line_number, i)
						columns.put (column_number, i)
						column_number := column_number + 1
					end
					i := i + 1
				end
			else
				from
				until
					eof or i > new_size
				loop
					position_in_string := position_in_string + 1
					if position_in_string > l_string.count then
						buffer.put ('%/255/', i)
						lines.put (-1, i)
						columns.put (-1, i)
						eof := True
					else
						c := l_string.item (position_in_string)
						if c = '%N' then
							buffer.put (c, i)
							lines.put (line_number, i)
							columns.put (column_number, i)
							line_number := line_number + 1
							column_number := 1
							i := i + 1
						else
							if
								column_number <= cmask.count and then
								cmask.item (column_number)
							then
								buffer.put (c, i)
								lines.put (line_number, i)
								columns.put (column_number, i)
								i := i + 1
							end
							column_number := column_number + 1
						end
					end
				end
				char_buffered_number := char_buffered_number + i - nb
			end
		end

note
	comment: "[
		Buffered files or strings
		When the buffer is filled, the columns forbidden by exclude
		are not copied in the buffer, but the last one, which is always
		a carriage return.
		The routine filling the buffer fills also the two arrays
		"line_nb_array", and "column_nb_array", recording the position
		of each character of the buffer in the original text.
		The class is deferred, to let an heir resetting its datas each
		time it fills the buffer.
		Do not forget to create the buffers before using this class.
	]"
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
