indexing

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

	make (fn: STRING) is
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			create internal_file.make_file_info (fn.to_cil)
			mode := Closed_file
			create last_string.make (256)
		ensure
			file_named: name.is_equal (fn)
			file_closed: is_closed
		end

	make_open_read (fn: STRING) is
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

	make_open_write (fn: STRING) is
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

	make_open_append (fn: STRING) is
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

	make_open_read_write (fn: STRING) is
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

	make_create_read_write (fn: STRING) is
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

	make_open_read_append (fn: STRING) is
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

	name: STRING is
			-- File name
		do
			create Result.make_from_cil (internal_file.get_name)
		ensure
			consistent_name: internal_stream /= Void implies internal_stream.get_name.equals (name.to_cil)
		end

	item: CHARACTER is
			-- Current item
		do
			read_character
			Result := last_character
			back
		end

	position: INTEGER is
			-- Current cursor position.
		do
			if not is_closed then
				Result := internal_stream.get_position.to_integer
			end
		end

	descriptor: INTEGER is
			-- File descriptor as used by the operating system.
		require else
			file_opened: not is_closed
		local
			omode: INTEGER
		do
			inspect mode
			when read_file then
				omode := c_read
			when append_file then
				omode := c_append
			when read_write_file then
				omode := c_readwrite
			when write_file then
				omode := c_write
			when append_read_file then
				omode := c_append
			end
			omode := omode | c_open_modifier
			Result := get_fd (file_pointer.to_integer_32, omode)
			descriptor_available := Result /= -1
		end

	descriptor_available: BOOLEAN

	separator: CHARACTER
				-- ASCII code of character following last word read

	file_pointer: POINTER is
			-- File pointer as required in C
		do
			if not is_closed then
				Result := internal_stream.get_handle
			end
		end

	file_info: UNIX_FILE_INFO is
			-- Collected information about the file.
		do
			set_buffer
			Result := clone (buffered_file_info)
		end

	inode: INTEGER is
			-- I-node number
		require
			file_exists: exists
		do
			Result := 0
		end

	links: INTEGER is
			-- Number of links on file
		require
			file_exists: exists
		do
			Result := 1
		end

	user_id: INTEGER is
			-- User identification of owner
		require
			file_exists: exists
		do
			Result := 0
		end

	group_id: INTEGER is
			-- Group identification of owner
		require
			file_exists: exists
		do
			Result := 0
		end

	protection: INTEGER is
			-- Protection mode, in decimal value
		require
			file_exists: exists
		do
			Result := 0
			if is_access_readable then
				Result := Result | (1 |<< 8)
			end
			if is_access_executable then
				Result := Result | (1 |<< 6)
			end
			if is_access_writable then
				Result := Result | (1 |<< 7)
			end
		end

	owner_name: STRING is
			-- Name of owner
		require
			file_exists: exists
		do
			Result := "0"
		end

	date: INTEGER is
			-- Time stamp (time of last modification)
		require
			file_exists: exists
		do
			Result := internal_file.get_last_write_time.to_file_time.to_integer
		end

	access_date: INTEGER is
			-- Time stamp of last access made to the inode.
		require
			file_exists: exists
		do
			Result := internal_file.get_last_access_time.to_file_time.to_integer
		end

	retrieved: ANY is
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		do
			Result := c_retrieved (descriptor)
		end

feature -- Measurement

	count: INTEGER is
			-- Size in bytes (0 if no associated physical file)
		do
			if exists then
				if not is_open_write then
					Result := internal_file.get_length.to_integer
				else
					Result := internal_stream.get_length.to_integer
				end
			end
		end

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor position?
		do
			Result := not is_closed and then (end_of_file or count = 0)
		end

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor position?
		do
			Result := is_closed
		end

	off: BOOLEAN is
			-- Is there no item?
		do
			Result := (count = 0) or else is_closed or else end_of_file
		end

	end_of_file: BOOLEAN is
			-- Has an EOF been detected?
		require
			opened: not is_closed
		do
			Result := internal_stream.get_length = internal_stream.get_position
		end

	exists: BOOLEAN is
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			external_name: ANY
		do
			Result := internal_file.get_exists
		ensure then
			unchanged_mode: mode = old mode
		end

	access_exists: BOOLEAN is
			-- Does physical file exist?
			-- (Uses real UID.)
		local
			external_name: ANY
		do
			Result := internal_file.get_exists
		end

	is_readable: BOOLEAN is
			-- Is file readable?
			-- (Checks permission for effective UID.)
		local
			perm: FILE_IOPERMISSION
			retried: BOOLEAN
		do
			if not retried then
				create perm.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.read, name.to_cil)
				perm.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_writable: BOOLEAN is
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		local
			perm: FILE_IOPERMISSION
			retried: BOOLEAN
		do
			if not retried then
				create perm.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.write, name.to_cil)
				perm.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_executable: BOOLEAN is
			-- Is file executable?
			-- (Checks execute permission for effective UID.)
		do
			Result := True
		end

	is_creatable: BOOLEAN is
			-- Is file creatable in parent directory?
			-- (Uses effective UID to check that parent is writable
			-- and file does not exist.)
		local
			perm: FILE_IOPERMISSION
			retried: BOOLEAN
		do
			if not retried then
					-- Is the parent directory writable?
				create perm.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.read, internal_file.get_directory_name)
				perm.demand
				Result := not exists or else writable
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	is_plain: BOOLEAN is
			-- Is file a plain file?
		require
			file_exists: exists
		do
			Result := internal_file.get_attributes = feature {FILE_ATTRIBUTES}.normal
		end

	is_device: BOOLEAN is
			-- Is file a device?
		require
			file_exists: exists
		do
			Result := False
		end

	is_directory: BOOLEAN is
			-- Is file a directory?
		require
			file_exists: exists
		do
			Result := (create {DIRECTORY}.make (name)).exists
		end

	is_symlink: BOOLEAN is
			-- Is file a symbolic link?
		require
			file_exists: exists
		do
			Result := False
		end

	is_fifo: BOOLEAN is
			-- Is file a named pipe?
		require
			file_exists: exists
		do
			Result := False
		end

	is_socket: BOOLEAN is
			-- Is file a named socket?
		require
			file_exists: exists
		do
			Result := False
		end

	is_block: BOOLEAN is
			-- Is file a block special file?
		require
			file_exists: exists
		do
			Result := False
		end

	is_character: BOOLEAN is
			-- Is file a character special file?
		require
			file_exists: exists
		do
			Result := False
		end

	is_setuid: BOOLEAN is
			-- Is file setuid?
		require
			file_exists: exists
		do
			Result := False
		end

	is_setgid: BOOLEAN is
			-- Is file setgid?
		require
			file_exists: exists
		do
			Result := False
		end

	is_sticky: BOOLEAN is
			-- Is file sticky (for memory swaps)?
		require
			file_exists: exists
		do
			Result := False
		end

	is_owner: BOOLEAN is
			-- Is file owned by effective UID?
		require
			file_exists: exists
		do
			Result := True
		end

	is_access_readable: BOOLEAN is
			-- Is file readable by real UID?
		require
			file_exists: exists
		do
			Result := is_readable
		end

	is_access_writable: BOOLEAN is
			-- Is file writable by real UID?
		require
			file_exists: exists
		do
			Result := is_writable
		end

	is_access_executable: BOOLEAN is
			-- Is file executable by real UID?
		require
			file_exists: exists
		do
			Result := is_executable
		end

	is_access_owner: BOOLEAN is
			-- Is file owned by real UID?
		require
			file_exists: exists
		do
			Result := True
		end

	file_readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := (mode >= Read_write_file or mode = Read_file)
						and readable
		end

	is_closed: BOOLEAN is
			-- Is file closed?
		do
			Result := mode = Closed_file
		end

	is_open_read: BOOLEAN is
			-- Is file open for reading?
		do
			Result := mode = Read_file or else
				mode = Read_write_file or else
				mode = Append_read_file
		end

	is_open_write: BOOLEAN is
			-- Is file open for writing?
		do
			Result := mode = Write_file or else
				mode = Read_write_file or else
				mode = Append_read_file or else
				mode = Append_file
		end

	is_open_append: BOOLEAN is
			-- Is file open for appending?
		do
			Result := mode = Append_file or else
				mode = Append_read_file
		end

	file_writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := mode >= Write_file
		end

	extendible: BOOLEAN is
			-- May new items be added?
		do
			Result := mode >= Write_file
		end

	file_prunable: BOOLEAN is
			-- May items be removed?
		do
			Result := mode >= Write_file and prunable
		end

	full: BOOLEAN is False
			-- Is structure filled to capacity?

feature -- Status setting

	open_read is
			-- Open file in read-only mode.
		require
			is_closed: is_closed
		do
			internal_stream := internal_file.open_read
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	open_write is
			-- Open file in write-only mode;
			-- create it if it does not exist.
		do
			internal_stream := internal_file.open_file_mode_file_access (feature {FILE_MODE}.open, feature {FILE_ACCESS}.write)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	open_append is
			-- Open file in append-only mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		do
			internal_stream := internal_file.open_file_mode_file_access (feature {FILE_MODE}.append, feature {FILE_ACCESS}.write)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	open_read_write is
			-- Open file in read and write mode.
		require
			is_closed: is_closed
		do
			internal_stream := internal_file.open_file_mode_file_access (
				feature {FILE_MODE}.open,
				feature {FILE_ACCESS}.read_write
			)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	create_read_write is
			-- Open file in read and write mode;
			-- create it if it does not exist.
		require
			is_closed: is_closed
		do
			internal_stream := internal_file.open_file_mode_file_access (
				feature {FILE_MODE}.open_or_create,
				feature {FILE_ACCESS}.read_write
			)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	open_read_append is
			-- Open file in read and write-at-end mode;
			-- create it if it does not exist.
			--| Not supported in the CIL.
		require
			is_closed: is_closed
		do
			open_read_write
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	fd_open_read (fd: INTEGER) is
			-- Open file of descriptor `fd' in read-only mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			internal_stream := create {FILE_STREAM}.make_file_stream_5 (hdl, feature {FILE_ACCESS}.read)
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	fd_open_write (fd: INTEGER) is
			-- Open file of descriptor `fd' in write mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			internal_stream := create {FILE_STREAM}.make_file_stream_5 (hdl, feature {FILE_ACCESS}.write)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	fd_open_append (fd: INTEGER) is
			-- Open file of descriptor `fd' in append mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			internal_stream := create {FILE_STREAM}.make_file_stream_5 (hdl, feature {FILE_ACCESS}.write)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	fd_open_read_write (fd: INTEGER) is
			-- Open file of descriptor `fd' in read-write mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			internal_stream := create {FILE_STREAM}.make_file_stream_5 (hdl, feature {FILE_ACCESS}.read_write)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	fd_open_read_append (fd: INTEGER) is
			-- Open file of descriptor `fd'
			-- in read and write-at-end mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			internal_stream := create {FILE_STREAM}.make_file_stream_5 (hdl, feature {FILE_ACCESS}.read_write)
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	reopen_read (fname: STRING) is
			-- Reopen in read-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_open_read (fname)
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	reopen_write (fname: STRING) is
			-- Reopen in write-only mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_open_write (fname)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	reopen_append (fname: STRING) is
			-- Reopen in append mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_open_append (fname)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	reopen_read_write (fname: STRING) is
			-- Reopen in read-write mode with file of name `fname'.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_open_read_write (fname)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	recreate_read_write (fname: STRING) is
			-- Reopen in read-write mode with file of name `fname';
			-- create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_create_read_write (fname)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	reopen_read_append (fname: STRING) is
			-- Reopen in read and write-at-end mode with file
			-- of name `fname'; create file if it does not exist.
		require
			is_open: not is_closed
			valid_name: fname /= Void
		do
			close
			make_open_read_append (fname)
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	close is
			-- Close file.
		do
			internal_stream.close
			mode := Closed_file
			descriptor_available := False
			internal_sread := Void
			internal_swrite := Void
		ensure then
			is_closed: is_closed
		end

feature -- Cursor movement

	start is
			-- Go to first position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			i := internal_stream.seek ((0).to_integer_64, feature {SEEK_ORIGIN}.begin)
		end

	finish is
			-- Go to last position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			i := internal_stream.seek ((0).to_integer_64, feature {SEEK_ORIGIN}.end_)
		end

	forth is
			-- Go to next position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			i := internal_stream.seek ((1).to_integer_64, feature {SEEK_ORIGIN}.current_)
		end

	back is
			-- Go back one position.
		local
			i: INTEGER_64
		do
			i := internal_stream.seek ((-1).to_integer_64, feature {SEEK_ORIGIN}.current_)
		end

	move (offset: INTEGER) is
			-- Advance by `offset' from current location.
		require
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			i := internal_stream.seek (offset.to_integer_64, feature {SEEK_ORIGIN}.current_)
		end

	go (abs_position: INTEGER) is
			-- Go to the absolute `position'.
			-- (New position may be beyond physical length.)
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		do
			internal_stream.set_position (abs_position.to_integer_64)
		end

	recede (abs_position: INTEGER) is
			-- Go to the absolute `position' backwards,
			-- starting from end of file.
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		local
			i: INTEGER_64
		do
			i := internal_stream.seek (abs_position.to_integer_64, feature {SEEK_ORIGIN}.end_)
		end

	next_line is
			-- Move to next input line.
		require
			is_readable: file_readable
		local
			c: INTEGER
			eol, eof: INTEGER
		do
			from
				c := internal_stream.read_byte
				eol := ('%N').code
				eof := -1
			until
				c = eol or c = eof
			loop
				c := internal_stream.read_byte
			end
		end

feature -- Element change

	extend (v: CHARACTER) is
			-- Include `v' at end.
		local
			cpos: INTEGER_64
		do
			cpos := internal_stream.get_position
			finish
			put_character (v)
			internal_stream.set_position (cpos)
		end

	flush is
			-- Flush buffered data to disk.
			-- Note that there is no guarantee that the operating
			-- system will physically write the data to the disk.
			-- At least it will end up in the buffer cache,
			-- making the data visible to other processes.
		require
			is_open: not is_closed
		do
			internal_stream.flush
		end

	link (fn: STRING) is
			-- Link current file to `fn'.
			-- `fn' must not already exist.
		require
			file_exists: exists
			-- `fn' does not exist already
		do
			
		end

	append (f: like Current) is
			-- Append a copy of the contents of `f'.
		require else
			target_is_closed: is_closed
			source_is_closed: f.is_closed
		local
			buf: NATIVE_ARRAY [INTEGER_8]
			bs, rd: INTEGER
			st, ost: FILE_STREAM
		do
				-- Open in append mode.
			open_append
				-- Open `f' in read mode.
			f.open_read
				-- Append contents of `f'.
			bs := 10000
			from
				st := internal_stream
				ost := f.internal_stream
				buf := (create {ARRAY [INTEGER_8]}.make (1, bs)).area.native_array
			until
				f.after
			loop
				rd := ost.read (buf, 0, bs)
				st.write (buf, 0, rd)
			end
				-- Close both files.
			close
			f.close
		ensure then
			new_count: count = old count + f.count
			files_closed: f.is_closed and is_closed
		end

	put_integer, putint (i: INTEGER) is
			-- Write `i' at current position.
		deferred
		end

	put_boolean, putbool (b: BOOLEAN) is
			-- Write `b' at current position.
		deferred
		end

	put_real, putreal (r: REAL) is
			-- Write `r' at current position.
		deferred
		end

	put_double, putdouble (d: DOUBLE) is
			-- Write `d' at current position.
		deferred
		end

	put_string, putstring (s: STRING) is
			-- Write `s' at current position.
		local
			ext_s: SYSTEM_STRING
		do
			if s.count /= 0 then
				ext_s := s.to_cil
				writer.write_string (ext_s)
			end
		end

	put_character, putchar (c: CHARACTER) is
			-- Write `c' at current position.
		do
			writer.write_char (c)
		end

	put_new_line, new_line is
			-- Write a new line character at current position.
		do
			writer.write_line
		end

	stamp (time: INTEGER) is
			-- Stamp with `time' (for both access and modification).
		require
			file_exists: exists
		local
			t: SYSTEM_DATE_TIME
		do
			t := feature {SYSTEM_DATE_TIME}.from_file_time (time.to_integer_64)
			internal_file.set_last_access_time (t)
			internal_file.set_last_write_time (t)
		ensure
			date_updated: date = time	-- But race condition possible
		end

	set_access (time: INTEGER) is
			-- Stamp with `time' (access only).
		require
			file_exists: exists
		local
			t: SYSTEM_DATE_TIME
		do
			t := feature {SYSTEM_DATE_TIME}.from_file_time (time.to_integer_64)
			internal_file.set_last_access_time (t)
		ensure
			acess_date_updated: access_date = time	-- But race condition might occur
			date_unchanged: date = old date	-- Modulo a race condition
		end

	set_date (time: INTEGER) is
			-- Stamp with `time' (modification time only).
		require
			file_exists: exists
		local
			t: SYSTEM_DATE_TIME
		do
			t := feature {SYSTEM_DATE_TIME}.from_file_time (time.to_integer_64)
			internal_file.set_last_write_time (t)
		ensure
			access_date_unchanged: access_date = old access_date	-- But race condition might occur
			date_updated: date = time					-- Modulo a race condition
		end

	change_name (new_name: STRING) is
			-- Change file name to `new_name'
		require
			new_name_not_void: new_name /= Void
			file_exists: exists
		do
			internal_file.move_to (new_name.to_cil)
		ensure
			name_changed: name.is_equal (new_name)
		end

	add_permission (who, what: STRING) is
			-- Add read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void
			what_is_not_void: what /= Void
			file_descriptor_exists: exists
		do
			
		end

	remove_permission (who, what: STRING) is
			-- Remove read, write, execute or setuid permission
			-- for `who' ('u', 'g' or 'o') to `what'.
		require
			-- `who @ 1 in {u, g, o}'
			-- For every `i' in 1 .. `what'.`count', `what' @ `i' in {w, r, x, s, t}'
			who_is_not_void: who /= Void
			what_is_not_void: what /= Void
			file_descriptor_exists: exists
		do
			
		end

	change_mode (mask: INTEGER) is
			-- Replace mode by `mask'.
		require
			file_exists: exists
		do
		end

	change_owner (new_owner_id: INTEGER) is
			-- Change owner of file to `new_owner_id' found in
			-- system password file. On some systems this
			-- requires super-user privileges.
		require
			file_exists: exists
		do
		end

	change_group (new_group_id: INTEGER) is
			-- Change group of file to `new_group_id' found in
			-- system password file.
		require
			file_exists: exists
		do
		end

	change_date: INTEGER is
			-- Time stamp of last change.
		require
			file_exists: exists
		do
			Result := internal_file.get_last_write_time.to_file_time.to_integer
		end

	touch is
			-- Update time stamp (for both access and modification).
		require
			file_exists: exists
		local
			now: SYSTEM_DATE_TIME
		do
			now := feature {SYSTEM_DATE_TIME}.get_now
			internal_file.set_last_access_time (now)
			internal_file.set_last_write_time (now)
		ensure
			date_changed: date /= old date	-- Race condition nearly impossible
		end

	basic_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		do
			c_basic_store (descriptor, $object)
		end
 
	general_store (object: ANY) is
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

	independent_store (object: ANY) is
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			c_independent_store (descriptor, $object)
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		require else
			is_closed: is_closed
		do
			open_write
			close
		end

	delete is
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		require
			exists: exists
		do
			internal_file.delete
		end

	reset (fn: STRING) is
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		do
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
			make (fn)
		ensure
			file_renamed: name = fn
			file_closed: is_closed
		end

feature -- Input

	read_real, readreal is
			-- Read a new real.
			-- Make result available in `last_real'.
		require else
			is_readable: file_readable
		deferred
		end

	read_double, readdouble is
			-- Read a new double.
			-- Make result available in `last_double'.
		require else
			is_readable: file_readable
		deferred
		end

	read_character, readchar is
			-- Read a new character.
			-- Make result available in `last_character'.
		require else
			is_readable: file_readable
		do
			last_character := reader.read.to_character
		end

	read_integer, readint is
			-- Read a new integer.
			-- Make result available in `last_integer'.
		require else
			is_readable: file_readable
		deferred
		end

	read_line, readline is
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
			create last_string.make_from_cil (reader.read_line)
		end

	read_stream, readstream (nb_char: INTEGER) is
			-- Read a string of at most `nb_char' bound characters
			-- or until end of file.
			-- Make result available in `last_string'.
		require else
			is_readable: file_readable
		local
			new_count: INTEGER
			str_area: NATIVE_ARRAY [CHARACTER]
		do
			last_string.grow (nb_char)
			str_area := last_string.area.native_array
			new_count := reader.read_array_char (str_area, 0, nb_char)
			last_string.make_from_special (str_area)
		end

	read_word, readword is
			-- Read a string, excluding white space and stripping
			-- leading white space.
			-- Make result available in `last_string'.
			-- White space characters are: blank, new_line, tab,
			-- vertical tab, formfeed, end of file.
		require
			is_readable: file_readable
		local
			blanks: STRING
			ri: INTEGER
			rc: CHARACTER
		do
				-- Clean previous stored string.
			last_string.wipe_out

				-- Initialize list of blanks character
			blanks := internal_separators

				-- Read until we find a character which is not a 
				-- separator.
			from
				ri := reader.read
				if ri /= -1 then
					rc := ri.to_character
				end
			until
				ri = -1 or else not blanks.has (rc)
			loop
				ri := reader.read
				if ri /= -1 then
					rc := ri.to_character
				else
					rc := ' '
				end
			end

			last_string.extend (rc)

			from
				ri := reader.read
				if ri /= -1 then
					rc := ri.to_character
				end
			until
				ri = -1 or else blanks.has (rc)
			loop
				last_string.extend (rc)
				ri := reader.read
				if ri /= -1 then
					rc := ri.to_character
				end
			end

			if ri /= -1 then
				back
			end
		end

feature -- Convenience

	copy_to (file: like Current) is
			-- Copy content of current from current cursor
			-- position to end of file into `file' from
			-- current cursor position of `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
			current_is_open_read: is_open_read
		do
			read_stream (count)
			file.put_string (last_string)
			create last_string.make (256)
		end

feature {FILE} -- Implementation

	internal_file: FILE_INFO
			-- File data concerning `Current'

	internal_stream: FILE_STREAM
			-- File stream relative to `Current'

	reader: TEXT_READER is
			-- Stream reader used to read in `Current' (if possible).
		do
			if internal_sread = Void and internal_stream.get_can_read then
				create {STREAM_READER} internal_sread.make_stream_reader (internal_stream)
			end
			Result := internal_sread
		end

	writer: TEXT_WRITER is
			-- Stream writer used to write in `Current' (if possible).
		do
			if internal_swrite = Void and internal_stream.get_can_write then
				create {STREAM_WRITER} internal_swrite.make_stream_writer (internal_stream)
			end
			Result := internal_swrite
		end

feature {NONE} -- Implementation

	internal_sread: TEXT_READER
			-- Stream reader used to read in `Current' (if any).

	internal_swrite: TEXT_WRITER
			-- Stream writer used to write in `Current' (if any).

	true_string: STRING is
			-- Character string "true"
		once
			Result := "True"
		end

	false_string: STRING is
			-- Character string "false"
		once
			Result := "False"
		end

	buffered_file_info: UNIX_FILE_INFO is
			-- Information about the file.
		once
			create Result.make
		end

	set_buffer is
			-- Resynchronizes information on file
		require
			file_exists: exists
		do
			buffered_file_info.update (name)
		end

	c_retrieved (file_handle: INTEGER): ANY is
			-- Object structured retrieved from file of pointer
			-- `file_ptr'
		do
			check
				not_implemented: False
			end
		end
 
	c_basic_store (file_handle: INTEGER; object: POINTER) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		do
			check
				not_implemented: False
			end
		end
 
	c_general_store (file_handle: INTEGER; object: POINTER)is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		do
			check
				not_implemented: False
			end
		end
 
	c_independent_store (file_handle: INTEGER; object: POINTER) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		do
			check
				not_implemented: False
			end
		end

feature {NONE} -- Inapplicable

	go_to (r: CURSOR) is
			-- Move to position marked `r'.
		do
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		require else
			is_writable: file_writable
		do
		ensure then
			item = v
			count = old count
		end

	prunable: BOOLEAN is
			-- Is there an item to be removed?
		do
		end

	remove is
			-- Remove current item.
		require else
			file_prunable: file_prunable
		do
		end

	prune (v: like item) is
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

	Closed_file: INTEGER is 0
	Read_file: INTEGER is 1
	Write_file: INTEGER	is 2
	Append_file: INTEGER is 3
	Read_Write_file: INTEGER is 4
	Append_Read_file: INTEGER is 5

	set_read_mode is
			-- Define file mode as read.
		do
			mode := Read_file
		end

	set_write_mode is
			-- Define file mode as write.
		do
			mode := Write_file
		end

feature {NONE} -- Implementation

	get_fd (hdl: INTEGER; omode: INTEGER): INTEGER is
			-- Return the file descriptor corresponding to the handle `hdl' (Windows only).
		external
			"C (EIF_INTEGER, EIF_INTEGER): EIF_INTEGER | %"io.h%""
		alias
			"_open_osfhandle"
		end

	c_append: INTEGER is 8
	c_readwrite: INTEGER is 2
	c_write: INTEGER is 1
	c_read: INTEGER is 0
	c_open_modifier: INTEGER is deferred end
			-- Flag that choses between binary and plain text mode.

	internal_separators: STRING is " %N%R%T%U"
			-- Characters that are considered as separators.

invariant

	valid_mode: Closed_file <= mode and mode <= Append_read_file
	name_exists: name /= Void
	name_not_empty: not name.is_empty

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

end -- class FILE


