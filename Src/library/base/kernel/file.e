indexing

	description:
		"Sequential files, viewed as persistent sequences of characters";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class FILE inherit

	UNBOUNDED [CHARACTER];

	SEQUENCE [CHARACTER]
		undefine
			prune
		redefine
			off, append
		end;

	IO_MEDIUM
		rename
			handle as descriptor,
			handle_available as descriptor_available
		end;

feature -- Initialization

	make (fn: STRING) is
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.empty
		do
			name := fn;
			mode := Closed_file;
			!! last_string.make (256)
		ensure
			file_named: name.is_equal (fn);
			file_closed: is_closed;
		end;

	make_open_read (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file in read mode.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			open_read;
		ensure
			exists: exists
			open_read: is_open_read
		end;

	make_open_write (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file for writing;
			-- create it if it does not exist.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			open_write;
		ensure
			exists: exists
			open_write: is_open_write
		end;

	make_open_append (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file in append-only mode.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			open_append;
		ensure
			exists: exists
			open_append: is_open_append
		end;

	make_open_read_write (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file for both reading and writing.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			open_read_write;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	make_create_read_write (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file for both reading and writing;
			-- create it if it does not exist.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			create_read_write;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	make_open_read_append (fn: STRING) is
			-- Create file object with `fn' as file name
			-- and open file for reading anywhere
			-- but writing at the end only.
			-- Create file if it does not exist.
		require
			string_exists: fn /= Void;
			string_not_empty: not fn.empty
		do
			make (fn);
			open_read_append;
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end;

feature -- Access

	name: STRING;
			-- File name

	item: CHARACTER is
			-- Current item
		do
			read_character
			Result := last_character
			back
		end;

	position: INTEGER is
			-- Current cursor position.
		do
			if not is_closed then
				Result := file_tell (file_pointer);
			end
		end;

	descriptor: INTEGER is
			-- File descriptor as used by the operating system.
		require else
			file_opened: not is_closed;
		do
			Result := file_fd (file_pointer);
			descriptor_available := True;
		end;

	descriptor_available: BOOLEAN;

	separator: CHARACTER;
				-- ASCII code of character following last word read

	file_pointer: POINTER;
			-- File pointer as required in C

	file_info: UNIX_FILE_INFO is
			-- Collected information about the file.
		do
			set_buffer;
			Result := clone (buffered_file_info);
		end;

	inode: INTEGER is
			-- I-node number
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.inode;
		end;

	links: INTEGER is
			-- Number of links on file
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.links;
		end;

	user_id: INTEGER is
			-- User identification of owner
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.user_id;
		end;

	group_id: INTEGER is
			-- Group identification of owner
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.group_id;
		end;

	protection: INTEGER is
			-- Protection mode, in decimal value
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.protection;
		end;

	owner_name: STRING is
			-- Name of owner
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.owner_name;
		end;

	date: INTEGER is
			-- Time stamp (time of last modification)
		require
			file_exists: exists
		do
			set_buffer;
			Result := buffered_file_info.date;
		end;

	access_date: INTEGER is
			-- Time stamp of last access made to the inode.
		require
			file_exists: exists
		do
			set_buffer;
			Result := buffered_file_info.access_date
		end;

feature -- Measurement

	count: INTEGER is
			-- Size in bytes (0 if no associated physical file)
		do
			if exists then
				if not is_open_write then
					set_buffer;
					Result := buffered_file_info.size
				else
					Result := file_size (file_pointer)
				end
			end
		end;

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor position?
		do
			Result := not is_closed and then (end_of_file or count = 0)
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor position?
		do
			Result := is_closed
		end;

	off: BOOLEAN is
			-- Is there no item?
		do
			Result := (count = 0) or else is_closed or else end_of_file
		end;

	end_of_file: BOOLEAN is
			-- Has an EOF been detected?
		require
			opened: not is_closed
		do
			Result := file_feof (file_pointer);
		end;

	exists: BOOLEAN is
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c;
			Result := file_exists ($external_name);
		ensure then
			unchanged_mode: mode = old mode
		end;

	access_exists: BOOLEAN is
			-- Does physical file exist?
			-- (Uses real UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c;
			Result := file_access ($external_name, 0);
		end;

	is_readable: BOOLEAN is
			-- Is file readable?
			-- (Checks permission for effective UID.)
		do
			set_buffer;
			Result := buffered_file_info.is_readable;
		end;

	is_writable: BOOLEAN is
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		do
			set_buffer;
			Result := buffered_file_info.is_writable;
		end;

	is_executable: BOOLEAN is
			-- Is file executable?
			-- (Checks execute permission for effective UID.)
		do
			set_buffer;
			Result := buffered_file_info.is_executable;
		end;

	is_creatable: BOOLEAN is
			-- Is file creatable in parent directory?
			-- (Uses effective UID to check that parent is writable
			-- and file does not exist.)
		local
			external_name: ANY
		do
			external_name := name.to_c;
			Result := file_creatable ($external_name);
		end;

	is_plain: BOOLEAN is
			-- Is file a plain file?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_plain;
		end;

	is_device: BOOLEAN is
			-- Is file a device?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_device;
		end;

	is_directory: BOOLEAN is
			-- Is file a directory?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_directory;
		end;

	is_symlink: BOOLEAN is
			-- Is file a symbolic link?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_symlink;
		end;

	is_fifo: BOOLEAN is
			-- Is file a named pipe?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_fifo;
		end;

	is_socket: BOOLEAN is
			-- Is file a named socket?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_socket;
		end;

	is_block: BOOLEAN is
			-- Is file a block special file?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_block;
		end;

	is_character: BOOLEAN is
			-- Is file a character special file?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_character;
		end;

	is_setuid: BOOLEAN is
			-- Is file setuid?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_setuid;
		end;

	is_setgid: BOOLEAN is
			-- Is file setgid?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_setgid;
		end;

	is_sticky: BOOLEAN is
			-- Is file sticky (for memory swaps)?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_sticky;
		end;

	is_owner: BOOLEAN is
			-- Is file owned by effective UID?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_owner;
		end;

	is_access_readable: BOOLEAN is
			-- Is file readable by real UID?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_access_readable;
		end;

	is_access_writable: BOOLEAN is
			-- Is file writable by real UID?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_access_writable;
		end;

	is_access_executable: BOOLEAN is
			-- Is file executable by real UID?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_access_executable;
		end;

	is_access_owner: BOOLEAN is
			-- Is file owned by real UID?
		require
			file_exists: exists;
		do
			set_buffer;
			Result := buffered_file_info.is_access_owner;
		end;

	file_readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := (mode >= Read_Write_file or mode = Read_file)
						and readable
		end;

	is_closed: BOOLEAN is
			-- Is file closed?
		do
			Result := mode = Closed_file
		end;

	is_open_read: BOOLEAN is
			-- Is file open for reading?
		do
			Result := mode = Read_file or else
				mode = Read_write_file or else
				mode = Append_read_file
		end;

	is_open_write: BOOLEAN is
			-- Is file open for writing?
		do
			Result := mode = Write_file or else
				mode = Read_write_file or else
				mode = Append_read_file or else
				mode = Append_file
		end;

	is_open_append: BOOLEAN is
			-- Is file open for appending?
		do
			Result := mode = Append_file or else
				mode = Append_read_file
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
			-- Open file in read-only mode.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 0);
			mode := Read_file;
		ensure
			exists: exists
			open_read: is_open_read
		end;

	open_write is
			-- Open file in write-only mode;
			-- create it if it does not exist.
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 1);
			mode := Write_file;
		ensure
			exists: exists
			open_write: is_open_write
		end;

	open_append is
			-- Open file in append-only mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 2);
			mode := Append_file;
		ensure
			exists: exists
			open_append: is_open_append
		end;

	open_read_write is
			-- Open file in read and write mode.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 3);
			mode := Read_write_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	create_read_write is
			-- Open file in read and write mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 4);
			mode := Read_write_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	open_read_append is
			-- Open file in read and write-at-end mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_open ($external_name, 5);
			mode := Append_read_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end;

	fd_open_read (fd: INTEGER) is
			-- Open file of descriptor `fd' in read-only mode.
		do
			file_pointer := file_dopen (fd, 0);
			mode := Read_file;
		ensure
			exists: exists
			open_read: is_open_read
		end;

	fd_open_write (fd: INTEGER) is
			-- Open file of descriptor `fd' in write mode.
		do
			file_pointer := file_dopen (fd, 1);
			mode := Write_file;
		ensure
			exists: exists
			open_write: is_open_write
		end;

	fd_open_append (fd: INTEGER) is
			-- Open file of descriptor `fd' in append mode.
		do
			file_pointer := file_dopen (fd, 2);
			mode := Append_file;
		ensure
			exists: exists
			open_append: is_open_append
		end;

	fd_open_read_write (fd: INTEGER) is
			-- Open file of descriptor `fd' in read-write mode.
		do
			file_pointer := file_dopen (fd, 3);
			mode := Read_write_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	fd_open_read_append (fd: INTEGER) is
			-- Open file of descriptor `fd'
			-- in read and write-at-end mode.
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_dopen (fd, 5);
			mode := Append_read_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end;

	reopen_read (fname: STRING) is
			-- Reopen in read-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := fname.to_c;
			file_pointer := file_reopen ($external_name, 0, file_pointer);
			name := fname;
			mode := Read_file;
		ensure
			exists: exists
			open_read: is_open_read
		end;

	reopen_write (fname: STRING) is
			-- Reopen in write-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_reopen ($external_name, 1, file_pointer);
			name := fname;
			mode := Write_file;
		ensure
			exists: exists
			open_write: is_open_write
		end;

	reopen_append (fname: STRING) is
			-- Reopen in append mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_reopen ($external_name, 2, file_pointer);
			name := fname;
			mode := Append_file;
		ensure
			exists: exists
			open_append: is_open_append
		end;

	reopen_read_write (fname: STRING) is
			-- Reopen in read-write mode with file of name `fname'.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_reopen ($external_name, 3, file_pointer);
			name := fname;
			mode := Read_write_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	recreate_read_write (fname: STRING) is
			-- Reopen in read-write mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_reopen ($external_name, 4, file_pointer);
			name := fname;
			mode := Read_write_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end;

	reopen_read_append (fname: STRING) is
			-- Reopen in read and write-at-end mode with file
			-- of name `fname'; create file if it does not exist.
		require
			is_open: not is_closed;
			valid_name: fname /= Void;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_pointer := file_reopen ($external_name, 5, file_pointer);
			name := fname;
			mode := Append_read_file;
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end;

	close is
			-- Close file.
		do
			file_close (file_pointer);
			mode := Closed_file;
			descriptor_available := False;
		ensure then
			is_closed: is_closed
		end;

feature -- Cursor movement

	start is
			-- Go to first position.
		require else
			file_opened: not is_closed;
		do
			file_go (file_pointer, 0);
		end;

	finish is
			-- Go to last position.
		require else
			file_opened: not is_closed;
		do
			file_recede (file_pointer, 0);
		end;

	forth is
			-- Go to next position.
		require else
			file_opened: not is_closed;
		do
			file_move (file_pointer, 1);
		end;

	back is
			-- Go back one position.
		do
			file_move (file_pointer, -1);
		end;

	move (offset: INTEGER) is
			-- Advance by `offset' from current location.
		require
			file_opened: not is_closed;
		do
			file_move (file_pointer, offset);
		end;

	go (abs_position: INTEGER) is
			-- Go to the absolute `position'.
			-- (New position may be beyond physical length.)
		require
			file_opened: not is_closed;
			non_negative_argument: abs_position >= 0;
		do
			file_go (file_pointer, abs_position);
		end;

	recede (abs_position: INTEGER) is
			-- Go to the absolute `position' backwards,
			-- starting from end of file.
		require
			file_opened: not is_closed;
			non_negative_argument: abs_position >= 0;
		do
			file_recede (file_pointer, abs_position);
		end;

	next_line is
			-- Move to next input line.
		require
			is_readable: file_readable;
		do
			file_tnil (file_pointer);
		end;

feature -- Element change

	extend (v: CHARACTER) is
			-- Include `v' at end.
		do
			put_character (v)
		end;

	flush is
			-- Flush buffered data to disk.
			-- Note that there is no guarantee that the operating
			-- system will physically write the data to the disk.
			-- At least it will end up in the buffer cache,
			-- making the data visible to other processes.
		require
			is_open: not is_closed;
		do
			file_flush (file_pointer);
		end;

	link (fn: STRING) is
			-- Link current file to `fn'.
			-- `fn' must not already exist.
		require
			file_exists: exists
			-- `fn' does not exist already
		local
			external_name: ANY;
			fn_name: ANY
		do
			external_name := name.to_c;
			fn_name := fn.to_c;
			file_link ($external_name, $fn_name)
		end;

	append (f: like Current) is
			-- Append a copy of the contents of `f'.
		require else
			target_is_closed: is_closed;
			source_is_closed: f.is_closed;
		do
				-- Open in append mode.
			open_append;
				-- Open `f' in read mode.
			f.open_read;
				-- Append contents of `f'.
			file_append (file_pointer, f.file_pointer, f.count);
				-- Close both files.
			close;
			f.close
		ensure then
			new_count: count = old count + f.count;
			files_closed: f.is_closed and is_closed;
		end;

	put_integer, putint (i: INTEGER) is
			-- Write `i' at current position.
		deferred
		end;

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' at current position.
		deferred
		end;

	put_real, putreal (r: REAL) is
			-- Write `r' at current position.
		deferred
		end;

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at current position.
		deferred
		end;

	put_string, putstring (s: STRING) is
			-- Write `s' at current position.
		local
			ext_s: ANY
		do
			if s.count /= 0 then
				ext_s := s.to_c;
				file_ps (file_pointer, $ext_s, s.count);
			end;
		end;

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at current position.
		do
			file_pc (file_pointer, c);
		end;

	new_line is
			-- Write a new line character at current position.
		do
			file_tnwl (file_pointer);
		end;

	stamp (time: INTEGER) is
			-- Stamp with `time' (for both access and modification).
		require
			file_exists: exists;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_utime ($external_name, time, 2);
		ensure
			date_updated: date = time;	-- But race condition possible
		end;

	set_access (time: INTEGER) is
			-- Stamp with `time' (access only).
		require
			file_exists: exists;
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_utime ($external_name, time, 0);
		ensure
			acess_date_updated: access_date = time;	-- But race condition might occur
			date_unchanged: date = old date;	-- Modulo a race condition
		end;

	set_date (time: INTEGER) is
			-- Stamp with `time' (modification time only).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_utime ($external_name, time, 1);
		ensure
			access_date_unchanged: access_date = old access_date;	-- But race condition might occur
			date_updated: date = time;					-- Modulo a race condition
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
			file_rename ($ext_old_name, $ext_new_name);
			name := new_name;
		ensure
			name_changed: name.is_equal (new_name);
		end;

	add_permission (who, what: STRING) is
			-- Add read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void;
			what_is_not_void: what /= Void;
			file_descriptor_exists: exists
		local
			external_name, ext_who, ext_what: ANY
		do
			external_name := name.to_c;
			ext_who := who.to_c;
			ext_what := what.to_c;
			file_perm ($external_name, $ext_who, $ext_what, 1);
		end;

	remove_permission (who, what: STRING) is
			-- Remove read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void;
			what_is_not_void: what /= Void;
			file_descriptor_exists: exists
		local
			external_name, ext_who, ext_what: ANY
		do
			external_name := name.to_c;
			ext_who := who.to_c;
			ext_what := what.to_c;
			file_perm ($external_name, $ext_who, $ext_what, 0);
		end;

	change_mode (mask: INTEGER) is
			-- Replace mode by `mask'.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_chmod ($external_name, mask);
		end;

	change_owner (new_owner_id: INTEGER) is
			-- Change owner of file to `new_owner_id' found in
			-- system password file. On some systems this
			-- requires super-user privileges.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_chown ($external_name, new_owner_id);
		end;

	change_group (new_group_id: INTEGER) is
			-- Change group of file to `new_group_id' found in
			-- system password file.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_chgrp ($external_name, new_group_id);
		end;

	change_date: INTEGER is
			-- Time stamp of last change.
		require
			file_exists: exists
		do
			set_buffer;
			Result := buffered_file_info.change_date
		end;

	touch is
			-- Update time stamp (for both access and modification).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_touch ($external_name)
		ensure
			date_changed: date /= old date	-- Race condition nearly impossible
		end;

feature -- Removal

	wipe_out is
			-- Remove all items.
		require else
			is_closed: is_closed;
		do
			open_write;
			close;
		end;

	delete is
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		require
			exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c;
			file_unlink ($external_name)
		end;

	reset (fn: STRING) is
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		do
			name := fn;
			if mode /= Closed_file then
				close
			end;
			last_integer := 0;
			if last_string /= Void then
				last_string.wipe_out
			end;
			last_real := 0.0;
			last_character := '%U';
			last_double := 0.0
		ensure
			file_renamed: name = fn;
			file_closed: is_closed
		end;

feature -- Input

	read_real, readreal is
			-- Read a new real.
			-- Make result available in `last_real'.
		require else
			is_readable: file_readable
		deferred
		end;

	read_double, readdouble is
			-- Read a new double.
			-- Make result available in `last_double'.
		require else
			is_readable: file_readable
		deferred
		end;

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		require else
			is_readable: file_readable
		do
			last_character := file_gc (file_pointer)
		end;

	read_integer, readint is
			-- Read a new integer.
			-- Make result available in `last_integer'.
		require else
			is_readable: file_readable
		deferred
		end;

	read_line, readline is
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		require else
			is_readable: file_readable
		local
			str_cap: INTEGER;
			read: INTEGER;	-- Amount of bytes already read
			str_area: ANY
			done: BOOLEAN
		do
			from
				str_area := last_string.area;
				str_cap := last_string.capacity;
			until
				done
			loop
				read := read +
					file_gs (file_pointer, $str_area, str_cap, read);
				if read > str_cap then
						-- End of line not reached yet
						--|The string must be consistently set before
						--|resizing.
					last_string.set_count (str_cap);
					last_string.resize (str_cap + 1024);
					str_cap := last_string.capacity;
					read := read - 1;		-- True amount of byte read
					str_area := last_string.area;
				else
					last_string.set_count (read);
					done := true
				end;
			end;
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read);
			end;
		end;

	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		require else
			is_readable: file_readable
		local
			new_count: INTEGER;
			str_area: ANY
		do
			last_string.resize (nb_char);
			str_area := last_string.area;
			new_count := file_gss (file_pointer, $str_area, nb_char);
			last_string.set_count (new_count);
		end;

	read_word, readword is
			-- Read a string, excluding white space and stripping
			-- leading white space.
			-- Make result available in `last_string'.
			-- White space characters are: blank, new_line, tab,
			-- vertical tab, formfeed, end of file.
		require
			is_readable: file_readable
		local
			str_area: ANY;
			str_cap: INTEGER;
			read: INTEGER;	-- Amount of bytes already read
		do
			from
				str_area := last_string.area;
				str_cap := last_string.capacity;
			until
				read > str_cap
			loop
				read := read +
					file_gw (file_pointer, $str_area, str_cap, read);
				if read > str_cap then
						-- End of word not reached yetO
					last_string.resize (str_cap + 1024);
					str_area := last_string.area;
					str_cap := last_string.capacity;
					read := read - 1;		-- True amount of byte read
				else
					last_string.set_count (read);
					read := str_cap + 1;	-- End of loop
				end;
			end;
				-- Ensure fair amount of garbage.
			if read < 1024 then
				last_string.resize (read);
			end;
			separator := file_lh (file_pointer); -- Look ahead
		end;

feature {STORABLE} -- Implementation

	storage_type: CHARACTER is 'F'
			-- Type for storage mechanism
			-- F for File, S for Socket

feature {NONE} -- Implementation

	true_string: STRING is
			-- Character string "true"
		once
			Result := "true"
		end;

	false_string: STRING is
			-- Character string "false"
		once
			Result := "false"
		end;

	buffered_file_info: UNIX_FILE_INFO is
			-- Information about the file.
		once
			!! Result.make;
		end;

	set_buffer is
			-- Resynchronizes information on file
		require
			file_exists: exists;
		do
			buffered_file_info.update (name);
		end;

	file_link (from_name, to_name: POINTER) is
			-- Link `to_name' to `from_name'
		external
			"C"
		end;

	file_unlink (fname: POINTER) is
			-- Delete file `fname'.
		external
			"C"
		end;

	file_open (f_name: POINTER; how: INTEGER): POINTER is
			-- File pointer for file `f_name', in mode `how'.
		external
			"C"
		end;

	file_dopen (fd, how: INTEGER): POINTER is
			-- File pointer for file of descriptor `fd' in mode `how'
			-- (which must fit the way `fd' was obtained).
		external
			"C"
		end;

	file_reopen (f_name: POINTER; how: INTEGER; file: POINTER): POINTER is
			-- File pointer to `file', reopened to have new name `f_name'
			-- in a mode specified by `how'.
		external
			"C"
		end;

	file_close (file: POINTER) is
			-- Close `file'.
		external
			"C"
		end;

	file_flush (file: POINTER) is
			-- Flush `file'.
		external
			"C"
		end;

	file_fd (file: POINTER): INTEGER is
			-- Operating system's file descriptor
		external
			"C"
		end;

	file_gc (file: POINTER): CHARACTER is
			-- Access the next character
		external
			"C"
		end;

	file_gs (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER is
			-- `a_string' updated with characters read from `file'
			-- until new line, with `begin' characters already read.
			-- If it does not fit, result is `length' - `begin' + 1.
			-- If it fits, result is number of characters read.
		external
			"C"
		end;

	file_gss (file: POINTER; a_string: POINTER; length: INTEGER): INTEGER is
			-- Read min (`length', remaining bytes in file) characters
			-- into `a_string'. If it does not fit, result is `length' + 1.
			-- Otherwise, result is the number of characters read.
		external
			"C"
		end;

	file_gw (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER is
			-- Read a string excluding white space and stripping
			-- leading white space from `file' into `a_string'.
			-- White space characters are: blank, new_line,
			-- tab, vertical tab, formfeed or end of file.
			-- If it does not fit, result is `length' - `begin' + 1,
			-- otherwise result is number of characters read.
		external
			"C"
		end;

	file_lh (file: POINTER): CHARACTER is
			-- Look ahead in `file' and find out the value of the next
			-- character. Do not read over character.
		external
			"C"
		end;

	file_size (file: POINTER): INTEGER is
			-- Size of `file'
		external
			"C"
		end;

	file_tnil (file: POINTER) is
			-- Read upto next input line.
		external
			"C"
		end;

	file_tell (file: POINTER): INTEGER is
			-- Current cursor position in file.
		external
			"C"
		end;

	file_touch (f_name: POINTER) is
			-- Touch file `f_name'.
		external
			"C"
		end;

	file_rename (old_name, new_name: POINTER) is
			-- Change file name from `old_name' to `new_name'.
		external
			"C"
		end;

	file_perm (f_name, who, what: POINTER; flag: INTEGER) is
			-- Change permissions for `f_name' to `who' and `what'.
			-- `flag' = 1 -> add permissions,
			-- `flag' = 0 -> remove permissions.
		external
			"C"
		end;

	file_chmod (f_name: POINTER; mask: INTEGER) is
			-- Change mode of `f_name' to `mask'.
		external
			"C"
		end;

	file_chown (f_name: POINTER; new_owner: INTEGER) is
			-- Change owner of `f_name' to `new_owner'
		external
			"C"
		end;

	file_chgrp (f_name: POINTER; new_group: INTEGER) is
			-- Change group of `f_name' to `new_group'
		external
			"C"
		end;

	file_utime (f_name: POINTER; time, how: INTEGER) is
			-- Set access, modification time or both (`how' = 0,1,2) on
			-- `f_name', using `time' as time stamp.
		external
			"C"
		end;

	file_tnwl (file: POINTER) is
			-- Print a new-line to `file'.
		external
			"C"
		end;

	file_append (file, from_file: POINTER; length: INTEGER) is
			-- Append a copy of `from_file' to `file'
		external
			"C"
		end;

	file_ps (file: POINTER; a_string: POINTER; length: INTEGER) is
			-- Print `a_string' to `file'.
		external
			"C"
		end;

	file_pc (file: POINTER; c: CHARACTER) is
			-- Put `c' to end of `file'.
		external
			"C"
		end;

	file_go (file: POINTER; abs_position: INTEGER) is
			-- Go to absolute `position', originated from start.
		external
			"C"
		end;

	file_recede (file: POINTER; abs_position: INTEGER) is
			-- Go to absolute `position', originated from end.
		external
			"C"
		end;

	file_move (file: POINTER; offset: INTEGER) is
			-- Move file pointer by `offset'.
		external
			"C"
		end;

	file_feof (file: POINTER): BOOLEAN is
			-- End of file?
		external
			"C"
		end;

	file_exists (f_name: POINTER): BOOLEAN is
			-- Does `f_name' exist.
		external
			"C"
		end;

	file_access (f_name: POINTER; which: INTEGER): BOOLEAN is
			-- Perform access test `which' on `f_name' using real UID.
		external
			"C"
		end;

	file_creatable (f_name: POINTER): BOOLEAN is
			-- Is `f_name' creatable.
		external
			"C"
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

	prune (v: like item) is
			-- Remove an occurrence of `v' if any.
		require else
			prunable: file_prunable
		do
		ensure then
			count <= old count
		end;

feature {FILE} -- Implementation

	mode: INTEGER;
			-- Input-output mode

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

invariant

	valid_mode: Closed_file <= mode and mode <= Append_Read_file;
	name_exists: name /= Void;
	name_not_empty: not name.empty

end -- class FILE


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
