indexing

	description: "OLE VARIANT structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_VARIANT

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate,
			destroy
		end

	EOLE_VAR_TYPE
		export
			{NONE} all
		end

feature -- Element change

	allocate: POINTER is
			-- Create associated OLE pointer.
		do
			Result := ole2_variant_alloc
			ole2_variant_init (Result)
		end

	destroy is
			-- Destroy associated OLE pointer.
		do
			if not is_attached and then ole_ptr /= default_pointer then
				ole2_variant_clear (ole_ptr)
				ole2_variant_free (ole_ptr)
				ole_ptr := default_pointer
			end
		end

	clear is
			-- Clear associated OLE pointer.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_variant_clear (ole_ptr)
		end

	varcopy (other: EOLE_VARIANT) is
			-- Copy other to `Current'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_variant_copy (other.ole_ptr, ole_ptr)
		end

	change_type (new_type: INTEGER) is
			-- Change type to `new_type'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_variant_change_type (ole_ptr, new_type)
		end

	clone_with_new_type (new_type: INTEGER): EOLE_VARIANT is
			-- Clone `Current' with type `new_type'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result.init
			ole2_clone_with_new_type (Result.ole_ptr, ole_ptr, new_type)
		end

	set_no_param is
			-- VARIANT structure with no parameter.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_no_param (ole_ptr)
		end

	set_vartype (vartyp: INTEGER) is
			-- Set variable type with `vartype'.
			-- See class EOLE_VARTYPE for `vartype' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_vartype (ole_ptr, vartype)
		end

	set_integer2 (int2: INTEGER) is
			-- Set value to short `int2'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_integer2 (ole_ptr, int2)
		end

	set_integer4 (int4: INTEGER) is
			-- Set value to long `int4'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_integer4 (ole_ptr, int4)
		end

	set_real4 (rea4: REAL) is
			-- Set value to float `real4'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_real4 (ole_ptr, rea4)
		end

	set_real8 (rea8: REAL) is
			-- Set value to double `real8'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_real8 (ole_ptr, rea8)
		end

	set_boolean (bool: BOOLEAN) is
			-- Set value to VARIANT_BOOL `bool'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_bool (ole_ptr, bool)
		end

	set_error (error_code: INTEGER) is
			-- Set value with `error_code'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_error (ole_ptr, error_code)
		end

	set_currency (lo, hi: INTEGER) is
			-- Set value to CY constitued by `lo' and `hi'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_currency (ole_ptr, lo, hi)
		end

	set_date (dat: REAL) is
			-- Set value to DATE `date'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_date (ole_ptr, dat)
		end

	set_bstr (bst: EOLE_BSTR) is
			-- Set value to BSTR `bst'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_bstr (ole_ptr, bst.ole_ptr)
		end

	set_unknown (unk: EOLE_UNKNOWN) is
			-- Set value to IUnknown FAR * `unk'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_unknown (ole_ptr, unk.ole_interface_ptr)
		end

	set_dispatch (disp: EOLE_DISPATCH) is
			-- Set value to IDispatch FAR * `disp'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_dispatch (ole_ptr, disp.ole_interface_ptr)
		end

	set_safearray (sa: EOLE_SAFEARRAY) is
			-- Set value to SAFEARRAY FAR * `sa'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_safearray (ole_ptr, sa.ole_ptr)
		end

	set_by_reference (ptr: POINTER; vartyp: INTEGER) is
			-- Set value `vartype' referenced by `ptr'.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			ole2_var_set_by_reference (ole_ptr, ptr, vartyp)
		end
		
feature -- Access

	vartype: INTEGER is
			-- Variable type
			-- See class EOLE_VARTYPE for `Result' value.
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_type (ole_ptr)
		end

	integer2: INTEGER is
			-- Short value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_integer2 (ole_ptr)
		end

	integer4: INTEGER is
			-- Long value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_integer4 (ole_ptr)
		end

	real4: REAL is
			-- Real value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_real4 (ole_ptr)
		end

	real8: REAL is
			-- Double value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_real8 (ole_ptr)
		end

	boolean: BOOLEAN is
			-- Boolean value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_boolean (ole_ptr)
		end

	error: INTEGER is
			-- Error value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_error (ole_ptr)
		end

	currency_lo: INTEGER is
			-- Low word of currency value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_currency_lo (ole_ptr)
		end

	currency_hi: INTEGER is
			-- High word of currency value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_currency_hi (ole_ptr)
		end

	date: REAL is
			-- Date value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_var_get_date (ole_ptr)
		end

	bstr: EOLE_BSTR is
			-- Binary string value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make_from_ptr (ole2_var_get_bstr (ole_ptr))
		end

	unknown: EOLE_UNKNOWN is
			-- Interface value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_var_get_unknown (ole_ptr))
		end

	dispatch: EOLE_DISPATCH is
			-- IDispatch value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_var_get_dispatch (ole_ptr))
		end

	safearray: EOLE_SAFEARRAY is
			-- SafeArray value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_var_get_safearray (ole_ptr))
		end

	by_reference: EOLE_REFERENCE is
			-- Referenced value
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.set_type (ole2_var_get_by_ref_type (ole_ptr))
			Result.set_ptr (ole2_var_get_by_ref_ptr (ole_ptr))
		end
	
	is_reference: BOOLEAN is
			-- Is variant passed by reference?
		do
			Result := c_and (vartype, Vt_byref) = vartype
		end
		
feature {NONE} -- Externals

	c_and (operand1, operand2: INTEGER): INTEGER is
			-- Binary 'and'.
		external
			"C [macro %"oleflags.h%"]"
		end
	
	ole2_variant_alloc: POINTER is
		external
			"C"
		alias
			"eole2_variant_alloc"
		end

	ole2_variant_free (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_variant_free"
		end

	ole2_variant_init (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_variant_init"
		end

	ole2_variant_clear (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_variant_clear"
		end

	ole2_variant_copy (ptr_dest, ptr_source: POINTER) is
		external
			"C"
		alias
			"eole2_variant_copy"
		end

	ole2_variant_change_type (ptr: POINTER; newtype: INTEGER) is
		external
			"C"
		alias
			"eole2_variant_change_type"
		end

	ole2_clone_with_new_type (ptr_dest, ptr_src: POINTER; newtype: INTEGER) is
		external
			"C"
		alias
			"eole2_variant_clone_with_new_type"
		end

	ole2_var_set_no_param (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_var_set_no_param"
		end

	ole2_var_set_vartype (ptr: POINTER; vartyp: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_vartype"
		end

	ole2_var_set_integer2 (ptr: POINTER; int2: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_integer2"
		end

	ole2_var_set_integer4 (ptr: POINTER; int4: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_integer4"
		end

	ole2_var_set_real4 (ptr: POINTER; rea4: REAL) is
		external
			"C"
		alias
			"eole2_var_set_real4"
		end

	ole2_var_set_real8 (ptr: POINTER; rea8: REAL) is
		external
			"C"
		alias
			"eole2_var_set_real8"
		end

	ole2_var_set_bool (ptr: POINTER; bool: BOOLEAN) is
		external
			"C"
		alias
			"eole2_var_set_bool"
		end

	ole2_var_set_error (ptr: POINTER; err: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_error"
		end

	ole2_var_set_currency (ptr: POINTER; lo, hi: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_currency"
		end

	ole2_var_set_date (ptr: POINTER; dat: REAL) is
		external
			"C"
		alias
			"eole2_var_set_date"
		end

	ole2_var_set_bstr (ptr, bst: POINTER) is
		external
			"C"
		alias
			"eole2_var_set_bstr"
		end

	ole2_var_set_unknown (ptr, unk: POINTER) is
		external
			"C"
		alias
			"eole2_var_set_unknown"
		end

	ole2_var_set_dispatch (ptr, disp: POINTER) is
		external
			"C"
		alias
			"eole2_var_set_dispatch"
		end

	ole2_var_set_safearray (ptr, sa: POINTER) is
		external
			"C"
		alias
			"eole2_var_set_safearray"
		end

	ole2_var_set_by_reference (varptr, ptr: POINTER; vartyp: INTEGER) is
		external
			"C"
		alias
			"eole2_var_set_by_reference"
		end

	ole2_var_get_type (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_type"
		end

	ole2_var_get_integer2 (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_integer2"
		end

	ole2_var_get_integer4 (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_integer4"
		end

	ole2_var_get_real4 (ptr: POINTER): REAL is
		external
			"C"
		alias
			"eole2_var_get_real4"
		end

	ole2_var_get_real8 (ptr: POINTER): REAL is
		external
			"C"
		alias
			"eole2_var_get_real8"
		end

	ole2_var_get_boolean (ptr: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_var_get_boolean"
		end

	ole2_var_get_error (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_error"
		end

	ole2_var_get_currency_lo (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_currency_lo"
		end

	ole2_var_get_currency_hi (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_currency_hi"
		end

	ole2_var_get_date (ptr: POINTER): REAL is
		external
			"C"
		alias
			"eole2_var_get_date"
		end

	ole2_var_get_bstr (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_var_get_bstr"
		end

	ole2_var_get_unknown (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_var_get_unknown"
		end

	ole2_var_get_dispatch (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_var_get_dispatch"
		end

	ole2_var_get_safearray (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_var_get_safearray"
		end

	ole2_var_get_by_ref_type (ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_var_get_by_ref_type"
		end

	ole2_var_get_by_ref_ptr (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_var_get_by_ref_ptr"
		end
	
end -- class EOLE_VARIANT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

