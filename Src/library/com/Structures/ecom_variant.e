indexing
	description: "COM VARIANT structure"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_VARIANT

inherit
	ECOM_WRAPPER

	ECOM_VAR_TYPE

creation
	make,
	make_from_pointer

feature -- Initialization

	make is
			-- Create new variant.
		do
			initializer := ccom_new_variant
			item := ccom_variant_item (initializer)
		end

feature -- Access

	variable_type: INTEGER is
			-- Variable type
		do
			Result := ccom_variable_type (initializer)
		end

	character_value: CHARACTER is
			-- Character value
		require
			is_character: is_character (variable_type)
		do
			Result := ccom_character (initializer)
		end

	character_reference: CHARACTER_REF is
			-- Reference character value
		require
			is_character_ref: is_character (variable_type) and is_byref (variable_type)
		do
			Result := ccom_character_reference (initializer)
		end

	unsigned_character_value: CHARACTER is
			-- Byte value
		require
			is_byte: is_unsigned_char (variable_type)
		do
			Result := ccom_unsigned_character (initializer)
		end

	unsigned_character_reference: CHARACTER_REF is
			-- Reference byte value
		require
			is_byte_ref: is_unsigned_char (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_character_reference (initializer)
		end

	integer2: INTEGER is
			-- Short value
		require
			is_integer2: is_integer2 (variable_type)
		do
			Result := ccom_integer2 (initializer)
		end

	integer2_reference: INTEGER_REF is
			-- Reference short value
		require
			is_integer2_ref: is_integer2 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer2_reference (initializer)
		end

	unsigned_integer2: INTEGER is
			-- Unsigned short value
		require
			is_unsigned_short: is_unsigned_short (variable_type)
		do
			Result := ccom_unsigned_integer2 (initializer)
		end

	unsigned_integer2_reference: INTEGER_REF is
			-- Reference unsigned short value
		require
			is_unsigned_integer2_ref: is_unsigned_short (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer2_reference (initializer)
		end

	integer4: INTEGER is
			-- Long value
		require
			is_integer4: is_integer4 (variable_type)
		do
			Result := ccom_integer4 (initializer)
		end

	integer4_reference: INTEGER_REF is
			-- Reference long value
		require
			is_integer4_ref: is_integer4 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer4_reference (initializer)
		end

	unsigned_integer4: INTEGER is
			-- Unsigned long value
		require
			is_unsigned_long: is_unsigned_long (variable_type)
		do
			Result := ccom_unsigned_integer4 (initializer)
		end

	unsigned_integer4_reference: INTEGER_REF is
			-- Reference unsigned long value
		require
			is_unsigned_long_ref: is_unsigned_long (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer4_reference (initializer)
		end

	integer_value: INTEGER is
			-- Integer value
		require
			is_integer: is_int (variable_type)
		do
			Result := ccom_integer (initializer)
		end

	integer_reference: INTEGER_REF is
			-- Reference integer value
		require
			is_integer_ref: is_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer_reference (initializer)
		end

	unsigned_integer: INTEGER is
			-- Unsigned integer value
		require
			is_unsigned_integer: is_unsigned_int (variable_type)
		do
			Result := ccom_unsigned_integer (initializer)
		end

	unsigned_integer_reference: INTEGER_REF is
			-- Reference unsigned integer value
		require
			is_unsigned_int_ref: is_unsigned_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer_reference (initializer)
		end

	real4: REAL is
			-- Real value
		require
			is_real4: is_real4 (variable_type)
		do
			Result := ccom_real4 (initializer)
		end

	real4_reference: REAL_REF is
			-- Reference real value
		require
			is_real4_ref: is_real4 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_real4_reference (initializer)
		end
			

	real8: DOUBLE is
			-- Double value
		require
			is_real8: is_real8 (variable_type)
		do
			Result := ccom_real8 (initializer)
		end

	real8_reference: DOUBLE_REF is
			-- Reference double value
		require
			is_real8_ref: is_real8 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_real8_reference (initializer)
		end

	boolean_value: BOOLEAN is
			-- Boolean value
		require
			is_boolean: is_boolean (variable_type)
		do
			Result := ccom_bool (initializer)
		end

	boolean_reference: BOOLEAN_REF is
			-- Reference boolean value
		require
			is_boolean_ref: is_boolean (variable_type) and is_byref (variable_type)
		do
			Result := ccom_bool_reference (initializer)
		end

	date_value: DATE_TIME is
			-- Date value
		require
			is_date: is_date (variable_type)
		local
			tmp_double: DOUBLE
		do
			Result := ccom_date (initializer)
		end

	date_reference: CELL[DATE_TIME] is
			-- Date reference value
		require
			is_date_ref: is_date (variable_type) and is_byref (variable_type)
		do
			Result := ccom_date_reference (initializer)
		end

	error: ECOM_HRESULT is
			-- Error value
		require
			is_error: is_error (variable_type)
		do
			create Result.make
			Result.set_item (ccom_error (initializer))
		end

	error_reference: ECOM_HRESULT is
			-- Error reference value
		require
			is_error_ref: is_error (variable_type) and is_byref (variable_type)
		do
			create Result.make
			Result.set_item (ccom_error_reference (initializer))
		end

	decimal: ECOM_DECIMAL is
			-- Decimal value
		require
		--	is_decimal: is_decimal (variable_type)
		do
			Result := ccom_decimal (initializer)
		end

	decimal_reference: ECOM_DECIMAL is
			-- Decimal reference value
		require
			is_decimal_ref: is_decimal (variable_type) and is_byref (variable_type)
		do
			create Result.make_by_pointer (ccom_decimal_reference (initializer))
		end

	currency: ECOM_CURRENCY is
			-- Currency value
		require
			is_currency: is_currency (variable_type)
		do
			Result := ccom_currency (initializer)
		end

	currency_reference: ECOM_CURRENCY is
			-- Reference currency value
		require
			is_currency_ref: is_currency (variable_type) and is_byref (variable_type)
		do
			create Result.make_by_pointer (ccom_currency_reference (initializer))
		end

	string_value: STRING is
			-- BSTR value
		require
			is_bstr: is_bstr (variable_type)
		do
			Result := ccom_bstr (initializer)
		end

	string_reference: CELL[STRING] is
			-- Reference BSTR value
		require
			is_bstr_ref: is_bstr (variable_type) and is_byref (variable_type)
		do
			Result := ccom_bstr_reference (initializer)
		end

	variant_value: ECOM_VARIANT is
			-- Variant value
		require
			is_variant: is_variant (variable_type)
		do
			create Result.make_from_pointer (ccom_variant (initializer))
		end

	unknown_interface: ECOM_UNKNOWN_INTERFACE is
			-- IUnknown interface value
		require
			is_unknown_ref: is_unknown (variable_type)
		do
			create Result.make_from_pointer( ccom_unknown_interface (initializer))
		end

	unknown_interface_reference: CELL[ECOM_UNKNOWN_INTERFACE] is
			-- IUnknown interface reference value
		require
			is_unknown_ref: is_unknown (variable_type) and is_byref (variable_type)
		local
			unk_interface: ECOM_UNKNOWN_INTERFACE
		do
			create unk_interface.make_from_pointer (ccom_unknown_interface_reference (initializer))
			create Result.put (unk_interface)
		end

	dispatch_interface: ECOM_AUTOMATION_INTERFACE is
			-- IDispatch interface value
		require
			is_dispatch_ref: is_dispatch (variable_type)
		do
			create Result.make_from_pointer (ccom_dispatch_interface (initializer))
		end

	dispatch_interface_reference: CELL[ECOM_AUTOMATION_INTERFACE] is
			-- IDispatch interface reference value
		require
			is_dispatch_ref: is_dispatch (variable_type) and is_byref (variable_type)
		local
			disp_interface: ECOM_AUTOMATION_INTERFACE
		do
			create disp_interface.make_from_pointer (ccom_dispatch_interface_reference (initializer))
			create Result.put (disp_interface)
		end

	integer4_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY value
		require
			is_integer4: is_integer4 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_long (initializer)
		end

	short_array: ECOM_ARRAY [INTEGER] is
			-- Integer ARRAY value
		require
			is_integer2: is_integer2 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_short (initializer)
		end

	real_array: ECOM_ARRAY [REAL] is
			-- ARRAY of reals
		require
			is_real4: is_real4 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_float (initializer)
		end

	double_array: ECOM_ARRAY [DOUBLE] is
			-- ARRAY of doubles
		require
			is_real8: is_real8 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_double (initializer)
		end

	char_array: ECOM_ARRAY [CHARACTER] is
			-- ARRAY of characters
		require
			is_character: is_character (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_character (initializer)
		end

	error_array: ECOM_ARRAY [ECOM_HRESULT] is
			-- ARRAY of HRESULTs
		require
			is_error: is_error (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_hresult (initializer)
		end

	currency_array: ECOM_ARRAY [ECOM_CURRENCY] is
			-- ARRAY of CURRENCY
		require
			is_currency: is_currency (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_currency (initializer)
		end

	date_array: ECOM_ARRAY [DATE_TIME] is
			-- ARRAY of DATE
		require
			is_date: is_date (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_date (initializer)
		end

	string_array: ECOM_ARRAY [STRING] is
			-- ARRAY of STRING.
		require
			is_bstr: is_bstr (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_bstr (initializer)
		end

	boolean_array: ECOM_ARRAY [BOOLEAN] is
			-- ARRAY of BOOLEAN.
		require
			is_boolean: is_boolean (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_boolean (initializer)
		end

	variant_array: ECOM_ARRAY [ECOM_VARIANT] is
			-- ARRAY of ECOM_VARIANTs.
		require
			is_variant: is_variant (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_variant (initializer)
		end

	decimal_array: ECOM_ARRAY [ECOM_DECIMAL] is
			-- ARRAY of ECOM_DECIMALs.
		require
			is_decimal: is_decimal (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_decimal (initializer)
		end

	dispatch_interface_array: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE] is
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			is_dispatch: is_dispatch (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_dispatch_interface (initializer)
		end

	unknown_interface_array: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE] is
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			is_unknown: is_unknown (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unknown_interface (initializer)
		end

	unsigned_character_array: ECOM_ARRAY[CHARACTER] is
			-- Array of unsigned character
		require
			is_unsigned_char: is_unsigned_char (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_character (initializer)
		end

	unsigned_short_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned short
		require
			is_unsigned_short: is_unsigned_short (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_short (initializer)
		end

	unsigned_integer4_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned long
		require
			is_unsigned_long: is_unsigned_long (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_long (initializer)
		end

	integer_array: ECOM_ARRAY[INTEGER] is
			-- Array of integers
		require
			is_int: is_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_integer (initializer)
		end

	unsigned_integer_array: ECOM_ARRAY[INTEGER] is
			-- Array of unsigned int
		require
			is_unsigned_int: is_unsigned_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_integer (initializer)
		end

	integer4_array_reference: CELL[ECOM_ARRAY [INTEGER]] is
			-- Reference integer ARRAY value
		require
			is_integer4: is_integer4 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_long_reference (initializer)
		end

	short_array_reference: CELL[ECOM_ARRAY [INTEGER]] is
			-- Integer ARRAY value
		require
			is_integer2: is_integer2 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_short_reference (initializer)
		end

	real_array_reference: CELL[ECOM_ARRAY [REAL]] is
			-- ARRAY of reals
		require
			is_real4: is_real4 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_float_reference (initializer)
		end

	double_array_reference: CELL[ECOM_ARRAY [DOUBLE]] is
			-- ARRAY of doubles
		require
			is_real8: is_real8 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_double_reference (initializer)
		end

	char_array_reference: CELL[ECOM_ARRAY[CHARACTER]] is
			-- ARRAY of characters
		require
			is_character: is_character (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_character_reference (initializer)
		end

	error_array_reference: CELL[ECOM_ARRAY [ECOM_HRESULT]] is
			-- ARRAY of HRESULTs
		require
			is_error: is_error (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_hresult_reference (initializer)
		end

	currency_array_reference: CELL[ECOM_ARRAY [ECOM_CURRENCY]] is
			-- ARRAY of CURRENCY
		require
			is_currency: is_currency (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_currency_reference (initializer)
		end

	date_array_reference: CELL[ECOM_ARRAY [DATE_TIME]] is
			-- ARRAY of DATE
		require
			is_date: is_date (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_date_reference (initializer)
		end

	string_array_reference: CELL[ECOM_ARRAY [STRING]] is
			-- ARRAY of STRING.
		require
			is_bstr: is_bstr (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_bstr_reference (initializer)
		end

	boolean_array_reference: CELL[ECOM_ARRAY[BOOLEAN]] is
			-- ARRAY of BOOLEAN.
		require
			is_boolean: is_boolean (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_boolean_reference (initializer)
		end

	variant_array_reference: CELL[ECOM_ARRAY[ECOM_VARIANT]] is
			-- ARRAY of ECOM_VARIANTs.
		require
			is_variant: is_variant (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_variant_reference (initializer)
		end

	decimal_array_reference: CELL[ECOM_ARRAY[ECOM_DECIMAL]] is
			-- ARRAY of ECOM_DECIMALs.
		require
			is_decimal: is_decimal (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_decimal_reference (initializer)
		end

	dispatch_interface_array_reference: CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]] is
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			is_dispatch: is_dispatch (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_dispatch_interface_reference (initializer)
		end

	unknown_interface_array_reference: CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]] is
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			is_unknown: is_unknown (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unknown_interface_reference (initializer)
		end

	unsigned_character_array_reference: CELL[ECOM_ARRAY[CHARACTER]] is
			-- Array of unsigned character
		require
			is_unsigned_char: is_unsigned_char (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_character_reference (initializer)
		end

	unsigned_short_array_reference: CELL[ECOM_ARRAY[INTEGER]] is
			-- Array of unsigned short
		require
			is_unsigned_short: is_unsigned_short (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_short_reference (initializer)
		end

	unsigned_integer4_array_reference: CELL[ECOM_ARRAY[INTEGER]] is
			-- Array of unsigned long
		require
			is_unsigned_long: is_unsigned_long (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_long_reference (initializer)
		end

	integer_array_reference: CELL[ECOM_ARRAY[INTEGER]] is
			-- Array of integers
		require
			is_int: is_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_integer_reference (initializer)
		end

	unsigned_integer_array_reference: CELL[ECOM_ARRAY[INTEGER]] is
			-- Array of unsigned int
		require
			is_unsigned_int: is_unsigned_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_integer_reference (initializer)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size of VARIANT structure
		do
			Result := c_size_of_variant
		end

feature -- Element change

	set_empty is
			-- Set empty VARIANT.
		do
			ccom_set_variable_type (initializer, Vt_empty)
		end

	set_character (a_char: CHARACTER) is
			-- Set character value.
		do
			ccom_set_character (initializer, a_char)
		end

	set_character_reference (a_char: CHARACTER_REF) is
			-- Set reference character value
		require
			non_void: a_char /= Void
		do
			ccom_set_character_reference (initializer, a_char)
		end

	set_unsigned_character (a_value: CHARACTER) is
			-- Set unsigned character value
		do
			ccom_set_unsigned_character (initializer, a_value)
		end

	set_unsigned_character_reference (a_value: CHARACTER_REF) is
			-- Set reference byte value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_character_reference (initializer, a_value)
		end

	set_integer2 (a_value: INTEGER) is
			-- Set short value
		do
			ccom_set_integer2 (initializer, a_value)
		end

	set_integer2_reference (a_value: INTEGER_REF) is
			-- Set reference short value
		require
			non_void: a_value /= Void
		do
			ccom_set_integer2_reference (initializer, a_value)
		end

	set_unsigned_integer2 (a_value: INTEGER) is
			-- Set unsigned short value
		do
			ccom_set_unsigned_integer2 (initializer, a_value)
		end

	set_unsigned_integer2_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned short value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer2_reference (initializer, a_value)
		end

	set_integer4 (a_value: INTEGER) is
			-- Set long value
		do
			ccom_set_integer4 (initializer, a_value)
		end

	set_integer4_reference (a_value: INTEGER_REF) is
			-- Set reference long value
		require
			non_void: a_value /= Void
		do
			ccom_set_integer4_reference (initializer, a_value)
		end

	set_unsigned_integer4 (a_value: INTEGER) is
			-- Set unsigned long value
		do
			ccom_set_unsigned_integer4 (initializer, a_value)
		end

	set_unsigned_integer4_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned long value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer4_reference (initializer, a_value)
		end

	set_integer (a_value: INTEGER) is
			-- Set integer value.
		do
			ccom_set_integer (initializer, a_value)
		end

	set_integer_reference (a_value: INTEGER_REF) is
			-- Set reference integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_integer_reference (initializer, a_value)
		end

	set_unsigned_integer (a_value: INTEGER) is
			-- Set unsigned integer value.
		do
			ccom_set_unsigned_integer (initializer, a_value)
		end

	set_unsigned_integer_reference (a_value: INTEGER_REF) is
			-- Set reference unsigned integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer_reference (initializer, a_value)
		end

	set_real4 (a_value: REAL) is
			-- Set real value.
		do
			ccom_set_real4 (initializer, a_value)
		end

	set_real4_reference (a_value: REAL_REF) is
			-- Set reference real value.
		require
			non_void: a_value /= Void
		do
			ccom_set_real4_reference (initializer, a_value)
		end
			

	set_real8 (a_value: DOUBLE) is
			-- Set double value.
		do
			ccom_set_real8 (initializer, a_value)
		end

	set_real8_reference (a_value: DOUBLE_REF) is
			-- Set reference double value.
		require
			non_void: a_value /= Void
		do
			ccom_set_real8_reference (initializer, a_value)
		end

	set_boolean (a_value: BOOLEAN) is
			-- Set boolean value.
		do
			ccom_set_bool (initializer, a_value)
		end

	set_boolean_reference (a_value: BOOLEAN_REF) is
			-- Set reference boolean value.
		require
			non_void: a_value /= Void
		do
			ccom_set_bool_reference (initializer, a_value)
		end

	set_date (a_value: DATE_TIME) is
			-- Set date value.
		require
			non_void: a_value /= Void
		do
			ccom_set_date (initializer, a_value)
		end

	set_date_reference (a_value: CELL[DATE_TIME]) is
			-- Set date reference value.
		require
			non_void: a_value /= Void
			valid_value: a_value.item /= Void
		do
			ccom_set_date_reference (initializer, a_value)
		end

	set_error (a_value: ECOM_HRESULT) is
			-- Set error value.
		require
			non_void: a_value /= Void
		do
			ccom_set_error (initializer, a_value.item)
		end

	set_error_reference (a_value: ECOM_HRESULT) is
			-- Set error reference value.
		require
			non_void: a_value /= Void
		do
			ccom_set_error_reference (initializer, a_value.item)
		end

	set_decimal (a_value: ECOM_DECIMAL) is
			-- Set decimal value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_decimal (initializer, a_value.item)
		end

	set_decimal_reference (a_value: ECOM_DECIMAL) is
			-- Set decimal reference value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_decimal_reference (initializer, a_value.item)
		end

	set_currency (a_value: ECOM_CURRENCY) is
			-- Set currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_currency (initializer, a_value.item)
		end

	set_currency_reference (a_value: ECOM_CURRENCY) is
			-- Set reference currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_currency_reference (initializer, a_value.item)
		end

	set_string (a_value: STRING) is
			-- Set BSTR value.
		require
			non_void_string: a_value /= Void
		do
			ccom_set_bstr (initializer, a_value)
		end

	set_string_reference (a_value: CELL[STRING]) is
			-- Set reference BSTR value.
		require
			non_void_string: a_value /= Void
			valid_value: a_value.item /= Void
		do
			ccom_set_bstr_reference (initializer, a_value.item)
		end

	set_variant (a_value: ECOM_VARIANT) is
			-- Set variant value.
		require
			non_void_variant: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant (initializer, a_value.item)
		end

	set_unknown_interface (a_value: ECOM_UNKNOWN_INTERFACE) is
			-- Set IUnknown interface value.
		require
			non_void: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_unknown_interface (initializer, a_value.item)
		end

	set_unknown_interface_reference (a_value: CELL[ECOM_UNKNOWN_INTERFACE]) is
			-- Set IUnknown interface reference value.
		require
			non_void: a_value /= Void
			valid_interface: a_value.item /= Void
			valid: a_value.item.item /= default_pointer
		do
			ccom_set_unknown_interface_reference (initializer, a_value.item.item)
		end

	set_dispatch_interface (a_value: ECOM_AUTOMATION_INTERFACE) is
			-- Set IDispatch interface value.
		require
			non_void: a_value /= Void
			valid_interface: a_value.item /= default_pointer
		do
			ccom_set_dispatch_interface (initializer, a_value.item)
		end

	set_dispatch_interface_reference (a_value: CELL[ECOM_AUTOMATION_INTERFACE]) is
			-- Set IDispatch interface reference value.
		require
			non_void: a_value /= Void
			valid_interface: a_value.item /= Void and a_value.item.item /= default_pointer
		do
			ccom_set_dispatch_interface_reference (initializer, a_value.item.item)
		end

	set_integer4_array (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_long (initializer, a_value)
		end

	set_short_array (a_value: ECOM_ARRAY [INTEGER]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_short (initializer, a_value)
		end

	set_real_array (a_value: ECOM_ARRAY [REAL]) is
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_float (initializer, a_value)
		end

	set_double_array (a_value: ECOM_ARRAY [DOUBLE]) is
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_double (initializer, a_value)
		end

	set_char_array (a_value: ECOM_ARRAY [CHARACTER]) is
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_character (initializer, a_value)
		end

	set_error_array (a_value: ECOM_ARRAY [ECOM_HRESULT]) is
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_hresult (initializer, a_value)
		end

	set_currency_array (a_value: ECOM_ARRAY [ECOM_CURRENCY]) is
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_currency (initializer, a_value)
		end

	set_date_array (a_value: ECOM_ARRAY [DATE_TIME]) is
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_date (initializer, a_value)
		end

	set_string_array (a_value: ECOM_ARRAY [STRING]) is
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_bstr (initializer, a_value)
		end

	set_boolean_array (a_value: ECOM_ARRAY [BOOLEAN]) is
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_boolean (initializer, a_value)
		end

	set_array (a_value: ECOM_ARRAY [ECOM_VARIANT]) is
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_variant (initializer, a_value)
		end

	set_decimal_array (a_value: ECOM_ARRAY [ECOM_DECIMAL]) is
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_decimal (initializer, a_value)
		end

	set_dispatch_array (a_value: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]) is
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_dispatch_interface (initializer, a_value)
		end

	set_unknown_array (a_value: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]) is
			-- Set ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unknown_interface (initializer, a_value)
		end

	set_unsigned_character_array (a_value: ECOM_ARRAY[CHARACTER]) is
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_character (initializer, a_value)
		end

	set_unsigned_short_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_short (initializer, a_value)
		end

	set_unsigned_integer4_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_long (initializer, a_value)
		end

	set_integer_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_integer (initializer, a_value)
		end

	set_unsigned_integer_array (a_value: ECOM_ARRAY[INTEGER]) is
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_integer (initializer, a_value)
		end

	set_integer4_array_reference (a_value: CELL[ECOM_ARRAY [INTEGER]]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_long_reference (initializer, a_value.item)
		end

	set_short_array_reference (a_value: CELL[ECOM_ARRAY [INTEGER]]) is
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_short_reference (initializer, a_value.item)
		end

	set_real_array_reference (a_value: CELL[ECOM_ARRAY [REAL]]) is
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_float_reference (initializer, a_value.item)
		end

	set_double_array_reference (a_value: CELL[ECOM_ARRAY[DOUBLE]]) is
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_double_reference (initializer, a_value.item)
		end

	set_char_array_reference (a_value: CELL[ECOM_ARRAY[CHARACTER]]) is
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_character_reference (initializer, a_value.item)
		end

	set_error_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_HRESULT]]) is
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_hresult_reference (initializer, a_value.item)
		end

	set_currency_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_CURRENCY]]) is
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_currency_reference (initializer, a_value.item)
		end

	set_date_array_reference (a_value: CELL[ECOM_ARRAY[DATE_TIME]]) is
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_date_reference (initializer, a_value.item)
		end

	set_string_array_reference (a_value: CELL[ECOM_ARRAY[STRING]]) is
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_bstr_reference (initializer, a_value.item)
		end

	set_boolean_array_reference (a_value: CELL[ECOM_ARRAY[BOOLEAN]]) is
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_boolean_reference (initializer, a_value.item)
		end

	set_variant_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_VARIANT]]) is
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_variant_reference (initializer, a_value.item)
		end

	set_decimal_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_DECIMAL]]) is
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_decimal_reference (initializer, a_value.item)
		end

	set_dispatch_interface_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]]) is
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_dispatch_interface_reference (initializer, a_value.item)
		end

	set_unknown_interface_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]]) is
			-- Set ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unknown_interface_reference (initializer, a_value.item)
		end

	set_unsigned_character_array_reference (a_value: CELL[ECOM_ARRAY[CHARACTER]]) is
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_character_reference (initializer, a_value.item)
		end

	set_unsigned_short_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]]) is
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_short_reference (initializer, a_value.item)
		end

	set_unsigned_integer4_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]]) is
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_long_reference (initializer, a_value.item)
		end

	set_integer_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]]) is
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_integer_reference (initializer, a_value.item)
		end

	set_unsigned_integer_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]]) is
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_integer_reference (initializer, a_value.item)
		end

feature {NONE} -- Implementation

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C++ wrapper
		do
			Result := create_ecom_variant (a_pointer)
		end

	delete_wrapper is
			-- Delete C++ wrapper
		do
			ccom_delete_variant (initializer)
		end

	variant_true: INTEGER is -1
			-- True value of type VARAINT_BOOL
	
	variant_false: INTEGER is 0
			-- False value of type BOOL

feature {NONE} -- Element change

	set_variable_type (a_type: INTEGER) is
			-- Set variable type.
		do
			ccom_set_variable_type (initializer, a_type)
		ensure
			type_set: variable_type = a_type
		end

feature {NONE} -- Externals

	c_size_of_variant: INTEGER is
		external 
			"C++ [macro %"E_variant.h%"]"
		alias
			"sizeof(VARIANT)"
		end

	ccom_variant_item (a_pointer: POINTER): POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_delete_variant (a_pointer: POINTER) is
		external
			"C++ [delete ecom_variant %"E_variant.h%"]()"
		end

	create_ecom_variant (a_ptr: POINTER): POINTER is
		external
			"C++ [new ecom_variant %"E_variant.h%"](VARIANT *)"
		end

	ccom_new_variant: POINTER is
		external
			"C++ [new ecom_variant %"E_variant.h%"]"
		end

	ccom_variable_type (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_variable_type (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](VARTYPE)"
		end

	ccom_character (a_ptr: POINTER): CHARACTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_CHARACTER"
		end

	ccom_set_character (a_ptr: POINTER; a: CHARACTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_CHARACTER)"
		end

	ccom_character_reference (a_ptr: POINTER): CHARACTER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_character_reference (a_ptr: POINTER; a: CHARACTER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_unsigned_character (a_ptr: POINTER): CHARACTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_CHARACTER"
		end

	ccom_set_unsigned_character (a_ptr: POINTER; a: CHARACTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_CHARACTER)"
		end

	ccom_unsigned_character_reference (a_ptr: POINTER): CHARACTER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_unsigned_character_reference (a_ptr: POINTER; a: CHARACTER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_integer2 (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_integer2 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_integer2_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_integer2_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_unsigned_integer2 (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_unsigned_integer2 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_unsigned_integer2_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_unsigned_integer2_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_integer4 (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_integer4 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_integer4_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_integer4_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_unsigned_integer4 (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_unsigned_integer4 (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_unsigned_integer4_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_unsigned_integer4_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_integer (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_integer (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_integer_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_integer_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_unsigned_integer (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_unsigned_integer (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_INTEGER)"
		end

	ccom_unsigned_integer_reference (a_ptr: POINTER): INTEGER_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_unsigned_integer_reference (a_ptr: POINTER; a: INTEGER_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_real4 (a_ptr: POINTER): REAL is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REAL"
		end

	ccom_set_real4 (a_ptr: POINTER; a: REAL) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_REAL)"
		end

	ccom_real4_reference (a_ptr: POINTER): REAL_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_real4_reference (a_ptr: POINTER; a: REAL_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_real8 (a_ptr: POINTER): DOUBLE is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_DOUBLE"
		end

	ccom_set_real8 (a_ptr: POINTER; a: DOUBLE) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_DOUBLE)"
		end

	ccom_real8_reference (a_ptr: POINTER): DOUBLE_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_real8_reference (a_ptr: POINTER; a: DOUBLE_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_bool (a_ptr: POINTER): BOOLEAN is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_BOOLEAN"
		end

	ccom_set_bool (a_ptr: POINTER; a: BOOLEAN) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_BOOLEAN)"
		end

	ccom_bool_reference (a_ptr: POINTER): BOOLEAN_REF is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_bool_reference (a_ptr: POINTER; a: BOOLEAN_REF) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_date (a_ptr: POINTER): DATE_TIME is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_date (a_ptr: POINTER; a: DATE_TIME) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_date_reference (a_ptr: POINTER): CELL[DATE_TIME] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_date_reference (a_ptr: POINTER; a: CELL[DATE_TIME]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_error (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_error (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](SCODE)"
		end

	ccom_error_reference (a_ptr: POINTER): INTEGER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_INTEGER"
		end

	ccom_set_error_reference (a_ptr: POINTER; a: INTEGER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](SCODE)"
		end

	ccom_decimal (a_ptr: POINTER): ECOM_DECIMAL is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_decimal (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](DECIMAL *)"
		end

	ccom_decimal_reference (a_ptr: POINTER): POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_decimal_reference (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](DECIMAL *)"
		end

	ccom_currency (a_ptr: POINTER): ECOM_CURRENCY is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_currency (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](CY *)"
		end

	ccom_currency_reference (a_ptr: POINTER): POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_currency_reference (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](CY *)"
		end

	ccom_bstr (a_ptr: POINTER): STRING is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_bstr (a_ptr: POINTER; a: STRING) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_bstr_reference (a_ptr: POINTER): CELL[STRING] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_bstr_reference (a_ptr: POINTER; a: STRING) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_variant (a_ptr: POINTER): POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_variant (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](VARIANT *)"
		end

	ccom_unknown_interface (a_ptr: POINTER):  POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_unknown_interface (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](IUnknown *)"
		end

	ccom_unknown_interface_reference (a_ptr: POINTER):  POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_unknown_interface_reference (a_ptr: POINTER; a: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](IUnknown *)"
		end

	ccom_dispatch_interface (a_ptr: POINTER):  POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_dispatch_interface (a_ptr: POINTER; a_value: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](IDispatch *)"
		end

	ccom_dispatch_interface_reference (a_ptr: POINTER):  POINTER is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_POINTER"
		end

	ccom_set_dispatch_interface_reference (a_ptr: POINTER; a_value: POINTER) is
		external
			"C++ [ecom_variant %"E_variant.h%"](IDispatch *)"
		end

	ccom_safearray_unsigned_integer (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_integer (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_character (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_character (a_ptr: POINTER): ECOM_ARRAY[CHARACTER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_float (a_ptr: POINTER): ECOM_ARRAY[REAL] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_double (a_ptr: POINTER): ECOM_ARRAY[DOUBLE] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_currency (a_ptr: POINTER): ECOM_ARRAY[ECOM_CURRENCY] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_date (a_ptr: POINTER): ECOM_ARRAY[DATE_TIME] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_bstr (a_ptr: POINTER): ECOM_ARRAY[STRING] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_dispatch_interface (a_ptr: POINTER): ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_hresult (a_ptr: POINTER): ECOM_ARRAY[ECOM_HRESULT] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_boolean (a_ptr: POINTER): ECOM_ARRAY[BOOLEAN] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_variant (a_ptr: POINTER): ECOM_ARRAY[ECOM_VARIANT] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_decimal (a_ptr: POINTER): ECOM_ARRAY[ECOM_DECIMAL] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unknown_interface (a_ptr: POINTER): ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_integer_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_integer_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_character_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[CHARACTER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_character_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[CHARACTER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_short_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_short_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_long_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unsigned_long_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_float_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[REAL]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_double_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[DOUBLE]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_currency_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_CURRENCY]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_date_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[DATE_TIME]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_bstr_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[STRING]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_dispatch_interface_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_hresult_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_HRESULT]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_boolean_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[BOOLEAN]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_variant_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_VARIANT]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_decimal_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_DECIMAL]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_safearray_unknown_interface_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]] is
		external
			"C++ [ecom_variant %"E_variant.h%"](): EIF_REFERENCE"
		end

	ccom_set_safearray_unsigned_integer (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_integer (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_character (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_character (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_float (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_double (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_currency (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_date (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_bstr (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_dispatch_interface (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_hresult (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_boolean (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_variant (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_decimal (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unknown_interface (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_integer_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_integer_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_character_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_character_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_short_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_short_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_long_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unsigned_long_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_float_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_double_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_currency_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_date_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_bstr_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_dispatch_interface_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_hresult_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_boolean_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_variant_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_decimal_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
		end

	ccom_set_safearray_unknown_interface_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]) is
		external
			"C++ [ecom_variant %"E_variant.h%"](EIF_OBJECT)"
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

