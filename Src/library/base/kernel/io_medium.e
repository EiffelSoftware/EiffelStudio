indexing

	description:

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class IO_MEDIUM inherit


feature -- Access

	name: STRING
			-- medium name
		deferred
		end;

feature -- Output 

	new_line is
			-- Write a new line character to medium
		require
			extendible: extendible
		deferred
		end;

	putstring (s: STRING) is
			-- Write `s' to medium
		require
			extendible: extendible
		deferred
		end;

	putchar (c: CHARACTER) is
			-- Write `c' to medium
		require
			extendible: extendible
		deferred
		end;

	putreal (r: REAL) is
			-- Write ASCII value of `r' to medium
		require
			extendible: extendible
		deferred
		end;

	putint (i: INTEGER) is
			-- Write ASCII value of `i' to medium.
		require
			extendible: extendible
		deferred
		end;
	
	putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' to medium.
		require
			extendible: extendible
		deferred
		end;
	
	putdouble (d: DOUBLE) is
			-- Write ASCII value of `d' to medium.
		require
			extendible: extendible
		deferred
		end;
	
feature -- Status report

	lastchar: CHARACTER;
			-- Last character read

	laststring: STRING;
			-- Last string read

	lastint: INTEGER;
			-- Last integer read by `readint'

	lastreal: REAL;
			-- Last real read by `readreal'

	lastdouble: DOUBLE;
			-- Last double read by `readdouble'


	exists: BOOLEAN is
			-- Does medium exist?
		deferred
		end;

	is_readable: BOOLEAN is
			-- Is medium readable?
		require
			handle_exists: exists
		deferred
		end;

	is_executable: BOOLEAN is
			-- Is medium executable?
		require
			handle_exists: exists
		deferred
		end;

	is_writable: BOOLEAN is
			-- Is medium writable?
		require
			descriptor_exists: exists
		deferred
		end;

	readable: BOOLEAN is
		require
			descriptor_exists: exists
		deferred
		end;

	extendible: BOOLEAN is
			-- May new items be added?
		deferred
		end;


	close is
			-- Close medium.
		deferred
		end;


feature -- Input

	readreal is
			-- Read a new real.
			-- Make result available in `lastreal'.
		require
			is_readable: readable;
		deferred
		end;

	readdouble is
			-- Read a new double.
			-- Make result available in `lastdouble'.
		require
			is_readable: readable;
		deferred
		end;

	readchar is
			-- Read a new character.
			-- Make result available in `lastchar'.
		require
			is_readable: readable;
		deferred
		end;

	readint is
			-- Read a new integer.
			-- Make result available in `lastint'.
		require
			is_readable: readable;
		deferred
		end;

	readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file is encountered.
			-- Make result available in `laststring'.
		require
			is_readable: readable;
		deferred
		end;

	readline is
			-- read a line of characters until a new line or
			-- end of medium
		require
			is_readable: readable;
		deferred
		end;
			

feature -- handle to medium

	handle: INTEGER is
		deferred
		end;


end -- class IO_MEDIUM


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
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
