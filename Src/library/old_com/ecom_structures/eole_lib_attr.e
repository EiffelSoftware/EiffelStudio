indexing

	description: "TLIBATTR structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_LIB_ATTR

inherit
	EOLE_OBJECT_WITH_POINTER

	EOLE_LIBRARY_FLAGS
	
	EOLE_SYS_KIND
	
feature -- Access

	guid: STRING is
			-- Type library GUID
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_guid (ole_ptr)
		end
		
	lcid: INTEGER is
			-- Type library locale identifier
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_lcid (ole_ptr)
		end
		
	sys_kind: INTEGER is
			-- Target hardware platform
			-- See class EOLE_SYS_KIND for result value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_sys_kind (ole_ptr)
		ensure
			valid_sys_kind: is_valid_sys_kind (Result)
		end
	
	major_version_number: INTEGER is
			-- Major version number
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_major_version_number (ole_ptr)
		end
	
	minor_version_number: INTEGER is
			-- Minor version number
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_minor_version_number (ole_ptr)
		end
		
	library_flags: INTEGER is
			-- Library flags
			-- See class EOLE_LIB_FLAGS for Result value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_lib_attr_library_flags (ole_ptr)
		ensure
			valid_library_flag: is_valid_library_flag (Result)
		end
		
feature {NONE} -- Externals

	ole2_lib_attr_guid (ptr: POINTER): STRING is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_REFERENCE"
		alias
			"eole2_lib_attr_guid"
		end
		
	ole2_lib_attr_lcid (ptr: POINTER): INTEGER is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_lib_attr_lcid"
		end
		
	ole2_lib_attr_sys_kind (ptr: POINTER): INTEGER is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_lib_attr_sys_kind"
		end
		
	ole2_lib_attr_major_version_number (ptr: POINTER): INTEGER is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_lib_attr_major_version_number"
		end
		
	ole2_lib_attr_minor_version_number (ptr: POINTER): INTEGER is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_lib_attr_minor_version_number"
		end
		
	ole2_lib_attr_library_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"libattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_lib_attr_library_flags"
		end
		
end -- class EOLE_LIB_ATTR

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

