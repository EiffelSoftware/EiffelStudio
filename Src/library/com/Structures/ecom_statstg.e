indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STATSTG

inherit

	MEMORY
		redefine
			dispose
		end

	ECOM_STGTY
	
	ECOM_STGM

	ECOM_LOCK_TYPES

creation
	make_from_statstg

feature {NONE} -- Initialization

	make_from_statstg (statstg: POINTER) is
			-- Creation routine
		require
			valid_statstg: statstg /= Default_pointer;
		do
			initializer := ccom_create_c_statstg;
			ccom_initialize_statstg (initializer, statstg);	
		end

feature -- Access

	name: STRING is
			-- name
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_wide_str_ptr (ccom_name (initializer))
			Result := wide_string.to_string
		end

	is_same_name (other_name: STRING): BOOLEAN is
		require
			valid_other_name: other_name /= Void
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_string(other_name);
			if (ccom_is_same_name (initializer, wide_string.item) = 1) then
				Result := true;
			end
		end

	type: INTEGER is
			-- Type of object
			-- Returns one of the values from the STGTY enumeration.
			-- See class ECOM_STGTY for values 
		do
			Result := ccom_type (initializer)
		ensure
			valid_type: is_valid_stgty (Result)
		end

	size: ECOM_ULARGE_INTEGER is
			-- Size in bytes of stream or byte array. 
		do
			!!Result.make_from_ularge_integer_ptr (ccom_size(initializer))
		ensure
			Result /= Void and Result.item /= Default_pointer
		end

	modification_time: POINTER is
			-- Last modification time 
		do
			Result := ccom_modification_t (initializer)
		ensure
			Result /= Default_pointer
		end

	creation_time: POINTER is
			-- Creation time  
		do
			Result := ccom_creation_t (initializer)
		ensure
			Result /= Default_pointer
		end

	access_time: POINTER is
			-- Last access time 
		do
			Result := ccom_access_t (initializer)
		ensure
			Result /= Default_pointer
		end

	mode: INTEGER is
			-- Access mode specified when the 
			-- object was opened. 
		do
			Result := ccom_mode (initializer)
		ensure
			valid_mode: is_valid_stgm (Result)
		end

	locks_supported: INTEGER is
			-- Types of region locking supported 
			-- by stream or byte array. See the LOCKTYPES 
			-- enumeration for the values available. This member 
			-- is not used for storage objects. 
		do
			Result := ccom_locks_supported (initializer)
		end

	clsid: POINTER is
			-- Class identifier for storage object; 
			-- set to CLSID_NULL for new storage objects. This member 
			-- is not used for streams or byte arrays. 
		do
			Result := ccom_clsid (initializer)
		end

feature {NONE} -- Implementation

	initializer: POINTER 
		-- Pointer to STATSTG structure (C++ object)

	dispose is
			-- delete corresponding C++ object
		do
			ccom_delete_c_statstg (initializer)
		end

feature {NONE} -- Externals

	ccom_create_c_statstg: POINTER is
		external
			"C++ [new E_STATSTG %"E_statstg.h%"] ()"
		end

	ccom_delete_c_statstg (cpp_obj: POINTER) is
		external
			"C++ [delete E_STATSTG %"E_statstg.h%"] ()"
		end

	ccom_initialize_statstg (cpp_obj: POINTER; p_statstg: POINTER) is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] (STATSTG *)"
		end

	ccom_name (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] (): LPWSTR"
		end

	ccom_is_same_name (cpp_obj: POINTER; other_name: POINTER): INTEGER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] (LPWSTR):EIF_INTEGER"
		end

	ccom_type (cpp_obj: POINTER) : INTEGER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] (): EIF_INTEGER"
		end

	ccom_size (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] (): (ULARGE_INTEGER *)"
		end

	ccom_modification_t (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] ():(FILETIME *)"
		end

	ccom_creation_t (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] ():(FILETIME *)"
		end

	ccom_access_t (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] ():(FILETIME *)"
		end

	ccom_mode (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"] ():DWORD"
		end

	ccom_locks_supported (cpp_obj: POINTER): INTEGER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"](): DWORD"
		end

	ccom_clsid (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_STATSTG %"E_statstg.h%"](): (CLSID*)"
		end

end -- class ECOM_STATSTG
