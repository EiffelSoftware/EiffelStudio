indexing
	description: "Generate names for vartype constants"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VARTYPE_NAMER

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
			{ANY} valid_var_type, is_basic
		end

	WIZARD_NAMER_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize tables
		do
			create c_names.make (20)

			c_names.put (Void_c_keyword, Vt_empty)
			c_names.put (Void_c_keyword, Vt_null)
			c_names.put (Com_char_type, Vt_i1)
			c_names.put (Com_short_type, Vt_i2)
			c_names.put (Long_macro, Vt_i4)
			c_names.put (Uchar_type, Vt_ui1)
			c_names.put (Ushort_type, Vt_ui2)
			c_names.put (Ulong_type, Vt_ui4)
			c_names.put (Com_float_type, Vt_r4)
			c_names.put (Double_c_keyword, Vt_r8)
			c_names.put (Com_integer_type, Vt_int)
			c_names.put (Uint_type, Vt_uint)
			c_names.put (void_c_keyword, Vt_void)
			c_names.put ("void *", binary_or (Vt_void, Vt_byref))
			c_names.put (Variant_bool, Vt_bool)
			c_names.put (Date_c_keyword, Vt_date)
			c_names.put (Hresult, Vt_hresult)
			c_names.put (Variant_c_keyword, Vt_variant)
			c_names.put (Currency, Vt_cy)
			c_names.put (Decimal, Vt_decimal)
			c_names.put (Idispatch, Vt_dispatch)
			c_names.put (Iunknown, Vt_unknown)
			c_names.put (Bstr, Vt_bstr)
			c_names.put (Lpstr, Vt_lpstr)
			c_names.put (Lpwstr, Vt_lpwstr)
			c_names.put (Large_integer, Vt_i8)
			c_names.put (Ularge_integer, Vt_ui8)
			c_names.put (Ptr, Vt_ptr)
			c_names.put (Safearray, Vt_safearray)
			c_names.put (Carray, Vt_carray)
			c_names.put (Typedef, Vt_userdefined)
			c_names.put (Hresult, Vt_error)
	
			create eiffel_names.make (20)

			eiffel_names.put (Void_type, Vt_empty)
			eiffel_names.put (Void_type, Vt_null)
			eiffel_names.put (Character_type, Vt_i1)
			eiffel_names.put (Integer_type, Vt_i2)
			eiffel_names.put (Integer_type, Vt_i4)
			eiffel_names.put (Character_type, Vt_ui1)
			eiffel_names.put (Integer_type, Vt_ui2)
			eiffel_names.put (Integer_type, Vt_ui4)
			eiffel_names.put (Real_type, Vt_r4)
			eiffel_names.put (Double_type, Vt_r8)
			eiffel_names.put (Integer_type, Vt_int)
			eiffel_names.put (Integer_type, Vt_uint)
			eiffel_names.put (Void_type, Vt_void)
			eiffel_names.put (Boolean_type, Vt_bool)
			eiffel_names.put (Date_time, Vt_date)
			eiffel_names.put (Ecom_hresult, Vt_hresult)
			eiffel_names.put (Ecom_variant, Vt_variant)
			eiffel_names.put (Ecom_currency, Vt_cy)
			eiffel_names.put (Ecom_decimal, Vt_decimal)
			eiffel_names.put (Ecom_interface, Vt_dispatch)
			eiffel_names.put (Ecom_interface, Vt_unknown)
			eiffel_names.put (String_type, Vt_bstr)
			eiffel_names.put (String_type, Vt_lpstr)
			eiffel_names.put (String_type, Vt_lpwstr)
			eiffel_names.put (Ecom_large_integer, Vt_i8)
			eiffel_names.put (Ecom_ularge_integer, Vt_ui8)
			eiffel_names.put (Cell_type, Vt_ptr)
			eiffel_names.put (Array_type, Vt_safearray)
			eiffel_names.put (Array_type, Vt_carray)
			eiffel_names.put (Alias_type, Vt_userdefined)
			eiffel_names.put (Ecom_hresult, Vt_error)
			eiffel_names.put (Character_type, Vt_i1)
			eiffel_names.put (Character_type, Vt_ui1)


			create variant_field_names.make (60)

			variant_field_names.put (Variant_bval, Vt_ui1)
			variant_field_names.put (Variant_ival, Vt_i2)
			variant_field_names.put (Variant_lval, Vt_i4)
			variant_field_names.put (Variant_fltval, Vt_r4)
			variant_field_names.put (Variant_dblval, Vt_r8)
			variant_field_names.put (Variant_boolval, Vt_bool)
			variant_field_names.put (Variant_scode, Vt_error)
			variant_field_names.put (Variant_scode, Vt_hresult)
			variant_field_names.put (Variant_cyval, Vt_cy)
			variant_field_names.put (Variant_date, Vt_date)
			variant_field_names.put (Variant_bstrval, Vt_bstr)
			variant_field_names.put (Variant_punkval, Vt_unknown)
			variant_field_names.put (Variant_pdispval, Vt_dispatch)
			variant_field_names.put (Variant_parray, Vt_array)
			variant_field_names.put (Variant_pbval, binary_or (Vt_byref, Vt_ui1))
			variant_field_names.put (Variant_pival, binary_or (Vt_byref, Vt_i2))
			variant_field_names.put (Variant_plval, binary_or (Vt_byref, Vt_i4))
			variant_field_names.put (Variant_pfltval, binary_or (Vt_byref, Vt_r4))
			variant_field_names.put (Variant_pdblval, binary_or (Vt_byref, Vt_r8))
			variant_field_names.put (Variant_pboolval, binary_or (Vt_byref, Vt_bool))
			variant_field_names.put (Variant_pscode, binary_or (Vt_byref, Vt_error))
			variant_field_names.put (Variant_pcyval, binary_or (Vt_byref, Vt_cy))
			variant_field_names.put (Variant_pdate, binary_or (Vt_byref, Vt_date))
			variant_field_names.put (Variant_pbstrval, binary_or (Vt_byref, Vt_bstr))
			variant_field_names.put (Variant_ppunkval, binary_or (Vt_byref, Vt_unknown))
			variant_field_names.put (Variant_ppdispval, binary_or (Vt_byref, Vt_dispatch))
			variant_field_names.put (Variant_pparray, binary_or (Vt_byref, Vt_array))
			variant_field_names.put (Variant_pvarval, binary_or (Vt_byref, Vt_variant))
			variant_field_names.put (Variant_pvarval,  Vt_variant)
			variant_field_names.put (Variant_cval, Vt_i1)
			variant_field_names.put (Variant_uival, Vt_ui2)
			variant_field_names.put (Variant_ulval, Vt_ui4)
			variant_field_names.put (Variant_intval, Vt_int)
			variant_field_names.put (Variant_uintval, Vt_uint)
			variant_field_names.put (Variant_decval, Vt_decimal)
			variant_field_names.put (Variant_pcval, binary_or (Vt_byref, Vt_i1))
			variant_field_names.put (Variant_puival, binary_or (Vt_byref, Vt_ui2))
			variant_field_names.put (Variant_pulval, binary_or (Vt_byref, Vt_ui4))
			variant_field_names.put (Variant_pintval, binary_or (Vt_byref, Vt_int))
			variant_field_names.put (Variant_puintval, binary_or (Vt_byref, Vt_uint))
			variant_field_names.put (Variant_pdecval, binary_or (Vt_byref, Vt_decimal))
			variant_field_names.put (Variant_brecval, Vt_record)
			variant_field_names.put (Variant_brecval, binary_or (Vt_byref, Vt_record))
			variant_field_names.put (Variant_byref, binary_or (Vt_byref, Vt_void))

			create ce_array_function_names.make (30)

			ce_array_function_names.put (Ccom_ce_array_character, Vt_i1)
			ce_array_function_names.put (Ccom_ce_array_unsigned_character, Vt_ui1)
			ce_array_function_names.put (Ccom_ce_array_short, Vt_i2)
			ce_array_function_names.put (Ccom_ce_array_unsigned_short, Vt_ui2)
			ce_array_function_names.put (Ccom_ce_array_long, Vt_i4)
			ce_array_function_names.put (Ccom_ce_array_unsigned_long, Vt_ui4)
			ce_array_function_names.put (Ccom_ce_array_integer, Vt_int)
			ce_array_function_names.put (Ccom_ce_array_unsigned_integer, Vt_uint)
			ce_array_function_names.put (Ccom_ce_array_float, Vt_r4)
			ce_array_function_names.put (Ccom_ce_array_double, Vt_r8)
			ce_array_function_names.put (Ccom_ce_array_currency, Vt_cy)
			ce_array_function_names.put (Ccom_ce_array_date, Vt_date)
			ce_array_function_names.put (Ccom_ce_array_bstr, Vt_bstr)
			ce_array_function_names.put (Ccom_ce_array_hresult, Vt_hresult)
			ce_array_function_names.put (Ccom_ce_array_hresult, Vt_error)
			ce_array_function_names.put (Ccom_ce_array_boolean, Vt_bool)
			ce_array_function_names.put (Ccom_ce_array_variant, Vt_variant)
			ce_array_function_names.put (Ccom_ce_array_decimal, Vt_decimal)
			ce_array_function_names.put (Ccom_ce_array_record, Vt_record)
			ce_array_function_names.put (Ccom_ce_array_lpstr, Vt_lpstr)
			ce_array_function_names.put (Ccom_ce_array_lpwstr, Vt_lpwstr)
			ce_array_function_names.put (Ccom_ce_array_long_long, Vt_i8)
			ce_array_function_names.put (Ccom_ce_array_ulong_long, Vt_ui8)
			ce_array_function_names.put (Ccom_ce_array_dispatch, Vt_dispatch)
			ce_array_function_names.put (Ccom_ce_array_unknown, Vt_unknown)

			create ec_array_function_names.make (30)

			ec_array_function_names.put (Ccom_ec_array_character, Vt_i1)
			ec_array_function_names.put (Ccom_ec_array_unsigned_character, Vt_ui1)
			ec_array_function_names.put (Ccom_ec_array_short, Vt_i2)
			ec_array_function_names.put (Ccom_ec_array_unsigned_short, Vt_ui2)
			ec_array_function_names.put (Ccom_ec_array_long, Vt_i4)
			ec_array_function_names.put (Ccom_ec_array_unsigned_long, Vt_ui4)
			ec_array_function_names.put (Ccom_ec_array_integer, Vt_int)
			ec_array_function_names.put (Ccom_ec_array_unsigned_integer, Vt_uint)
			ec_array_function_names.put (Ccom_ec_array_float, Vt_r4)
			ec_array_function_names.put (Ccom_ec_array_double, Vt_r8)
			ec_array_function_names.put (Ccom_ec_array_currency, Vt_cy)
			ec_array_function_names.put (Ccom_ec_array_date, Vt_date)
			ec_array_function_names.put (Ccom_ec_array_bstr, Vt_bstr)
			ec_array_function_names.put (Ccom_ec_array_hresult, Vt_hresult)
			ec_array_function_names.put (Ccom_ec_array_hresult, Vt_error)
			ec_array_function_names.put (Ccom_ec_array_boolean, Vt_bool)
			ec_array_function_names.put (Ccom_ec_array_variant, Vt_variant)
			ec_array_function_names.put (Ccom_ec_array_decimal, Vt_decimal)
			ec_array_function_names.put (Ccom_ec_array_record, Vt_record)
			ec_array_function_names.put (Ccom_ec_array_lpstr, Vt_lpstr)
			ec_array_function_names.put (Ccom_ec_array_lpwstr, Vt_lpwstr)
			ec_array_function_names.put (Ccom_ec_array_long_long, Vt_i8)
			ec_array_function_names.put (Ccom_ec_array_ulong_long, Vt_ui8)
			ec_array_function_names.put (Ccom_ec_array_dispatch, Vt_dispatch)
			ec_array_function_names.put (Ccom_ec_array_unknown, Vt_unknown)

		ensure
			non_void_c_names: c_names /= Void
			non_void_eiffel_names: eiffel_names /= Void
			non_void_variant_field_names: variant_field_names /= Void
		end

feature -- Access

	c_name (a_var_type: INTEGER): STRING is
			-- C name of constant `a_var_type'
		require
			valid_var_type: valid_var_type (a_var_type)
		do	
			Result := clone (c_names.item (a_var_type))
		ensure
			non_void_c_name: Result /= Void
			valid_c_name: not Result.empty
		end

	eiffel_name (a_var_type: INTEGER): STRING is
			-- Eiffel name of constant `a_var_type'
		require
			valid_var_type: valid_var_type (a_var_type)
		do	
			Result := clone (eiffel_names.item (a_var_type))
		ensure
			non_void_eiffel_name: Result /= Void
			valid_eiffel_name: not Result.empty
		end

	variant_field_name (a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Name VARIANT field for constant `a_var_type'
		require
			valid_visitor: a_visitor /= Void
		local
			a_type: INTEGER
			tmp_string: STRING
		do
			a_type := a_visitor.vt_type
			if is_array (a_type) then
				if is_byref (a_type) then
					a_type := binary_or (Vt_byref, Vt_array)
				else
					a_type := Vt_array
				end
			end

			Result := clone (variant_field_names.item (a_type))

			if (Result = Void or else Result.empty) then
				if a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer then
					Result := clone (Variant_punkval)
				elseif  a_visitor.is_interface_pointer_pointer or a_visitor.is_coclass_pointer_pointer then
					Result := clone (Variant_ppunkval)
				else
					tmp_string := clone (a_visitor.c_type)
					tmp_string.append (Space)
					tmp_string.append (message_output.Not_variant_type)
					message_output.add_warning (Current, tmp_string)
					create Result.make (0)
				end
			end
		end

	ce_array_function_name (a_var_type: INTEGER): STRING is
			-- CE conversion function name of constant `a_var_type'
		require
			valid_var_type: valid_var_type (a_var_type)
		do	
			Result := clone (ce_array_function_names.item (a_var_type))
		ensure
			non_void_ce_array_function_name: Result /= Void
			valid_c_name: not Result.empty
		end

	ec_array_function_name (a_var_type: INTEGER): STRING is
			-- EC conversion function name of constant `a_var_type'
		require
			valid_var_type: valid_var_type (a_var_type)
		do	
			Result := clone (ec_array_function_names.item (a_var_type))
		ensure
			non_void_ec_array_function_name: Result /= Void
			valid_c_name: not Result.empty
		end

feature {NONE} -- Implementation

	c_names: HASH_TABLE [STRING, INTEGER]
			-- C names.

	eiffel_names: HASH_TABLE [STRING, INTEGER]
			-- Eiffel names.

	variant_field_names: HASH_TABLE [STRING, INTEGER]
			-- VARIANT field names.

	ce_array_function_names: HASH_TABLE [STRING, INTEGER]
			-- CE conversion function names for arrays.

	ec_array_function_names: HASH_TABLE [STRING, INTEGER]
			-- EC conversion function names for arrays.

	
	
invariant
	non_void_c_names: c_names /= Void
	non_void_eiffel_names: eiffel_names /= Void
	non_void_variant_field_names: variant_field_names /= Void
	non_void_ce_array_function_names: ce_array_function_names /= Void
	non_void_ec_array_function_names: ec_array_function_names /= Void
	

end -- class WIZARD_VARTYPE_NAMER

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
  