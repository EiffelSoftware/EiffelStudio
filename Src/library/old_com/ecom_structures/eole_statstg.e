indexing

	description: "STATSTG structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	EOLE_STATSTG

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate
		end
		
	EOLE_LOCK_TYPES
	
	EOLE_STGM
	
	EOLE_STGTY

feature -- Element Change

	allocate: POINTER is
			-- Allocate memory space for associated C++ structure.
		do
			Result := ole2_statstg_allocate
		end
		
	set_element_name (element_nam: STRING) is
			-- Set name with `element_nam'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (element_nam)
			ole2_statstg_set_element_name (ole_ptr, wel_string.item)
		ensure
			element_name_set: element_name.is_equal (element_nam)
		end

	set_element_type (element_typ: INTEGER) is
			-- Set type to `element_typ'.
			-- See class EOLE_STGTY for `element_type' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_element_type: is_valid_stgty (element_typ)
		do
			ole2_statstg_set_element_type (ole_ptr, element_typ)
		ensure
			element_type_set: element_type = element_typ
		end

	set_element_size (element_siz: INTEGER) is
			-- Set size of storage element with `element_siz'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_statstg_set_element_size (ole_ptr, element_siz)
		ensure
			element_size_set: element_size = element_siz
		end

	set_modification_time (mtime: EOLE_FILE_TIME) is
			-- Set time of last modification of storage element with `mtime'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_statstg_set_modification_time (ole_ptr, mtime.ole_ptr)
		ensure
			modification_time_set: modification_time.is_equal (mtime)
		end

	set_creation_time (ctime: EOLE_FILE_TIME) is
			-- Set time of creation of storage element with `ctime'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_statstg_set_creation_time (ole_ptr, ctime.ole_ptr)
		ensure
			creation_time_set: creation_time.is_equal (ctime)
		end

	set_access_time (atime: EOLE_FILE_TIME) is
			-- Set time of last access to storage element with `atime'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_statstg_set_access_time (ole_ptr, atime.ole_ptr)
		ensure
			access_time_set: access_time.is_equal (atime)
		end

	set_open_mode (mode: INTEGER) is
			-- Set open mode of storage element with `mode'.
			-- See class EOLE_STGM for `mode' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_mode: is_valid_stgm (mode)
		do
			ole2_statstg_set_open_mode (ole_ptr, mode)
		ensure
			open_mode_set: open_mode = mode
		end

	set_locks_supported (locks: INTEGER) is
			-- Set supported locks with `locks'.
			-- See class EOLE_LOCKTYPES for `locks' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_lock_type: is_valid_lock (locks)
		do
			ole2_statstg_set_locks_supported (ole_ptr, locks)
		ensure
			locks_supported_set: locks_supported = locks
		end

	set_clsid (clid: STRING) is
			-- Set class identifier associated with storage
			-- with `clid'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (clid)
			ole2_statstg_set_clsid (ole_ptr, wel_string.item)
		ensure
			clsid_set: clsid.is_equal (clid)
		end

	set_state_bits (state_bts: INTEGER) is
			-- Set state bits of storage element with `state_bts'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_statstg_set_state_bits (ole_ptr, state_bts)
		ensure
			state_bits_set: state_bits = state_bts
		end

feature -- Access

	element_name: STRING is
			-- Storage element name
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_element_name (ole_ptr)
		ensure
			valid_result: Result /= Void
		end

	element_type: INTEGER is
			-- Storage element type
			-- See class EOLE_STGTY for `Result' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_element_type (ole_ptr)
		ensure
			valid_result: is_valid_stgty (Result)		
		end

	element_size: INTEGER is
			-- Storage element size
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_element_size (ole_ptr)
		end

	modification_time: EOLE_FILE_TIME is
			-- Storage element last modification time
		do
			!! Result
			Result.attach (ole2_statstg_get_modification_time (ole_ptr))
		end

	creation_time: EOLE_FILE_TIME is
			-- Storage element creation time
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_statstg_get_creation_time (ole_ptr))
		end

	access_time: EOLE_FILE_TIME is
			-- Storage element last access time
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_statstg_get_access_time (ole_ptr))
		end

	open_mode: INTEGER is
			-- Mode in which element was opened
			-- See class EOLE_STGM for `Result' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_open_mode (ole_ptr)
		ensure
			valid_result: is_valid_stgm (Result)
		end

	locks_supported: INTEGER is
			-- Locks supported by the storage element
			-- See class EOLE_LOCKTYPES for Result value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_locks_supported (ole_ptr)
		ensure
			valid_lock_type: is_valid_lock (Result)
		end

	clsid: STRING is
			-- CLSID associated with storage
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_clsid (ole_ptr)
		end

	state_bits: INTEGER is
			-- State bits of storage element
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_statstg_get_state_bits (ole_ptr)
		end

feature {NONE} -- Externals

	ole2_statstg_allocate: POINTER is
		external
			"C"
		alias
			"eole2_statstg_allocate"
		end;

	ole2_statstg_set_element_name (this, element_nam: POINTER) is
		external
			"C"
		alias
			"eole2_statstg_set_element_name"
		end;

	ole2_statstg_set_element_type (this: POINTER; element_typ: INTEGER) is
		external
			"C"
		alias
			"eole2_statstg_set_element_type"
		end;

	ole2_statstg_set_element_size (this: POINTER; element_siz: INTEGER) is
		external
			"C"
		alias
			"eole2_statstg_set_element_size"
		end;

	ole2_statstg_set_modification_time (this, mtime: POINTER) is
		external
			"C"
		alias
			"eole2_statstg_set_modification_time"
		end;

	ole2_statstg_set_creation_time (this, ctime: POINTER) is
		external
			"C"
		alias
			"eole2_statstg_set_creation_time"
		end;

	ole2_statstg_set_access_time (this, atime: POINTER) is
		external
			"C"
		alias
			"eole2_statstg_set_access_time"
		end;

	ole2_statstg_set_open_mode (this: POINTER; mode: INTEGER) is
		external
			"C"
		alias
			"eole2_statstg_set_open_mode"
		end;

	ole2_statstg_set_locks_supported (this: POINTER; lock_supported: INTEGER) is
		external
			"C"
		alias
			"eole2_statstg_set_locks_supported"
		end;

	ole2_statstg_set_clsid (this, clid: POINTER) is
		external
			"C"
		alias
			"eole2_statstg_set_clsid"
		end;

	ole2_statstg_set_state_bits (this: POINTER; state_bit: INTEGER) is
		external
			"C"
		alias
			"eole2_statstg_set_state_bits"
		end;

	ole2_statstg_get_element_name (this: POINTER): STRING is
		external
			"C"
		alias
			"eole2_statstg_get_element_name"
		end;

	ole2_statstg_get_element_type (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_statstg_get_element_type"
		end;

	ole2_statstg_get_element_size (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_statstg_get_element_size"
		end;

	ole2_statstg_get_modification_time (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_statstg_get_modification_time"
		end;

	ole2_statstg_get_creation_time (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_statstg_get_creation_time"
		end;

	ole2_statstg_get_access_time (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_statstg_get_access_time"
		end;

	ole2_statstg_get_open_mode (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_statstg_get_open_mode"
		end;

	ole2_statstg_get_locks_supported (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_statstg_get_locks_supported"
		end;

	ole2_statstg_get_clsid (this: POINTER): STRING is
		external
			"C"
		alias
			"eole2_statstg_get_clsid"
		end;

	ole2_statstg_get_state_bits (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_statstg_get_state_bits"
		end;
	
end -- class EOLE_STATSTG

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

