indexing
	description: "Implementation of the STORABLE mechanism with streams."
	date: "$Date$"
	revision: "$Revision$"

class 
	STREAM

inherit
	IO_MEDIUM

creation
	make_stream

feature -- Initialization

		make_stream is
				-- Create stream object with a default_size of 100 bytes
			do
				buffer_size := 100
				create_c_buffer
			end

feature -- Status report

		support_storable: BOOLEAN is False
				-- Can medium be used to store an Eiffel structure?

feature -- Access

		name: STRING

		buffer: POINTER;
				-- C buffer correspond to the Eiffel STREAM.

		buffer_size: INTEGER
				-- Buffer's size.

		create_c_buffer is
				-- Create the C memory corresponding to the C
				-- buffer.
			do
				buffer := c_malloc (buffer_size)
			end

		retrieved: ANY is
				-- Retrieved object structure
				-- To access resulting object under correct type,
				-- use assignment attempt.
				-- Will raise an exception (code `Retrieve_exception')
				-- if content is not a stored Eiffel structure.
			do
				Result := c_retrieved (buffer, buffer_size)
			end

feature -- Element change

	basic_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		do
			buffer_size := c_stream_basic_store (buffer, buffer_size, $object)
		end;

	general_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		do
			buffer_size := c_stream_general_store (buffer, buffer_size, $object)
		end

	independent_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			buffer_size := c_stream_independent_store (buffer, buffer_size, $object)
		end

feature {NONE} -- Implementation
 
	c_stream_basic_store (stream_buffer: POINTER; stream_buffer_size: INTEGER; object: POINTER): INTEGER is
			-- Store object structure reachable form current object
			-- Return new size of `buffer'.
		external
			"C | %"eif_store.h%""
		alias
			"stream_estore"
		end;

	c_stream_general_store (stream_buffer: POINTER; stream_buffer_size: INTEGER; object: POINTER): INTEGER is
			-- Store object structure reachable form current object
			-- Return new size of `buffer'.
		external
			"C | %"eif_store.h%""
		alias
			"stream_eestore"
		end;

	c_stream_independent_store (stream_buffer: POINTER; stream_buffer_size: INTEGER; object: POINTER): INTEGER is
			-- Store object structure reachable form current object
			-- Return new size of `buffer'.
		external
			"C |%"eif_store.h%""
		alias
			"stream_sstore"
		end;

	c_retrieved (stream_buffer: POINTER; stream_buffer_size: INTEGER): ANY is
			-- Object structured retrieved from stream of pointer
			-- `stream_ptr'
		external
			"C | %"eif_retrieve.h%""
		alias
			"stream_eretrieve"	
		end;
	
	c_malloc (size: INTEGER): POINTER is
		external
			"C | %"eif_store.h%""
		alias
			"stream_malloc"
		end;

  
feature -- Status report

	handle: INTEGER is
			-- Handle to medium
		do
		end

	handle_available: BOOLEAN is
			-- Is the handle available after class has been
			-- created?
		do
		end

	exists: BOOLEAN is
			-- Does stream exist?
		do
			--Result := 
		end

	is_open_read: BOOLEAN; 
			-- Is stream opened for input

	is_open_write: BOOLEAN;
			-- Is this stream opened for output

	is_readable: BOOLEAN is
			-- Is stream a readable?
		do
			Result := True
		end;

	is_executable: BOOLEAN is
			-- Is stream executable?
		do
			Result := False
		end

	is_writable: BOOLEAN is
			-- Is stream writable?
		do
			Result := True
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
		end

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := True
		end

	is_closed: BOOLEAN is
			-- Is the I/O medium open
		do
		end


feature -- Status setting

	close is
			-- Close medium.
		do
		end

feature -- Output

	put_new_line,new_line is
			-- Write a new line character to medium
		require else
			stream_exists: exists;
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

	put_integer, putint (i: INTEGER) is
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

	read_integer, readint is
			-- Read a new integer.
			-- Make result available in `last_integer'.
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

feature {STREAM} -- Implementation

	mode: INTEGER;
			-- Input-output mode
	Closed_stream: INTEGER is 0;
	Input_stream: INTEGER is 1;
	Output_stream: INTEGER is 2;
	
	set_input_mode is
			-- Define stream mode as input.
		do
			mode := Input_stream
		end;

	set_output_mode is
			-- Deffine stream mode as output.
		do
			mode := Output_stream
		end;

invariant

	valid_mode: Closed_stream <= mode and mode <= Output_stream
	name_exists: name /= Void;
	name_not_empty: not name.empty

end -- class STREAM

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
