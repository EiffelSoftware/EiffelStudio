indexing

	description: "COM IStream interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_STREAM

inherit
	EOLE_UNKNOWN
		export
			{NONE}	create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

	EOLE_STGC
	
	EOLE_STREAM_SEEK
	
	EOLE_STAT_FLAGS

	EOLE_LOCK_TYPES

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_stream
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_stream)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end

	end_of_stream: BOOLEAN
			-- Has end of stream been reached?

feature -- Message Transmission

	seek (offset, origin: INTEGER) is
			-- Adjust location of seek pointer by adding `offset'
			-- to `origin'.
			-- See class EOLE_STREAM_SEEK for `origin' value.
		require
			valid_interface: is_valid_interface
			valid_origin: is_valid_seek (origin)
		do
			ole2_stream_seek (ole_interface_ptr, offset, origin)
		end

	set_size (new_size: INTEGER) is
			-- Set size of stream to `new_size'.
		require
			valid_interface: is_valid_interface
		do
			ole2_stream_set_size (ole_interface_ptr, new_size)
		end

	copy_to (stream_dest: EOLE_STREAM; num_bytes_to_copy: INTEGER) is
			-- Copies num_byrtes_to_copy `bytes' to `stream_dest' stream,
			-- starting at current seek pointer in each stream.
		require
			valid_interface: is_valid_interface
			valid_stream_dest: stream_dest /= Void and then stream_dest.is_valid_interface
		do
			ole2_stream_copy_to (ole_interface_ptr, stream_dest.ole_interface_ptr, num_bytes_to_copy)
		end

	commit (mode: INTEGER) is
			--  Commits any changes made to EOLE_STORAGE object containing
			--  Current according to `mode'.
			-- See class EOLE_STGC for `mode' value.
		require
			valid_interface: is_valid_interface
			valid_mode: is_valid_stgc (mode)
		do
			ole2_stream_commit (ole_interface_ptr, mode)
		end

	revert is
			-- Discard all changes made to stream since it was opened
			-- or last committed in transacted mode.
			-- In direct mode has no effect.
		require
			valid_interface: is_valid_interface
		do
			ole2_stream_revert (ole_interface_ptr)
		end

	stat (stat_flag: INTEGER): EOLE_STATSTG is
			-- Retrieve informations about `Current'
		require
			valid_interface: is_valid_interface
			valid_stat_flag: is_valid_stat_flag (stat_flag)
		do
			!! Result
			Result.attach (ole2_stream_stat (ole_interface_ptr, stat_flag))
		end
		
	lock_region (offset, count: EOLE_LARGE_INTEGER; lock: INTEGER) is
			-- Restrict access to range of bytes specified 
			-- by `offset' and `count' in the stream.
		require
			valid_interface: is_valid_interface
			valid_offset: offset /= Void
			valid_count: count /= Void and (count.low_part /= 0 or count.high_part /= 0)
			valid_lock_type: is_valid_lock (lock)
		do
			ole2_stream_lock_region (ole_interface_ptr, offset.ole_ptr, count.ole_ptr, lock)
		end

	unlock_region (offset, count: EOLE_LARGE_INTEGER; lock: INTEGER) is
			-- Remove the access restriction range of bytes specified with `offset' 
			-- and `count' previously restricted with `lock_region'. `lock' should be
			-- the same as when `lock_region' has been called.
		require
			valid_interface: is_valid_interface
			valid_offset: offset /= Void
			valid_count: count /= Void and (count.low_part /= 0 or count.high_part /= 0)
			valid_lock_type: is_valid_lock (lock)
		do
			ole2_stream_unlock_region (ole_interface_ptr, offset.ole_ptr, count.ole_ptr, lock)
		end
		
	write (buff: POINTER; num_bytes_to_write: INTEGER): INTEGER is
			-- Write `num_bytes_to_write' bytes of `buff' into stream
			-- and return number of bytes actually written.
		require
			valid_interface: is_valid_interface
			valid_buffer: buff /= default_pointer
		do
			Result := ole2_stream_write (ole_interface_ptr, buff, num_bytes_to_write)
		end
		
	write_character (ch: CHARACTER) is
			-- Write `ch' to stream at current position.
		do
			ole2_stream_write_character (ole_interface_ptr, ch)
			end_of_stream := status.last_hresult = S_false
		end

	write_integer (i: INTEGER) is
			-- Write `i' to stream at current position.
		do
			ole2_stream_write_integer (ole_interface_ptr, i)
			end_of_stream := status.last_hresult = S_false
		end

	write_real (r: REAL) is
			-- Write `r' to stream at current position.
		do
			ole2_stream_write_real (ole_interface_ptr, r)
			end_of_stream := status.last_hresult = S_false
		end

	write_boolean (b: BOOLEAN) is
			-- Write `b' to stream at current position.
		do
			ole2_stream_write_boolean (ole_interface_ptr, b)
			end_of_stream := status.last_hresult = S_false
		end

	write_string (s: STRING) is
			-- Write `s' to stream at current seek pointer.
		require
			valid_string: s /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (s)
			ole2_stream_write_string (ole_interface_ptr, wel_string.item)
			end_of_stream := status.last_hresult = S_false
		end

	read (buff: POINTER; num_bytes_to_read: INTEGER): INTEGER is
			-- Read `num_bytes_to_read' bytes into `buff' and
			-- return number of bytes actually read.
		require
			valid_interface: is_valid_interface
			valid_buffer: buff /= default_pointer
		do
			Result := ole2_stream_read (ole_interface_ptr, buff, num_bytes_to_read)
			end_of_stream := (Result < num_bytes_to_read)
		end

	read_character: CHARACTER is
			-- Read single character from stream at current position.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_stream_read_character (ole_interface_ptr)
			end_of_stream := status.last_hresult = S_false
		end

	read_integer: INTEGER is
			-- Read integer value from stream at current position.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_stream_read_integer (ole_interface_ptr)
			end_of_stream := status.last_hresult = S_false
		end

	read_real: REAL is
			-- Read real value from stream at current position.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_stream_read_real (ole_interface_ptr)
			end_of_stream := status.last_hresult = S_false
		end

	read_boolean: BOOLEAN is
			-- Read boolean value from stream at current position.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_stream_read_boolean (ole_interface_ptr)
			end_of_stream := status.last_hresult = S_false
		end
	
	read_string: STRING is
			-- Read string from stream at current position.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_stream_read_string (ole_interface_ptr)
			end_of_stream := status.last_hresult = S_false
		end
			
feature {NONE} -- Externals

	ole2_stream_read (pistreamthis, pv: POINTER; cb: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_stream_read"
		end

	ole2_stream_read_string (pistreamthis: POINTER): STRING is
		external
			"C"
		alias
			"eole2_stream_read_string"
		end

	ole2_stream_read_character (pistreamthis: POINTER): CHARACTER is
		external
			"C"
		alias
			"eole2_stream_read_character"
		end

	ole2_stream_read_integer (pistreamthis: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_stream_read_integer"
		end

	ole2_stream_read_real (pistreamthis: POINTER): REAL is
		external
			"C"
		alias
			"eole2_stream_read_real"
		end

	ole2_stream_read_boolean (pistreamthis: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_stream_read_boolean"
		end
		
	ole2_stream_write (pistreamthis, pv: POINTER; cb: INTEGER): INTEGER is
		external
			"C"
		alias
			"eole2_stream_write"
		end

	ole2_stream_write_integer (pistreamthis: POINTER; int: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_write_integer"
		end

	ole2_stream_write_character (pistreamthis: POINTER; ch: CHARACTER) is
		external
			"C"
		alias
			"eole2_stream_write_character"
		end

	ole2_stream_write_boolean (pistreamthis: POINTER; b: BOOLEAN) is
		external
			"C"
		alias
			"eole2_stream_write_boolean"
		end

	ole2_stream_write_real (pistreamthis: POINTER; r: REAL) is
		external
			"C"
		alias
			"eole2_stream_write_real"
		end

	ole2_stream_write_string (pistreamthis, s: POINTER) is
		external
			"C"
		alias
			"eole2_stream_write_string"
		end

	ole2_stream_seek (pistreamthis: POINTER; offset, origin: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_seek"
		end

	ole2_stream_set_size (pistreamthis: POINTER; new_size: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_set_size"
		end

	ole2_stream_copy_to (pistreamthis, pistreamdest: POINTER; cb: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_copy_to"
		end

	ole2_stream_commit (pistreamthis: POINTER; mode: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_commit"
		end

	ole2_stream_revert (pistreamthis: POINTER) is
		external
			"C"
		alias
			"eole2_stream_revert"
		end
	
	ole2_stream_stat (pistreamthis: POINTER; statflag: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_stream_stat"
		end
		
	ole2_stream_lock_region (pistreamthis: POINTER; offset, count: POINTER; lock: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_lock_region"
		end
		
	ole2_stream_unlock_region (pistreamthis: POINTER; offset, count: POINTER; lock: INTEGER) is
		external
			"C"
		alias
			"eole2_stream_unlock_region"
		end

end -- class EOLE_STREAM

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

