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

	date: DATE_TIME is
			-- Date value
		require
			is_date: is_date (variable_type)
		local
			tmp_double: DOUBLE
		do
			if 
				binary_and (variable_type, Vt_byref) = Vt_byref 
			then
				tmp_double := ccom_variant_date_byref (item)
			else
				tmp_double := ccom_variant_date (item)
			end
			Result := ccom_ce_date (ecom_rt_ptr, tmp_double)
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

	integer_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY
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
			Result := ccom_ce_safearray_long (ecom_rt_ptr, ptr)
		end

	short_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY
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
			Result := ccom_ce_safearray_short (ecom_rt_ptr, ptr)
		end

	real_array: ECOM_ARRAY [REAL] is
			-- ARRAY of reals
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
			Result := ccom_ce_safearray_float (ecom_rt_ptr, ptr)
		end

	double_array: ECOM_ARRAY [DOUBLE] is
			-- ARRAY of doubles
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
			Result := ccom_ce_safearray_double (ecom_rt_ptr, ptr)
		end

	char_array: ECOM_ARRAY [CHARACTER] is
			-- ARRAY of characters
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
			Result := ccom_ce_safearray_char (ecom_rt_ptr, ptr)
		end

	error_array: ECOM_ARRAY [ECOM_HRESULT] is
			-- ARRAY of HRESULTs
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
			Result := ccom_ce_safearray_hresult (ecom_rt_ptr, ptr)
		end

	currency_array: ECOM_ARRAY [ECOM_CURRENCY] is
			-- ARRAY of CURRENCY.
		require
			is_currency: is_currency (variable_type)
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
			Result := ccom_ce_safearray_currency (ecom_rt_ptr, ptr)
		end

	date_array: ECOM_ARRAY [DATE_TIME] is
			-- ARRAY of DATE.
		require
			is_date: is_date (variable_type)
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
			Result := ccom_ce_safearray_date (ecom_rt_ptr, ptr)
		end

	string_array: ECOM_ARRAY [STRING] is
			-- ARRAY of STRING.
		require
			is_bstr: is_bstr (variable_type)
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
			Result := ccom_ce_safearray_bstr (ecom_rt_ptr, ptr)
		end

	boolean_array: ECOM_ARRAY [BOOLEAN] is
			-- ARRAY of BOOLEAN.
		require
			is_boolean: is_boolean (variable_type)
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
			Result := ccom_ce_safearray_boolean (ecom_rt_ptr, ptr)
		end

	variant_array: ECOM_ARRAY [ECOM_VARIANT] is
			-- ARRAY of ECOM_VARIANTs.
		require
			is_variant: is_variant (variable_type)
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
			Result := ccom_ce_safearray_variant (ecom_rt_ptr, ptr)
		end

	decimal_array: ECOM_ARRAY [ECOM_DECIMAL] is
			-- ARRAY of ECOM_DECIMALs.
		require
			is_decimal: is_decimal (variable_type)
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
			Result := ccom_ce_safearray_decimal (ecom_rt_ptr, ptr)
		end

	dispatch_array: ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE] is
			-- ARRAY of ECOM_GENERIC_DISPINTERFACEs.
		require
			is_dispatch: is_dispatch (variable_type)
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
			Result := ccom_ce_safearray_dispatch (ecom_rt_ptr, ptr)
		end

	unknown_array: ECOM_ARRAY [ECOM_GENERIC_INTERFACE] is
			-- ARRAY of ECOM_GENERIC_INTERFACEs.
		require
			is_unknown: is_unknown (variable_type)
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
			Result := ccom_ce_safearray_unknown (ecom_rt_ptr, ptr)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_variant
		end

feature -- Element change


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

	ecom_rt_ptr: POINTER is
		external
			"C [macro %"ecom_rt_globals.h%"]: EIF_POINTER"
		alias
			"&rt_ce"
		end

	ccom_ce_date (cpp_obj: POINTER; a_date: DOUBLE): DATE_TIME is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (DATE): EIF_REFERENCE"
		end

	ccom_ce_safearray_short (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [INTEGER] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_long (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [INTEGER] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_float (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [REAL] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_double (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [DOUBLE] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_currency (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_CURRENCY] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_date (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [DATE_TIME] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_bstr (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [STRING] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_hresult (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_HRESULT] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_boolean (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [BOOLEAN] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_variant (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_VARIANT] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_decimal (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_DECIMAL] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_char (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [CHARACTER] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_dispatch (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

	ccom_ce_safearray_unknown (cpp_obj: POINTER; a_safearray: POINTER): ECOM_ARRAY [ECOM_GENERIC_INTERFACE] is
		external
			"C++ [ecom_runtime_ce %"ecom_runtime_c_e.h%"] (SAFEARRAY *): EIF_REFERENCE"
		end

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

