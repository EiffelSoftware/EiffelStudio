indexing

	description: "OLE ARRAYDESC structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_ARRAY_DESC

inherit
	EOLE_OBJECT_WITH_POINTER

feature -- Access

	type_desc: EOLE_TYPE_DESC is
			-- Array elements type
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_arraydesc_typedesc (ole_ptr))
		end
		
	count_dimension: INTEGER is
			-- Number of dimensions
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_arraydesc_count_dims (ole_ptr)
		end		
		
	bounds: ARRAY [EOLE_SAFEARRAY_BOUNDS] is
			-- Bounds for each dimension.
		do
			Result := ole2_arraydesc_bounds (ole_ptr)
		end
	
feature {NONE} -- Externals

	ole2_arraydesc_typedesc (this: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_arraydesc_typedesc"
		end

	ole2_arraydesc_count_dims (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_arraydesc_count_dims"
		end

	ole2_arraydesc_bounds (this: POINTER): ARRAY [EOLE_SAFEARRAY_BOUNDS] is
		external
			"C"
		alias
			"eole2_arraydesc_bounds"
		end
		
end -- class EOLE_ARRAY_DESC

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

