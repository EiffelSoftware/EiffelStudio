indexing

	description:
		"Any medium that can perform input and/or output"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class IO_MEDIUM

inherit
	MEMORY
		export
		 {NONE} all
		redefine
			dispose
		end

	STRING_HANDLER

feature -- Access

	name: STRING is
			-- Medium name
		deferred
		end

	retrieved: ANY is
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		require
			exists: exists
			is_open_read: is_open_read
			support_storable: support_storable
		deferred
		ensure
			Result_exists: Result /= Void
		end

feature -- Element change

	basic_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		require
			object_not_void: object /= Void
			exists: exists
			is_open_write: is_open_write
			support_storable: support_storable
		deferred
		end
 
	general_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		require
			object_not_void: object /= Void
			exists: exists
			is_open_write: is_open_write
			support_storable: support_storable
		deferred
		end
 
	independent_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		require
			object_not_void: object /= Void
			exists: exists
			is_open_write: is_open_write
			support_storable: support_storable
		deferred
		end
 
feature -- Status report

	handle: INTEGER is
			-- Handle to medium
		require
			valid_handle: handle_available
		deferred
		end

	handle_available: BOOLEAN is
			-- Is the handle available after class has been
			-- created?
		deferred
		end

	is_plain_text: BOOLEAN is
			-- Is file reserved for text (character sequences)?
		do
		end

	last_character: CHARACTER
			-- Last character read by `read_character'

	last_string: STRING
			-- Last string read

	last_integer: INTEGER
			-- Last integer read by `read_integer'

	last_real: REAL
			-- Last real read by `read_real'

	last_double: DOUBLE
			-- Last double read by `read_double'

	exists: BOOLEAN is
			-- Does medium exist?
		deferred
		end

	is_open_read: BOOLEAN is
			-- Is this medium opened for input
		deferred
		end

	is_open_write: BOOLEAN is
			-- Is this medium opened for output
		deferred
		end

	is_readable: BOOLEAN is
			-- Is medium readable?
		require
			handle_exists: exists
		deferred
		end

	is_executable: BOOLEAN is
			-- Is medium executable?
		require
			handle_exists: exists
		deferred
		end

	is_writable: BOOLEAN is
			-- Is medium writable?
		require
			handle_exists: exists
		deferred
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		require
			handle_exists: exists
		deferred
		end

	extendible: BOOLEAN is
			-- May new items be added?
		deferred
		end

	is_closed: BOOLEAN is
			-- Is the I/O medium open
		deferred
		end

	support_storable: BOOLEAN is
			-- Can medium be used to store an Eiffel object?
		deferred
		end

feature -- Status setting

	close is
			-- Close medium.
		require
			medium_is_open: not is_closed
		deferred
		end

feature -- Removal

	dispose is
			-- Ensure this medium is closed when garbage collected.
		do
			if not is_closed then
				close
			end
		end

feature -- Output

	put_new_line, new_line is
			-- Write a new line character to medium
		require
			extendible: extendible
		deferred
		end

	put_string, putstring (s: STRING) is
			-- Write `s' to medium.
		require
			extendible: extendible
			non_void: s /= Void
		deferred
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' to medium.
		require
			extendible: extendible
		deferred
		end

	put_real, putreal (r: REAL) is
			-- Write `r' to medium.
		require
			extendible: extendible
		deferred
		end

	put_integer, putint (i: INTEGER) is
			-- Write `i' to medium.
		require
			extendible: extendible
		deferred
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' to medium.
		require
			extendible: extendible
		deferred
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' to medium.
		require
			extendible: extendible
		deferred
		end

feature -- Input

	read_real, readreal is
			-- Read a new real.
			-- Make result available in `last_real'.
		require
			is_readable: readable
		deferred
		end

	read_double, readdouble is
			-- Read a new double.
			-- Make result available in `last_double'.
		require
			is_readable: readable
		deferred
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		require
			is_readable: readable
		deferred
		end

	read_integer, readint is
			-- Read a new integer.
			-- Make result available in `last_integer'.
		require
			is_readable: readable
		deferred
		end

	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of medium is encountered.
			-- Make result available in `last_string'.
		require
			is_readable: readable
		deferred
		end

	read_line, readline is
			-- Read characters until a new line or
			-- end of medium.
			-- Make result available in `last_string'.
		require
			is_readable: readable
		deferred
		end

feature -- Obsolete

	lastchar: CHARACTER is
			-- Last character read by `read_character'
		do
			Result := last_character
		end

	laststring: STRING is
			-- Last string read
		do
			Result := last_string
		end

	lastint: INTEGER is
			-- Last integer read by `read_integer'
		do
			Result := last_integer
		end

	lastreal: REAL is
			-- Last real read by `read_real'
		do
			Result := last_real
		end

	lastdouble: DOUBLE is
			-- Last double read by `read_double'
		do
			Result := last_double
		end

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

end -- class IO_MEDIUM


