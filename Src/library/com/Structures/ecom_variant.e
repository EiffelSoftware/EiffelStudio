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

	character_value: CHARACTER is
			-- Character value
		require
			is_character: is_character (variable_type)
		do
			Result := ccom_variant_char (item)
		end

	character_reference: CHARACTER_REF is
			-- Reference character value
		require
			is_character_ref: is_character (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_char_byref (item)
		end

	unsigned_character_value: CHARACTER is
			-- Byte value
		require
			is_byte: is_unsigned_char (variable_type)
		do
			Result := ccom_variant_unsigned_char (item)
		end

	unsigned_character_reference: CHARACTER_REF is
			-- Reference byte value
		require
			is_byte_ref: is_unsigned_char (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_unsigned_char_byref (item)
		end

	integer2: INTEGER is
			-- Short value
		require
			is_integer2: is_integer2 (variable_type)
		do
			Result := ccom_variant_integer2 (item)
		end

	integer2_reference: INTEGER_REF is
			-- Reference short value
		require
			is_integer2_ref: is_integer2 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_integer2_byref (item)
		end

	unsigned_integer2: INTEGER is
			-- Unsigned short value
		require
			is_unsigned_short: is_unsigned_short (variable_type)
		do
			Result := ccom_variant_unsigned_integer2 (item)
		end

	unsigned_integer2_reference: INTEGER_REF is
			-- Reference unsigned short value
		require
			is_unsigned_integer2_ref: is_unsigned_short (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_unsigned_integer2_byref (item)
		end

	integer4: INTEGER is
			-- Long value
		require
			is_integer4: is_integer4 (variable_type)
		do
			Result := ccom_variant_integer4 (item)
		end

	integer4_reference: INTEGER_REF is
			-- Reference long value
		require
			is_integer4_ref: is_integer4 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_integer4_byref (item)
		end

	unsigned_integer4: INTEGER is
			-- Unsigned long value
		require
			is_unsigned_long: is_unsigned_long (variable_type)
		do
			Result := ccom_variant_unsigned_integer4 (item)
		end

	unsigned_integer4_reference: INTEGER_REF is
			-- Reference unsigned long value
		require
			is_unsigned_long_ref: is_unsigned_long (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_unsigned_integer4_byref (item)
		end

	integer_value: INTEGER is
			-- Integer value
		require
			is_integer: is_int (variable_type)
		do
			Result := ccom_variant_integer (item)
		end

	integer_reference: INTEGER_REF is
			-- Reference integer value
		require
			is_integer_ref: is_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_integer_byref (item)
		end

	unsigned_integer: INTEGER is
			-- Unsigned integer value
		require
			is_unsigned_integer: is_unsigned_int (variable_type)
		do
			Result := ccom_variant_unsigned_integer (item)
		end

	unsigned_integer_reference: INTEGER_REF is
			-- Reference unsigned integer value
		require
			is_unsigned_int_ref: is_unsigned_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_unsigned_integer_byref (item)
		end

	real4: REAL is
			-- Real value
		require
			is_real4: is_real4 (variable_type)
		do
			Result := ccom_variant_real4 (item)
		end

	real4_reference: REAL_REF is
			-- Reference real value
		require
			is_real4_ref: is_real4 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_real4_byref (item)
		end
			

	real8: DOUBLE is
			-- Double value
		require
			is_real8: is_real8 (variable_type)
		do
			Result := ccom_variant_real8 (item)
		end

	real8_reference: DOUBLE_REF is
			-- Reference double value
		require
			is_real8_ref: is_real8 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_real8_byref (item)
		end

	boolean_value: BOOLEAN is
			-- Boolean value
		require
			is_boolean: is_boolean (variable_type)
		do
			Result := ccom_variant_bool (item)
		end

	boolean_reference: BOOLEAN_REF is
			-- Reference boolean value
		require
			is_boolean_ref: is_boolean (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_bool_byref (item)
		end

	date_value: DATE_TIME is
			-- Date value
		require
			is_date: is_date (variable_type)
		local
			tmp_double: DOUBLE
		do
			Result := ccom_variant_date (item)
		end

	date_reference: DATE_TIME is
			-- Date reference value
		require
			is_date_ref: is_date (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_date_byref (item)
		end

	error: ECOM_HRESULT is
			-- Error value
		require
			is_error: is_error (variable_type)
		do
			Result := ccom_variant_error (item)
		end

	error_reference: ECOM_HRESULT is
			-- Error reference value
		require
			is_error_ref: is_error (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_error_byref (item)
		end

	decimal: ECOM_DECIMAL is
			-- Decimal value
		require
			is_decimal: is_decimal (variable_type)
		do
			Result := ccom_variant_decimal (item)
		end

	decimal_reference: ECOM_DECIMAL is
			-- Decimal reference value
		require
			is_decimal_ref: is_decimal (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_decimal_byref (item)
		end

	currency: ECOM_CURRENCY is
			-- Currency value
		require
			is_currency: is_currency (variable_type)
		do
			Result := ccom_variant_currency (item)
		end

	currency_reference: ECOM_CURRENCY is
			-- Reference currency value
		require
			is_currency_ref: is_currency (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_currency_byref (item)
		end

	string_value: STRING is
			-- BSTR value
		require
			is_bstr: is_bstr (variable_type)
		do
			Result := ccom_variant_bstr (item)
		end

	string_reference: STRING is
			-- Reference BSTR value
		require
			is_bstr_ref: is_bstr (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_bstr_byref (item)
		end

	variant_value: ECOM_VARIANT is
			-- Variant value
		require
			is_variant: is_variant (variable_type)
		do
			Result := ccom_variant_variant (item)
		end

	unknown_interface: ECOM_UNKNOWN_INTERFACE is
			-- IUnknown interface value
		require
			is_unknown_ref: is_unknown (variable_type)
		do
			Result := ccom_variant_unknown (item)
		end

	unknown_interface_reference: ECOM_UNKNOWN_INTERFACE is
			-- IUnknown interface reference value
		require
			is_unknown_ref: is_unknown (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_unknown_byref (item)
		end

	dispatch_interface: ECOM_AUTOMATION_INTERFACE is
			-- IDispatch interface value
		require
			is_dispatch_ref: is_dispatch (variable_type)
		do
			Result := ccom_variant_dispatch (item)
		end

	dispatch_interface_reference: ECOM_AUTOMATION_INTERFACE is
			-- IDispatch interface reference value
		require
			is_dispatch_ref: is_dispatch (variable_type) and is_byref (variable_type)
		do
			Result := ccom_variant_dispatch_byref (item)
		end

	integer4_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY value
		require
			is_integer4: is_integer4 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_long (item)
		end

	short_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY value
		require
			is_integer2: is_integer2 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_short (item)
		end

	real_array: ECOM_ARRAY [REAL] is
			-- ARRAY of reals
		require
			is_real4: is_real4 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_float (item)
		end

	double_array: ECOM_ARRAY [DOUBLE] is
			-- ARRAY of doubles
		require
			is_real8: is_real8 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_double (item)
		end

	char_array: ECOM_ARRAY [CHARACTER] is
			-- ARRAY of characters
		require
			is_character: is_character (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_char (item)
		end

	error_array: ECOM_ARRAY [ECOM_HRESULT] is
			-- ARRAY of HRESULTs
		require
			is_error: is_error (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_hresult (item)
		end

	currency_array: ECOM_ARRAY [ECOM_CURRENCY] is
			-- ARRAY of CURRENCY
		require
			is_currency: is_currency (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_currency (item)
		end

	date_array: ECOM_ARRAY [DATE_TIME] is
			-- ARRAY of DATE
		require
			is_date: is_date (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_date (item)
		end

	string_array: ECOM_ARRAY [STRING] is
			-- ARRAY of STRING.
		require
			is_bstr: is_bstr (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_bstr (item)
		end

	boolean_array: ECOM_ARRAY [BOOLEAN] is
			-- ARRAY of BOOLEAN.
		require
			is_boolean: is_boolean (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_boolean (item)
		end

	variant_array: ECOM_ARRAY [ECOM_VARIANT] is
			-- ARRAY of ECOM_VARIANTs.
		require
			is_variant: is_variant (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_variant (item)
		end

	decimal_array: ECOM_ARRAY [ECOM_DECIMAL] is
			-- ARRAY of ECOM_DECIMALs.
		require
			is_decimal: is_decimal (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_decimal (item)
		end

	dispatch_array: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE] is
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			is_dispatch: is_dispatch (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_dispatch (item)
		end

	unknown_array: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE] is
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			is_unknown: is_unknown (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unknown (item)
		end

	unsigned_character_array: ECOM_ARRAY[CHARACTER] is
			-- Array of unsigned character
		require
			is_unsigned_char: is_unsigned_char (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_char (item)
		end

	unsigned_short_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned short
		require
			is_unsigned_short: is_unsigned_short (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_short (item)
		end

	unsigned_integer4_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned long
		require
			is_unsigned_long: is_unsigned_long (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_long (item)
		end

	integer_array: ECOM_ARRAY[INTEGER] is
			-- Array of integers
		require
			is_int: is_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_int (item)
		end

	unsigned_integer_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned int
		require
			is_unsigned_int: is_unsigned_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_int (item)
		end

	integer4_array_byref: ECOM_ARRAY [INTEGER] is
			-- Reference integer ARRAY value
		require
			is_integer4: is_integer4 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_long_byref (item)
		end

	short_array_byref: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY value
		require
			is_integer2: is_integer2 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_short_byref (item)
		end

	real_array_byref: ECOM_ARRAY [REAL] is
			-- ARRAY of reals
		require
			is_real4: is_real4 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_float_byref (item)
		end

	double_array_reference: ECOM_ARRAY [DOUBLE] is
			-- ARRAY of doubles
		require
			is_real8: is_real8 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_double_byref (item)
		end

	char_array_reference: ECOM_ARRAY [CHARACTER] is
			-- ARRAY of characters
		require
			is_character: is_character (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_char_byref (item)
		end

	error_array_reference: ECOM_ARRAY [ECOM_HRESULT] is
			-- ARRAY of HRESULTs
		require
			is_error: is_error (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_hresult_byref (item)
		end

	currency_array_reference: ECOM_ARRAY [ECOM_CURRENCY] is
			-- ARRAY of CURRENCY
		require
			is_currency: is_currency (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_currency_byref (item)
		end

	date_array_reference: ECOM_ARRAY [DATE_TIME] is
			-- ARRAY of DATE
		require
			is_date: is_date (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_date_byref (item)
		end

	string_array_reference: ECOM_ARRAY [STRING] is
			-- ARRAY of STRING.
		require
			is_bstr: is_bstr (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_bstr_byref (item)
		end

	boolean_array_reference: ECOM_ARRAY [BOOLEAN] is
			-- ARRAY of BOOLEAN.
		require
			is_boolean: is_boolean (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_boolean_byref (item)
		end

	variant_array_reference: ECOM_ARRAY [ECOM_VARIANT] is
			-- ARRAY of ECOM_VARIANTs.
		require
			is_variant: is_variant (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_variant_byref (item)
		end

	decimal_array_reference: ECOM_ARRAY [ECOM_DECIMAL] is
			-- ARRAY of ECOM_DECIMALs.
		require
			is_decimal: is_decimal (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_decimal_byref (item)
		end

	dispatch_array_reference: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE] is
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			is_dispatch: is_dispatch (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_dispatch_byref (item)
		end

	unknown_array_reference: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE] is
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			is_unknown: is_unknown (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_unknown_byref (item)
		end

	unsigned_character_array_reference: ECOM_ARRAY[CHARACTER] is
			-- Array of unsigned character
		require
			is_unsigned_char: is_unsigned_char (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_char_byref (item)
		end

	unsigned_short_array_reference: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned short
		require
			is_unsigned_short: is_unsigned_short (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_short_byref (item)
		end

	unsigned_integer4_array_reference: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned long
		require
			is_unsigned_long: is_unsigned_long (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_long_byref (item)
		end

	integer_array_reference: ECOM_ARRAY[INTEGER] is
			-- Array of integers
		require
			is_int: is_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_int (item)
		end

	unsigned_integer_array_reference: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned int
		require
			is_unsigned_int: is_unsigned_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_variant_safearray_unsigned_int (item)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_variant
		end

feature -- Element change

	set_character (a_char: CHARACTER) is
			-- Set character value.
		do
			ccom_set_variant_char (item, a_char)
		end

	set_character_reference (a_char: CHARACTER_REF) is
			-- Set reference character value
		require
			non_void: a_char /= Void
		do
			ccom_set_variant_char_byref (item, a_char)
		end

	set_unsigned_character (a_value: CHARACTER) is
			-- Set unsigned character value
		do
			ccom_set_variant_unsigned_char (item, a_value)
		end

	set_unsigned_char_reference (a_value: CHARACTER_REF) is
			-- Set reference byte value
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_unsigned_char_byref (item, a_value)
		end

	set_integer2 (a_value: INTEGER) is
			-- Set short value
		do
			ccom_set_variant_integer2 (item, a_value)
		end

	set_integer2_reference (a_value: INTEGER_REF) is
			-- Set reference short value
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_integer2_byref (item, a_value)
		end

	set_unsigned_integer2 (a_value: INTEGER) is
			-- Set unsigned short value
		do
			ccom_set_variant_unsigned_integer2 (item, a_value)
		end

	set_unsigned_integer2_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned short value
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_unsigned_integer2_byref (item, a_value)
		end

	set_integer4 (a_value: INTEGER) is
			-- Set long value
		do
			ccom_set_variant_integer4 (item, a_value)
		end

	set_integer4_reference (a_value: INTEGER_REF) is
			-- Set reference long value
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_integer4_byref (item, a_value)
		end

	set_unsigned_integer4 (a_value: INTEGER) is
			-- Set unsigned long value
		do
			ccom_set_variant_unsigned_integer4 (item, a_value)
		end

	set_unsigned_integer4_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned long value
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_unsigned_integer4_byref (item, a_value)
		end

	set_integer (a_value: INTEGER) is
			-- Set integer value.
		do
			ccom_set_variant_integer (item, a_value)
		end

	set_integer_reference (a_value: INTEGER_REF) is
			-- Set reference integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_integer_byref (item, a_value)
		end

	set_unsigned_integer (a_value: INTEGER) is
			-- Set unsigned integer value.
		do
			ccom_set_variant_unsigned_integer (item, a_value)
		end

	set_unsigned_integer_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_unsigned_integer_byref (item, a_value)
		end

	set_real4 (a_value: REAL) is
			-- Set real value.
		do
			ccom_set_variant_real4 (item, a_value)
		end

	set_real4_reference (a_value: REAL_REF) is
			-- Set reference real value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_real4_byref (item, a_value)
		end
			

	set_real8 (a_value: DOUBLE) is
			-- Set double value.
		do
			ccom_set_variant_real8 (item, a_value)
		end

	set_real8_reference (a_value: DOUBLE_REF) is
			-- Set reference double value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_real8_byref (item, a_value)
		end

	set_boolean (a_value: BOOLEAN) is
			-- Set boolean value.
		do
			ccom_set_variant_bool (item, a_value)
		end

	set_boolean_reference (a_value: BOOLEAN_REF) is
			-- Set reference boolean value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_bool_byref (item, a_value)
		end

	set_date (a_value: DATE_TIME) is
			-- Set date value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_date (item, a_value)
		end

	set_date_reference (a_value: DATE_TIME) is
			-- Set date reference value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_date_byref (item, a_value)
		end

	set_error (a_value: ECOM_HRESULT) is
			-- Set error value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_error (item, a_value.item)
		end

	set_error_reference (a_value: ECOM_HRESULT) is
			-- Set error reference value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_error_byref (item, a_value.item)
		end

	set_decimal (a_value: ECOM_DECIMAL) is
			-- Set decimal value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_decimal (item, a_value.item)
		end

	set_decimal_reference (a_value: ECOM_DECIMAL) is
			-- Set decimal reference value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_decimal_byref (item, a_value.item)
		end

	set_currency (a_value: ECOM_CURRENCY) is
			-- Set currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_currency (item, a_value.item)
		end

	set_currency_reference (a_value: ECOM_CURRENCY) is
			-- Set reference currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_currency_byref (item, a_value.item)
		end

	set_string (a_value: STRING) is
			-- Set BSTR value.
		require
			non_void_string: a_value /= Void
		do
			ccom_set_variant_bstr (item, a_value)
		end

	set_string_reference (a_value: STRING) is
			-- Set reference BSTR value.
		require
			non_void_string: a_value /= Void
		do
			ccom_set_variant_bstr_byref (item, a_value)
		end

	set_variant (a_value: ECOM_VARIANT) is
			-- Set variant value.
		require
			non_void_variant: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_variant (item, a_value.item)
		end

	set_unknown_interface (a_value: ECOM_UNKNOWN_INTERFACE) is
			-- Set IUnknown interface value.
		require
			non_void: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_unknown (item, a_value.item)
		end

	set_unknown_interface_reference (a_value: ECOM_UNKNOWN_INTERFACE) is
			-- Set IUnknown interface reference value.
		require
			non_void: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant_unknown_byref (item, a_value.item)
		end

	set_dispatch_interface (a_value: ECOM_AUTOMATION_INTERFACE) is
			-- Set IDispatch interface value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_dispatch (item, a_value)
		end

	set_dispatch_interface_reference (a_value: ECOM_AUTOMATION_INTERFACE) is
			-- Set IDispatch interface reference value.
		require
			non_void: a_value /= Void
		do
			ccom_set_variant_dispatch_byref (item, a_value)
		end

	set_integer4_array (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_long (item, a_value)
		end

	set_short_array (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_short (item, a_value)
		end

	set_real_array (a_value: ECOM_ARRAY [REAL]) is
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_float (item, a_value)
		end

	set_double_array (a_value: ECOM_ARRAY [DOUBLE]) is
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_double (item, a_value)
		end

	set_char_array (a_value: ECOM_ARRAY [CHARACTER]) is
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_char (item, a_value)
		end

	set_error_array (a_value: ECOM_ARRAY [ECOM_HRESULT]) is
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_hresult (item, a_value)
		end

	set_currency_array (a_value: ECOM_ARRAY [ECOM_CURRENCY]) is
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_currency (item, a_value)
		end

	set_date_array (a_value: ECOM_ARRAY [DATE_TIME]) is
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_date (item, a_value)
		end

	set_string_array (a_value: ECOM_ARRAY [STRING]) is
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_bstr (item, a_value)
		end

	set_boolean_array (a_value: ECOM_ARRAY [BOOLEAN]) is
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_boolean (item, a_value)
		end

	set_variant_array (a_value: ECOM_ARRAY [ECOM_VARIANT]) is
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_variant (item, a_value)
		end

	set_decimal_array (a_value: ECOM_ARRAY [ECOM_DECIMAL]) is
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_decimal (item, a_value)
		end

	set_dispatch_array (a_value: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]) is
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_dispatch (item, a_value)
		end

	set_unknown_array (a_value: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]) is
			-- Set ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unknown (item, a_value)
		end

	set_unsigned_character_array (a_value: ECOM_ARRAY[CHARACTER]) is
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_char (item, a_value)
		end

	set_unsigned_short_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_short (item, a_value)
		end

	set_unsigned_integer4_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_long (item, a_value)
		end

	set_integer_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_int (item, a_value)
		end

	set_unsigned_integer_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_int (item, a_value)
		end

	set_integer4_array_reference (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_long_byref (item, a_value)
		end

	set_short_array_reference (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_short_byref (item, a_value)
		end

	set_real_array_reference (a_value: ECOM_ARRAY [REAL]) is
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_float_byref (item, a_value)
		end

	set_double_array_reference (a_value: ECOM_ARRAY [DOUBLE]) is
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_double_byref (item, a_value)
		end

	set_char_array_reference (a_value: ECOM_ARRAY [CHARACTER]) is
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_char_byref (item, a_value)
		end

	set_error_array_reference (a_value: ECOM_ARRAY [ECOM_HRESULT]) is
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_hresult_byref (item, a_value)
		end

	set_currency_array_reference (a_value: ECOM_ARRAY [ECOM_CURRENCY]) is
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_currency_byref (item, a_value)
		end

	set_date_array_reference (a_value: ECOM_ARRAY [DATE_TIME]) is
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_date_byref (item, a_value)
		end

	set_string_array_reference (a_value: ECOM_ARRAY [STRING]) is
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_bstr_byref (item, a_value)
		end

	set_boolean_array_reference (a_value: ECOM_ARRAY [BOOLEAN]) is
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_boolean_byref (item, a_value)
		end

	set_variant_array_reference (a_value: ECOM_ARRAY [ECOM_VARIANT]) is
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_variant_byref (item, a_value)
		end

	set_decimal_array_reference (a_value: ECOM_ARRAY [ECOM_DECIMAL]) is
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_decimal_byref (item, a_value)
		end

	set_dispatch_array_reference (a_value: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]) is
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_dispatch_byref (item, a_value)
		end

	set_unknown_array_reference (a_value: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]) is
			-- Set ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unknown_byref (item, a_value)
		end

	set_unsigned_character_array_reference (a_value: ECOM_ARRAY[CHARACTER]) is
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_char_byref (item, a_value)
		end

	set_unsigned_short_array_reference (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_short_byref (item, a_value)
		end

	set_unsigned_integer4_array_reference (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_long_byref (item, a_value)
		end

	set_integer_array_reference (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_int_byref (item, a_value)
		end

	set_unsigned_integer_array_reference (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_variant_safearray_unsigned_int_byref (item, a_value)
		end

feature {NONE} -- Implementation

	variant_true: INTEGER is -1
			-- True value of type VARAINT_BOOL
	
	variant_false: INTEGER is 0
			-- False value of type VARIANT_BOOL

feature {NONE} -- Element change

	set_variable_type (a_type: INTEGER) is
			-- Set variable type.
		do
			ccom_set_variant_variable_type (item, a_type)
		ensure
			type_set: variable_type = a_type
		end

feature {NONE} -- Externals

	c_size_of_variant: INTEGER is
		external 
			"C [macro %"E_variant.h%"]"
		alias
			"sizeof(VARIANT)"
		end

	ccom_variant_variable_type (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_variable_type (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, VARTYPE)"
		end

	ccom_variant_char (a_ptr: POINTER): CHARACTER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_CHARACTER"
		end

	ccom_set_variant_char (a_ptr: POINTER; a: CHARACTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_CHARACTER)"
		end

	ccom_variant_char_byref (a_ptr: POINTER): CHARACTER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_char_byref (a_ptr: POINTER; a: CHARACTER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_unsigned_char (a_ptr: POINTER): CHARACTER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_CHARACTER"
		end

	ccom_set_variant_unsigned_char (a_ptr: POINTER; a: CHARACTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_CHARACTER)"
		end

	ccom_variant_unsigned_char_byref (a_ptr: POINTER): CHARACTER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unsigned_char_byref (a_ptr: POINTER; a: CHARACTER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_integer2 (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_integer2 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_integer2_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_integer2_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_unsigned_integer2 (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_unsigned_integer2 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_unsigned_integer2_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unsigned_integer2_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_integer4 (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_integer4 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_integer4_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_integer4_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_unsigned_integer4 (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_unsigned_integer4 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_unsigned_integer4_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unsigned_integer4_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_integer (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_integer (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_integer_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_integer_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_unsigned_integer (a_ptr: POINTER): INTEGER is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_INTEGER"
		end

	ccom_set_variant_unsigned_integer (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_unsigned_integer_byref (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unsigned_integer_byref (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_real4 (a_ptr: POINTER): REAL is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REAL"
		end

	ccom_set_variant_real4 (a_ptr: POINTER; a: REAL) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REAL)"
		end

	ccom_variant_real4_byref (a_ptr: POINTER): REAL_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_real4_byref (a_ptr: POINTER; a: REAL_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_real8 (a_ptr: POINTER): DOUBLE is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_DOUBLE"
		end

	ccom_set_variant_real8 (a_ptr: POINTER; a: DOUBLE) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_DOUBLE)"
		end

	ccom_variant_real8_byref (a_ptr: POINTER): DOUBLE_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_real8_byref (a_ptr: POINTER; a: DOUBLE_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_bool (a_ptr: POINTER): BOOLEAN is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_BOOLEAN"
		end

	ccom_set_variant_bool (a_ptr: POINTER; a: BOOLEAN) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_BOOLEAN)"
		end

	ccom_variant_bool_byref (a_ptr: POINTER): BOOLEAN_REF is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_bool_byref (a_ptr: POINTER; a: BOOLEAN_REF) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_date (a_ptr: POINTER): DATE_TIME is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_date (a_ptr: POINTER; a: DATE_TIME) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_date_byref (a_ptr: POINTER): DATE_TIME is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_date_byref (a_ptr: POINTER; a: DATE_TIME) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_error (a_ptr: POINTER): ECOM_HRESULT is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_error (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_error_byref (a_ptr: POINTER): ECOM_HRESULT is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_error_byref (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_INTEGER)"
		end

	ccom_variant_decimal (a_ptr: POINTER): ECOM_DECIMAL is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_decimal (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, DECIMAL *)"
		end

	ccom_variant_decimal_byref (a_ptr: POINTER): ECOM_DECIMAL is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_decimal_byref (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, DECIMAL *)"
		end

	ccom_variant_currency (a_ptr: POINTER): ECOM_CURRENCY is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_currency (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, CY *)"
		end

	ccom_variant_currency_byref (a_ptr: POINTER): ECOM_CURRENCY is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_currency_byref (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, CY *)"
		end

	ccom_variant_bstr (a_ptr: POINTER): STRING is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_bstr (a_ptr: POINTER; a: STRING) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_bstr_byref (a_ptr: POINTER): STRING is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_bstr_byref (a_ptr: POINTER; a: STRING) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_variant (a_ptr: POINTER): ECOM_VARIANT is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_variant (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, VARIANT *)"
		end

	ccom_variant_unknown (a_ptr: POINTER):  ECOM_UNKNOWN_INTERFACE is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unknown (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, IUnknown *)"
		end

	ccom_variant_unknown_byref (a_ptr: POINTER):  ECOM_UNKNOWN_INTERFACE is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_unknown_byref (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, IUnknown *)"
		end

	ccom_variant_dispatch (a_ptr: POINTER):  ECOM_AUTOMATION_INTERFACE is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_dispatch (a_ptr: POINTER; a_value: ECOM_AUTOMATION_INTERFACE) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_dispatch_byref (a_ptr: POINTER):  ECOM_AUTOMATION_INTERFACE is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_dispatch_byref (a_ptr: POINTER; a_value: ECOM_AUTOMATION_INTERFACE) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_variant_safearray_unsigned_int (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_int (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_char (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_char (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_float (a_ptr: POINTER): ECOM_ARRAY[REAL] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_double (a_ptr: POINTER): ECOM_ARRAY[DOUBLE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_currency (a_ptr: POINTER): ECOM_ARRAY[ECOM_CURRENCY] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_date (a_ptr: POINTER): ECOM_ARRAY[DATE_TIME] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_bstr (a_ptr: POINTER): ECOM_ARRAY[STRING] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_dispatch (a_ptr: POINTER): ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_hresult (a_ptr: POINTER): ECOM_ARRAY[ECOM_HRESULT] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_boolean (a_ptr: POINTER): ECOM_ARRAY[BOOLEAN] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_variant (a_ptr: POINTER): ECOM_ARRAY[ECOM_VARIANT] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_decimal (a_ptr: POINTER): ECOM_ARRAY[ECOM_DECIMAL] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unknown (a_ptr: POINTER): ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_int_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_int_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_char_byref (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_char_byref (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_short_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_short_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_long_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unsigned_long_byref (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_float_byref (a_ptr: POINTER): ECOM_ARRAY[REAL] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_double_byref (a_ptr: POINTER): ECOM_ARRAY[DOUBLE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_currency_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_CURRENCY] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_date_byref (a_ptr: POINTER): ECOM_ARRAY[DATE_TIME] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_bstr_byref (a_ptr: POINTER): ECOM_ARRAY[STRING] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_dispatch_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_hresult_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_HRESULT] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_boolean_byref (a_ptr: POINTER): ECOM_ARRAY[BOOLEAN] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_variant_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_VARIANT] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_decimal_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_DECIMAL] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_variant_safearray_unknown_byref (a_ptr: POINTER): ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE] is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *): EIF_REFERENCE"
		end

	ccom_set_variant_safearray_unsigned_int (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_int (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_char (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_char (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_float (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_double (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_currency (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_date (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_bstr (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_dispatch (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_hresult (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_boolean (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_variant (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_decimal (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unknown (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_int_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_int_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_char_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_char_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_short_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_short_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_long_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unsigned_long_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_float_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_double_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_currency_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_date_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_bstr_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_dispatch_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_hresult_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_boolean_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_variant_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_decimal_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
		end

	ccom_set_variant_safearray_unknown_byref (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]) is
		external
			"C++ [macro %"E_variant.h%"](VARIANT *, EIF_REFERENCE)"
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

