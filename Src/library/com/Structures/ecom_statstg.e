indexing
	description: "Encapsulation of STATSTG structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STATSTG

inherit

	ECOM_WRAPPER

	ECOM_STGTY
		export
			{NONE} all
		end
	
	ECOM_STGM
		export
			{NONE} all
		end

	ECOM_LOCK_TYPES
		export
			{NONE} all
		end

creation

	make_from_pointer

feature -- Access

	name: STRING is
			-- name
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_pointer (ccom_name (initializer))
			Result := wide_string.to_string
		end

	is_same_name (other_name: STRING): BOOLEAN is
		require
			valid_other_name: other_name /= Void
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string(other_name);
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
			!! Result.make_from_pointer (ccom_size(initializer))
		ensure
			Result /= Void and Result.item /= Default_pointer
		end

	modification_time: WEL_FILE_TIME is
			-- Last modification time 
		do
			!! Result.make_by_pointer (ccom_modification_t (initializer))
		ensure
			Result /= Void
		end

	creation_time: WEL_FILE_TIME is
			-- Creation time  
		do
			!! Result.make_by_pointer (ccom_creation_t (initializer))
		ensure
			Result /= Void
		end

	access_time: WEL_FILE_TIME is
			-- Last access time 
		do
			!! Result.make_by_pointer (ccom_access_t (initializer))
		ensure
			Result /= Void
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

	create_wrapper (a_pointer: POINTER): POINTER is
		do
			Result := ccom_create_c_statstg (a_pointer)
		end

	delete_wrapper is
			-- delete corresponding C++ object
		do
			ccom_delete_c_statstg (initializer)
		end

feature {NONE} -- Externals

	ccom_create_c_statstg(a_pointer: POINTER): POINTER is
		external
			"C++ [new E_STATSTG %"E_statstg.h%"] (STATSTG *)"
		end

	ccom_delete_c_statstg (cpp_obj: POINTER) is
		external
			"C++ [delete E_STATSTG %"E_statstg.h%"] ()"
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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

