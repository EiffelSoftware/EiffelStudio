indexing
	description: "TYPEDESC structure, contained within TYPEATTR structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_TYPE_DESC

inherit
	ECOM_STRUCTURE

	ECOM_VAR_TYPE
		undefine
			copy, is_equal
		end

creation	
	make,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	var_type: INTEGER is
			-- Type
			-- See class ECOM_VAR_TYPE for Result values.
		do
			Result := ccom_typedesc_vartype (item)
		end

	type_desc: ECOM_TYPE_DESC is
			-- Nested TYPEDESC structure
			-- that specifies safearray element type
		require 
			valid_type: is_ptr (var_type) or is_safearray (var_type)
		do
			!! Result.make_from_pointer (ccom_typedesc_typedesc (item))
		end

	array_desc: ECOM_ARRAY_DESC is
			-- Nested ARRAYDESC structure
		require
			valid_type: is_carray (var_type)
		local
			l_pointer: POINTER
		do
			l_pointer := ccom_typedesc_arraydesc (item)
			if l_pointer /= default_pointer then
				create Result.make_from_pointer (l_pointer)
			end
		end

	href_type: INTEGER is
			-- Handle to type description
		require
			valid_type: is_user_defined (var_type) 
		do
			Result := ccom_typedesc_href_type (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of TYPEDESC structure
		do
			Result := c_size_of_type_desc
		end

feature {NONE} -- Externals

	c_size_of_type_desc: INTEGER is
		external 
			"C [macro %"E_typedesc.h%"]"
		alias
			"sizeof(TYPEDESC)"
		end

	ccom_typedesc_vartype (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_typedesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_typedesc_typedesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_typedesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_typedesc_arraydesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_typedesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_typedesc_href_type (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_typedesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

end -- class ECOM_TYPE_DESC

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

