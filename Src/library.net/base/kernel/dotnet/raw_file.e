indexing

	description:
		"Files, viewed as persistent sequences of bytes"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class RAW_FILE

inherit
	FILE
		rename
			index as position,
			reader as text_reader,
			writer as text_writer
		redefine
			read_stream, 
			readstream,
			read_character,
			readchar,
			read_to_managed_pointer,
			put_string,
			putstring,
			put_character,
			putchar,
			put_managed_pointer,
			close
		end

create

	make, make_open_read, make_open_write, make_open_append,
	make_open_read_write, make_create_read_write,
	make_open_read_append

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to an Eiffel structure?

feature -- Status setting

	close is
			-- Free allocated resources.
		do
			Precursor {FILE}
			internal_breader := Void
			internal_bwriter := Void
		end

feature -- Output

	put_integer, putint (i: INTEGER) is
			-- Write binary value of `i' at current position.
		do
			writer.write (i)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write binary value of `b' at current position.
		do
			writer.write (b)
		end

	put_real, putreal (r: REAL) is
			-- Write binary value of `r' at current position.
		do
			writer.write_real (r)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write binary value `d' at current position.
		do
			writer.write_double (d)
		end

	put_data (p: POINTER; size: INTEGER) is
			-- Put `data' of length `size' pointed by `p' at
			-- current position.
		obsolete
			"Use put_managed_pointer instead."
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i > (size - 1)
			loop
				writer.write ({MARSHAL}.read_byte (p + i))
				i := i + 1
			end
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		local
			i: INTEGER
		do
			from
				i := start_pos
			until
				i = nb_bytes
			loop
				writer.write (p.read_natural_8 (i))
				i := i + 1
			end
		end

	put_string, putstring (s: STRING) is
			-- 
		local
			byte_array: NATIVE_ARRAY [NATURAL_8]
			str_index: INTEGER
		do
			create byte_array.make (s.count)
			from
				str_index := 0
			until
				str_index = byte_array.count
			loop
				byte_array.put (str_index, s.item (str_index + 1).code.to_natural_8)
				str_index := str_index + 1
			end
			writer.write (byte_array)
		end
		
	put_character, putchar (c: CHARACTER) is
			-- Write `c' at current position.
		do
			writer.write (c.code.to_integer.to_natural_8)
		end

feature -- Input

	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		require else
			is_readable: file_readable
		local
			new_count: INTEGER
			str_area: NATIVE_ARRAY [NATURAL_8]
			str_area_index: INTEGER
		do
			if last_string = Void then
				create_last_string (nb_char)
			else
				last_string.clear_all
				last_string.grow (nb_char)
			end
			create str_area.make (nb_char)
			new_count := reader.read (str_area, 0, nb_char)
			
			check
				valid_new_count: new_count <= nb_char
			end
			
			from
				str_area_index := 0
			until
				str_area_index = new_count
			loop
				last_string.append_character (str_area.item (str_area_index).to_character)
				str_area_index := str_area_index + 1
			end
			internal_end_of_file := reader.peek_char = -1
		end

	read_integer, readint is
			-- Read the binary representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			last_integer := reader.read_int_32
			internal_end_of_file := reader.peek_char = -1
		end

	read_real, readreal is
			-- Read the binary representation of a new real
			-- from file. Make result available in `last_real'.
		do
			last_real := reader.read_single
			internal_end_of_file := reader.peek_char = -1
		end

	read_double, readdouble is
			-- Read the binary representation of a new double
			-- from file. Make result available in `last_double'.
		do
			last_double := reader.read_double
			internal_end_of_file := reader.peek_char = -1
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
		  	a_code: INTEGER
		do
		  	a_code := reader.read
		  	if a_code = - 1 then
				internal_end_of_file := True
		  	else
				last_character := a_code.to_character
		  	end
		end
	
	read_data (p: POINTER; nb_bytes: INTEGER) is
			-- Read a string of at most `nb_bytes' bound bytes
			-- or until end of file.
			-- Make result available in `p'.
		obsolete
			"Use read_to_managed_pointer instead."
		local
			i: INTEGER
			byte: NATURAL_8
		do
			from
				i := 0
			until
				i > (nb_bytes - 1)
			loop
				byte := reader.read_byte
				{MARSHAL}.write_byte (p + i, byte)
				i := i + 1
			end
			internal_end_of_file := reader.peek_char = -1
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		require else
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			is_readable: file_readable
		local
			i: INTEGER
		do
			from
				i := start_pos
			until
				i = nb_bytes
			loop
				p.put_natural_8 (reader.read_byte, i)
				i := i + 1
			end
			internal_end_of_file := reader.peek_char = -1
		end

feature {NONE} -- Implementation

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER is
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		local
			i, j: INTEGER
			str_area: NATIVE_ARRAY [NATURAL_8]
		do
			create str_area.make (nb)
			Result := reader.read (str_area, 0, nb)
			internal_end_of_file := reader.peek_char = -1
			from
				i := 0
				j := pos
			until
				i >= Result
			loop
				a_string.put (str_area.item (i).to_character, j)
				i := i + 1
				j := j + 1
			end
		end

	c_open_modifier: INTEGER is 32768
			-- Open the file in binary mode.

	writer: BINARY_WRITER is
			-- What is used to write in the file.
		do
			if internal_bwriter = Void then
				create internal_bwriter.make_from_output (internal_stream)
			end
			Result := internal_bwriter
		end

	internal_bwriter: BINARY_WRITER
			-- Once per opening value of `writer'.

	reader: BINARY_READER is
			-- What is used to read in the file.
		do
			if internal_breader = Void then
				create internal_breader.make_from_input (internal_stream)
			end
			Result := internal_breader
		end

	internal_breader: BINARY_READER
			-- Once per opening value of `reader'.

invariant

	not_plain_text: not is_plain_text

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class RAW_FILE



