indexing
	description: "COM TYPEATTR structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_ATTR

inherit
	ECOM_STRUCTURE

	ECOM_TYPE_KIND
		
	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

creation
	make, make_by_pointer

feature -- Access

	guid: ECOM_GUID is
			-- GUID of type information
		do
			!!Result.make_by_pointer (ccom_typeattr_guid (item))
		end

	lcid: INTEGER is
			-- Locale of member names and doc strings.
		do
			Result := ccom_typeattr_lcid (item)
		end

	memid_constructor: INTEGER is
			-- Member ID of constructor
		do
			Result := ccom_typeattr_memid_constructor (item)
		end

	memid_destructor: INTEGER is
			-- Member ID of destructor
		do
			Result := ccom_typeattr_memid_destructor (item)
		end

	size_instance: INTEGER is
			-- Size of instance of this type
		do
			Result := ccom_typeattr_size_instance (item)
		end

	type_kind: INTEGER is
			-- Kind of type
			-- See class ECOM_TYPE_KIND for possible return values.
		do
			Result := ccom_typeattr_type_kind (item)
		ensure
			is_valid_type_kind (Result)
		end

	count_func: INTEGER is
			-- Number of functions
		do
			Result := ccom_typeattr_func_count (item)
		end

	count_variables: INTEGER is
			-- Number of variables/data members
		do
			Result := ccom_typeattr_variable_count (item)
		end

	count_implemented_types: INTEGER is
			-- Number of implemented interfaces
		do
			Result := ccom_typeattr_interface_count (item)
		end

	vtbl_size: INTEGER is
			-- Size of type's VTBL
		do
			Result := ccom_typeattr_vtbl_size (item)
		end

	byte_alignment: INTEGER is
			-- Byte alignment for instance of this type
			-- Value of "0" indicates alignment on the 64K boundary;
			-- "1" indicates no special alignment.
			-- For other values, n indicates aligned on byte n.
		do
			Result := ccom_typeattr_alignment (item)
		end

	flags: INTEGER is
			-- Flags for this type
			-- See class ECOM_TYPE_FLAGS for possible return values.
		do
			Result := ccom_typeattr_type_flags (item)
		ensure
			is_valid_typeflag (Result)
		end

	major_version_number: INTEGER is
			-- Major version number
		do
			Result := ccom_typeattr_major_vernum (item)
		end

	minor_version_number: INTEGER is
			-- Minor version number
		do
			Result := ccom_typeattr_minor_vernum (item)
		end

	type_alias: ECOM_TYPE_DESC is
			-- Type for which this type is alias
			-- If `type_kind' is equal Tkind_alias
		require
			type_kind = Tkind_alias
		do
			!!Result.make_by_pointer (ccom_typeattr_alias_typedesc (item))
		end

	idl_desc: ECOM_IDL_DESC is
			-- IDL attribute
		do
			!!Result.make_by_pointer (ccom_typeattr_idl_attributes (item))
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of TYPEDESC structure
		do
			Result := c_size_of_type_attr 
		end

feature {NONE} -- Externals

	c_size_of_type_attr: INTEGER is
		external 
			"C [macro %"E_type_attr.h%"]"
		alias
			"sizeof(TYPEATTR)"
		end

	ccom_typeattr_guid (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_typeattr_lcid (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_memid_constructor (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_memid_destructor (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_size_instance (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_type_kind (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_func_count (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_variable_count (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_interface_count (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_vtbl_size (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_alignment (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_type_flags (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_major_vernum (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_minor_vernum (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typeattr_alias_typedesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_typeattr_idl_attributes (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_type_attr.h%"](EIF_POINTER): EIF_POINTER"
		end

end -- class ECOM_TYPE_ATTR

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

