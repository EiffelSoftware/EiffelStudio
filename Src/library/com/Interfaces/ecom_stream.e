indexing
	description: "encapsulation of standard implementation of IStream interface"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STREAM

inherit
	
	ECOM_INTERFACE
	
	ECOM_STAT_FLAGS
	
	ECOM_STREAM_SEEK

	ECOM_LOCK_TYPES

	ECOM_STAT_FLAGS

	EXCEPTIONS

creation

	make_from_pointer

feature -- Basic Operations

	update_end_of_stream is
			-- update value of `end_of_stream'
		do
			end_of_stream := (ccom_end_of_stream_reached (initializer) = 1)
		end

	read (buffer: POINTER; bytes: INTEGER) is
			-- Reads `bytes' number of bytes from stream 
			-- into memory starting at current seek pointer.
		require
			valid_buffer: buffer /= default_pointer
		local
			tried: BOOLEAN
		do
			if not tried then
				ccom_read (initializer, buffer, bytes)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end
	
	read_character is
			-- Read character from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_character := ccom_read_character (initializer)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end

	read_integer is
			-- Read integer from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_integer := ccom_read_integer (initializer)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end

	read_real is
			-- Read real from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_real := ccom_read_real (initializer)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end

	read_boolean is
			-- Read boolean from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_boolean := ccom_read_boolean (initializer)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end

	read_string is
			-- Read string from stream.
		local
			tried: BOOLEAN
		do
			if not tried then
				last_string := ccom_read_string (initializer)
				end_of_stream := False
			end
		rescue
			if exception = E_end_of_stream then
				end_of_stream := True
				tried := True
				retry
			end
		end

	write (buffer: POINTER; bytes: INTEGER) is
			-- Writes `bytes' number of bytes into stream
			-- starting at current seek pointer.
		require
			valid_buffer: buffer /= default_pointer
		do
			ccom_write (initializer, buffer, bytes)
		end

	write_character (character: CHARACTER) is
			-- Write `character' into stream.
	
		do
			ccom_write_character (initializer, character)
		end

	write_integer (integer: INTEGER) is
			-- Write `integer' into stream.
	
		do
			ccom_write_integer (initializer, integer)
		end

	write_real (real: REAL) is
			-- Write `real' into stream.
		do
			ccom_write_real (initializer, real)
		end

	write_boolean (boolean: BOOLEAN) is
			-- Write `boolean' into stream.
	
		do
			ccom_write_boolean (initializer, boolean)
		end

	write_string (string: STRING) is
			-- Write `string' into stream.
		require
			string /= Void
		local
			wel_string: WEL_STRING
		do
			!!wel_string.make (string)
			ccom_write_string (initializer, wel_string.item)
		end

	seek (displacement: ECOM_LARGE_INTEGER; origin: INTEGER) is
			-- Move seek pointer by `displacement' 
			-- relative to `origin'.
			-- See class ECOM_STREAM_SEEK for `origin' values.
		require
			valid_displacement: displacement /= Void and then
					displacement.item /= Default_pointer;
			valid_seek_origin: is_valid_seek(origin)
		do
			ccom_seek (initializer, displacement.item, origin)	
		end
	
	start is
			-- Set seek pointer to beginning of stream.
		local
			large_integer: ECOM_LARGE_INTEGER
		do
			!!large_integer.make_from_integer (0)
			seek (large_integer, Stream_seek_set)
			end_of_stream := False
		ensure
			not_end: not end_of_stream
		end
	
	finish is
			-- Set seek pointer to end of stream.
		local
			large_integer: ECOM_LARGE_INTEGER
		do
			!!large_integer.make_from_integer (0)
			seek (large_integer, Stream_seek_end)
			end_of_stream := True
		ensure
			at_end: end_of_stream
		end

	set_size (new_size: ECOM_ULARGE_INTEGER) is
			-- Change size of stream to `new_size'.
		require
			valid_new_size: new_size /= Void and then
				new_size.item /= Default_pointer;
		do
			ccom_set_size (initializer, new_size.item)
		ensure
			size = new_size
		end
		
	copy_to (destination: ECOM_STREAM; bytes: ECOM_ULARGE_INTEGER) is
			-- Copy `bytes' number of bytes from current seek pointer
			-- in stream to current seek pointer in 
			-- `destination'.
		require
			valid_destination: destination /= Void 
					and then destination.interface /= Default_pointer
			valid_bytes_number: bytes /= Void and then
					bytes.item /= Default_pointer
		do
			ccom_copy_to (initializer, destination.interface, bytes.item)
		end
	
	lock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER) is
			-- Restricts access to range of bytes defined by
			-- `offset' and `count'.
		require
			valid_offset: offset /= Void and then offset.item /= Default_pointer
			valid_count: count /= Void and then count.item /= Default_pointer
			valid_lock: is_valid_lock (lock)
		do
			ccom_lock_region (initializer, offset.item, count.item, lock)
		end
	
	unlock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER) is
			-- Removes access restriction to range of bytes defined by
			-- `offset' and `count'.
		require
			valid_offset: offset /= Void and then offset.item /= Default_pointer
			valid_count: count /= Void and then count.item /= Default_pointer
			valid_lock: is_valid_lock (lock)
		do
			ccom_unlock_region (initializer, offset.item, count.item, lock)
		end

	clone_stream: ECOM_STREAM is
			-- New stream referencing
			-- the same bytes as Current
			-- Seek pointer is also cloned
		do
			!!Result.make_from_pointer(ccom_clone(initializer))
		ensure
			clone_created: Result /= Void and then Result.interface /= Default_pointer
		end

feature -- Access

	end_of_stream: BOOLEAN
			-- Is current seek pointer at end of stream?
			-- Valid only after `read' ,`update_end_of_stream', `start', or `finish'.

	last_character: CHARACTER
			-- last read CHARACTER 

	last_integer: INTEGER
			-- last read INTEGER

	last_real: REAL
			-- last read REAL

	last_boolean: BOOLEAN
			-- last read BOOLEAN

	last_string: STRING
			-- last read STRING

	description (stat_flag: INTEGER): ECOM_STATSTG is
			-- STATSTG structure
			-- See class ECOM_STAT_FLAGS for `stat_flag' values.
		require
			valid_stat_flag: is_valid_stat_flag (stat_flag)
		local
			ptr: POINTER
		do
			ptr := ccom_stat (initializer, stat_flag);
			!!Result.make_from_pointer (ptr);
		ensure
			Result /= Void
		end

	name: STRING is
			-- Name
		do
			Result := description(Statflag_default).name
		end

	size: ECOM_ULARGE_INTEGER is
			-- Size in bytes
		do
			Result := description(Statflag_noname).size
		end

	modification_time: WEL_FILE_TIME is
			-- Modification time
		do
			Result := description(Statflag_noname).modification_time
		end

	creation_time: WEL_FILE_TIME is
			-- Creation time
		do
			Result := description(Statflag_noname).creation_time
		end

	access_time: WEL_FILE_TIME is
			-- Access time
		do
			Result := description(Statflag_noname).access_time
		end

	locks_supported: INTEGER is
			-- Types of region locking supported by stream
		do
			Result := description(Statflag_noname).locks_supported
		end
	
feature {ECOM_STREAM, ECOM_STORAGE}


feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_c_istream (a_pointer)
		end

	release_interface is
			-- Close root compound file
		do
			ccom_delete_c_stream (initializer);
		end


feature {NONE} -- Externals

	ccom_create_c_istream(a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IStream %"E_IStream.h%"](IStream *)"
		end

	ccom_delete_c_stream (cpp_obj: POINTER) is
		external
			"C++ [delete E_IStream %"E_IStream.h%"]()"
		end

	ccom_end_of_stream_reached (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_IStream %"E_IStream.h%"](): EIF_INTEGER"
		end

	ccom_read (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
		end

	ccom_read_character (cpp_obj: POINTER): CHARACTER is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_CHARACTER"
		end

	ccom_read_integer (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_INTEGER"
		end

	ccom_read_real (cpp_obj: POINTER): REAL is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_REAL"
		end

	ccom_read_boolean (cpp_obj: POINTER): BOOLEAN is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_BOOLEAN"
		end

	ccom_read_string (cpp_obj: POINTER): STRING is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_REFERENCE"
		end

	ccom_write (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
		end

	ccom_write_character (cpp_obj: POINTER; character: CHARACTER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_CHARACTER)"
		end

	ccom_write_integer (cpp_obj: POINTER; integer: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_INTEGER)"
		end

	ccom_write_real (cpp_obj: POINTER; real: REAL) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_REAL)"
		end

	ccom_write_boolean (cpp_obj: POINTER; boolean: BOOLEAN) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_BOOLEAN)"
		end

	ccom_write_string (cpp_obj: POINTER; string: POINTER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER)"
		end

	ccom_seek (cpp_obj: POINTER; displacement: POINTER; origin: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_INTEGER)"
		end

	ccom_set_size (cpp_obj: POINTER; new_size: POINTER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER)"
		end

	ccom_copy_to (cpp_obj: POINTER; destination: POINTER; cb: POINTER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (IStream *, EIF_POINTER)"	
		end

	ccom_lock_region (cpp_obj: POINTER; offset, cb: POINTER; 
					lock_type: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_POINTER, EIF_INTEGER)"
		end

	ccom_unlock_region (cpp_obj: POINTER; offset, cb: POINTER;
					lock_type: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (EIF_POINTER, EIF_POINTER, EIF_INTEGER)"
		end

	ccom_stat (cpp_obj: POINTER; flag: INTEGER): POINTER  is
		external
			"C++ [E_IStream %"E_IStream.h%"] (DWORD): EIF_POINTER"
		end

	ccom_clone (cpp_obj: POINTER): POINTER  is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_POINTER"
		end

	ccom_stream (cpp_obj: POINTER): POINTER  is
		external
			"C++ [E_IStream %"E_IStream.h%"] (): EIF_POINTER"
		end

end -- class ECOM_STREAM

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

