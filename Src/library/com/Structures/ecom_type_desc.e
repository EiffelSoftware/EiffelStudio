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

creation	make,
	make_by_pointer

feature -- Initialization


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
			is_ptr (var_type) or is_safearray (var_type)
		do
			!!Result.make_by_pointer (ccom_typedesc_typedesc (item))
		end

	array_desc: ECOM_ARRAY_DESC is
			-- Nested ARRAYDESC structure
		require
			is_carray (var_type)
		do
			!!Result.make_by_pointer (ccom_typedesc_arraydesc (item))
		end

	href_type: INTEGER is
			-- Handle to type description
		require
			is_user_defined (var_type) 
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

invariant
	invariant_clause: -- Your invariant here

end -- class ECOM_TYPE_DESC

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

