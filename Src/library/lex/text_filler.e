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
			Result := file.name
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
			!! mask.make (line_length);
			mask.all_true;
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
			c_temp1, c_temp2, c_temp3, c_temp4, c_temp5: ANY
		do
			if buf >= buffer_size then
				previous_buffer_size := buffer_size;
				buffer_size := buf;
				previous_buffer := clone (buffer);
				buffer.resize (buffer_size);
				buffer.append (previous_buffer);
				line_nb_array.resize (1, buffer_size);
				column_nb_array.resize (1, buffer_size);
				c_temp2 := buffer.to_c;
				c_temp3 := line_nb_array.to_c;
				c_temp4 := column_nb_array.to_c;
				c_temp5 := mask.to_c;
				if source_is_file then
					char_buffered_number := char_buffered_number
					+ fill_buf (file.file_pointer, $c_temp2,
					$c_temp3, $c_temp4,
					$c_temp5, b, previous_buffer_size, buffer_size)
				else
					c_temp1 := string.to_c;
					char_buffered_number := char_buffered_number
					+ fill_f_s ($c_temp1, $c_temp2,
					$c_temp3, $c_temp4,
					$c_temp5, b, previous_buffer_size, buffer_size)
				end
			else
				c_temp2 := buffer.to_c;
				c_temp3 := line_nb_array.to_c;
				c_temp4 := column_nb_array.to_c;
				c_temp5 := mask.to_c;
				if source_is_file then
					char_buffered_number := char_buffered_number
					+ fill_buf (file.file_pointer, $c_temp2,
					$c_temp3, $c_temp4,
					$c_temp5, b, buffer_size, buf)
				else
					c_temp1 := string.to_c;
					char_buffered_number := char_buffered_number
					+ fill_f_s ($c_temp1, $c_temp2,
					$c_temp3, $c_temp4,
					$c_temp5, b, buffer_size, buf)
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
		do
			!! file.make_open_read (f_name);
			reset;
			char_buffered_number := 0;
			source_is_file := true;
			source_size := file.count;
			initialize;
			reset_data
		end; 

	set_string (s: STRING) is
			-- Use `s' as the input string.
		do
			string := s;
			reset;
			char_buffered_number := 0;
			source_is_file := false;
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
		local
			c_temp1, c_temp2, c_temp3, c_temp4, c_temp5: ANY
		do
			c_temp2 := buffer.to_c;
			c_temp3 := line_nb_array.to_c;
			c_temp4 := column_nb_array.to_c;
			c_temp5 := mask.to_c;
			if source_is_file then
				char_buffered_number := char_buffered_number
				+ fill_buf (file.file_pointer, $c_temp2,
				$c_temp3, $c_temp4,
				$c_temp5, b, buffer_size, buffer_size);
			else
				c_temp1 := string.to_c;
				char_buffered_number := char_buffered_number
				+ fill_f_s ($c_temp1, $c_temp2,
				$c_temp3, $c_temp4,
				$c_temp5, b, buffer_size, buffer_size)
			end
		end; 

	fill_whole_buffer is
			-- Fill with new characters.
		do
			fill_buffer (buffer_size)
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

	initialize is
			-- Set buffers
		deferred
		end;

	reset_data is
			-- Initialize datas when set_file or set_string is used.
		deferred
		end 

	reset is
		external
			"C"
		end; 

	fill_f_s (str: POINTER; buf, line_nb_ar, col_nb_ar, mk: POINTER;
				b, buf_sz, buf_end: INTEGER): INTEGER is
		external
			"C"
		end; 

	fill_buf (fp: POINTER; buf, line_nb_ar, col_nb_ar, mk: POINTER;
				b, buf_sz, buf_end: INTEGER): INTEGER is
		external
			"C"
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
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
