indexing

	description:
		"Directories, in the Unix sense, with creation and exploration features";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DIRECTORY

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

creation

	make, make_open_read

feature -- Initialization

	make (dn: STRING) is
			-- Create directory object for the directory
			-- of name `dn'.
		require
			string_exists: dn /= Void
		do
			name := dn;
			mode := Close_directory;
		end;

	make_open_read (dn: STRING) is
			-- Create directory object for the directory
			-- of name `dn' and open it for reading.
		require
			string_exists: dn /= Void
		do
			make (dn);
			open_read;
		end;

	create is
			-- Create a physical directory.
		require
			physical_not_exists: not exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_mkdir ($external_name);
		end;

feature -- Access

	readentry is
			-- Read next directory entry;
			-- make result available in `lastentry'.
			-- Make result void if all entries have been read.
		require
			is_opened: not is_closed
		do
			lastentry := dir_next (directory_pointer);
		end;

	name: STRING;
			-- Directory name

	has_entry (entry_name: STRING): BOOLEAN is
			-- Has directory the entry `entry_name'?
			-- The use of `dir_temp' is required not
			-- to change the position in the current
			-- directory entries list.
		require
			string_exists: entry_name /= Void;
		local
			ext_entry_name: ANY;
			dir_temp: DIRECTORY
		do
			!! dir_temp.make_open_read (name);
			ext_entry_name := entry_name.to_c;
			Result := dir_temp.dir_search (dir_temp.directory_pointer,
							$ext_entry_name) /= default_pointer;
			dir_temp.close
		end;

	open_read is
			-- Open directory `name' for reading.
		local
			external_name: ANY
		do
			external_name := name.to_c;
			directory_pointer := dir_open ($external_name);
			mode := Read_directory;
		end;

	close is
			-- Close directory.
		require
			is_open: not is_closed;
		do
			dir_close (directory_pointer);
			mode := Close_directory;
		end;

	start is
			-- Go to first entry of directory.
		require
			is_opened: not is_closed;
		do
			dir_rewind (directory_pointer);
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of entries in directory.
		require
			directory_exists: exists
		local
			dir_temp: DIRECTORY;
			counter: INTEGER
		do
			!! dir_temp.make_open_read (name);
			from
				dir_temp.start;
				dir_temp.readentry
			until
				dir_temp.lastentry = Void
			loop
				counter := counter + 1;
				dir_temp.readentry;
			end;
			Result := counter;
			dir_temp.close
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [STRING] is
			-- The entries, in sequential format.
		local
			dir_temp: DIRECTORY;
		do
			!! dir_temp.make_open_read (name);
			!! Result.make (count);
			from
				dir_temp.start;
				dir_temp.readentry
			until
				dir_temp.lastentry = Void
			loop
				Result.extend (dir_temp.lastentry);
				dir_temp.readentry
			end;
			dir_temp.close
		end;

feature -- Status report

	lastentry: STRING;
			-- Last entry read by `readentry'

	is_closed: BOOLEAN is
			-- Is current directory closed?
		do
			Result := mode = Close_directory;
		end;

	empty: BOOLEAN is
			-- Is directory empty?
		require
			directory_exists: exists
		do
			Result := (count = 0)
		end;

	exists: BOOLEAN is
			-- Does the directory exist?
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			Result := eif_dir_exists ($external_name)
		end;

	is_readable: BOOLEAN is
			-- Is the directory readable?
		require
			directory_exists: exists
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			Result := eif_dir_is_readable ($external_name)
		end;

	is_executable: BOOLEAN is
			-- Is the directory executable?
		require
			directory_exists: exists
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			Result := eif_dir_is_executable ($external_name)
		end;

	is_writable: BOOLEAN is
			-- Is the directory writable?
		require
			directory_exists: exists
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			Result := eif_dir_is_writable ($external_name)
		end;

feature -- Removal

	delete is
			-- Delete directory if empty
		require
			directory_exists: exists
			empty_directory: empty
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			eif_dir_delete ($external_name)
		end

	dispose is
			-- Ensure this medium is closed when garbage collected.
		do
			if not is_closed then
				close;
			end;
		end;

feature -- Obsolete

	sequential_representation: ARRAYED_LIST [STRING] is
				obsolete "Use ``linear_representation'' instead"
		do
			Result := linear_representation
		end;

feature {DIRECTORY} -- Implementation

	directory_pointer: POINTER;
			-- Directory pointer as required in C

	dir_search (dir_ptr: POINTER; entry: POINTER): POINTER is
			-- Return the `DIRENTRY' structure corresponding
			-- to the name `entry' of directory `dir_ptr'.
		external
			"C"
		end;

feature {NONE} -- Implementation

	mode: INTEGER;
			-- Status mode of the directory.
			-- Possible values are the following:

	Close_directory: INTEGER is unique;

	Read_directory: INTEGER is unique;

	file_mkdir (dir_name: POINTER) is
			-- Make directory `dir_name'.
		external
			"C"
		end;

	dir_open (dir_name: POINTER): POINTER is
			-- Open the directory `dir_name'.
		external
			"C"
		end;

	dir_rewind (dir_ptr: POINTER) is
			-- Rewind the directory `dir_ptr'.
		external
			"C"
		end;

	dir_close (dir_ptr: POINTER) is
			-- Close the directory `dir_ptr'.
		external
			"C"
		end;

	dir_next (dir_ptr: POINTER): STRING is
			-- Return the next entry for directory 'dir_ptr'.
		external
			"C"
		end;

	eif_dir_delete (dir_name: POINTER) is
			-- Delete the directory `dir_name'.
		external
			"C"
		end;

	eif_dir_exists (dir_name: POINTER): BOOLEAN is
			-- Does the directory `dir_name' exist?
		external
			"C"
		end;

	eif_dir_is_readable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' readable?
		external
			"C"
		end;

	eif_dir_is_executable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' executable?
		external
			"C"
		end;

	eif_dir_is_writable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' writable?
		external
			"C"
		end;

end -- class DIRECTORY


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
