indexing
	description: "Vratype namer constants"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_NAMER_CONSTANTS

feature -- VARIANT field names -- 14

	Variant_bval: STRING is "bVal"

	Variant_ival: STRING is "iVal"

	Variant_lval: STRING is "lVal"

	Variant_fltval: STRING is "fltVal"

	Variant_dblval: STRING is "dblVal"

	Variant_boolval: STRING is "boolVal"

	Variant_scode: STRING is "scode"

	Variant_cyval: STRING is "cyVal"

	Variant_date: STRING is "date"

	Variant_bstrval: STRING is "bstrVal"

	Variant_punkval: STRING is "punkVal"

	Variant_pdispval: STRING is "pdispVal"

	Variant_parray: STRING is "parray"

	Variant_pbval: STRING is "pbVal"

	Variant_pival: STRING is "piVal"

	Variant_plval: STRING is "plVal"

	Variant_pfltval: STRING is "pfltVal"

	Variant_pdblval: STRING is "pdblVal"

	Variant_pboolval: STRING is "pboolVal"

	Variant_pscode: STRING is "pscode"

	Variant_pcyval: STRING is "pcyVal"

	Variant_pdate: STRING is "pdate"

	Variant_pbstrval: STRING is "pbstrVal"

	Variant_ppunkval: STRING is "ppunkVal"

	Variant_ppdispval: STRING is "ppdispVal"

	Variant_pparray: STRING is "pparray"

	Variant_pvarval: STRING is "pvarVal"

	Variant_cval: STRING is "cVal"

	Variant_uival: STRING is "uiVal"
	
	Variant_ulval: STRING is "ulVal"

	Variant_intval: STRING is "intVal"

	Variant_uintval: STRING is "uintVal"

	Variant_decval: STRING is "decVal"

	Variant_pcval: STRING is "pcVal"

	Variant_puival: STRING is "puiVal"
	
	Variant_pulval: STRING is "pulVal"

	Variant_pintval: STRING is "pintVal"

	Variant_puintval: STRING is "puintVal"

	Variant_pdecval: STRING is "pdecVal"

	Variant_byref: STRING is "byref"

	Variant_brecval: STRING is "pvRecord"
	
	Variant_llval: STRING is "llVal"
	
	Variant_ullval: STRING is "ullVal"

	Variant_pllval: STRING is "pllVal"
	
	Variant_pullval: STRING is "pullVal"

feature -- C to Eiffel conversion function names for arrays.

	Ccom_ce_array_character: STRING is "ccom_ce_array_character"

	Ccom_ce_array_unsigned_character: STRING is "ccom_ce_array_unsigned_character"

	Ccom_ce_array_short: STRING is "ccom_ce_array_short"

	Ccom_ce_array_unsigned_short: STRING is "ccom_ce_array_unsigned_short"

	Ccom_ce_array_long: STRING is "ccom_ce_array_long"

	Ccom_ce_array_unsigned_long: STRING is "ccom_ce_array_unsigned_long"

	Ccom_ce_array_integer: STRING is "ccom_ce_array_integer"

	Ccom_ce_array_unsigned_integer: STRING is "ccom_ce_array_unsigned_integer"

	Ccom_ce_array_float: STRING is "ccom_ce_array_float"

	Ccom_ce_array_double: STRING is "ccom_ce_array_double"

	Ccom_ce_array_currency: STRING is "ccom_ce_array_currency"

	Ccom_ce_array_date: STRING is "ccom_ce_array_date"

	Ccom_ce_array_bstr: STRING is "ccom_ce_array_bstr"

	Ccom_ce_array_hresult: STRING is "ccom_ce_array_hresult"

	Ccom_ce_array_boolean: STRING is "ccom_ce_array_boolean"

	Ccom_ce_array_variant: STRING is "ccom_ce_array_variant"

	Ccom_ce_array_decimal: STRING is "ccom_ce_array_decimal"

	Ccom_ce_array_record: STRING is "ccom_ce_array_record"

	Ccom_ce_array_lpstr: STRING is "ccom_ce_array_lpstr"

	Ccom_ce_array_lpwstr: STRING is "ccom_ce_array_lpwstr"

	Ccom_ce_array_long_long: STRING is "ccom_ce_array_long_long"

	Ccom_ce_array_ulong_long: STRING is "ccom_ce_array_ulong_long"

	Ccom_ce_array_dispatch: STRING is "ccom_ce_array_dispatch"

	Ccom_ce_array_unknown: STRING is "ccom_ce_array_unknown"

feature -- Eiffel to C conversion function names for arrays.

	Ccom_ec_array_character: STRING is "ccom_ec_array_character"

	Ccom_ec_array_short: STRING is "ccom_ec_array_short"

	Ccom_ec_array_long: STRING is "ccom_ec_array_long"

	Ccom_ec_array_integer: STRING is "ccom_ec_array_integer"

	Ccom_ec_array_unsigned_character: STRING is "ccom_ec_array_unsigned_character"

	Ccom_ec_array_unsigned_short: STRING is "ccom_ec_array_unsigned_short"

	Ccom_ec_array_unsigned_long: STRING is "ccom_ec_array_unsigned_long"

	Ccom_ec_array_unsigned_integer: STRING is "ccom_ec_array_unsigned_integer"

	Ccom_ec_array_float: STRING is "ccom_ec_array_float"

	Ccom_ec_array_double: STRING is "ccom_ec_array_double"

	Ccom_ec_array_currency: STRING is "ccom_ec_array_currency"

	Ccom_ec_array_date: STRING is "ccom_ec_array_date"

	Ccom_ec_array_bstr: STRING is "ccom_ec_array_bstr"

	Ccom_ec_array_hresult: STRING is "ccom_ec_array_hresult"

	Ccom_ec_array_boolean: STRING is "ccom_ec_array_boolean"

	Ccom_ec_array_variant: STRING is "ccom_ec_array_variant"

	Ccom_ec_array_decimal: STRING is "ccom_ec_array_decimal"

	Ccom_ec_array_record: STRING is "ccom_ec_array_record"

	Ccom_ec_array_lpstr: STRING is "ccom_ec_array_lpstr"

	Ccom_ec_array_lpwstr: STRING is "ccom_ec_array_lpwstr"

	Ccom_ec_array_long_long: STRING is "ccom_ec_array_long_long"

	Ccom_ec_array_ulong_long: STRING is "ccom_ec_array_ulong_long"

	Ccom_ec_array_dispatch: STRING is "ccom_ec_array_dispatch"

	Ccom_ec_array_unknown: STRING is "ccom_ec_array_unknown"

end -- class WIZARD_NAMER_CONSTANTS

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
