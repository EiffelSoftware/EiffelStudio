indexing
	description: "COM VARIANT structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_VARIANT

inherit
	ECOM_STRUCTURE

	ECOM_VAR_TYPE

creation
	make,
	make_by_pointer

feature -- Access

	variable_type: INTEGER is
			-- Variable type
		do
			Result := ccom_variant_variable_type (item)
		end

	character: CHARACTER is
			-- 1 byte value
		require
			is_character: is_character (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_char_byref (item)
			else
				Result := ccom_variant_char (item)
			end
		end

	integer2: INTEGER is
			-- Short value
		require
			is_integer2: is_integer2 (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_integer2_byref (item)
			else
				Result := ccom_variant_integer2 (item)
			end
		end

	integer4: INTEGER is
			-- Long value
		require
			is_integer4: is_integer4 (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_integer4_byref (item)
			else
				Result := ccom_variant_integer4 (item)
			end
		end

	real4: REAL is
			-- Real value
		require
			is_real4: is_real4 (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_real4_byref (item)
			else
				Result := ccom_variant_real4 (item)
			end
		end

	real8: DOUBLE is
			-- Double value
		require
			is_real8: is_real8 (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_real8_byref (item)
			else
				Result := ccom_variant_real8 (item)
			end
		end

	boolean: BOOLEAN is
			-- Boolean value
		require
			is_boolean: is_boolean (variable_type)
		local
			int: INTEGER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				int := ccom_variant_bool_byref (item)
			else
				int := ccom_variant_bool (item)
			end
			Result := (int /= variant_false)
		end

	date: DOUBLE is
			-- Date value
		require
			is_date: is_date (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_date_byref (item)
			else
				Result := ccom_variant_date (item)
			end
		end

	error: INTEGER is
			-- Error value
		require
			is_error: is_error (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				Result := ccom_variant_error_byref (item)
			else
				Result := ccom_variant_error (item)
			end
		end

	variant_structure: ECOM_VARIANT is
			-- Variant value
		require
			is_variant: is_variant (variable_type)
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then				
				!!Result.make_by_pointer (ccom_variant_variant (item))
			end
		ensure
			Result /= Void
		end

	integer_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_INTEGER_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_integer4: is_integer4 (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

	short_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_SHORT_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_integer2: is_integer2 (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

	real_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_REAL_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_real4: is_real4 (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

	double_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_DOUBLE_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_real8: is_real8 (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

	char_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_CHARACTER_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_character: is_character (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

	error_safearray: ECOM_SAFEARRAY [ECOM_SAFEARRAY_ERROR_ELEMENT] is
			-- Integer SAFEARRAY
		require
			is_error: is_error (variable_type)
			is_array: is_array (variable_type)
		local
			ptr: POINTER
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				ptr := ccom_variant_safearray_byref (item)
			else
				ptr := ccom_variant_safearray (item)
			end
			create Result.make_from_pointer (ptr)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_variant
		end


feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	variant_true: INTEGER is -1
			-- True value of type VARAINT_BOOL
	
	variant_false: INTEGER is 0
			-- False value of type VARIANT_BOOL


feature {NONE} -- Externals

	c_size_of_variant: INTEGER is
		external 
			"C [macro %"E_variant.h%"]"
		alias
			"sizeof(VARIANT)"
		end

	ccom_variant_variable_type (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_char (a_ptr: POINTER): CHARACTER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_CHARACTER"
		end

	ccom_variant_char_byref (a_ptr: POINTER): CHARACTER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_CHARACTER"
		end

	ccom_variant_integer2 (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_integer2_byref (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_integer4 (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_integer4_byref (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_real4 (a_ptr: POINTER): REAL is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_REAL"
		end

	ccom_variant_real4_byref (a_ptr: POINTER): REAL is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_REAL"
		end

	ccom_variant_real8 (a_ptr: POINTER): DOUBLE is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_DOUBLE"
		end

	ccom_variant_real8_byref (a_ptr: POINTER): DOUBLE is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_DOUBLE"
		end

	ccom_variant_bool (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_bool_byref (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_date (a_ptr: POINTER): DOUBLE is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_DOUBLE"
		end

	ccom_variant_date_byref (a_ptr: POINTER): DOUBLE is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_DOUBLE"
		end

	ccom_variant_error (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_error_byref (a_ptr: POINTER): INTEGER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_INTEGER"
		end

	ccom_variant_variant (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_variant_safearray (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_POINTER"
		end

	ccom_variant_safearray_byref (a_ptr: POINTER): POINTER is
		external
			"C [macro %"E_variant.h%"](EIF_POINTER): EIF_POINTER"
		end


invariant
	invariant_clause: -- Your invariant here

end -- class ECOM_VARIANT

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

