indexing
	description: "COM TLIBATTR structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TLIB_ATTR

inherit
	ECOM_STRUCTURE

	ECOM_SYS_KIND

	ECOM_LIB_FLAGS

creation
	make, make_by_pointer

feature -- Access

	guid: ECOM_GUID is
			-- Unique ID of the library
		do
			!!Result.make_by_pointer (ccom_tlibattr_guid (item))
		end

	lcid: INTEGER is
			-- Language/locale of the library.
		do
			Result := ccom_tlibattr_lcid (item)
		end

	SYS_kind: INTEGER is
			-- Target hardware platform
			-- See class ECOM_SYS_KIND for possible return values.
		do
			Result := ccom_tlibattr_sys_kind (item)
		ensure
			is_valid_sys_kind (Result)
		end

	flags: INTEGER is
			-- Library flags.
			-- See class ECOM_LIB_FLAGS for possible return values.
		do
			Result := ccom_tlibattr_tlib_flags (item)
		ensure
			is_valid_lib_flag (Result)
		end

	major_version_number: INTEGER is
			-- Major version number
		do
			Result := ccom_tlibattr_major_vernum (item)
		end

	minor_version_number: INTEGER is
			-- Minor version number
		do
			Result := ccom_tlibattr_minor_vernum (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of TLIBATTR structure
		do
			Result := c_size_of_tlib_attr 
		end

feature {NONE} -- Externals

	c_size_of_tlib_attr: INTEGER is
		external 
			"C [macro %"E_tlib_attr.h%"]"
		alias
			"sizeof(TLIBATTR)"
		end

	ccom_tlibattr_guid (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_tlibattr_lcid (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_sys_kind (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_tlib_flags (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_major_vernum (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_tlibattr_minor_vernum (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_tlib_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	
end -- class ECOM_TLIB_ATTR

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

