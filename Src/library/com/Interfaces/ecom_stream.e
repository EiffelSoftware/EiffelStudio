indexing
	description: "encapsulation of standard implementation of IStream interface"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STREAM

inherit
	
	MEMORY
		redefine
			dispose
		end
	
	ECOM_STAT_FLAGS
	
	ECOM_STREAM_SEEK

	ECOM_LOCK_TYPES

	ECOM_STAT_FLAGS

creation

	make_from_stream

feature {NONE} -- Initialization 

	make_from_stream (p_stream: POINTER) is
			-- Create new object giving IStream interface pointer.
		require
			valid_stream: p_stream /= Default_pointer
		do
			initializer := ccom_create_c_istream;
			ccom_initialize_stream (initializer, p_stream);
			item := ccom_stream (initializer)
		ensure
			stream_created: item /= Default_pointer;
		end

feature -- Basic Operations

	read (buffer: POINTER; bytes: INTEGER) is
			-- Reads `bytes' number of bytes from stream 
			-- into memory starting at current seek pointer.
		require
			valid_buffer: buffer /= Default_pointer
		do
			ccom_read (initializer, buffer, bytes)
		end
	
	write (buffer: POINTER; bytes: INTEGER) is
			-- Writes `bytes' number of bytes into stream
			-- starting at current seek pointer.
		require
			valid_buffer: buffer /= Default_pointer
		do
			ccom_write (initializer, buffer, bytes)
		end

	seek (displacement: ECOM_LARGE_INTEGER; origin: INTEGER) is
			-- New position of seek pointer
			-- move seek pointer by `displacement' 
			-- relative to `origin'
			-- see class ECOM_STREAM_SEEK for `origin' values
		require
			valid_displacement: displacement /= Void and then
					displacement.item /= Default_pointer;
			valid_seek_origin: is_valid_seek(origin)
		do
			ccom_seek (initializer, displacement.item, origin)	
		end
		
	set_size (new_size: ECOM_ULARGE_INTEGER) is
			-- change size of steram object to `new_size'
		require
			valid_new_size: new_size /= Void and then
				new_size.item /= Default_pointer;
		do
			ccom_set_size (initializer, new_size.item)
		ensure
			size = new_size
		end
		
	copy_to (destination: ECOM_STREAM; bytes: ECOM_ULARGE_INTEGER) is
			-- copy `bytes' number of bytes from current seek pointer
			-- in stream to current seek pointer in 
			-- `destination'
		require
			valid_destination: destination /= Void 
					and then destination.item /= Default_pointer
			valid_bytes_number: bytes /= Void and then
					bytes.item /= Default_pointer
		do
			ccom_copy_to (initializer, destination.item, bytes.item)
		end
	
	lock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER) is
			-- restricts access to range of bytes defined by
			-- `offset' and `count'
		require
			valid_offset: offset /= Void and then offset.item /= Default_pointer
			valid_count: count /= Void and then count.item /= Default_pointer
			valid_lock: is_valid_lock (lock)
		do
			ccom_lock_region (initializer, offset.item, count.item, lock)
		end
	
	unlock_region (offset, count: ECOM_ULARGE_INTEGER; lock: INTEGER) is
			-- removes access restriction to range of bytes defined by
			-- `offset' and `count'
		require
			valid_offset: offset /= Void and then offset.item /= Default_pointer
			valid_count: count /= Void and then count.item /= Default_pointer
			valid_lock: is_valid_lock (lock)
		do
			ccom_unlock_region (initializer, offset.item, count.item, lock)
		end

	clone_stream: ECOM_STREAM is
			-- creates new stream that references
			-- the same bytes as original stream
		do
			!!Result.make_from_stream(ccom_clone(initializer))
		ensure
			clone_created: Result.item /= Default_pointer
		end

feature -- Access

	description (stat_flag: INTEGER): ECOM_STATSTG is
			-- STATSTG structure
		require
			valid_stat_flag: is_valid_stat_flag (stat_flag)
		local
			ptr: POINTER
		do
			ptr := ccom_stat (initializer, stat_flag);
			!!Result.make_from_statstg (ptr);
		ensure
			Result /= Void
		end

	name: STRING is
			-- name
		do
			Result := description(Statflag_default).name
		end

	is_same_name (a_name: STRING): BOOLEAN is
			-- Is name equal to `a_name'
		require
			valid_a_name: a_name /= Void
		do
			Result := description(Statflag_default).is_same_name (a_name)
		end

	size: ECOM_ULARGE_INTEGER is
			-- Size in bytes
		do
			Result := description(Statflag_noname).size
		end

	modification_time: POINTER is
			-- modification time
		do
			Result := description(Statflag_noname).modification_time
		end

	creation_time: POINTER is
			-- creation time
		do
			Result := description(Statflag_noname).creation_time
		end

	access_time: POINTER is
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

	item: POINTER 
			-- Pointer to IStream interface

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to structure

	dispose is
			-- Close root compound file
		do
			ccom_delete_c_stream (initializer);
		end


feature {NONE} -- Externals

	ccom_create_c_istream: POINTER is
		external
			"C++ [new E_IStream %"E_IStream.h%"]()"
		end

	ccom_delete_c_stream (cpp_obj: POINTER) is
		external
			"C++ [delete E_IStream %"E_IStream.h%"]()"
		end

	ccom_initialize_stream (cpp_obj: POINTER; p_stream: POINTER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (IStream *)"
		end

	ccom_read (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
		end

	ccom_write (cpp_obj: POINTER; buffer: POINTER; byte_num: INTEGER) is
		external
			"C++ [E_IStream %"E_IStream.h%"] (void *, ULONG)"
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


invariant 

	valid_cpp_object: initializer /= Default_pointer and then
						item /= Default_pointer;
	
end -- class ECOM_STREAM
