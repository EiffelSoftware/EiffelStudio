indexing

	description:
		"Buffered files or strings for lexical analysis";
	comment:
		"See detailed comment at end of class";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TEXT_FILLER 

feature -- Access

	buffer: STRING;
			-- Buffer filled by fill_buffer

	file_name : STRING is
			-- Name of input file
		do
			if source_is_file then
				Result := file.name
			end
		end; 

	line_nb_array: LEX_ARRAY [INTEGER];
			-- Array recording the line numbers of each buffered
			-- character (the line number of the `i'-th character in the
			-- buffer is the `i'-th entry of `line_nb_array')

	column_nb_array: LEX_ARRAY [INTEGER];
			-- Array recording the column numbers of each buffered
			-- character (the column number of the `i'-th character in the
			-- buffer is the `i'-th entry of `column_nb_array')

	char_buffered_number: INTEGER;
			-- Number of characters read and written
			-- in buffer since the beginning

feature -- Status setting

	create_buffers (buf, lin: INTEGER) is
			-- Create buffers and mask.
		do
			buffer_size := buf;
			line_length := lin;
			!! buffer.make (buffer_size);
			buffer.fill_blank;
			!! line_nb_array.make (1, buffer_size);
			!! column_nb_array.make (1, buffer_size)
		ensure
			buffer_size = buf;
			line_length = lin
		end; 

	resize_and_fill_buffer (buf, b: INTEGER) is
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
			buffer_created: buffer /= Void;
			c_buffer_created: column_nb_array /= Void;
			l_buffer_created: line_nb_array /= Void;
			b_not_too_large: b <= buffer_size;
			b_positive: b >= 0
		local
			previous_buffer_size: INTEGER;
			previous_buffer: STRING;
		do
			if buf >= buffer_size then
				previous_buffer_size := buffer_size;
				buffer_size := buf;
				previous_buffer := clone (buffer);
				buffer.resize (buffer_size);
				buffer.append (previous_buffer);
				line_nb_array.resize (1, buffer_size);
				column_nb_array.resize (1, buffer_size);
				if source_is_file then
					fill_from_file (b, previous_buffer_size, buffer_size)
				else
					fill_from_string (b, previous_buffer_size, buffer_size)
				end
			else
				if source_is_file then
					fill_from_file (b, buffer_size, buf)
				else
					fill_from_string (b, buffer_size, buf)
				end;
				buffer_size := buf;
				buffer.resize (buffer_size);
				line_nb_array.resize (1, buffer_size);
				column_nb_array.resize (1, buffer_size)
			end
		ensure
			buffer_size = buf
		end; 

	exclude (i, j: INTEGER) is
			-- Discard columns `i' to `j' from the input.
			-- A zero value for `j' means all the way to the
			-- end of the line.
		require
			i_positive: i > 0;
			j_null_or_greater_than_i: j = 0 or j >= i
		local
			index, last_index: INTEGER
		do
			if mask = Void then
				!! mask.make (line_length);
				mask.all_true
			end
			if j = 0 then
				last_index := line_length + 1
			else
				last_index := j + 1
			end;
			from
				index := i
			until
				index = last_index
			loop
				mask.remove (index);
				index := index + 1
			end
		end; 

	set_file (f_name: STRING) is
			-- Use `f_name' as input file.
		require
			file_name_not_void: f_name /= Void
		do
			close_file;
			!! file.make_open_read (f_name);
			reset;
			char_buffered_number := 0;
			source_is_file := True;
			source_size := file.count;
			initialize;
			reset_data
		end; 

	set_string (s: STRING) is
			-- Use `s' as the input string.
		require
			string_not_void: s /= Void
		do
			close_file;
			string := s;
			reset;
			char_buffered_number := 0;
			source_is_file := False;
			source_size := string.capacity;
			initialize;
			reset_data
		end; 

	fill_buffer (b: INTEGER) is
			-- Copy the characters from the `b'+1-st to the last one in
			-- the beginning of the buffer and then fill the end of
			-- the buffer with the text. This routine skips the columns
			-- forbidden by exclude, but always puts '\n' at the end
			-- of a line; the line and column numbers are those of
			-- the characters in the real file.
		require
			buffer_created: buffer /= Void;
			c_buffer_created: column_nb_array /= Void;
			l_buffer_created: line_nb_array /= Void;
			b_not_too_large: b <= buffer_size;
			b_positive: b >= 0
		do
			if source_is_file then
				fill_from_file (b, buffer_size, buffer_size)
			else
				fill_from_string (b, buffer_size, buffer_size)
			end
		end; 

	fill_whole_buffer is
			-- Fill with new characters.
		do
			fill_buffer (buffer_size)
		end 

	close_file is
			-- Close input file if any.
		do
			if file /= Void and then not file.is_closed then
				file.close
			end
			file := Void
		ensure
			file_is_void: file = Void
		end

feature -- Implementation

	buffer_size: INTEGER;
			-- Buffer size

feature {NONE} -- Implementation

	line_length: INTEGER;
			-- Maximal number of characters in a line

	source_size: INTEGER;
			-- Character number in file or string source

	file: PLAIN_TEXT_FILE
			-- File to be buffered

	string: STRING;
			-- String to be buffered

	mask: FIXED_INTEGER_SET;
			-- Set of readable columns

	source_is_file: BOOLEAN;
			-- Is the source a file? (If not it is a string)

	line_number: INTEGER;
	column_number: INTEGER
			-- Character position in document

	position_in_string: INTEGER
			-- Position of last character read in `string'

	initialize is
			-- Set buffers
		deferred
		end;

	reset_data is
			-- Initialize datas when set_file or set_string is used.
		deferred
		end 

	reset is
			-- Initialize character position in document.
		do
			line_number := 1
			column_number := 1
			position_in_string := 0
		end

	fill_from_file (position, old_size, new_size: INTEGER) is
			-- Copy the characters from `position'+1-th to `old_size'-th
			-- in beginning of `buffer', and fill other part of `buffer'
			-- with characters from `file'.
		require
			buffer_created: buffer /= Void;
			c_buffer_created: column_nb_array /= Void;
			l_buffer_created: line_nb_array /= Void;
			position_not_too_large: position <= buffer_size;
			position_positive: position >= 0;
			valid_old_size: old_size >= 0 and old_size <= buffer_size;
			valid_new_size: new_size >= 0 and new_size <= buffer_size;
			file_not_void: file /= Void
		local
			c: CHARACTER;
			i, nb: INTEGER;
			eof: BOOLEAN;
			lines, columns: LEX_ARRAY [INTEGER];
			cmask: FIXED_INTEGER_SET;
			file_nb: INTEGER;
			file_last_string: STRING
		do
			lines := line_nb_array;
			columns := column_nb_array;
			if position /= 0 and position < old_size then
				buffer.subcopy (buffer, position + 1, old_size, 1)
				lines.subcopy (lines, position + 1, old_size, 1)
				columns.subcopy (columns, position + 1, old_size, 1)
			end;
			nb := old_size - position;
			i := nb + 1;
			if mask = Void then
				file_nb := new_size - nb;
				file.read_stream (file_nb);
				file_last_string := file.last_string;
				if file_last_string.count < file_nb then
					file_nb := file_last_string.count;
					buffer.put ('%/255/', i + file_nb);
					char_buffered_number := char_buffered_number + file_nb + 1
				else
					char_buffered_number := char_buffered_number + file_nb
				end;
				buffer.subcopy (file_last_string, 1, file_nb, i)
				from
				until
					eof or i > new_size
				loop
					inspect buffer.item (i)
					when '%/255/' then
						lines.put (-1, i);
						columns.put (-1, i);
						close_file;
						eof := True
					when '%N' then
						lines.put (line_number, i);
						columns.put (column_number, i);
						line_number := line_number + 1;
						column_number := 1
					else
						lines.put (line_number, i);
						columns.put (column_number, i);
						column_number := column_number + 1
					end
					i := i + 1
				end
			else
				from
					cmask := mask
				until
					eof or i > new_size
				loop
					if file.end_of_file then
						buffer.put ('%/255/', i);
						lines.put (-1, i);
						columns.put (-1, i);
						close_file;
						eof := True
					else
						file.read_character;
						c := file.last_character;
						if c = '%N' then
							buffer.put (c, i);
							lines.put (line_number, i);
							columns.put (column_number, i);
							line_number := line_number + 1;
							column_number := 1;
							i := i + 1
						else
							if
								column_number <= cmask.count and then
								cmask.item (column_number)
							then
								buffer.put (c, i);
								lines.put (line_number, i);
								columns.put (column_number, i);
								i := i + 1
							end;
							column_number := column_number + 1
						end
					end	
				end
				char_buffered_number := char_buffered_number + i - nb
			end
		end

	fill_from_string (position, old_size, new_size: INTEGER) is
			-- Copy the characters from `position'+1-th to `old_size'-th
			-- in beginning of `buffer', and fill other part of `buffer'
			-- with characters from `string'.
		require
			buffer_created: buffer /= Void;
			c_buffer_created: column_nb_array /= Void;
			l_buffer_created: line_nb_array /= Void;
			position_not_too_large: position <= buffer_size;
			position_positive: position >= 0;
			valid_old_size: old_size >= 0 and old_size <= buffer_size;
			valid_new_size: new_size >= 0 and new_size <= buffer_size;
			string_not_void: string /= Void
		local
			c: CHARACTER;
			i, nb: INTEGER;
			eof: BOOLEAN;
			lines, columns: LEX_ARRAY [INTEGER];
			cmask: FIXED_INTEGER_SET;
			str_nb: INTEGER
		do
			lines := line_nb_array;
			columns := column_nb_array;
			if position /= 0 and position < old_size then
				buffer.subcopy (buffer, position + 1, old_size, 1)
				lines.subcopy (lines, position + 1, old_size, 1)
				columns.subcopy (columns, position + 1, old_size, 1)
			end;
			nb := old_size - position;
			i := nb + 1;
			if mask = Void then
				str_nb := new_size - nb;
				if string.count - position_in_string < str_nb then
					str_nb := string.count - position_in_string
					buffer.put ('%/255/', i + str_nb);
					char_buffered_number := char_buffered_number + str_nb + 1
				else
					char_buffered_number := char_buffered_number + str_nb
				end;
				buffer.subcopy (string, position_in_string + 1, position_in_string + str_nb, i)
				position_in_string := position_in_string + str_nb;
				from
				until
					eof or i > new_size
				loop
					inspect buffer.item (i)
					when '%/255/' then
						lines.put (-1, i);
						columns.put (-1, i);
						eof := True
					when '%N' then
						lines.put (line_number, i);
						columns.put (column_number, i);
						line_number := line_number + 1;
						column_number := 1
					else
						lines.put (line_number, i);
						columns.put (column_number, i);
						column_number := column_number + 1
					end
					i := i + 1
				end
			else
				from
					cmask := mask
				until
					eof or i > new_size
				loop
					position_in_string := position_in_string + 1
					if position_in_string > string.count then
						buffer.put ('%/255/', i);
						lines.put (-1, i);
						columns.put (-1, i);
						eof := True
					else
						c := string.item (position_in_string);
						if c = '%N' then
							buffer.put (c, i);
							lines.put (line_number, i);
							columns.put (column_number, i);
							line_number := line_number + 1;
							column_number := 1;
							i := i + 1
						else
							if
								column_number <= cmask.count and then
								cmask.item (column_number)
							then
								buffer.put (c, i);
								lines.put (line_number, i);
								columns.put (column_number, i);
								i := i + 1
							end;
							column_number := column_number + 1
						end
					end	
				end
				char_buffered_number := char_buffered_number + i - nb
			end
		end

-- Buffered files or strings
-- When the buffer is filled, the columns forbidden by exclude
-- are not copied in the buffer, but the last one, which is always
-- a carriage return.
-- The routine filling the buffer fills also the two arrays
-- "line_nb_array", and "column_nb_array", recording the position
-- of each character of the buffer in the original text.
-- The class is deferred, to let an heir resetting its datas each
-- time it fills the buffer.
-- Do not forget to create the buffers before using this class.

end -- class TEXT_FILLER


--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

