indexing

	description:
		"Files, viewed as persistent sequences of bytes"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RAW_FILE

inherit
	FILE
		rename
			index as position
		redefine
			read_stream,
			readstream,
			read_character,
			readchar,
			put_string,
			putstring,
			put_character,
			putchar,
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
		end

feature -- Output

	put_integer_8 (i: INTEGER_8) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_integer_8 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 1)
		end

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_integer_32 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 4)
		end

	put_integer_16 (i: INTEGER_16) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_integer_16 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 2)
		end

	put_integeR_64 (i: INTEGER_64) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_integer_64 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 8)
		end

	put_natural_8 (i: NATURAL_8) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_natural_8 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 1)
		end

	put_natural_16 (i: NATURAL_16) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_natural_16 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 2)
		end

	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_natural_32 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 4)
		end

	put_natural_64 (i: NATURAL_64) is
			-- Write binary value of `i' at current position.
		do
			internal_managed_pointer.put_natural_64 (i, 0)
			put_managed_pointer (internal_managed_pointer, 0, 8)
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write binary value of `b' at current position.
		do
			if b then
				put_character ('%/001/')
			else
				put_character ('%U')
			end
		end

	put_real, putreal (r: REAL) is
			-- Write binary value of `r' at current position.
		do
			internal_managed_pointer.put_real_32 (r, 0)
			put_managed_pointer (internal_managed_pointer, 0, {PLATFORM}.real_32_bytes)
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write binary value `d' at current position.
		do
			internal_managed_pointer.put_real_64 (d, 0)
			put_managed_pointer (internal_managed_pointer, 0, {PLATFORM}.real_64_bytes)

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
				internal_stream.write_byte ({MARSHAL}.read_byte (p + i))
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
			internal_stream.write (byte_array, 0, byte_array.count)
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at current position.
		do
			internal_stream.write_byte (c.code.to_integer.to_natural_8)
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
			new_count := internal_stream.read (str_area, 0, nb_char)

			check
				valid_new_count: new_count <= nb_char
			end

			from
				str_area_index := 0
			until
				str_area_index = new_count
			loop
				last_string.append_character (str_area.item (str_area_index).to_character_8)
				str_area_index := str_area_index + 1
			end
		end

	read_integer, readint, read_integer_32 is
			-- Read the binary representation of a new integer
			-- from file. Make result available in `last_integer'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 4)
			last_integer := internal_managed_pointer.read_integer_32 (0)
		end

	read_integer_8 is
			-- Read the binary representation of a new 8-bit integer
			-- from file. Make result available in `last_integer_8'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 1)
			last_integer_8 := internal_managed_pointer.read_integer_8 (0)

		end

	read_integer_16 is
			-- Read the binary representation of a new 16-bit integer
			-- from file. Make result available in `last_integer_16'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 2)
			last_integer_16 := internal_managed_pointer.read_integer_16 (0)
		end

	read_integer_64 is
			-- Read the binary representation of a new 64-bit integer
			-- from file. Make result available in `last_integer_64'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 8)
			last_integer_64 := internal_managed_pointer.read_integer_64 (0)
		end

	read_natural_8 is
			-- Read the binary representation of a new 8-bit natural
			-- from file. Make result available in `last_natural_8'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 1)
			last_natural_8 := internal_managed_pointer.read_natural_8 (0)
		end

	read_natural_16 is
			-- Read the binary representation of a new 16-bit natural
			-- from file. Make result available in `last_natural_16'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 2)
			last_natural_16 := internal_managed_pointer.read_natural_16 (0)
		end

	read_natural, read_natural_32 is
			-- Read the binary representation of a new 32-bit natural
			-- from file. Make result available in `last_natural'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 4)
			last_natural := internal_managed_pointer.read_natural_32 (0)
		end

	read_natural_64 is
			-- Read the binary representation of a new 64-bit natural
			-- from file. Make result available in `last_natural_64'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, 8)
			last_natural_64 := internal_managed_pointer.read_natural_64 (0)
		end

	read_real, readreal is
			-- Read the binary representation of a new real
			-- from file. Make result available in `last_real'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, {PLATFORM}.real_32_bytes)
			last_real := internal_managed_pointer.read_real_32 (0)
		end

	read_double, readdouble is
			-- Read the binary representation of a new double
			-- from file. Make result available in `last_double'.
		do
			read_to_managed_pointer (internal_managed_pointer, 0, {PLATFORM}.real_64_bytes)
			last_double := internal_managed_pointer.read_real_64 (0)
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		local
		  	a_code: INTEGER
		do
		  	a_code := internal_stream.read_byte
		  	if a_code = - 1 then
				internal_end_of_file := True
		  	else
				last_character := a_code.to_character_8
		  	end
		end

	read_data (p: POINTER; nb_bytes: INTEGER) is
			-- Read a string of at most `nb_bytes' bound bytes
			-- or until end of file.
			-- Make result available in `p'.
		obsolete
			"Use read_to_managed_pointer instead."
		local
			i, l_i, l_read: INTEGER
		do
			from
				i := 0
				l_i := 0
			until
				i > (nb_bytes - 1) or l_i = -1
			loop
				l_i := internal_stream.read_byte
				if l_i /= -1 then
					l_read := l_read + 1
					{MARSHAL}.write_byte (p + i, l_i.to_natural_8)
					i := i + 1
				end
			end
			bytes_read := l_read
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
			Result := internal_stream.read (str_area, 0, nb)
			from
				i := 0
				j := pos
			until
				i >= Result
			loop
				a_string.put (str_area.item (i).to_character_8, j)
				i := i + 1
				j := j + 1
			end
		end

	c_open_modifier: INTEGER is 32768
			-- Open the file in binary mode.

	internal_managed_pointer: MANAGED_POINTER is
			-- Managed pointer for internal use
		do
			if mgn_ptr = Void then
				create mgn_ptr.make (64)
			end
			Result := mgn_ptr
		end

	mgn_ptr: MANAGED_POINTER
			-- Managed pointer for internal use	

invariant

	not_plain_text: not is_plain_text

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class RAW_FILE



