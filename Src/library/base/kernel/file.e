indexing

	description:
		"Sequential files, viewed as persistent sequences of characters";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FILE inherit

	UNBOUNDED [CHARACTER];

	SEQUENCE [CHARACTER]
		undefine
			prune
		end

feature -- Access

	name: STRING;
			-- File name

	item: CHARACTER is
			-- Current item
		do
			Result := lastchar
		end;

feature -- Measurement

	count: INTEGER is
			-- Size in bytes
		deferred
		end;

feature -- Element change

	extend (v: CHARACTER) is
			-- Include `v' at end.
		do
			putchar (v)
		end;

	new_line is
			-- Write a new line character at current position.
		require
			extendible
		deferred
		end;

	putstring (s: STRING) is
			-- Write `s' at current position.
		require
			extendible
		deferred
		end;

	putchar (c: CHARACTER) is
			-- Write `c' at current position.
		require
			extendible
		deferred
		end;

	putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		require
			extendible
		deferred
		end;

	putint (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		require
			extendible
		deferred
		end;
	
	putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		require
			extendible
		deferred
		end;
	
	putdouble (d: DOUBLE) is
			-- Write ASCII value of `d' at current position.
		require
			extendible
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

	file_readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := (mode >= Read_Write_file or mode = Read_file)
						and readable
		end;

	exists: BOOLEAN is
			-- Does (physical) file exist?
		deferred
		ensure
			mode = old mode
		end;

	is_readable: BOOLEAN is
			-- Is file readable?
		require
			file_descriptor_exists: exists
		deferred
		end;

	is_executable: BOOLEAN is
			-- Is file executable?
		require
			file_descriptor_exists: exists
		deferred
		end;

	is_writable: BOOLEAN is
			-- Is file writable?
		require
			file_descriptor_exists: exists
		deferred
		end;

	is_creatable: BOOLEAN is
			-- Is file creatable in parent directory?
		deferred
		end;

	is_closed: BOOLEAN is
			-- Is file closed?
		do
			Result := mode = Closed_file
		end;

	is_open_read: BOOLEAN is
			-- Is file open for reading?
		do
			Result := mode = Read_file
		end;

	is_open_write: BOOLEAN is
			-- Is file open for writing?
		do
			Result := mode = Write_file
		end;

	is_open_append: BOOLEAN is
			-- Is file open for appending?
		do
			Result := mode = Append_file
		end;

	file_writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := mode >= Write_file
		end;

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := mode >= Write_file
		end;

	file_prunable: BOOLEAN is
			-- May items be removed?
		do
			Result := mode >= Write_file and prunable
		end;

	full: BOOLEAN is false;
			-- Is structure filled to capacity?

feature -- Status setting

	open_read is
			-- Open in read mode.
		require
			is_closed: is_closed;
		deferred
		ensure
			opened_for_reading: is_open_read;
		end;

	open_write is
			-- Open in write mode and create a file of name `name'
			-- if none exists.
		require
			is_closed: is_closed;
		deferred
		ensure
			opened_for_writing: is_open_write;
			file_exists: exists;
		end;

	open_append is
			-- Open in append mode and create a file of name `name'
			-- if none exists.
		require
			is_closed: is_closed;
		deferred
		ensure
			opened_for_appending: is_open_append;
			file_exists: exists;
		end;

	close is
			-- Close file.
		deferred
		end;

feature -- Removal

	delete is
			-- Remove link with physical file.
		require
			file_exists: exists
		deferred
		end;

	reset (fn: STRING) is
			-- Change file name to `fn' and reset
			-- all (internal) information.
		require
			fn /= Void
		deferred
		ensure
			file_renamed: name = fn;
			file_closed: is_closed
		end;

feature -- Input

	readreal is
			-- Read a new real.
			-- Make result available in `lastreal'.
		require
			is_readable: file_readable;
		deferred
		end;

	readdouble is
			-- Read a new double.
			-- Make result available in `lastdouble'.
		require
			is_readable: file_readable;
		deferred
		end;

	readchar is
			-- Read a new character.
			-- Make result available in `lastchar'.
		require
			is_readable: file_readable;
		deferred
		end;

	readint is
			-- Read a new integer.
			-- Make result available in `lastint'.
		require
			is_readable: file_readable;
		deferred
		end;

	readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file is encountered.
			-- Make result available in `laststring'.
		require
			is_readable: file_readable;
		deferred
		end;

feature {NONE} -- Inapplicable

	go_to (r: CURSOR) is
			-- Move to position marked `r'.
		do
		end;

	replace (v: like item) is
			-- Replace current item by `v'.
		require else
			is_writable: file_writable
		do
		ensure then
			item = v;
		  	count = old count
		end;

	prunable: BOOLEAN is
			-- Is there an item to be removed?
		do
		end;

	remove is
			-- Remove current item.
		require else
			file_prunable: file_prunable
		do
		end;

	prune	(v: like item) is
			-- Remove an occurrence of `v' if any
		require else
			prunable: file_prunable
		do
		ensure then
		  	count <= old count
		end;

feature {FILE} -- Implementation

	mode: INTEGER;
			-- Input-output mode
			-- Possible values for mode are the following:

	Closed_file: INTEGER is 0;
	Read_file: INTEGER is 1;
	Write_file: INTEGER	is 2;
	Append_file: INTEGER is 3;
	Read_Write_file: INTEGER is 4;
	Append_Read_file: INTEGER is 5;

	set_read_mode is
			-- Define file mode as read.
		do
			mode := Read_file
		end;

	set_write_mode is
			-- Define file mode as write.
		do
			mode := Write_file
		end;

end -- class FILE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
