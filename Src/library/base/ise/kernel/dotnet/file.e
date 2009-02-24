note

	description:
		"Sequential files, viewed as persistent sequences of characters"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			create internal_file.make (fn.to_cil)
			mode := Closed_file
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			name := fn
		ensure
			file_named: name = fn
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
			if not is_closed and then attached internal_stream as l_stream then
				Result := l_stream.position.to_integer
			end
		end

	descriptor: INTEGER
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

	file_pointer: POINTER
			-- File pointer as required in C
		do
			if not is_closed and then attached {FILE_STREAM} internal_stream as l_file then
				Result := l_file.handle
			end
		end

	file_info: UNIX_FILE_INFO
			-- Collected information about the file.
		do
			set_buffer
			Result := buffered_file_info.twin
		end

	inode: INTEGER
			-- I-node number
		require
			file_exists: exists
		do
			Result := 0
		end

	links: INTEGER
			-- Number of links on file
		require
			file_exists: exists
		do
			Result := 1
		end

	user_id: INTEGER
			-- User identification of owner
		require
			file_exists: exists
		do
			Result := 0
		end

	group_id: INTEGER
			-- Group identification of owner
		require
			file_exists: exists
		do
			Result := 0
		end

	protection: INTEGER
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

	owner_name: STRING
			-- Name of owner
		require
			file_exists: exists
		do
			Result := "0"
		end

	date: INTEGER
			-- Time stamp (time of last modification)
		require
			file_exists: exists
		do
			internal_file.refresh
			Result := eiffel_file_date_time (internal_file.last_write_time.to_universal_time)
		end

	access_date: INTEGER
			-- Time stamp of last access made to the inode.
		require
			file_exists: exists
		do
			internal_file.refresh
			Result := eiffel_file_date_time (internal_file.last_access_time.to_universal_time)
		end

	retrieved: ANY
			-- Retrieved object structure
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if content is not a stored Eiffel structure.
		local
			l_formatter: BINARY_FORMATTER
			l_result: detachable ANY
		do
			create l_formatter.make
			l_result := l_formatter.deserialize (internal_stream)
			check l_result_attached: l_result /= Void end
			Result := l_result
		end

feature -- Measurement

	count: INTEGER
			-- Size in bytes (0 if no associated physical file)
		do
			if exists then
				if not is_open_write then
					internal_file.refresh
					if not is_directory then
						Result := internal_file.length.to_integer
					end
				elseif attached internal_stream as l_stream then
					Result := l_stream.length.to_integer
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
			Result := internal_end_of_file
		end

	exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			l_directory: DIRECTORY
		do
			internal_file.refresh
			Result := internal_file.exists
			if not Result then -- May return `False' on directories
				create l_directory.make (name)
				Result := l_directory.exists
			end
		ensure then
			unchanged_mode: mode = old mode
		end

	access_exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses real UID.)
		do
			internal_file.refresh
			Result := internal_file.exists
		end

	is_readable: BOOLEAN
			-- Is file readable?
			-- (Checks permission for effective UID.)
		local
			perm: FILE_IO_PERMISSION
			retried: BOOLEAN
		do
			if not retried then
				internal_file.refresh
				create perm.make_from_access_and_path ({FILE_IO_PERMISSION_ACCESS}.read,
					internal_file.full_name)
				perm.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_writable: BOOLEAN
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		local
			perm: FILE_IO_PERMISSION
			retried: BOOLEAN
		do
			if not retried then
				internal_file.refresh
				create perm.make_from_access_and_path ({FILE_IO_PERMISSION_ACCESS}.write,
					internal_file.full_name)
				perm.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_executable: BOOLEAN
			-- Is file executable?
			-- (Checks execute permission for effective UID.)
		do
			Result := True
		end

	is_creatable: BOOLEAN
			-- Is file creatable in parent directory?
			-- (Uses effective UID to check that parent is writable
			-- and file does not exist.)
		local
			perm: FILE_IO_PERMISSION
			retried: BOOLEAN
		do
			if not retried then
					-- Is the parent directory writable?
				internal_file.refresh
				create perm.make_from_access_and_path ({FILE_IO_PERMISSION_ACCESS}.read,
					internal_file.directory_name)
				perm.demand
				Result := not exists or else writable
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	is_plain: BOOLEAN
			-- Is file a plain file?
		require
			file_exists: exists
		do
			Result := not is_directory and not is_device
		end

	is_device: BOOLEAN
			-- Is file a device?
		require
			file_exists: exists
		do
			internal_file.refresh
			Result := (internal_file.attributes & {FILE_ATTRIBUTES}.device) =
				{FILE_ATTRIBUTES}.device
		end

	is_directory: BOOLEAN
			-- Is file a directory?
		require
			file_exists: exists
		do
			internal_file.refresh
			Result := (internal_file.attributes & {FILE_ATTRIBUTES}.directory) =
				{FILE_ATTRIBUTES}.directory
		end

	is_symlink: BOOLEAN
			-- Is file a symbolic link?
		require
			file_exists: exists
		do
			Result := False
		end

	is_fifo: BOOLEAN
			-- Is file a named pipe?
		require
			file_exists: exists
		do
			Result := False
		end

	is_socket: BOOLEAN
			-- Is file a named socket?
		require
			file_exists: exists
		do
			Result := False
		end

	is_block: BOOLEAN
			-- Is file a block special file?
		require
			file_exists: exists
		do
			Result := False
		end

	is_character: BOOLEAN
			-- Is file a character special file?
		require
			file_exists: exists
		do
			Result := False
		end

	is_setuid: BOOLEAN
			-- Is file setuid?
		require
			file_exists: exists
		do
			Result := False
		end

	is_setgid: BOOLEAN
			-- Is file setgid?
		require
			file_exists: exists
		do
			Result := False
		end

	is_sticky: BOOLEAN
			-- Is file sticky (for memory swaps)?
		require
			file_exists: exists
		do
			Result := False
		end

	is_owner: BOOLEAN
			-- Is file owned by effective UID?
		require
			file_exists: exists
		do
			Result := True
		end

	is_access_readable: BOOLEAN
			-- Is file readable by real UID?
		require
			file_exists: exists
		do
			Result := is_readable
		end

	is_access_writable: BOOLEAN
			-- Is file writable by real UID?
		require
			file_exists: exists
		do
			Result := is_writable
		end

	is_access_executable: BOOLEAN
			-- Is file executable by real UID?
		require
			file_exists: exists
		do
			Result := is_executable
		end

	is_access_owner: BOOLEAN
			-- Is file owned by real UID?
		require
			file_exists: exists
		do
			Result := True
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

feature -- Comparison

	same_file (fn: STRING): BOOLEAN
			-- Is current file the same as `a_filename'?
		require
			fn_not_void: fn /= Void
			fn_not_empty: not fn.is_empty
		local
			l_comparer: FILE_COMPARER
		do
			create l_comparer
			Result := l_comparer.same_files (name, fn)
		end

feature -- Status setting

	open_read
			-- Open file in read-only mode.
		require
			is_closed: is_closed
		do
			internal_file.refresh
			internal_stream := internal_file.open_read
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	open_write
			-- Open file in write-only mode;
			-- create it if it does not exist.
		do
			internal_file.refresh
			internal_stream := internal_file.open_file_mode_file_access (
				{FILE_MODE}.create_, {FILE_ACCESS}.write)
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
		do
			internal_file.refresh
			internal_stream := internal_file.open_file_mode_file_access (
				{FILE_MODE}.append, {FILE_ACCESS}.write)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	open_read_write
			-- Open file in read and write mode.
		require
			is_closed: is_closed
		do
			internal_file.refresh
			internal_stream := internal_file.open_file_mode_file_access (
				{FILE_MODE}.open, {FILE_ACCESS}.read_write)
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
		do
			internal_file.refresh
			internal_stream := internal_file.open_file_mode_file_access (
				{FILE_MODE}.create_, {FILE_ACCESS}.read_write)
			mode := Read_write_file
		ensure
			exists: exists
			open_read: is_open_read
			open_write: is_open_write
		end

	open_read_append
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

	fd_open_read (fd: INTEGER)
			-- Open file of descriptor `fd' in read-only mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			create {FILE_STREAM} internal_stream.make (hdl, {FILE_ACCESS}.read)
			mode := Read_file
		ensure
			exists: exists
			open_read: is_open_read
		end

	fd_open_write (fd: INTEGER)
			-- Open file of descriptor `fd' in write mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			create {FILE_STREAM} internal_stream.make (hdl, {FILE_ACCESS}.write)
			mode := Write_file
		ensure
			exists: exists
			open_write: is_open_write
		end

	fd_open_append (fd: INTEGER)
			-- Open file of descriptor `fd' in append mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			create {FILE_STREAM} internal_stream.make (hdl, {FILE_ACCESS}.write)
			mode := Append_file
		ensure
			exists: exists
			open_append: is_open_append
		end

	fd_open_read_write (fd: INTEGER)
			-- Open file of descriptor `fd' in read-write mode.
		local
			hdl: POINTER
		do
			hdl := hdl + fd
			create {FILE_STREAM} internal_stream.make (hdl, {FILE_ACCESS}.read_write)
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
			hdl: POINTER
		do
			hdl := hdl + fd
			create {FILE_STREAM} internal_stream.make (hdl, {FILE_ACCESS}.read_write)
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
		do
			close
			make_open_read (fname)
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
		do
			close
			make_open_write (fname)
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
		do
			close
			make_open_append (fname)
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
		do
			close
			make_open_read_write (fname)
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
		do
			close
			make_create_read_write (fname)
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
		do
			close
			make_open_read_append (fname)
			mode := Append_read_file
		ensure
			exists: exists
			open_read: is_open_read
			open_append: is_open_append
		end

	close
			-- Close file.
		do
			if attached internal_sread as l_sread then
				l_sread.close
			end
			if attached internal_swrite as l_swrite then
				l_swrite.close
			end
			if attached internal_stream as l_stream then
				l_stream.close
			end
			mode := Closed_file
			descriptor_available := False
			internal_sread := Void
			internal_swrite := Void
			internal_end_of_file := False
		ensure then
			is_closed: is_closed
		end

feature -- Cursor movement

	start
			-- Go to first position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek ((0).to_integer_64, {SEEK_ORIGIN}.begin)
			end
		end

	finish
			-- Go to last position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek ((0).to_integer_64, {SEEK_ORIGIN}.end_)
			end
		end

	forth
			-- Go to next position.
		require else
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek ((1).to_integer_64, {SEEK_ORIGIN}.current_)
			end
		end

	back
			-- Go back one position.
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek ((-1).to_integer_64, {SEEK_ORIGIN}.current_)
			end
		end

	move (offset: INTEGER)
			-- Advance by `offset' from current location.
		require
			file_opened: not is_closed
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek (offset.to_integer_64, {SEEK_ORIGIN}.current_)
			end
		end

	go (abs_position: INTEGER)
			-- Go to the absolute `position'.
			-- (New position may be beyond physical length.)
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		do
			if attached internal_stream as l_stream then
				l_stream.set_position (abs_position.to_integer_64)
			end
		end

	recede (abs_position: INTEGER)
			-- Go to the absolute `position' backwards,
			-- starting from end of file.
		require
			file_opened: not is_closed
			non_negative_argument: abs_position >= 0
		local
			i: INTEGER_64
		do
			if attached internal_stream as l_stream then
				i := l_stream.seek (-abs_position.to_integer_64, {SEEK_ORIGIN}.end_)
			end
		end

	next_line
			-- Move to next input line.
		require
			is_readable: file_readable
		local
			c: INTEGER
			eol, eof: INTEGER
		do
			if attached internal_stream as l_stream then
				from
					c := l_stream.read_byte
					eol := ('%N').code
					eof := -1
				until
					c = eol or c = eof
				loop
					c := l_stream.read_byte
				end
			end
		end

feature -- Element change

	extend (v: CHARACTER)
			-- Include `v' at end.
		local
			cpos: INTEGER_64
		do
			if attached internal_stream as l_stream then
				cpos := l_stream.position
				finish
				put_character (v)
				l_stream.set_position (cpos)
			end
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
			if attached internal_stream as l_stream then
				l_stream.flush
			end
		end

	link (fn: STRING)
			-- Link current file to `fn'.
			-- `fn' must not already exist.
		require
			file_exists: exists
			-- `fn' does not exist already
		do

		end

	append (f: like Current)
			-- Append a copy of the contents of `f'.
		require else
			target_is_closed: is_closed
			source_is_closed: f.is_closed
		local
			buf: NATIVE_ARRAY [NATURAL_8]
			bs, rd: INTEGER
			st, ost: like internal_stream
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
				check
					ost_attached: ost /= Void
					st_attached: st /= Void
				end
				create buf.make (bs + 1)
				rd := ost.read (buf, 0, bs)
			until
				rd = 0
			loop
				st.write (buf, 0, rd)
				rd := ost.read (buf, 0, bs)
			end
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
			i: INTEGER
			l_count: INTEGER
			str_area: NATIVE_ARRAY [NATURAL_8]
		do
			l_count := s.count
			if l_count /= 0 then
				create str_area.make (l_count)
				from
					i := 1
				until
					i > l_count
				loop
					str_area.put (i-1, s.item (i).code.to_natural_8)
					i := i + 1
				end
				if attached internal_stream as l_stream then
					l_stream.write (str_area, 0, l_count)
				end
			end
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Put data of length `nb_bytes' pointed by `start_pos' index in `p' at
			-- current position.
		local
			i, nb: INTEGER
		do
			if attached internal_stream as l_stream then
				from
					i := start_pos
					nb := i + nb_bytes
				until
					i = nb
				loop
					l_stream.write_byte (p.read_natural_8 (i))
					i := i + 1
				end
			end
		end

	put_character, putchar (c: CHARACTER)
			-- Write `c' at current position.
		do
			if attached internal_stream as l_stream then
				l_stream.write_byte (c.code.to_natural_8)
			end
		end

	put_new_line, new_line
			-- Write a new line character at current position.
		do
			check
				eiffel_newline_valid_count: eiffel_newline.count = 1
			end
			if attached internal_stream as l_stream then
				l_stream.write_byte (eiffel_newline.item (1).code.to_natural_8)
			end
		end

	stamp (time: INTEGER)
			-- Stamp with `time' (for both access and modification).
		require
			file_exists: exists
		do
			set_access (time)
			set_date (time)
		ensure
			date_updated: date = time	-- But race condition possible
		end

	set_access (time: INTEGER)
			-- Stamp with `time' (access only).
		require
			file_exists: exists
		do
			internal_file.refresh
			internal_file.set_last_access_time (dot_net_file_date_time (time))
		ensure
			acess_date_updated: access_date = time	-- But race condition might occur
			date_unchanged: date = old date	-- Modulo a race condition
		end

	set_date (time: INTEGER)
			-- Stamp with `time' (modification time only).
		require
			file_exists: exists
		do
			internal_file.refresh
			internal_file.set_last_write_time (dot_net_file_date_time (time))
		ensure
			access_date_unchanged: access_date = old access_date -- But race condition might occur
			date_updated: date = time -- Modulo a race condition
		end

	change_name (new_name: STRING)
			-- Change file name to `new_name'
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			file_exists: exists
		local
			l_info: FILE_INFO
		do
			create l_info.make (new_name.to_cil)
			if l_info.exists and not same_file (new_name) then
				l_info.delete
			end
			internal_file.refresh
			internal_file.move_to (new_name.to_cil)
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
		do

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
		do

		end

	change_mode (mask: INTEGER)
			-- Replace mode by `mask'.
		require
			file_exists: exists
		do
		end

	change_owner (new_owner_id: INTEGER)
			-- Change owner of file to `new_owner_id' found in
			-- system password file. On some systems this
			-- requires super-user privileges.
		require
			file_exists: exists
		do
		end

	change_group (new_group_id: INTEGER)
			-- Change group of file to `new_group_id' found in
			-- system password file.
		require
			file_exists: exists
		do
		end

	change_date: INTEGER
			-- Time stamp of last change.
		require
			file_exists: exists
		do
			internal_file.refresh
			Result := eiffel_file_date_time (internal_file.last_write_time.to_universal_time)
		end

	touch
			-- Update time stamp (for both access and modification).
		require
			file_exists: exists
		local
			now: SYSTEM_DATE_TIME
		do
			now := {SYSTEM_DATE_TIME}.now
			internal_file.refresh
			internal_file.set_last_access_time (now)
			internal_file.set_last_write_time (now)
		ensure
			date_changed: date /= old date	-- Race condition nearly impossible
		end

	basic_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable within current system only.
		local
			l_formatter: BINARY_FORMATTER
		do
			create l_formatter.make
			l_formatter.serialize (internal_stream, object)
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
			basic_store (object)
		end

	independent_store (object: ANY)
			-- Produce an external representation of the
			-- entire object structure reachable from `object'.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		do
			basic_store (object)
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
		do
			internal_file.delete
			internal_file.refresh
		end

	reset (fn: STRING)
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		do
			if mode /= Closed_file then
				close
			end
			make (fn)
			last_integer := 0
			if attached last_string as l_last_string then
				l_last_string.wipe_out
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
		local
		  	a_code: INTEGER
		do
			if attached internal_stream as l_stream then
				a_code := l_stream.read_byte
				if a_code = - 1 then
					internal_end_of_file := True
				else
					last_character := a_code.to_character_8
				end
			end
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
			i, c: INTEGER
			str_cap: INTEGER
			done: BOOLEAN
			l_last_string: like last_string
		do
			if attached internal_stream as l_stream then
				from
					l_last_string := last_string
					if l_last_string = Void then
						create_last_string (1024)
						l_last_string := last_string
						check l_last_string_attached: l_last_string /= Void end
					else
						l_last_string.clear_all
					end
					done := False
					i := 0
					str_cap := l_last_string.capacity
				until
					done
				loop
					c := l_stream.read_byte
					if c = 13 and then peek = 10 then
							-- Discard end of line in the form "%R%N".
						c := l_stream.read_byte
						done := True
					elseif c = 10 then
							-- Discard end of line in the form "%N".
						done := True
					elseif c = -1 then
						internal_end_of_file := True
						done := True
					else
						i := i + 1
						if i > str_cap then
							if str_cap < 2048 then
								l_last_string.grow (str_cap + 1024)
								str_cap := str_cap + 1024
							else
								l_last_string.automatic_grow
								str_cap := l_last_string.capacity
							end
						end
						l_last_string.append_character (c.to_character_8)
					end
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
			str_area: NATIVE_ARRAY [NATURAL_8]
			l_last_string: like last_string
		do
			l_last_string := last_string
			if l_last_string = Void then
				create_last_string (nb_char)
				l_last_string := last_string
				check l_last_string_attached: l_last_string /= Void end
			else
				l_last_string.clear_all
				l_last_string.grow (nb_char)
			end
			create str_area.make (nb_char)
			if attached internal_stream as l_stream then
				new_count := l_stream.read (str_area, 0, nb_char)
			end
			if new_count = -1  then
				l_last_string.set_count (0)
				internal_end_of_file := True
			else
				set_string (str_area, 0, new_count, l_last_string)
				l_last_string.set_count (new_count)
				internal_end_of_file := peek = -1
			end
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- Read at most `nb_bytes' bound bytes and make result
			-- available in `p' at position `start_pos'.
		require else
			p_not_void: p /= Void
			p_large_enough: p.count >= nb_bytes + start_pos
			is_readable: file_readable
		local
			i, nb, l_byte, l_read: INTEGER
		do
			if attached internal_stream as l_stream then
				from
					i := start_pos
					nb := nb_bytes + i
				until
					i = nb
				loop
					l_byte := l_stream.read_byte
					if l_byte = -1 then
						internal_end_of_file := True
						i := nb - 1 -- Jump out of loop
					else
						l_read := l_read + 1
						p.put_natural_8 (l_byte.as_natural_8, i)
					end
					i := i + 1
				end
			end
			bytes_read := l_read
		end

	read_word, readword, read_word_thread_aware
			-- Read a string, excluding white space and stripping
			-- leading white space.
			-- Make result available in `last_string'.
			-- White space characters are: blank, new_line, tab,
			-- vertical tab, formfeed, end of file.
		require
			is_readable: file_readable
		local
			blanks: STRING
			old_c, rc: CHARACTER
			l_last_string: like last_string
		do
				-- Save previous state of `last_character' as we modify it
				-- by using `read_character'
			old_c := last_character

				-- Clean previous stored string.
			l_last_string := last_string
			if l_last_string = Void then
				create_last_string (0)
				l_last_string := last_string
				check l_last_string_attached: l_last_string /= Void end
			else
				l_last_string.clear_all
			end

				-- Initialize list of blanks character
			blanks := internal_separators

				-- Read until we find a character which is not a
				-- separator.
			from
				read_character
				if not end_of_file then
					rc := last_character
				end
			until
				end_of_file or else not blanks.has (rc)
			loop
				read_character
				if not end_of_file then
					rc := last_character
				else
					rc := ' '
				end
			end

			l_last_string.extend (rc)

			from
				read_character
				if not end_of_file then
					rc := last_character
				end
			until
				end_of_file or else blanks.has (rc)
			loop
				l_last_string.extend (rc)
				read_character
				if not end_of_file then
					rc := last_character
				end
			end

			separator := last_character
			if not end_of_file then
				back
			end
			last_character := old_c
		ensure
			last_string_not_void: last_string /= Void
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
			l_pos: INTEGER
			l_old_last_string, l_last_string: like last_string
		do
			from
				l_read := 0
				nb := count
				l_modulo := 51200
				l_old_last_string := last_string
				last_string := Void
				l_pos := position
				if l_pos /= 0 then
					go (0)
				end
			until
				l_read >= nb
			loop
				read_stream (l_modulo)
				l_last_string := last_string
				check l_last_string_attached: l_last_string /= Void end
				file.put_string (l_last_string)
				l_read := l_read + l_modulo
			end
				-- Restore previous status of Current file.
			if l_pos /= 0 then
				go (l_pos)
			end
			last_string := l_old_last_string
		end

feature {FILE} -- Implementation

	internal_file: FILE_INFO
			-- File data concerning `Current'

	internal_stream: detachable SYSTEM_STREAM
			-- File stream relative to `Current'

	internal_end_of_file: BOOLEAN
			-- Did last call to `reader.read' reach end of file?

feature {NONE} -- Implementation

	create_last_string (a_min_size: INTEGER)
			-- Create new instance of `last_string' with a least `a_min_size'
			-- as capacity.
		require
			last_string_void: last_string = Void
			a_min_size_non_negative: a_min_size >= 0
		do
			create last_string.make (default_last_string_size.max (a_min_size))
		ensure
			last_string_not_void: last_string /= Void
			capacity_set: attached last_string as l_string and then l_string.capacity >= a_min_size
		end

	default_last_string_size: INTEGER = 256
			-- Default size for creating `last_string'

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

	internal_sread: detachable STREAM_READER
			-- Stream reader used to read in `Current' (if any).

	internal_swrite: detachable STREAM_WRITER
			-- Stream writer used to write in `Current' (if any).

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

	dot_net_base_file_time: INTEGER_64
			-- nano-seconds between 01/01/0001:00:00:00:00 and 01/01/1601:00:00:00:00
		local
			t: SYSTEM_DATE_TIME
		once
			t.make_with_year_and_month_and_day (1601 ,1 ,1 ,0 ,0 ,0 ,0)
			Result := t.ticks
		end

	eiffel_base_file_time: INTEGER_64
			-- nano-seconds between 01/01/0001:00:00:00:00 and 01/01/1970:00:00:00:00
		local
			t: SYSTEM_DATE_TIME
		once
			t.make_with_year_and_month (1970 ,1 ,1 ,0 ,0 ,0)
			Result := t.ticks
		end

	dot_net_time_offset: INTEGER_64
			-- the offset in nano-seconds between 01/01/1601:00:00:00:00 and 01/01/1970:00:00:00:00
		do
			Result := eiffel_base_file_time - dot_net_base_file_time
		end

	dot_net_file_date_time (time: INTEGER): SYSTEM_DATE_TIME
			-- convert an eiffel date to a .NET file date time
			-- 'eiffel_date' must be the seconds from 01/01/1970:00:00:00:00 (file system time)
			-- returns nano-seconds since 01/01/1601:00:00:00:00
		local
			t: SYSTEM_DATE_TIME
		do
			t.make_from_ticks (eiffel_base_file_time + (time.to_integer_64 * 10000000))
			Result := t
		end

	eiffel_file_date_time (dot_net_date: SYSTEM_DATE_TIME): INTEGER
			-- convert a .NET file date time to an eiffel date
			-- 'dot_net_date' must be the nano-seconds from 01/01/1601:00:00:00:00
			-- (file system time) returns seconds since 01/01/1970:00:00:00:00
		local
			i64: INTEGER_64
		do
			i64 := ((dot_net_date.ticks - eiffel_base_file_time) / 10000000).floor
			Result := i64.to_integer
		end

	mode: INTEGER
			-- Input-output mode

	Closed_file: INTEGER = 0
	Read_file: INTEGER = 1
	Write_file: INTEGER	= 2
	Append_file: INTEGER = 3
	Read_write_file: INTEGER = 4
	Append_read_file: INTEGER = 5

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

feature {NONE} -- Implementation

	peek: INTEGER
			-- Peek next character in file, but don't use it, e.g. don't move `position'.
			-- Return -1 if end of file has been reached, otherwise next character.
		require
			is_readable: file_readable
		do
			if attached internal_stream as l_stream then
				Result := l_stream.read_byte
				if Result /= -1 then
					back
				end
			end
		end

	set_string (buf: NATIVE_ARRAY [NATURAL_8]; offset, nb: INTEGER; str: STRING)
			-- Set `nb' bytes of data stored in `buf' starting from `offset'
			-- to `str'.
		require
			buf_not_void: buf /= Void
			offset_not_nagetive: offset >= 0
			nb_positive: nb > 0
			buf_count_large_enought: offset + nb <= buf.count
			str_not_void: str /= Void
			str_large_enough: str.capacity >= nb
		local
			i: INTEGER
			j: INTEGER
			l: INTEGER
			should_append: BOOLEAN
		do
			from
				j := offset
				i := 1
				l := str.count
			until
				i > nb
			loop
				if (not should_append) and then (i>l) then
					should_append := True
				end
				if should_append then
					str.append_character (buf.item (j).to_character_8)
				else
					str.put (buf.item (j).to_character_8, i)
				end
				i := i + 1
				j := j + 1
			end
		end

	get_fd (hdl: INTEGER; omode: INTEGER): INTEGER
			-- Return the file descriptor corresponding to the handle `hdl' (Windows only).
		external
			"C (EIF_INTEGER, EIF_INTEGER): EIF_INTEGER | %"io.h%""
		alias
			"_open_osfhandle"
		end

	eiffel_newline: STRING = "%N"
			-- Representation of Eiffel `%N' character as a SYSTEM_STRING.

	dotnet_newline: STRING = "%R%N"
			-- Representation of a .NET newline as a SYSTEM_STRING.

	c_append: INTEGER = 8
	c_readwrite: INTEGER = 2
	c_write: INTEGER = 1
	c_read: INTEGER = 0
	c_open_modifier: INTEGER deferred end
			-- Flag that choses between binary and plain text mode.

	internal_separators: STRING = " %N%R%T%U"
			-- Characters that are considered as separators.

invariant

	valid_mode: Closed_file <= mode and mode <= Append_read_file
	name_exists: name /= Void
	name_not_empty: not name.is_empty

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class FILE


