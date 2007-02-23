indexing

	description: "Implementation of the STORABLE mechanism with streams."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	STREAM

inherit
	IO_MEDIUM

create
	make,
	make_with_size

feature -- Initialization

	make is
			-- Create stream object with a default_size of 100 bytes
		do
			buffer_size := 200
			create_c_buffer
		end

	make_with_size (n: INTEGER) is
			-- Create stream object with a default_size of `n' bytes
		do
			buffer_size := n
			create_c_buffer
		end

feature -- Status report

	support_storable: BOOLEAN is True
			-- Can medium be used to store an Eiffel structure?

feature -- Access

	item: POINTER
			-- Direct access to stored/retrieved data

	buffer: POINTER is
			-- C buffer correspond to the Eiffel STREAM
		obsolete
			"Use `item' instead to directly access stored/retrieved data"
		do
			Result := default_pointer
		end

	buffer_size: INTEGER
			-- Buffer's size.

	object_stored_size: INTEGER
			-- Size of last stored object.

	create_c_buffer is
			-- Create the C memory corresponding to the C
			-- buffer.
		do
			item := item.memory_alloc (buffer_size)
		end

	retrieved: ANY is
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		local
			l_formatter: BINARY_FORMATTER
			l_mem: SYSTEM_MEMORY_STREAM
			l_buf: NATIVE_ARRAY [NATURAL_8]
		do
			create l_buf.make (buffer_size)
			{MARSHAL}.copy (item, l_buf, 0, buffer_size)
			create l_mem.make_from_buffer (l_buf)
			create l_formatter.make
			Result ?= l_formatter.deserialize (l_mem)
			l_mem.close
		end

feature -- Element change

	basic_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		local
			l_formatter: BINARY_FORMATTER
			l_mem: SYSTEM_MEMORY_STREAM
			l_size: INTEGER
		do
			create l_mem.make (0)
			create l_formatter.make
			l_formatter.serialize (l_mem, object)
			l_size := l_mem.length.to_integer_32
			if l_size > buffer_size then
				buffer_size := l_size
				item := item.memory_realloc (l_size)
			end
			{MARSHAL}.copy (l_mem.get_buffer, 0, item, l_size)
			l_mem.close
		end

	general_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		do
			basic_store (object)
		end

	independent_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			basic_store (object)
		end

	set_additional_size (new_size: INTEGER) is
			-- Set `new_size' to BUFFER_SIZE, internal value used to
			-- increment `buffer_size' during storable operations.
		do
		end

feature -- Status report

	exists: BOOLEAN is True
			-- Stream exists in any cases.

	is_open_read: BOOLEAN is True
			-- Stream opens for input.

	is_open_write: BOOLEAN is True
			-- Stream opens for output.

	is_readable: BOOLEAN is True

	is_executable: BOOLEAN is
			-- Is stream executable?
		do
			Result := False
		end

	is_writable: BOOLEAN is True
			-- Stream is writable.

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
		end

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := True
		end

	is_closed: BOOLEAN
			-- Is the I/O medium open

feature -- Status setting

	close is
			-- Close medium.
		do
			is_closed := True
			item.memory_free
			item := default_pointer
		end

feature -- Output

	put_new_line, new_line is
			-- Write a new line character to medium
		require else
			stream_exists: exists
		do
			put_character ('%N')		
		end

	put_string, putstring (s: STRING) is
			-- Write `s' to medium.
		do
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' to medium.
		do
		end

	put_real, putreal (r: REAL) is
			-- Write `r' to medium.
		do
		end

	put_integer, putint, put_integer_32 (i: INTEGER) is
			-- Write `i' to medium.
		do
		end
		
	put_integer_8 (i: INTEGER_8) is
			-- Write `i' to medium.
		do			
		end
		
	put_integer_16 (i: INTEGER_16) is
			-- Write `i' to medium.
		do			
		end

	put_integer_64 (i: INTEGER_64) is
			-- Write `i' to medium.
		do			
		end
		
	put_natural_8 (i: NATURAL_8) is
			-- Write `i' to medium.
		do			
		end

	put_natural_16 (i: NATURAL_16) is
			-- Write `i' to medium.
		do			
		end
		
	put_natural, put_natural_32 (i: NATURAL_32) is
			-- Write `i' to medium.
		do			
		end
		
	put_natural_64 (i: NATURAL_64) is
			-- Write `i' to medium.
		do			
		end		

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' to medium.
		do
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' to medium.
		do
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		do
		end

feature -- Input

	read_real, readreal is
			-- Read a new real.
			-- Make result available in `last_real'.
		do
		end

	read_double, readdouble is
			-- Read a new double.
			-- Make result available in `last_double'.
		do
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		do
		end

	read_integer, readint, read_integer_32 is
			-- Read a new integer.
			-- Make result available in `last_integer'.
		do
		end

	read_integer_8 is
			-- Read a new 8-bit integer.
			-- Make result available in `last_integer_8'.
		do
		end

	read_integer_16 is
			-- Read a new 16-bit integer.
			-- Make result available in `last_integer_16'.
		do
		end		
		
	read_integer_64 is
			-- Read a new 64-bit integer.
			-- Make result available in `last_integer_64'.
		do
		end
		
	read_natural_8 is
			-- Read a new 8-bit natural.
			-- Make result available in `last_natural_8'.
		do
		end

	read_natural_16 is
			-- Read a new 16-bit natural.
			-- Make result available in `last_natural_16'.
		do
		end		

	read_natural, read_natural_32 is
			-- Read a new 32-bit natural.
			-- Make result available in `last_natural'.
		do
		end
		
	read_natural_64 is
			-- Read a new 64-bit natural.
			-- Make result available in `last_natural_64'.
		do
		end
		
	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of medium is encountered.
			-- Make result available in `last_string'.
		do
		end

	read_line, readline is
			-- Read characters until a new line or
			-- end of medium.
			-- Make result available in `last_string'.
		do
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		do
		end

feature {NONE} -- Not exported

	name: STRING is
			-- Not meaningful
		do
		end

	handle: INTEGER is
			-- Handle to medium
		do
		end

	handle_available: BOOLEAN is
			-- Is the handle available after class has been
			-- created?
		do
		end

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



end -- class STREAM


