--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Unix specific directory

indexing

	date: "$Date$";
	revision: "$Revision$"

class DIRECTORY

creation

	make, make_open_read

feature -- Creation

	make (dn: STRING) is
			-- Create an Eiffel Directory with `dn'
			-- as directory name.
		require
			string_exists: dn /= Void
		do
			name := dn;
			mode := Close_directory;
		end;

	make_open_read (dn: STRING) is
			-- Create an Eiffel directory with `dn'
			-- as directory name and open it for reading.
		require
			string_exists: dn /= Void
		do
			make (dn);
			open_read;
		end;

    create is
            -- Create a physical directory if it doesn't already exists.
        require
            physical_not_exists: not exists
        local
            external_name: ANY
        do
            external_name := name.to_c;
            file_mkdir ($external_name);
        end;

feature -- Access

	exists: BOOLEAN is
			-- Does the directory exist ?
		local
			external_name: ANY;
		do
			external_name := name.to_c;
			Result := file_exists ($external_name)
		end;

	readentry is
			-- Read next directory entry and
			-- make result available in `lastentry'.
			-- (the result may be void if the end of directory
			-- is encountered)
		require
			is_opened: not is_closed
		do
			lastentry := dir_next (directory_pointer);
		end;

	has_entry (entry_name: STRING): BOOLEAN is
			-- Has directory the entry `entry_name'?
			-- The use of `dir_temp' is required not
			-- to perturbate the position in the current
			-- directory entries list.
		require
			string_exists: entry_name /= Void;
		local
			dir_entry: ANY;
			ext_entry_name: ANY;
			dir_temp: DIRECTORY
		do
			!! dir_temp.make_open_read (name);
			ext_entry_name := entry_name.to_c;
			dir_entry := dir_temp.dir_search (dir_temp.directory_pointer,
							$ext_entry_name);
			Result := dir_entry /= Void;
		end;

	name: STRING;
			-- Directory name

	lastentry: STRING;
			-- Last entry read by `readentry'

feature -- Directory handling

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

feature {DIRECTORY} -- Directory handling

	directory_pointer: POINTER;
			-- Directory pointer as required in C

feature -- Number of entries

	count: INTEGER is
			-- Number of entries in `Current'.
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
		end;
	
feature -- Transformation

	sequential_representation: ARRAY_SEQUENCE [STRING] is
			-- Sequential representation of the entries
			-- of `Current'.
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
				Result.add (dir_temp.lastentry);
				dir_temp.readentry
			end;
		end;
				
feature -- Status

	is_closed: BOOLEAN is
			-- Is current directory closed?
		do
			Result := mode = Close_directory;
		end;

feature {NONE} -- Status

	mode: INTEGER;
			-- Status mode of the directory.
			-- Possible values are the following:

	Close_directory: INTEGER is unique;

	Read_directory: INTEGER is unique;

feature {DIRECTORY} -- External

	dir_search (dir_ptr: POINTER; entry: ANY): ANY is
			-- Return the `DIRENTRY' structure corresponding
			-- to the name `entry' of directory `dir_ptr'.
		external
			"C"
		end;

feature {NONE} -- Externals

	dir_open (dir_name: ANY): POINTER is
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
			-- Return the next entry for directory.
		external
			"C"
		end;

	file_exists (dir_name: ANY): BOOLEAN is
			-- Does `dir_name' exist.
		external
			"C"
		end;

    file_mkdir (dir_name: ANY) is
            -- Make directory `dir_name'.
        external
            "C"
        end;

end
