--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Notion of files

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class FILE inherit

	UNBOUNDED;

	SEQUENCE [CHARACTER]
		undefine
			empty
		end

feature -- Access

	name: STRING;
			-- File name

	item: CHARACTER is
			-- Current item
		do
			Result := lastchar
		end;

	readint is
			-- Read a new integer from `Current'.
			-- Make result available in `lastint'.
		require
			is_readable: file_readable;
		deferred
		end;

	readreal is
			-- Read a new real from `Current'.
			-- Make result available in `lastreal'.
		require
			is_readable: file_readable;
		deferred
		end;

	readdouble is
			-- Read a new double from `Current'.
			-- Make result available in `lastdouble'.
		require
			is_readable: file_readable;
		deferred
		end;

	readchar is
			-- Read a new character from `Current'.
			-- Make result available in `lastchar'.
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

feature -- Insertion

	add (v: CHARACTER) is
			-- Include `v' in `Current'.
		do
			putchar (v)
		end;

	putstring (s: STRING) is
			-- Write `s' at current position.
		require
			extensible
		deferred
		end;

	putchar (c: CHARACTER) is
			-- Write `c' at current position.
		require
			extensible
		deferred
		end;

	putreal (r: REAL) is
			-- Write ASCII value of `r' at current position.
		require
			extensible
		deferred
		end;

	putint (i: INTEGER) is
			-- Write ASCII value of `i' at current position.
		require
			extensible
		deferred
		end;
	
	putbool (b: BOOLEAN) is
			-- Write ASCII value of `b' at current position.
		require
			extensible
		deferred
		end;
	
	putdouble (d: DOUBLE) is
			-- Write ASCII value of `d' at current position.
		require
			extensible
		deferred
		end;
	
	file_writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := mode >= Write_file
		end;

	extensible: BOOLEAN is
			-- May new items be added to `Current'?
		do
			Result := mode >= Write_file
		end;

feature -- Deletion

	file_contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := mode >= Write_file and contractable
		end;

	contractable: BOOLEAN is
			-- Is there an item to be removed from `Current'?
		do
			Result := not off
		end

feature -- File handling

	open_read is
			-- Open `Current' in read mode.
		require
			is_closed: is_closed;
		deferred
		ensure
			opened_for_reading: is_open_read;
		end;

	open_write is
			-- Open `Current' in write mode and
			-- create a file `name' as a physical
			-- representation if non-existent.
		require
			is_closed: is_closed;
		deferred
		ensure
			opened_for_writing: is_open_write;
			file_exists: exists;
		end;

	open_append is
			-- Open `Current' in append mode and
			-- create a file `name' as a physical
			-- representation if non-existent.
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

	delete is
			-- Forget link between `Current' and (physical) file.
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

feature -- Status

	exists: BOOLEAN is
			-- Does (physical) file exist?
		deferred
		ensure
	--		mode = old mode
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

feature {UNIX_FILE, UNIX_STD, FILE} -- Status

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

feature -- Number of elements

	count: INTEGER is
			-- Size of `Current' in bytes
		deferred
		end;

feature {NONE}
		-- deferred features inherited from COLLECTION and ACTIVE
		-- which have no sense in class FILE

	remove is
			-- Remove current item.
		require else
			is_contractable: file_contractable
		do
		ensure then
			not full;
		--  count = (old count - 1)
		end;

	replace (v: like item) is
			-- Replace current item by `v'.
		require else
			is_writable: file_writable
		do
		ensure then
			item = v;
		--  count = old count
		end;

	remove_item	(v: like item) is
			-- Remove `v' from `Current'.
		require else
			is_contractable: file_contractable
		do
		ensure then
		--  count <= old count
		end;

end -- class FILE
