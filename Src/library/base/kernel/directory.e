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

	create_dir is
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

	change_name (new_name: STRING) is
			-- Change file name to `new_name'
		require
			not_new_name_Void: new_name /= Void;
			file_exists: exists
		local
			ext_old_name, ext_new_name: ANY;
		do
			ext_old_name := name.to_c;
			ext_new_name := new_name.to_c;
			eif_dir_rename ($ext_old_name, $ext_new_name);
			name := new_name;
		ensure
			name_changed: name.is_equal (new_name);
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

feature {DIRECTORY} -- Implementation

	directory_pointer: POINTER;
			-- Directory pointer as required in C

	dir_search (dir_ptr: POINTER; entry: POINTER): POINTER is
			-- Return the `DIRENTRY' structure corresponding
			-- to the name `entry' of directory `dir_ptr'.
		external
			"C | %"eif_dir.h%""
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
			"C | %"eif_file.h%""
		end;

	dir_open (dir_name: POINTER): POINTER is
			-- Open the directory `dir_name'.
		external
			"C | %"eif_dir.h%""
		end;

	dir_rewind (dir_ptr: POINTER) is
			-- Rewind the directory `dir_ptr'.
		external
			"C | %"eif_dir.h%""
		end;

	dir_close (dir_ptr: POINTER) is
			-- Close the directory `dir_ptr'.
		external
			"C | %"eif_dir.h%""
		end;

	dir_next (dir_ptr: POINTER): STRING is
			-- Return the next entry for directory 'dir_ptr'.
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_delete (dir_name: POINTER) is
			-- Delete the directory `dir_name'.
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_exists (dir_name: POINTER): BOOLEAN is
			-- Does the directory `dir_name' exist?
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_is_readable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' readable?
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_is_executable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' executable?
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_is_writable (dir_name: POINTER): BOOLEAN is
			-- Is `dir_name' writable?
		external
			"C | %"eif_dir.h%""
		end;

	eif_dir_rename (old_name, new_name: POINTER) is
			-- Change directory name from `old_name' to `new_name'.
		external
			"C | %"eif_file.h%""
		alias
			"file_rename"
		end;

end -- class DIRECTORY


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

