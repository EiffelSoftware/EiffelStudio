note

	description:
		"Sequential files, viewed as persistent sequences of characters"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class FILE inherit

	UNBOUNDED [CHARACTER]

	SEQUENCE [CHARACTER]
		undefine
			prune
		redefine
			off, append
		end

	IO_MEDIUM
		rename
			handle as descriptor,
			handle_available as descriptor_available
		end

feature -- Initialization

	make (fn: STRING)
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			name := fn
			mode := Closed_file
			create last_string.make (256)
		ensure
			file_named: name.is_equal (fn)
			file_closed: is_closed
		end

	make_open_read (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file in read mode.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			open_read
		ensure
			exists: exists
			open_read: is_open_read
		end

	make_open_write (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file for writing;
			-- create it if it does not exist.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			open_write
		ensure
			exists: exists
			open_write: is_open_write
		end

	make_open_append (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file in append-only mode.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			open_append
		ensure
			exists: exists
			open_append: is_open_append
		end

	make_open_read_write (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file for both reading and writing.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			open_read_write
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	make_create_read_write (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file for both reading and writing;
			-- create it if it does not exist.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			create_read_write
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	make_open_read_append (fn: STRING)
			-- Create file object with `fn' as file name
			-- and open file for reading anywhere
			-- but writing at the end only.
			-- Create file if it does not exist.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			make (fn)
			open_read_append
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

feature -- Access

	name: STRING
			-- File name

	item: CHARACTER
			-- Current item
		do
			read_character
			Result := last_character
			back
		end

	position: INTEGER
			-- Current cursor position.
		do
			if not is_closed then
				Result := file_tell (file_pointer)
			end
		end

	descriptor: INTEGER
			-- File descriptor as used by the operating system.
		require else
			file_opened: not is_closed
		do
			Result := file_fd (file_pointer)
			descriptor_available := True
		end

	descriptor_available: BOOLEAN

	separator: CHARACTER
				-- ASCII code of character following last word read

	file_pointer: POINTER
			-- File pointer as required in C

	file_info: UNIX_FILE_INFO
			-- Collected information about the file.
		do
			set_buffer
			Result := clone (buffered_file_info)
		end

	inode: INTEGER
			-- I-node number
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.inode
		end

	links: INTEGER
			-- Number of links on file
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.links
		end

	user_id: INTEGER
			-- User identification of owner
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.user_id
		end

	group_id: INTEGER
			-- Group identification of owner
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.group_id
		end

	protection: INTEGER
			-- Protection mode, in decimal value
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.protection
		end

	owner_name: STRING
			-- Name of owner
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.owner_name
		end

	date: INTEGER
			-- Time stamp (time of last modification)
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.date
		end

	access_date: INTEGER
			-- Time stamp of last access made to the inode.
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.access_date
		end

	retrieved: ANY
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		do
			Result := c_retrieved (descriptor)
		end

feature -- Measurement

	count: INTEGER
			-- Size in bytes (0 if no associated physical file)
		do
			if exists then
				if not is_open_write then
					set_buffer
					Result := buffered_file_info.size
				else
					Result := file_size (file_pointer)
				end
			end
		end

feature -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor position?
		do
			Result := not is_closed and then (end_of_file or count = 0)
		end

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor position?
		do
			Result := is_closed
		end

	off: BOOLEAN
			-- Is there no item?
		do
			Result := (count = 0) or else is_closed or else end_of_file
		end

	end_of_file: BOOLEAN
			-- Has an EOF been detected?
		require
			opened: not is_closed
		do
			Result := file_feof (file_pointer)
		end

	exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_exists ($external_name)
		ensure then
			unchanged_mode: mode = old mode
		end

	access_exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses real UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_access ($external_name, 0)
		end

	path_exists: BOOLEAN
			-- Does physical file `name' exist without resolving
			-- symbolic links?
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_path_exists ($external_name)
		ensure then
			unchanged_mode: mode = old mode
		end

	is_readable: BOOLEAN
			-- Is file readable?
			-- (Checks permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_readable
		end

	is_writable: BOOLEAN
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_writable
		end

	is_executable: BOOLEAN
			-- Is file executable?
			-- (Checks execute permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_executable
		end

	is_creatable: BOOLEAN
			-- Is file creatable in parent directory?
			-- (Uses effective UID to check that parent is writable
			-- and file does not exist.)
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_creatable ($external_name, name.count)
		end

	is_plain: BOOLEAN
			-- Is file a plain file?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_plain
		end

	is_device: BOOLEAN
			-- Is file a device?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_device
		end

	is_directory: BOOLEAN
			-- Is file a directory?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_directory
		end

	is_symlink: BOOLEAN
			-- Is file a symbolic link?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_symlink
		end

	is_fifo: BOOLEAN
			-- Is file a named pipe?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_fifo
		end

	is_socket: BOOLEAN
			-- Is file a named socket?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_socket
		end

	is_block: BOOLEAN
			-- Is file a block special file?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_block
		end

	is_character: BOOLEAN
			-- Is file a character special file?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_character
		end

	is_setuid: BOOLEAN
			-- Is file setuid?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_setuid
		end

	is_setgid: BOOLEAN
			-- Is file setgid?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_setgid
		end

	is_sticky: BOOLEAN
			-- Is file sticky (for memory swaps)?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_sticky
		end

	is_owner: BOOLEAN
			-- Is file owned by effective UID?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_owner
		end

	is_access_readable: BOOLEAN
			-- Is file readable by real UID?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_access_readable
		end

	is_access_writable: BOOLEAN
			-- Is file writable by real UID?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_access_writable
		end

	is_access_executable: BOOLEAN
			-- Is file executable by real UID?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_access_executable
		end

	is_access_owner: BOOLEAN
			-- Is file owned by real UID?
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.is_access_owner
		end

	file_readable: BOOLEAN
			-- Is there a current item that may be read?
		do
			Result := (mode >= Read_write_file or mode = Read_file)
						and readable
		end

	is_closed: BOOLEAN
			-- Is file closed?
		do
			Result := mode = Closed_file
		end

	is_open_read: BOOLEAN
			-- Is file open for reading?
		do
			Result := mode = Read_file or else
				mode = Read_write_file or else
				mode = Append_read_file
		end

	is_open_write: BOOLEAN
			-- Is file open for writing?
		do
			Result := mode = Write_file or else
				mode = Read_write_file or else
				mode = Append_read_file or else
				mode = Append_file
		end

	is_open_append: BOOLEAN
			-- Is file open for appending?
		do
			Result := mode = Append_file or else
				mode = Append_read_file
		end

	file_writable: BOOLEAN
			-- Is there a current item that may be modified?
		do
			Result := mode >= Write_file
		end

	extendible: BOOLEAN
			-- May new items be added?
		do
			Result := mode >= Write_file
		end

	file_prunable: BOOLEAN
			-- May items be removed?
		do
			Result := mode >= Write_file and prunable
		end

	full: BOOLEAN = False
			-- Is structure filled to capacity?

	prunable: BOOLEAN
			-- Is there an item to be removed?
		do
		end

feature -- Status setting

	open_read
			-- Open file in read-only mode.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 0)
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	open_write
			-- Open file in write-only mode;
			-- create it if it does not exist.
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 1)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	open_append
			-- Open file in append-only mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 2)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	open_read_write
			-- Open file in read and write mode.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 3)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	create_read_write
			-- Open file in read and write mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 4)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	open_read_append
			-- Open file in read and write-at-end mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 5)
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	fd_open_read (fd: INTEGER)
			-- Open file of descriptor `fd' in read-only mode.
		do
			file_pointer := file_dopen (fd, 0)
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	fd_open_write (fd: INTEGER)
			-- Open file of descriptor `fd' in write mode.
		do
			file_pointer := file_dopen (fd, 1)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	fd_open_append (fd: INTEGER)
			-- Open file of descriptor `fd' in append mode.
		do
			file_pointer := file_dopen (fd, 2)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	fd_open_read_write (fd: INTEGER)
			-- Open file of descriptor `fd' in read-write mode.
		do
			file_pointer := file_dopen (fd, 3)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	fd_open_read_append (fd: INTEGER)
			-- Open file of descriptor `fd'
			-- in read and write-at-end mode.
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_dopen (fd, 5)
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	reopen_read (fname: STRING)
			-- Reopen in read-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := fname.to_c
			file_pointer := file_reopen ($external_name, 0, file_pointer)
			name := fname
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	reopen_write (fname: STRING)
			-- Reopen in write-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_reopen ($external_name, 1, file_pointer)
			name := fname
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	reopen_append (fname: STRING)
			-- Reopen in append mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_reopen ($external_name, 2, file_pointer)
			name := fname
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	reopen_read_write (fname: STRING)
			-- Reopen in read-write mode with file of name `fname'.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_reopen ($external_name, 3, file_pointer)
			name := fname
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	recreate_read_write (fname: STRING)
			-- Reopen in read-write mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_reopen ($external_name, 4, file_pointer)
			name := fname
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	reopen_read_append (fname: STRING)
			-- Reopen in read and write-at-end mode with file
			-- of name `fname'; create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_reopen ($external_name, 5, file_pointer)
			name := fname
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	close
			-- Close file.
		do
			file_close (file_pointer)
			mode := Closed_file
			descriptor_available := False
		ensure then
			is_closed: is_closed
		end

feature -- Cursor movement

	start
			-- Go to first position.
		require else
			file_opened: not is_closed
		do
			file_go (file_pointer, 0)
		end

	finish
			-- Go to last position.
		require else
			file_opened: not is_closed
		do
			file_recede (file_pointer, 0)
		end

	forth
			-- Go to next position.
		require else
			file_opened: not is_closed
		do
			file_move (file_pointer, 1)
		end

	back
			-- Go back one position.
		do
			file_move (file_pointer, - 1)
		end

	move (offset: INTEGER)
			-- Advance by `offset' from current location.
		require
			file_opened: not is_closed
		do
			file_move (file_pointer, offset)
		end

	go (abs_position: INTEGER)
			-- Go to the absolute `position'.
			-- (New position may be beyond physical length.)
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		do
			file_go (file_pointer, abs_position)
		end

	recede (abs_position: INTEGER)
			-- Go to the absolute `position' backwards,
			-- starting from end of file.
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		do
			file_recede (file_pointer, abs_position)
		end

	next_line
			-- Move to next input line.
		require
			is_readable: file_readable
		do
			file_tnil (file_pointer)
		end

feature -- Element change

	extend (v: CHARACTER)
			-- Include `v' at end.
		do
			put_character (v)
		end

	flush
			-- Flush buffered data to disk.
			-- Note that there is no guarantee that the operating
			-- system will physically write the data to the disk.
			-- At least it will end up in the buffer cache,
			-- making the data visible to other processes.
		require
			is_open: not is_closed
		do
			file_flush (file_pointer)
		end

	link (fn: STRING)
			-- Link current file to `fn'.
			-- `fn' must not already exist.
		require
			file_exists: exists
			-- `fn' does not exist already
		local
			external_name: ANY
			fn_name: ANY
		do
			external_name := name.to_c
			fn_name := fn.to_c
			file_link ($external_name, $fn_name)
		end

	append (f: like Current)
			-- Append a copy of the contents of `f'.
		require else
			target_is_closed: is_closed
			source_is_closed: f.is_closed
		do
				-- Open in append mode.
			open_append
				-- Open `f' in read mode.
			f.open_read
				-- Append contents of `f'.
			file_append (file_pointer, f.file_pointer, f.count)
				-- Close both files.
			close
			f.close
		ensure then
			new_count: count = old count + f.count
			files_closed: f.is_closed and is_closed
		end

	put_integer, putint (i: INTEGER)
			-- Write `i' at current position.
		deferred
		end

	put_boolean, putbool (b: BOOLEAN)
			-- Write `b' at current position.
		deferred
		end

	put_real, putreal (r: REAL)
			-- Write `r' at current position.
		deferred
		end

	put_double, putdouble (d: DOUBLE)
			-- Write `d' at current position.
		deferred
		end

	put_string, putstring (s: STRING)
			-- Write `s' at current position.
		local
			ext_s: ANY
		do
			if s.count /= 0 then
				ext_s := s.area
				file_ps (file_pointer, $ext_s, s.count)
			end
		end

	put_character, putchar (c: CHARACTER)
			-- Write `c' at current position.
		do
			file_pc (file_pointer, c)
		end

	put_new_line, new_line
			-- Write a new line character at current position.
		do
			file_tnwl (file_pointer)
		end

	stamp (time: INTEGER)
			-- Stamp with `time' (for both access and modification).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_utime ($external_name, time, 2)
		ensure
			date_updated: date = time	-- But race condition possible
		end

	set_access (time: INTEGER)
			-- Stamp with `time' (access only).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_utime ($external_name, time, 0)
		ensure
			acess_date_updated: access_date = time	-- But race condition might occur
			date_unchanged: date = old date	-- Modulo a race condition
		end

	set_date (time: INTEGER)
			-- Stamp with `time' (modification time only).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_utime ($external_name, time, 1)
		ensure
			access_date_unchanged: access_date = old access_date	-- But race condition might occur
			date_updated: date = time					-- Modulo a race condition
		end

	change_name (new_name: STRING)
			-- Change file name to `new_name'
		require
			new_name_not_void: new_name /= Void
			file_exists: exists
		local
			ext_old_name, ext_new_name: ANY
		do
			ext_old_name := name.to_c
			ext_new_name := new_name.to_c
			file_rename ($ext_old_name, $ext_new_name)
			name := new_name
		ensure
			name_changed: name.is_equal (new_name)
		end

	add_permission (who, what: STRING)
			-- Add read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void
			what_is_not_void: what /= Void
			file_descriptor_exists: exists
		local
			external_name, ext_who, ext_what: ANY
		do
			external_name := name.to_c
			ext_who := who.to_c
			ext_what := what.to_c
			file_perm ($external_name, $ext_who, $ext_what, 1)
		end

	remove_permission (who, what: STRING)
			-- Remove read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void
			what_is_not_void: what /= Void
			file_descriptor_exists: exists
		local
			external_name, ext_who, ext_what: ANY
		do
			external_name := name.to_c
			ext_who := who.to_c
			ext_what := what.to_c
			file_perm ($external_name, $ext_who, $ext_what, 0)
		end

	change_mode (mask: INTEGER)
			-- Replace mode by `mask'.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_chmod ($external_name, mask)
		end

	change_owner (new_owner_id: INTEGER)
			-- Change owner of file to `new_owner_id' found in
			-- system password file. On some systems this
			-- requires super-user privileges.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_chown ($external_name, new_owner_id)
		end

	change_group (new_group_id: INTEGER)
			-- Change group of file to `new_group_id' found in
			-- system password file.
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_chgrp ($external_name, new_group_id)
		end

	change_date: INTEGER
			-- Time stamp of last change.
		require
			file_exists: exists
		do
			set_buffer
			Result := buffered_file_info.change_date
		end

	touch
			-- Update time stamp (for both access and modification).
		require
			file_exists: exists
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_touch ($external_name)
		ensure
			date_changed: date /= old date	-- Race condition nearly impossible
		end

	basic_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		do
			c_basic_store (descriptor, $object)
		end
 
	general_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		do
			c_general_store (descriptor, $object)
		end

	independent_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			c_independent_store (descriptor, $object)
		end

feature -- Removal

	wipe_out
			-- Remove all items.
		require else
			is_closed: is_closed
		do
			open_write
			close
		end

	delete
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
			external_name := name.to_c
			file_unlink ($external_name)
		end

	reset (fn: STRING)
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		do
			name := fn
			if mode /= Closed_file then
				close
			end
			last_integer := 0
			if last_string /= Void then
				last_string.wipe_out
			end
			last_real := 0.0
			last_character := '%U'
			last_double := 0.0
		ensure
			file_renamed: name = fn
			file_closed: is_closed
		end

feature -- Input

	read_real, readreal
			-- Read a new real.
			-- Make result available in `last_real'.
		require else
			is_readable: file_readable
		deferred
		end

	read_double, readdouble
			-- Read a new double.
			-- Make result available in `last_double'.
		require else
			is_readable: file_readable
		deferred
		end

	read_character, readchar
			-- Read a new character.
			-- Make result available in `last_character'.
		require else
			is_readable: file_readable
		do
			last_character := file_gc (file_pointer)
		end

	read_integer, readint
			-- Read a new integer.
			-- Make result available in `last_integer'.
		require else
			is_readable: file_readable
		deferred
		end

	read_line, readline
			-- Read a string until new line or end of file.
			-- Make result available in `last_string'.
			-- New line will be consumed but not part of `last_string'.
		require else
			is_readable: file_readable
		local
			str_cap: INTEGER
			read: INTEGER	-- Amount of bytes already read
			str_area: ANY
			done: BOOLEAN
		do
			from
				str_area := last_string.area
				str_cap := last_string.capacity
			until
				done
			loop
				read := read + file_gs (file_pointer, $str_area, str_cap, read)
				if read > str_cap then
						-- End of line not reached yet
						--|The string must be consistently set before
						--|resizing.
					last_string.set_count (str_cap)
					if str_cap < 2048 then
						last_string.grow (str_cap + 1024)
					else
							-- Increase capacity by `Growth_percentage' as
							-- defined in RESIZABLE.
						last_string.automatic_grow
					end
					str_cap := last_string.capacity
					read := read - 1		-- True amount of byte read
					str_area := last_string.area
				else
					last_string.set_count (read)
					done := True
				end
			end
		end

	read_stream, readstream (nb_char: INTEGER)
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		require else
			is_readable: file_readable
		local
			new_count: INTEGER
			str_area: ANY
		do
			last_string.grow (nb_char)
			str_area := last_string.area
			new_count := file_gss (file_pointer, $str_area, nb_char)
			last_string.set_count (new_count)
		end

	read_word, readword
			-- Read a string, excluding white space and stripping
			-- leading white space.
			-- Make result available in `last_string'.
			-- White space characters are: blank, new_line, tab,
			-- vertical tab, formfeed, end of file.
		require
			is_readable: file_readable
		local
			str_area: ANY
			str_cap: INTEGER
			read: INTEGER	-- Amount of bytes already read
		do
			from
				str_area := last_string.area
				str_cap := last_string.capacity
			until
				read > str_cap
			loop
				read := read +
					file_gw (file_pointer, $str_area, str_cap, read)
				if read > str_cap then
						-- End of word not reached yet.
					if str_cap < 2048 then
						last_string.grow (str_cap + 1024)
					else
							-- Increase capacity by `Growth_percentage' as
							-- defined in RESIZABLE.
						last_string.automatic_grow
					end
					str_area := last_string.area
					str_cap := last_string.capacity
					read := read - 1		-- True amount of byte read
				else
					last_string.set_count (read)
					read := str_cap + 1	-- End of loop
				end
			end
			separator := file_lh (file_pointer) -- Look ahead
		end

feature -- Convenience

	copy_to (file: like Current)
			-- Copy content of current from current cursor
			-- position to end of file into `file' from
			-- current cursor position of `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
			current_is_open_read: is_open_read
		local
			l_modulo, l_read, nb: INTEGER
		do
			from
				l_read := 0
				nb := count
				l_modulo := 51200
			until
				l_read >= nb
			loop
				read_stream (l_modulo)
				file.put_string (last_string)
				l_read := l_read + l_modulo
			end
			create last_string.make (256)
		end

feature {NONE} -- Implementation

	read_to_string (a_string: STRING; pos, nb: INTEGER): INTEGER
			-- Fill `a_string', starting at position `pos' with at
			-- most `nb' characters read from current file.
			-- Return the number of characters actually read.
		require
			is_readable: file_readable
			not_end_of_file: not end_of_file
			a_string_not_void: a_string /= Void
			valid_position: a_string.valid_index (pos)
			nb_large_enough: nb > 0
			nb_small_enough: nb <= a_string.count - pos + 1
		deferred
		ensure
			nb_char_read_large_enough: Result >= 0
			nb_char_read_small_enough: Result <= nb
			character_read: not end_of_file implies Result > 0
		end

	true_string: STRING
			-- Character string "true"
		once
			Result := "True"
		end

	false_string: STRING
			-- Character string "false"
		once
			Result := "False"
		end

	buffered_file_info: UNIX_FILE_INFO
			-- Information about the file.
		once
			create Result.make
		end

	set_buffer
			-- Resynchronizes information on file
		require
			file_exists: exists
		do
			buffered_file_info.update (name)
		end

	file_link (from_name, to_name: POINTER)
			-- Link `to_name' to `from_name'
		external
			"C (char *, char *) | %"eif_file.h%""
		end

	file_unlink (fname: POINTER)
			-- Delete file `fname'.
		external
			"C | %"eif_file.h%""
		end

	file_open (f_name: POINTER; how: INTEGER): POINTER
			-- File pointer for file `f_name', in mode `how'.
		external
			"C signature (char *, int): EIF_POINTER use %"eif_file.h%""
		end

	file_dopen (fd, how: INTEGER): POINTER
			-- File pointer for file of descriptor `fd' in mode `how'
			-- (which must fit the way `fd' was obtained).
		external
			"C signature (int, int): EIF_POINTER use %"eif_file.h%""
		end

	file_reopen (f_name: POINTER; how: INTEGER; file: POINTER): POINTER
			-- File pointer to `file', reopened to have new name `f_name'
			-- in a mode specified by `how'.
		external
			"C (char *, int, FILE *): EIF_POINTER | %"eif_file.h%""
		end

	file_close (file: POINTER)
			-- Close `file'.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_flush (file: POINTER)
			-- Flush `file'.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_fd (file: POINTER): INTEGER
			-- Operating system's file descriptor
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	file_gc (file: POINTER): CHARACTER
			-- Access the next character
		external
			"C (FILE *): EIF_CHARACTER | %"eif_file.h%""
		end

	file_gs (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER
			-- `a_string' updated with characters read from `file'
			-- until new line, with `begin' characters already read.
			-- If it does not fit, result is `length' - `begin' + 1.
			-- If it fits, result is number of characters read.
		external
			"C (FILE *, char *, EIF_INTEGER, EIF_INTEGER): EIF_INTEGER | %"eif_file.h%""
		end

	file_gss (file: POINTER; a_string: POINTER; length: INTEGER): INTEGER
			-- Read min (`length', remaining bytes in file) characters
			-- into `a_string'. If it does not fit, result is `length' + 1.
			-- Otherwise, result is the number of characters read.
		external
			"C (FILE *, char *, EIF_INTEGER): EIF_INTEGER | %"eif_file.h%""
		end

	file_gw (file: POINTER; a_string: POINTER; length, begin: INTEGER): INTEGER
			-- Read a string excluding white space and stripping
			-- leading white space from `file' into `a_string'.
			-- White space characters are: blank, new_line,
			-- tab, vertical tab, formfeed or end of file.
			-- If it does not fit, result is `length' - `begin' + 1,
			-- otherwise result is number of characters read.
		external
			"C (FILE *, char *, EIF_INTEGER, EIF_INTEGER): EIF_INTEGER | %"eif_file.h%""
		end

	file_lh (file: POINTER): CHARACTER
			-- Look ahead in `file' and find out the value of the next
			-- character. Do not read over character.
		external
			"C (FILE *): EIF_CHARACTER | %"eif_file.h%""
		end

	file_size (file: POINTER): INTEGER
			-- Size of `file'
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	file_tnil (file: POINTER)
			-- Read upto next input line.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_tell (file: POINTER): INTEGER
			-- Current cursor position in file.
		external
			"C (FILE *): EIF_INTEGER | %"eif_file.h%""
		end

	file_touch (f_name: POINTER)
			-- Touch file `f_name'.
		external
			"C | %"eif_file.h%""
		end

	file_rename (old_name, new_name: POINTER)
			-- Change file name from `old_name' to `new_name'.
		external
			"C | %"eif_file.h%""
		end

	file_perm (f_name, who, what: POINTER; flag: INTEGER)
			-- Change permissions for `f_name' to `who' and `what'.
			-- `flag' = 1 -> add permissions,
			-- `flag' = 0 -> remove permissions.
		external
			"C signature (char *, char *, char *, int) use %"eif_file.h%""
		end

	file_chmod (f_name: POINTER; mask: INTEGER)
			-- Change mode of `f_name' to `mask'.
		external
			"C signature (char *, int) use %"eif_file.h%""
		end

	file_chown (f_name: POINTER; new_owner: INTEGER)
			-- Change owner of `f_name' to `new_owner'
		external
			"C signature (char *, int) use %"eif_file.h%""
		end

	file_chgrp (f_name: POINTER; new_group: INTEGER)
			-- Change group of `f_name' to `new_group'
		external
			"C signature (char *, int) use %"eif_file.h%""
		end

	file_utime (f_name: POINTER; time, how: INTEGER)
			-- Set access, modification time or both (`how' = 0,1,2) on
			-- `f_name', using `time' as time stamp.
		external
			"C signature (char *, int, int) use %"eif_file.h%""
		end

	file_tnwl (file: POINTER)
			-- Print a new-line to `file'.
		external
			"C (FILE *) | %"eif_file.h%""
		end

	file_append (file, from_file: POINTER; length: INTEGER)
			-- Append a copy of `from_file' to `file'
		external
			"C (FILE *, FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_ps (file: POINTER; a_string: POINTER; length: INTEGER)
			-- Print `a_string' to `file'.
		external
			"C (FILE *, char *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_pc (file: POINTER; c: CHARACTER)
			-- Put `c' to end of `file'.
		external
			"C (FILE *, EIF_CHARACTER) | %"eif_file.h%""
		end

	file_go (file: POINTER; abs_position: INTEGER)
			-- Go to absolute `position', originated from start.
		external
			"C (FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_recede (file: POINTER; abs_position: INTEGER)
			-- Go to absolute `position', originated from end.
		external
			"C (FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_move (file: POINTER; offset: INTEGER)
			-- Move file pointer by `offset'.
		external
			"C (FILE *, EIF_INTEGER) | %"eif_file.h%""
		end

	file_feof (file: POINTER): BOOLEAN
			-- End of file?
		external
			"C (FILE *): EIF_BOOLEAN | %"eif_file.h%""
		end

	file_exists (f_name: POINTER): BOOLEAN
			-- Does `f_name' exist.
		external
			"C | %"eif_file.h%""
		end

	file_path_exists (f_name: POINTER): BOOLEAN
			-- Does `f_name' exist.
		external
			"C | %"eif_file.h%""
		end

	file_access (f_name: POINTER; which: INTEGER): BOOLEAN
			-- Perform access test `which' on `f_name' using real UID.
		external
			"C | %"eif_file.h%""
		end

	file_creatable (f_name: POINTER; n: INTEGER): BOOLEAN
			-- Is `f_name' of count `n' creatable.
		external
			"C | %"eif_file.h%""
		end

	c_retrieved (file_handle: INTEGER): ANY
			-- Object structured retrieved from file of pointer
			-- `file_ptr'
		external
			"C | %"eif_retrieve.h%""
		alias
			"eretrieve"
		end
 
	c_basic_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C | %"eif_store.h%""
		alias
			"estore"
		end
 
	c_general_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C | %"eif_store.h%""
		alias
			"eestore"
		end
 
	c_independent_store (file_handle: INTEGER; object: POINTER)
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C | %"eif_store.h%""
		alias
			"sstore"
		end

feature {NONE} -- Inapplicable

	go_to (r: CURSOR)
			-- Move to position marked `r'.
		do
		end

	replace (v: like item)
			-- Replace current item by `v'.
		require else
			is_writable: file_writable
		do
		ensure then
			item = v
			count = old count
		end

	remove
			-- Remove current item.
		require else
			file_prunable: file_prunable
		do
		end

	prune (v: like item)
			-- Remove an occurrence of `v' if any.
		require else
			prunable: file_prunable
		do
		ensure then
			count <= old count
		end

feature {FILE} -- Implementation

	mode: INTEGER
			-- Input-output mode

	Closed_file: INTEGER = 0
	Read_file: INTEGER = 1
	Write_file: INTEGER	= 2
	Append_file: INTEGER = 3
	Read_Write_file: INTEGER = 4
	Append_Read_file: INTEGER = 5

	set_read_mode
			-- Define file mode as read.
		do
			mode := Read_file
		end

	set_write_mode
			-- Define file mode as write.
		do
			mode := Write_file
		end

invariant

	valid_mode: Closed_file <= mode and mode <= Append_read_file
	name_exists: name /= Void
	name_not_empty: not name.is_empty

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class FILE


