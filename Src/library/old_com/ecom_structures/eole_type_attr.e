indexing

	description: "TYPEATTR structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_ATTR

inherit
	EOLE_OBJECT_WITH_POINTER
	
feature -- Access

	guid: STRING is
			-- Type Info GUID
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_guid (ole_ptr)
		end
		
	lcid: INTEGER is
			-- Type Info locale identifier
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_lcid (ole_ptr)
		end

	memid_constructor: INTEGER is
			-- Member ID of constructor
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_memid_constructor (ole_ptr)
		end
		
	memid_destructor: INTEGER is
			-- Member ID of destructor
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_memid_destructor (ole_ptr)
		end

	size_instance: INTEGER is
			-- Size of instance of this type
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_size_instance (ole_ptr)
		end

	type_kind: INTEGER is
			-- Kind of type
			-- See class EOLE_TYPE_KIND for possible Result values.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_type_kind (ole_ptr)
		end
		
	count_func: INTEGER is
			-- Number of functions
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_count_func (ole_ptr)
		end

	count_variables: INTEGER is
			-- Number of variables/data members
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_count_variables (ole_ptr)
		end
		
	count_implemented_types: INTEGER is
			-- Number of implemented interfaces
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_count_implemented_types (ole_ptr)
		end

	size_VTBL: INTEGER is
			-- Size of type's VTBL
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_size_VTBL (ole_ptr)
		end
		
	byte_alignment: INTEGER is
			-- Byte alignment for instance of this type
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_byte_alignment (ole_ptr)
		end

	flags: INTEGER is
			-- Flags for this type
			-- See class EOLE_TYPE_FLAGS for possible Result values.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_flags (ole_ptr)
		end
		
	major_version_number: INTEGER is
			-- Major version number
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_major_version_number (ole_ptr)
		end
	
	minor_version_number: INTEGER is
			-- Minor version number
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_type_attr_minor_version_number (ole_ptr)
		end

	kind_alias: EOLE_TYPE_DESC is
			-- Alias type
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_type_attr_kind_alias (ole_ptr))
		end
		
	idl_desc: EOLE_IDL_DESC is
			-- IDL attribute
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_type_attr_idl_desc (ole_ptr))
		end
		
feature {NONE} -- Externals

	ole2_type_attr_guid (ptr: POINTER): STRING is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_REFERENCE"
		alias
			"eole2_type_attr_guid"
		end
		
	ole2_type_attr_lcid (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_lcid"
		end
		
	ole2_type_attr_memid_constructor (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_memid_constructor"
		end

	ole2_type_attr_memid_destructor (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_memid_destructor"
		end

	ole2_type_attr_size_instance (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_size_instance"
		end
		
	ole2_type_attr_type_kind (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_type_kind"
		end
		
	ole2_type_attr_count_func (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_count_func"
		end
		
	ole2_type_attr_count_variables (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_count_variables"
		end
		
	ole2_type_attr_count_implemented_types (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_count_implemented_types"
		end
		
	ole2_type_attr_size_VTBL (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_size_VTBL"
		end
		
	ole2_type_attr_byte_alignment (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_byte_alignment"
		end
	
	ole2_type_attr_flags (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_flags"
		end

	ole2_type_attr_major_version_number (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_major_version_number"
		end

	ole2_type_attr_minor_version_number (ptr: POINTER): INTEGER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_minor_version_number"
		end

	ole2_type_attr_kind_alias (ptr: POINTER): POINTER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_kind_alias"
		end

	ole2_type_attr_idl_desc (ptr: POINTER): POINTER is
		external
			"C [macro %"typeattr.h%"] (EIF_POINTER): EIF_INTEGER"
		alias
			"eole2_type_attr_idl_desc"
		end

end -- class EOLE_TYPE_ATTR

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
