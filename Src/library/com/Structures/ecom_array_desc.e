indexing
	description: "ARRAYDESC structure, contained within TYPEDESC structure %
				% describes type of array's elements and array dimensions"
	status: "See notice at end of class"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ARRAY_DESC

inherit
	ECOM_STRUCTURE


creation
	make,
	make_by_pointer


feature -- Access

	type_desc: ECOM_TYPE_DESC is
			-- Array elements type
		do
			!!Result.make_by_pointer (ccom_arraydesc_typedesc (item))
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

