indexing
	description: "ARRAYDESC structure, contained within TYPEDESC structure %
				% describes type of array's elements and array dimensions"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ARRAY_DESC

inherit
	ECOM_STRUCTURE


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

	type_desc: ECOM_TYPE_DESC is
			-- Array elements type
		do
			!! Result.make_from_pointer (ccom_arraydesc_typedesc (item))
		end

	count_dimension: INTEGER is
			-- Number of dimensions
		do
			Result := ccom_arraydesc_dim_count (item)
		end

	bounds: ARRAY [ECOM_SAFE_ARRAY_BOUND] is
			-- Bounds for each dimension.
		do
			Result := ccom_arraydesc_bounds (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of TYPEDESC structure
		do
			Result := c_size_of_array_desc
		end

feature {NONE} -- externals

	c_size_of_array_desc: INTEGER is
		external 
			"C [macro %"E_arraydesc.h%"]"
		alias
			"sizeof(ARRAYDESC)"
		end

	ccom_arraydesc_typedesc (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_arraydesc.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_arraydesc_dim_count (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_arraydesc.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_arraydesc_bounds (a_ptr: POINTER): ARRAY [ECOM_SAFE_ARRAY_BOUND] is
		external
			"C (EIF_POINTER): EIF_REFERENCE | %"E_arraydesc.h%""
		end

end -- class ECOM_ARRAY_DESC

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

