indexing
	description: "[
		Ojbect that manipulates a UNIX unnamed pipe.
		All the read_xxx features except read_stream_non_block in this class are block features.
		In other words, they will block until requested number of bytes have been read.
		While read_stream_non_block will read as much as requested bytes of data and will return with
		acturally read data if no other data is in the pipe.
		All the put_xxx features are block features.
		Note: Always check last_read_successful after a read_xxx feature and check last_write_successful
				   after a write_xxx feature.

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNIX_UNNAMED_PIPE

inherit
	PROCESS_UNIX_PIPE
		undefine
			make
		redefine
			dispose,
			close_read_descriptor,
			close_write_descriptor
		end

	IO_MEDIUM
		redefine
			dispose
		end

	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make (read_fd, write_fd: INTEGER) is
		require else
			read_descriptor_valid: read_fd >= 0
			write_descriptor_valid: write_fd >= 0
		do
			Precursor (read_fd, write_fd)
			is_read_descriptor_open := True
			is_write_descriptor_open := True
			create shared_mptr.make (initial_buffer_size)
		ensure then
			read_descriptor_set: read_descriptor = read_fd
			read_descriptor_open: is_read_descriptor_open
			write_descriptor_set: write_descriptor = write_fd
			write_descriptor_open: is_write_descriptor_open
		end

feature -- Access

	name: STRING is
		do
			Result := Void
		end

	retrieved: ANY is
		do
			(create {MISMATCH_CORRECTOR}).mismatch_information.do_nothing
			Result := c_retrieved (read_descriptor)
		end

	handle: INTEGER is
		do
			Result := invalid_descriptor
		end

	handle_available: BOOLEAN is
		do
			Result := False
		end

feature -- Removal

	dispose is
		do
			close
		end

	close is
		do
			close_read_descriptor
			close_write_descriptor
		end

feature -- Status report

	is_closed: BOOLEAN is
		do
			Result := (not is_read_descriptor_open) and (not is_write_descriptor_open)
		end

	is_open_read: BOOLEAN is
		do
			Result := is_read_descriptor_open
		end

	is_open_write: BOOLEAN is
		do
			Result := is_write_descriptor_open
		end

	is_readable: BOOLEAN is
		do
			Result := is_read_descriptor_open
		end

	is_writable: BOOLEAN is
		do
			Result := is_write_descriptor_open
		end

	readable: BOOLEAN is
		do
			Result := is_read_descriptor_open
		end

	is_executable: BOOLEAN is
		do
			Result := False
		end

	exists: BOOLEAN is
		do
			Result := is_read_descriptor_open or is_write_descriptor_open
		end

	extendible: BOOLEAN is
		do
			Result := is_write_descriptor_open
		end

	support_storable: BOOLEAN is
		do
			Result := True
		end

feature -- Status setting

	close_read_descriptor is
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor
				is_read_descriptor_open := False
			end
		rescue
			retried := True
			is_read_descriptor_open := False
			retry
		end

	close_write_descriptor is
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor
				is_write_descriptor_open := False
			end
		rescue
			retried := True
			is_write_descriptor_open := False
			retry
		end

feature -- Element change

	general_store (object: ANY) is
		do
			c_general_store (write_descriptor, $object)
		end

	independent_store (object: ANY) is
		do
			c_independent_store (write_descriptor, $object)
		end

	basic_store (object: ANY) is
		do
			c_basic_store (write_descriptor, $object)
		end

feature -- Input

	readreal, read_real is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `readreal'.
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.real_bytes)
			if last_read_successful then
				last_real := shared_mptr.read_real_32 (0)
			end
		end

	read_double, readdouble is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.double_bytes)
			if last_read_successful then
				last_double := shared_mptr.read_real_64 (0)
			end
		end

	read_character is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.character_bytes)
			if last_read_successful then
				last_character := shared_mptr.read_character (0)
			end
		end

	readchar is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.character_bytes)
			if last_read_successful then
				last_character := shared_mptr.read_character (0)
			end
		end

	read_integer, readint, read_integer_32 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.integer_32_bytes)
			if last_read_successful then
				last_integer := shared_mptr.read_integer_32 (0)
			end
		end

	read_integer_16 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.integer_16_bytes)
			if last_read_successful then
				last_integer_16 := shared_mptr.read_integer_16 (0)
			end
		end

	read_integer_8 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.integer_8_bytes)
			if last_read_successful then
				last_integer_8 := shared_mptr.read_integer_8 (0)
			end
		end

	read_integer_64 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.integer_64_bytes)
			if last_read_successful then
				last_integer_64 := shared_mptr.read_integer_64 (0)
			end
		end

	read_natural_8 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.natural_8_bytes)
			if last_read_successful then
				last_natural_8 := shared_mptr.read_natural_8 (0)
			end
		end

	read_natural_16 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.natural_16_bytes)
			if last_read_successful then
				last_natural_16 := shared_mptr.read_natural_16 (0)
			end
		end

	read_natural, read_natural_32 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.natural_32_bytes)
			if last_read_successful then
				last_natural := shared_mptr.read_natural_32 (0)
			end
		end

	read_natural_64 is
		do
			read_block (read_descriptor, shared_mptr.item, current_platform.natural_64_bytes)
			if last_read_successful then
				last_natural_64 := shared_mptr.read_natural_64 (0)
			end
		end

	read_stream (nb_char: INTEGER) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `readstream'.
		local
			mp: MANAGED_POINTER
			i: INTEGER
		do
			create mp.make (nb_char)
			read_block (read_descriptor, mp.item, nb_char)
			if last_read_successful then
				create last_string.make (nb_char)
				from
					i := 0
				until
					i = nb_char
				loop
					last_string.append_character (mp.read_natural_8 (i).to_character_8)
					i := i + 1
				end
			end
		end

	readstream (nb_char: INTEGER) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `read_stream'.
		local
			mp: MANAGED_POINTER
			i: INTEGER
		do
			create mp.make (nb_char)
			read_block (read_descriptor, mp.item, nb_char)
			if last_read_successful then
				create last_string.make (nb_char)
				from
					i := 0
				until
					i = nb_char
				loop
					last_string.append_character (mp.read_natural_8 (i).to_character_8)
					i := i + 1
				end
			end
		end

	read_stream_non_block (nb_char: INTEGER) is
		local
			count: INTEGER
			mp: MANAGED_POINTER
		do
			last_read_successful := True
			create mp.make (nb_char)
			count := read (read_descriptor, mp.item, nb_char)
			if count > 0 then
				create last_string.make (count + 1)
				last_string.from_c_substring (mp.item, 1, count)
			else
				last_string := Void
				if count = -1 then
					last_read_successful := False
				end
			end
			mp := Void
		end

	read_line is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `readline'.
		local
			done: BOOLEAN
			char: CHARACTER
		do
			from
				last_string := ""
			until
				done
			loop
				read_block (read_descriptor, shared_mptr.item, current_platform.character_bytes)
				if last_read_successful then
					char := shared_mptr.read_character (0)
					if char = '%N' then
						done := True
					else
						last_string.append_character (char)
					end
				else
					done := True
				end
			end
		end

	readline is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `read_line'.
		local
			done: BOOLEAN
			char: CHARACTER
		do
			from
				last_string := ""
			until
				done
			loop
				read_block (read_descriptor, shared_mptr.item, current_platform.character_bytes)
				if last_read_successful then
					char := shared_mptr.read_character (0)
					if char = '%N' then
						done := True
					else
						last_string.append_character (char)
					end
				else
					done := True
				end
			end
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
		do
			read_block (read_descriptor, p.item + start_pos, nb_bytes)
		end

feature -- Output

	put_new_line is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `new_line'.
		do
			put_character ('%N')
		end

	new_line is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `put_new_line'.
		do
			put_character ('%N')
		end

	put_character (c: CHARACTER) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `putchar'.
		do
			shared_mptr.put_character (c, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.character_bytes)
		end

	putchar (c: CHARACTER) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `put_character'.
		do
			shared_mptr.put_character (c, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.character_bytes)
		end

	put_string (s: STRING) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `putstring'.
		local
			mp: MANAGED_POINTER
			i: INTEGER
		do
			create mp.make (s.count)
			from
				i := 1
			until
				i > s.count
			loop
				mp.put_character (s.item (i), i - 1)
				i := i + 1
			end
			write_block (write_descriptor, mp.item, s.count)
		end

	putstring (s: STRING) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `put_string'.
		local
			mp: MANAGED_POINTER
			i: INTEGER
		do
			create mp.make (s.count)
			from
				i := 1
			until
				i > s.count
			loop
				mp.put_character (s.item (i), i - 1)
				i := i + 1
			end
			write_block (write_descriptor, mp.item, s.count)
		end

	putreal, put_real (r: REAL) is
		do
			shared_mptr.put_real_32 (r, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.real_bytes)
		end

	put_integer, putint, put_integer_32  (i: INTEGER) is
		do
			shared_mptr.put_integer_32 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.integer_32_bytes)
		end

	put_integer_64 (i: INTEGER_64) is
		do
			shared_mptr.put_integer_64 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.integer_64_bytes)
		end

	put_integer_16 (i: INTEGER_16) is
		do
			shared_mptr.put_integer_16 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.integer_16_bytes)
		end

	put_integer_8 (i: INTEGER_8) is
		do
			shared_mptr.put_integer_8 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.integer_8_bytes)
		end

	put_natural_8 (i: NATURAL_8) is
		do
			shared_mptr.put_natural_8 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.natural_8_bytes)
		end

	put_natural_16 (i: NATURAL_16) is
		do
			shared_mptr.put_natural_16 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.natural_16_bytes)
		end

	put_natural, put_natural_32 (i: NATURAL_32) is
		do
			shared_mptr.put_natural_32 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.natural_32_bytes)
		end

	put_natural_64 (i: NATURAL_64) is
		do
			shared_mptr.put_natural_64 (i, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.natural_64_bytes)
		end

	put_boolean (b: BOOLEAN) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `putbool'.
		do
			shared_mptr.put_boolean (b, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.boolean_bytes)
		end

	putbool (b: BOOLEAN) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `put_boolean'.
		do
			shared_mptr.put_boolean (b, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.boolean_bytes)
		end

	putdouble, put_double (d: DOUBLE) is
			-- Was declared in UNIX_UNNAMED_PIPE as synonym of `putdouble'.
		do
			shared_mptr.put_real_64 (d, 0)
			write_block (write_descriptor, shared_mptr.item, current_platform.double_bytes)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER) is
		do
			write_block (write_descriptor, p.item + start_pos, nb_bytes)
		end

feature -- Input

	read_block (fildes: INTEGER; buf: POINTER; size: INTEGER) is
			-- Read `size' byte of data into `buf' from `fildes'.
		local
			read_count, count: INTEGER
			size_left: INTEGER
			pos: INTEGER
			done: BOOLEAN
			retried_count: INTEGER
		do
			from
				read_count := 0
				count := 0
				size_left := size
				pos := 0
				done := False
				last_read_successful := True
				retried_count := 0
			until
				done
			loop
				count := read (fildes, buf + pos, size_left)
				if count = 0 then
					done := True
					is_write_descriptor_open := False
				elseif count = -1 then
					if retried_count < 1 then
						retried_count := retried_count + 1
					else
						done := True
						last_read_successful := False
					end
				else
					pos := pos + count
					size_left := size_left - count
					if size_left = 0 then
						done := True
					end
				end
			end
		end

	write_block (fildes: INTEGER; buf: POINTER; size: INTEGER) is
			-- Write `size' byte of data stored in `buf' to `fildes'.
		local
			write_count, count: INTEGER
			size_left: INTEGER
			pos: INTEGER
			done: BOOLEAN
			retried_count: INTEGER
		do
			from
				write_count := 0
				count := 0
				size_left := size
				pos := 0
				done := False
				last_write_successful := True
			until
				done
			loop
				count := write (fildes, buf.item + pos, size_left)
				if count <= 0 then
					if retried_count = 0 then
						retried_count := retried_count + 1
					else
						done := True
						last_write_successful := False
					end
				else
					pos := pos + count
					size_left := size_left - count
					if size_left = 0 then
						done := True
					end
				end
			end
		end

	read (fildes: INTEGER; buf: POINTER; size: INTEGER): INTEGER is
		external
			"C blocking signature (int, void*, size_t): ssize_t use <unistd.h>"
		end

	write (fildes: INTEGER; buf: POINTER; size: INTEGER): INTEGER is
		external
			"C blocking signature (int, void*, size_t): ssize_t use <unistd.h>"
		end

	c_basic_store (file_handle: INTEGER; object: POINTER) is
		external
			"C signature (EIF_INTEGER, EIF_REFERENCE) use %"eif_store.h%""
		alias
			"estore"
		end

	c_independent_store (file_handle: INTEGER; object: POINTER) is
		external
			"C signature (EIF_INTEGER, EIF_REFERENCE) use %"eif_store.h%""
		alias
			"sstore"
		end

	c_general_store (file_handle: INTEGER; object: POINTER) is
		external
			"C signature (EIF_INTEGER, EIF_REFERENCE) use %"eif_store.h%""
		alias
			"eestore"
		end

	c_retrieved (file_handle: INTEGER): ANY is
		external
			"C | %"eif_retrieve.h%""
		alias
			"eretrieve"
		end

feature  -- Status reporting

	last_read_successful: BOOLEAN
			-- Is last read operation successful?

	last_write_successful: BOOLEAN
			-- Is last write operation successful?

feature {NONE} -- Implementation

	is_read_descriptor_open: BOOLEAN
			-- Is read end of pipe open?

	is_write_descriptor_open: BOOLEAN
			-- Is write end of pipe open?

	current_platform: PLATFORM is
			-- Platform indicator
		once
			create Result
		end

	shared_mptr: MANAGED_POINTER
			-- Shared memory area

	Invalid_descriptor: INTEGER is -1
			-- Invalid file descriptor

	Initial_buffer_size: INTEGER is 128
			-- Initial size of buffer used by `shared_mptr'	

invariant
	shared_pointer_not_void: shared_mptr /= Void
	current_platform_not_void: current_platform /= Void

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
