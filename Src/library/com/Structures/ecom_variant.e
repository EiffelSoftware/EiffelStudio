note
	description: "COM VARIANT structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_VARIANT

inherit
	ECOM_STRUCTURE
		redefine
			make,
			out,
			destroy_item
		end

	ECOM_VAR_TYPE
		undefine
			copy, is_equal
		redefine
			out
		end

create
	make,
	make_from_pointer,
	make_from_character,
	make_from_integer,
	make_from_real,
	make_from_double,
	make_from_boolean,
	make_from_date,
	make_from_error,
	make_from_decimal,
	make_from_currency,
	make_from_string,
	make_from_variant,
	make_from_iunknown,
	make_from_integer_array,
	make_from_real_array,
	make_from_double_array,
	make_from_char_array,
	make_from_error_array,
	make_from_currency_array,
	make_from_date_array,
	make_from_string_array,
	make_from_boolean_array,
	make_from_decimal_array

convert
	make_from_pointer ({POINTER}),
	make_from_character ({CHARACTER}),
	make_from_integer ({INTEGER}),
	make_from_real ({REAL}),
	make_from_double ({DOUBLE}),
	make_from_boolean ({BOOLEAN}),
	make_from_date ({DATE_TIME}),
	make_from_error ({ECOM_HRESULT}),
	make_from_decimal ({ECOM_DECIMAL}),
	make_from_currency ({ECOM_CURRENCY}),
	make_from_string ({STRING}),
	make_from_iunknown ({ECOM_INTERFACE}),
	make_from_integer_array ({ECOM_ARRAY [INTEGER]}),
	make_from_real_array ({ECOM_ARRAY [REAL]}),
	make_from_double_array ({ECOM_ARRAY [DOUBLE]}),
	make_from_boolean_array ({ECOM_ARRAY [BOOLEAN]}),
	make_from_char_array ({ECOM_ARRAY [CHARACTER]}),
	make_from_error_array ({ECOM_ARRAY [ECOM_HRESULT]}),
	make_from_currency_array ({ECOM_ARRAY [ECOM_CURRENCY]}),
	make_from_date_array ({ECOM_ARRAY [DATE_TIME]}),
	make_from_string_array ({ECOM_ARRAY [STRING]}),
	make_from_decimal_array ({ECOM_ARRAY [ECOM_DECIMAL]})

feature {NONE} -- Initialization

	make
			-- Create new variant.
		do
			item := create_ecom_variant
			shared := False
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

	make_from_character (a_value: CHARACTER)
			-- Initialize instance with character `a_value'.
		do
			make
			set_character (a_value)
		ensure
			character: character_value = a_value
		end

	make_from_integer (a_value: INTEGER)
			-- Initialize instance with integer `a_value'.
		do
			make
			set_integer (a_value)
		ensure
			integer: integer_value = a_value
		end

	make_from_real (a_value: REAL)
			-- Initialize instance with real `a_value'.
		do
			make
			set_real (a_value)
		ensure
			real: real_value = a_value
		end

	make_from_double (a_value: DOUBLE)
			-- Make from double `a_value'.
		do
			make
			set_double (a_value)
		ensure
			double: double_value = a_value
		end

	make_from_boolean (a_value: BOOLEAN)
			-- Initialize instance with boolean `a_value'.
		do
			make
			set_boolean (a_value)
		ensure
			boolean: boolean_value = a_value
		end

	make_from_date (a_value: DATE_TIME)
			-- Initialize instance with date `a_value'.
		do
			make
			set_date (a_value)
		ensure
			date: date_value.is_equal (a_value)
		end

	make_from_error (a_value: ECOM_HRESULT)
			-- Initialize instance with scode `a_value'.
		do
			make
			set_error (a_value)
		ensure
			error: error.is_equal (a_value)
		end

	make_from_decimal (a_value: ECOM_DECIMAL)
			-- Initialize instance with decimal `a_value'.
		do
			make
			set_decimal (a_value)
		ensure
			decimal: decimal.is_equal (a_value)
		end

	make_from_currency (a_value: ECOM_CURRENCY)
			-- Initialize instance with currency `a_value'.
		do
			make
			set_currency (a_value)
		ensure
			currency: currency.is_equal (a_value)
		end

	make_from_string (a_value: STRING)
			-- Initialize instance with string `a_value'.
		do
			make
			set_string (a_value)
		ensure
			string: string_value.is_equal (a_value)
		end

	make_from_variant (a_value: ECOM_VARIANT)
			-- Initialize instance with variant `a_value'.
		do
			make
			set_variant (a_value)
		ensure
			variant_value: variant_value.is_equal (a_value)
		end

	make_from_iunknown (a_value: ECOM_INTERFACE)
			-- Initialize instance with IUnknown interface `a_value'.
		do
			make
			set_iunknown (a_value)
		ensure
			iunknown: iunknown.item = a_value.item
		end

	make_from_integer_array (a_value: ECOM_ARRAY [INTEGER])
			-- Initialize instance with integer array `a_value'.
		do
			make
			set_integer_array (a_value)
		ensure
			integer_array: integer_array.is_equal (a_value)
		end

	make_from_real_array (a_value: ECOM_ARRAY [REAL])
			-- Initialize instance with real array `a_value'.
		do
			make
			set_real_array (a_value)
		ensure
			real_array: real_array.is_equal (a_value)
		end

	make_from_double_array (a_value: ECOM_ARRAY [DOUBLE])
			-- Initialize instance with double array `a_value'.
		do
			make
			set_double_array (a_value)
		ensure
			double_array: double_array.is_equal (a_value)
		end

	make_from_boolean_array (a_value: ECOM_ARRAY [BOOLEAN])
			-- Initialize instance with boolean array `a_value'.
		do
			make
			set_boolean_array (a_value)
		ensure
			boolean_array: boolean_array.is_equal (a_value)
		end

	make_from_char_array (a_value: ECOM_ARRAY [CHARACTER])
			-- Initialize instance with char array `a_value'.
		do
			make
			set_char_array (a_value)
		ensure
			char_array: char_array.is_equal (a_value)
		end

	make_from_error_array (a_value: ECOM_ARRAY [ECOM_HRESULT])
			-- Initialize instance with scode array `a_value'.
		do
			make
			set_error_array (a_value)
		ensure
			error_array: arrays_equal (error_array,  a_value)
		end

	make_from_currency_array (a_value: ECOM_ARRAY [ECOM_CURRENCY])
			-- Initialize instance with currency array `a_value'.
		do
			make
			set_currency_array (a_value)
		ensure
			currency_array: arrays_equal (currency_array, a_value)
		end

	make_from_date_array (a_value: ECOM_ARRAY [DATE_TIME])
			-- Initialize instance with date array `a_value'.
		do
			make
			set_date_array (a_value)
		ensure
			date_array: arrays_equal (date_array, a_value)
		end

	make_from_string_array (a_value: ECOM_ARRAY [STRING])
			-- Initialize instance with string array `a_value'.
		do
			make
			set_string_array (a_value)
		ensure
			string_array: arrays_equal (string_array, a_value)
		end

	make_from_decimal_array (a_value: ECOM_ARRAY [ECOM_DECIMAL])
			-- Initialize instance with decimal array `a_value'.
		do
			make
			set_decimal_array (a_value)
		ensure
			decimal_array: arrays_equal (decimal_array, a_value)
		end

feature -- Comparison

	arrays_equal (a_array, a_other: ECOM_ARRAY [ANY]): BOOLEAN
			-- Are `a_array' and `a_other' equal using object comparison?
		require
			attached_array: a_array /= Void
			attached_other: a_other /= Void
		local
			l_comp, l_other_comp: BOOLEAN
		do
			l_comp := a_array.object_comparison
			l_other_comp := a_other.object_comparison
			if not l_comp then
				a_array.compare_objects
			end
			if not l_other_comp then
				a_other.compare_objects
			end
			Result := a_array.is_equal (a_other)
			if not l_comp then
				a_array.compare_references
			end
			if not l_other_comp then
				a_other.compare_references
			end
		ensure
			array_comparison_unchanged: a_array.object_comparison = old a_array.object_comparison
			other_comparison_unchanged: a_other.object_comparison = old a_other.object_comparison
		end

feature -- Access

	variable_type: INTEGER
			-- Variable type
		do
			Result := ccom_variable_type (item)
		end

	character_value: CHARACTER
			-- Character value
		require
			is_character: variable_type = Vt_i1
		do
			Result := ccom_character (item)
		end

	character_reference: CHARACTER_REF
			-- Reference character value
		require
			is_character_ref: is_character (variable_type) and is_byref (variable_type)
		do
			Result := ccom_character_reference (item)
		end

	unsigned_character_value: CHARACTER
			-- Byte value
		require
			is_byte: is_unsigned_char (variable_type)
		do
			Result := ccom_unsigned_character (item)
		end

	unsigned_character_reference: CHARACTER_REF
			-- Reference byte value
		require
			is_byte_ref: is_unsigned_char (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_character_reference (item)
		end

	integer2: INTEGER
			-- Short value
		require
			is_integer2: variable_type = Vt_i2
		do
			Result := ccom_integer2 (item)
		end

	integer2_reference: INTEGER_REF
			-- Reference short value
		require
			is_integer2_ref: is_integer2 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer2_reference (item)
		end

	unsigned_integer2: INTEGER
			-- Unsigned short value
		require
			is_unsigned_short: variable_type = Vt_ui2
		do
			Result := ccom_unsigned_integer2 (item)
		end

	unsigned_integer2_reference: INTEGER_REF
			-- Reference unsigned short value
		require
			is_unsigned_integer2_ref: is_unsigned_short (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer2_reference (item)
		end

	integer4: INTEGER
			-- Long value
		require
			is_integer4: variable_type = Vt_i4
		do
			Result := ccom_integer4 (item)
		end

	integer4_reference: INTEGER_REF
			-- Reference long value
		require
			is_integer4_ref: is_integer4 (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer4_reference (item)
		end

	unsigned_integer4: INTEGER
			-- Unsigned long value
		require
			is_unsigned_long: variable_type = Vt_ui4
		do
			Result := ccom_unsigned_integer4 (item)
		end

	unsigned_integer4_reference: INTEGER_REF
			-- Reference unsigned long value
		require
			is_unsigned_long_ref: is_unsigned_long (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer4_reference (item)
		end

	integer_value: INTEGER
			-- Integer value
		require
			is_integer: variable_type = Vt_int
		do
			Result := ccom_integer (item)
		end

	integer_reference: INTEGER_REF
			-- Reference integer value
		require
			is_integer_ref: is_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_integer_reference (item)
		end

	unsigned_integer: INTEGER
			-- Unsigned integer value
		require
			is_unsigned_integer: variable_type = Vt_uint
		do
			Result := ccom_unsigned_integer (item)
		end

	unsigned_integer_reference: INTEGER_REF
			-- Reference unsigned integer value
		require
			is_unsigned_int_ref: is_unsigned_int (variable_type) and is_byref (variable_type)
		do
			Result := ccom_unsigned_integer_reference (item)
		end

	real_value: REAL
			-- Real value
		require
			is_real: variable_type = Vt_r4
		do
			Result := ccom_real (item)
		end

	real_reference: REAL_REF
			-- Reference real value
		require
			is_real_ref: is_real (variable_type) and is_byref (variable_type)
		do
			Result := ccom_real_reference (item)
		end


	double_value: DOUBLE
			-- Double value
		require
			is_double: variable_type = Vt_r8
		do
			Result := ccom_double (item)
		end

	double_reference: DOUBLE_REF
			-- Reference double value
		require
			is_double_ref: is_double (variable_type) and is_byref (variable_type)
		do
			Result := ccom_double_reference (item)
		end

	boolean_value: BOOLEAN
			-- Boolean value
		require
			is_boolean: variable_type = Vt_bool
		do
			Result := ccom_bool (item)
		end

	boolean_reference: BOOLEAN_REF
			-- Reference boolean value
		require
			is_boolean_ref: is_boolean (variable_type) and is_byref (variable_type)
		do
			Result := ccom_bool_reference (item)
		end

	date_value: DATE_TIME
			-- Date value
		require
			is_date: variable_type = Vt_date
		do
			Result := ccom_date (item)
		end

	date_reference: CELL[DATE_TIME]
			-- Date reference value
		require
			is_date_ref: is_date (variable_type) and is_byref (variable_type)
		do
			Result := ccom_date_reference (item)
		end

	error: ECOM_HRESULT
			-- Error value
		require
			is_error: variable_type = Vt_error
		do
			create Result.make
			Result.set_item (ccom_error (item))
		end

	error_reference: ECOM_HRESULT
			-- Error reference value
		require
			is_error_ref: is_error (variable_type) and is_byref (variable_type)
		do
			create Result.make
			Result.set_item (ccom_error_reference (item))
		end

	decimal: ECOM_DECIMAL
			-- Decimal value
		require
		--	is_decimal: variable_type = Vt_decimal
		do
			Result := ccom_decimal (item)
		end

	decimal_reference: ECOM_DECIMAL
			-- Decimal reference value
		require
			is_decimal_ref: is_decimal (variable_type) and is_byref (variable_type)
		do
			create Result.make_from_pointer (ccom_decimal_reference (item))
		end

	currency: ECOM_CURRENCY
			-- Currency value
		require
			is_currency: variable_type = Vt_cy
		do
			Result := ccom_currency (item)
		end

	currency_reference: ECOM_CURRENCY
			-- Reference currency value
		require
			is_currency_ref: is_currency (variable_type) and is_byref (variable_type)
		do
			create Result.make_from_pointer (ccom_currency_reference (item))
		end

	string_value: STRING
			-- BSTR value
		require
			is_bstr: variable_type = Vt_bstr
		do
			Result := ccom_bstr (item)
		end

	string_reference: CELL[STRING]
			-- Reference BSTR value
		require
			is_bstr_ref: is_bstr (variable_type) and is_byref (variable_type)
		do
			Result := ccom_bstr_reference (item)
		end

	variant_value: ECOM_VARIANT
			-- Variant value
		require
			is_variant: is_variant (variable_type)
		do
			create Result.make_from_pointer (ccom_variant (item))
			Result.set_unshared
		end

	iunknown: ECOM_UNKNOWN_INTERFACE
			-- IUnknown interface value
		require
			is_iunknown: is_iunknown (variable_type)
		do
			create Result.make_from_pointer( ccom_iunknown (item))
		end

	iunknown_reference: CELL[ECOM_UNKNOWN_INTERFACE]
			-- IUnknown interface reference value
		require
			is_unknown_ref: has_iunknown (variable_type) and is_byref (variable_type)
		local
			unk_interface: ECOM_UNKNOWN_INTERFACE
		do
			create unk_interface.make_from_pointer (ccom_iunknown_reference (item))
			create Result.put (unk_interface)
		end

	idispatch: ECOM_AUTOMATION_INTERFACE
			-- IDispatch interface value
		require
			is_idispatch: is_idispatch (variable_type)
		do
			create Result.make_from_pointer (ccom_idispatch (item))
		end

	idispatch_reference: CELL[ECOM_AUTOMATION_INTERFACE]
			-- IDispatch interface reference value
		require
			is_idispatch_ref: has_idispatch (variable_type) and is_byref (variable_type)
		local
			disp_interface: ECOM_AUTOMATION_INTERFACE
		do
			create disp_interface.make_from_pointer (ccom_idispatch_reference (item))
			create Result.put (disp_interface)
		end

	integer4_array: ECOM_ARRAY [INTEGER]
			-- Integer ARRAY value
		require
			has_integer4: has_integer4 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_long (item)
		end

	short_array: ECOM_ARRAY [INTEGER]
			-- Integer ARRAY value
		require
			has_integer2: has_integer2 (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_short (item)
		end

	real_array: ECOM_ARRAY [REAL]
			-- ARRAY of reals
		require
			has_real: has_real (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_float (item)
		end

	double_array: ECOM_ARRAY [DOUBLE]
			-- ARRAY of doubles
		require
			has_double: has_double (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_double (item)
		end

	char_array: ECOM_ARRAY [CHARACTER]
			-- ARRAY of characters
		require
			has_character: has_character (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_character (item)
		end

	error_array: ECOM_ARRAY [ECOM_HRESULT]
			-- ARRAY of HRESULTs
		require
			has_error: has_error (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_error (item)
		end

	currency_array: ECOM_ARRAY [ECOM_CURRENCY]
			-- ARRAY of CURRENCY
		require
			has_currency: has_currency (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_currency (item)
		end

	date_array: ECOM_ARRAY [DATE_TIME]
			-- ARRAY of DATE
		require
			has_date: has_date (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_date (item)
		end

	string_array: ECOM_ARRAY [STRING]
			-- ARRAY of STRING.
		require
			has_bstr: has_bstr (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_bstr (item)
		end

	boolean_array: ECOM_ARRAY [BOOLEAN]
			-- ARRAY of BOOLEAN.
		require
			has_boolean: has_boolean (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_boolean (item)
		end

	variant_array: ECOM_ARRAY [ECOM_VARIANT]
			-- ARRAY of ECOM_VARIANTs.
		require
			has_variant: has_variant (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_variant (item)
		end

	decimal_array: ECOM_ARRAY [ECOM_DECIMAL]
			-- ARRAY of ECOM_DECIMALs.
		require
			has_decimal: has_decimal (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_decimal (item)
		end

	idispatch_array: ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			has_idispatch: has_idispatch (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_idispatch (item)
		end

	iunknown_array: ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			has_iunknown: has_iunknown (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_iunknown (item)
		end

	unsigned_character_array: ECOM_ARRAY[CHARACTER]
			-- Array of unsigned character
		require
			has_unsigned_char: has_unsigned_char (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_character (item)
		end

	unsigned_short_array: ECOM_ARRAY[INTEGER]
			-- Array of unsigned short
		require
			has_unsigned_short: has_unsigned_short (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_short (item)
		end

	unsigned_integer4_array: ECOM_ARRAY[INTEGER]
			-- Array of unsigned long
		require
			has_unsigned_long: has_unsigned_long (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_long (item)
		end

	integer_array: ECOM_ARRAY[INTEGER]
			-- Array of integers
		require
			has_int: has_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_integer (item)
		end

	unsigned_integer_array: ECOM_ARRAY[INTEGER]
			-- Array of unsigned int
		require
			has_unsigned_int: has_unsigned_int (variable_type)
			is_array: is_array (variable_type)
		do
			Result := ccom_safearray_unsigned_integer (item)
		end

	integer4_array_reference: CELL[ECOM_ARRAY [INTEGER]]
			-- Reference integer ARRAY value
		require
			has_integer4: has_integer4 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_long_reference (item)
		end

	short_array_reference: CELL[ECOM_ARRAY [INTEGER]]
			-- Integer ARRAY value
		require
			has_integer2: has_integer2 (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_short_reference (item)
		end

	real_array_reference: CELL[ECOM_ARRAY [REAL]]
			-- ARRAY of reals
		require
			has_real: has_real (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_float_reference (item)
		end

	double_array_reference: CELL[ECOM_ARRAY [DOUBLE]]
			-- ARRAY of doubles
		require
			has_double: has_double (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_double_reference (item)
		end

	char_array_reference: CELL[ECOM_ARRAY[CHARACTER]]
			-- ARRAY of characters
		require
			has_character: has_character (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_character_reference (item)
		end

	error_array_reference: CELL[ECOM_ARRAY [ECOM_HRESULT]]
			-- ARRAY of HRESULTs
		require
			has_error: has_error (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_error_reference (item)
		end

	currency_array_reference: CELL[ECOM_ARRAY [ECOM_CURRENCY]]
			-- ARRAY of CURRENCY
		require
			has_currency: has_currency (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_currency_reference (item)
		end

	date_array_reference: CELL[ECOM_ARRAY [DATE_TIME]]
			-- ARRAY of DATE
		require
			has_date: has_date (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_date_reference (item)
		end

	string_array_reference: CELL[ECOM_ARRAY [STRING]]
			-- ARRAY of STRING.
		require
			has_bstr: has_bstr (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_bstr_reference (item)
		end

	boolean_array_reference: CELL[ECOM_ARRAY[BOOLEAN]]
			-- ARRAY of BOOLEAN.
		require
			has_boolean: has_boolean (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_boolean_reference (item)
		end

	variant_array_reference: CELL[ECOM_ARRAY[ECOM_VARIANT]]
			-- ARRAY of ECOM_VARIANTs.
		require
			has_variant: has_variant (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_variant_reference (item)
		end

	decimal_array_reference: CELL[ECOM_ARRAY[ECOM_DECIMAL]]
			-- ARRAY of ECOM_DECIMALs.
		require
			has_decimal: has_decimal (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_decimal_reference (item)
		end

	idispatch_array_reference: CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]]
			-- ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			has_idispatch: has_idispatch (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_idispatch_reference (item)
		end

	iunknown_array_reference: CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]]
			-- ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			has_iunknown: has_iunknown (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_iunknown_reference (item)
		end

	unsigned_character_array_reference: CELL[ECOM_ARRAY[CHARACTER]]
			-- Array of unsigned character
		require
			has_unsigned_char: has_unsigned_char (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_character_reference (item)
		end

	unsigned_short_array_reference: CELL[ECOM_ARRAY[INTEGER]]
			-- Array of unsigned short
		require
			has_unsigned_short: has_unsigned_short (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_short_reference (item)
		end

	unsigned_integer4_array_reference: CELL[ECOM_ARRAY[INTEGER]]
			-- Array of unsigned long
		require
			has_unsigned_long: has_unsigned_long (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_long_reference (item)
		end

	integer_array_reference: CELL[ECOM_ARRAY[INTEGER]]
			-- Array of integers
		require
			has_int: has_int (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_integer_reference (item)
		end

	unsigned_integer_array_reference: CELL[ECOM_ARRAY[INTEGER]]
			-- Array of unsigned int
		require
			has_unsigned_int: has_unsigned_int (variable_type)
			is_array: is_array (variable_type)
			is_byref: is_byref (variable_type)
		do
			Result := ccom_safearray_unsigned_integer_reference (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of VARIANT structure
		do
			Result := c_size_of_variant
		end

feature -- Element change

	set (a: ANY)
			-- Set VARIANT with ANY.
		do
			if a = Void then
				set_empty
			elseif attached {CHARACTER_REF} a as l_char then
				set_character_reference (l_char)
			elseif attached {INTEGER_REF} a as l_int then
				set_integer4_reference (l_int)
			elseif attached {REAL_REF} a as l_real then
				set_real_reference (l_real)
			elseif attached {DOUBLE_REF} a as l_double then
				set_double_reference (l_double)
			elseif attached {BOOLEAN_REF} a as l_boolean then
				set_boolean_reference (l_boolean)
			elseif attached {DATE_TIME} a as l_date then
				set_date (l_date)
			elseif attached {CELL[DATE_TIME]} a as l_date_cell then
				set_date_reference (l_date_cell)
			elseif attached {ECOM_HRESULT} a as l_hr then
				set_error (l_hr)
			elseif attached {ECOM_DECIMAL} a as l_decimal then
				set_decimal (l_decimal)
			elseif attached {ECOM_CURRENCY} a as l_currency then
				set_currency (l_currency)
			elseif attached {STRING} a as l_string then
				set_string (l_string)
			elseif attached {CELL [STRING]} a as l_string_cell then
				set_string_reference (l_string_cell)
			elseif attached {ECOM_INTERFACE} a as l_interface then
				set_iunknown (l_interface)
			elseif attached {CELL [ECOM_INTERFACE]} a as l_interface_cell then
				set_iunknown_reference (l_interface_cell)
			elseif attached {ECOM_ARRAY [ECOM_VARIANT]} a as l_array then
				set_array (l_array)
			elseif attached {ECOM_ARRAY [BOOLEAN]} a as l_boolean_array then
				set_boolean_array (l_boolean_array)
			elseif attached {CELL [ECOM_ARRAY [BOOLEAN]]} a as l_boolean_array_cell then
				set_boolean_array_reference (l_boolean_array_cell)
			elseif attached {ECOM_ARRAY [CHARACTER]} a as l_char_array then
				set_char_array (l_char_array)
			elseif attached {CELL [ECOM_ARRAY [CHARACTER]]} a as l_char_array_cell then
				set_char_array_reference (l_char_array_cell)
			elseif attached {ECOM_ARRAY [ECOM_CURRENCY]} a as l_currency_array then
				set_currency_array (l_currency_array)
			elseif attached {CELL [ECOM_ARRAY [ECOM_CURRENCY]]} a as l_currency_array_cell then
				set_currency_array_reference (l_currency_array_cell)
			elseif attached {ECOM_ARRAY [DATE_TIME]} a as l_date_array then
				set_date_array (l_date_array)
			elseif attached {CELL [ECOM_ARRAY [DATE_TIME]]} a as l_date_array_cell then
				set_date_array_reference (l_date_array_cell)
			elseif attached {ECOM_ARRAY [ECOM_DECIMAL]} a as l_decimal_array then
				set_decimal_array (l_decimal_array)
			elseif attached {CELL [ECOM_ARRAY [ECOM_DECIMAL]]} a as l_decimal_array_cell then
				set_decimal_array_reference (l_decimal_array_cell)
			elseif attached {ECOM_ARRAY [DOUBLE]} a as l_double_array then
				set_double_array (l_double_array)
			elseif attached {CELL [ECOM_ARRAY [DOUBLE]]} a as l_double_array_cell then
				set_double_array_reference (l_double_array_cell)
			elseif attached {ECOM_ARRAY [ECOM_HRESULT]} a as l_error_array then
				set_error_array (l_error_array)
			elseif attached {CELL [ECOM_ARRAY [ECOM_HRESULT]]} a as l_error_array_cell then
				set_error_array_reference (l_error_array_cell)
			elseif attached {ECOM_ARRAY [INTEGER]} a as l_integer_array then
				set_integer4_array (l_integer_array)
			elseif attached {CELL [ECOM_ARRAY [INTEGER]]} a as l_integer_array_cell then
				set_integer4_array_reference (l_integer_array_cell)
			elseif attached {ECOM_ARRAY [REAL]} a as l_real_array then
				set_real_array (l_real_array)
			elseif attached {CELL [ECOM_ARRAY [REAL]]} a as l_real_array_cell then
				set_real_array_reference (l_real_array_cell)
			elseif attached {ECOM_ARRAY [STRING]} a as l_string_array then
				set_string_array (l_string_array)
			elseif attached {CELL [ECOM_ARRAY [STRING]]} a as l_string_array_cell then
				set_string_array_reference (l_string_array_cell)
			elseif attached {ECOM_ARRAY [ECOM_INTERFACE]} a as l_unknown_array then
				set_iunknown_array (l_unknown_array)
			elseif attached {CELL [ECOM_ARRAY [ECOM_INTERFACE]]} a as l_unknown_array_cell then
				set_iunknown_array_reference (l_unknown_array_cell)
			elseif attached {CELL [ECOM_ARRAY [ECOM_VARIANT]]} a as l_variant_array then
				set_variant_array_reference (l_variant_array)
			elseif attached {ECOM_VARIANT} a as l_variant then
				set_variant (l_variant)
			else
				check
					valid_type: False
				end
			end
		end

	set_empty
			-- Set empty VARIANT.
		do
			ccom_set_variable_type (item, Vt_empty)
		end

	set_character (a_char: CHARACTER)
			-- Set character value.
		do
			ccom_set_character (item, a_char)
		ensure
			set: character_value = a_char
		end

	set_character_reference (a_char: CHARACTER_REF)
			-- Set reference character value
		require
			non_void: a_char /= Void
		do
			ccom_set_character_reference (item, a_char)
		ensure
			set: character_reference = a_char
		end

	set_unsigned_character (a_value: CHARACTER)
			-- Set unsigned character value
		do
			ccom_set_unsigned_character (item, a_value)
		end

	set_unsigned_character_reference (a_value: CHARACTER_REF)
			-- Set reference byte value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_character_reference (item, a_value)
		end

	set_integer2 (a_value: INTEGER)
			-- Set short value
		do
			ccom_set_integer2 (item, a_value)
		end

	set_integer2_reference (a_value: INTEGER_REF)
			-- Set reference short value
		require
			non_void: a_value /= Void
		do
			ccom_set_integer2_reference (item, a_value)
		end

	set_unsigned_integer2 (a_value: INTEGER)
			-- Set unsigned short value
		do
			ccom_set_unsigned_integer2 (item, a_value)
		end

	set_unsigned_integer2_reference (a_value: INTEGER_REF)
			-- Set reference unsigned short value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer2_reference (item, a_value)
		end

	set_integer4 (a_value: INTEGER)
			-- Set long value
		do
			ccom_set_integer4 (item, a_value)
		end

	set_integer4_reference (a_value: INTEGER_REF)
			-- Set reference long value
		require
			non_void: a_value /= Void
		do
			ccom_set_integer4_reference (item, a_value)
		end

	set_unsigned_integer4 (a_value: INTEGER)
			-- Set unsigned long value
		do
			ccom_set_unsigned_integer4 (item, a_value)
		end

	set_unsigned_integer4_reference (a_value: INTEGER_REF)
			-- Set reference unsigned long value
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer4_reference (item, a_value)
		end

	set_integer (a_value: INTEGER)
			-- Set integer value.
		do
			ccom_set_integer (item, a_value)
		end

	set_integer_reference (a_value: INTEGER_REF)
			-- Set reference integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_integer_reference (item, a_value)
		end

	set_unsigned_integer (a_value: INTEGER)
			-- Set unsigned integer value.
		do
			ccom_set_unsigned_integer (item, a_value)
		end

	set_unsigned_integer_reference (a_value: INTEGER_REF)
			-- Set reference unsigned integer value.
		require
			non_void: a_value /= Void
		do
			ccom_set_unsigned_integer_reference (item, a_value)
		end

	set_real (a_value: REAL)
			-- Set real value.
		do
			ccom_set_real (item, a_value)
		end

	set_real_reference (a_value: REAL_REF)
			-- Set reference real value.
		require
			non_void: a_value /= Void
		do
			ccom_set_real_reference (item, a_value)
		end

	set_double (a_value: DOUBLE)
			-- Set double value.
		do
			ccom_set_double (item, a_value)
		end

	set_double_reference (a_value: DOUBLE_REF)
			-- Set reference double value.
		require
			non_void: a_value /= Void
		do
			ccom_set_double_reference (item, a_value)
		end

	set_boolean (a_value: BOOLEAN)
			-- Set boolean value.
		do
			ccom_set_bool (item, a_value)
		end

	set_boolean_reference (a_value: BOOLEAN_REF)
			-- Set reference boolean value.
		require
			non_void: a_value /= Void
		do
			ccom_set_bool_reference (item, a_value)
		end

	set_date (a_value: DATE_TIME)
			-- Set date value.
		require
			non_void: a_value /= Void
		do
			ccom_set_date (item, a_value)
		end

	set_date_reference (a_value: CELL[DATE_TIME])
			-- Set date reference value.
		require
			non_void: a_value /= Void
			valid_value: a_value.item /= Void
		do
			ccom_set_date_reference (item, a_value)
		end

	set_error (a_value: ECOM_HRESULT)
			-- Set error value.
		require
			non_void: a_value /= Void
		do
			ccom_set_error (item, a_value.item)
		end

	set_error_reference (a_value: ECOM_HRESULT)
			-- Set error reference value.
		require
			non_void: a_value /= Void
		do
			ccom_set_error_reference (item, a_value.item)
		end

	set_decimal (a_value: ECOM_DECIMAL)
			-- Set decimal value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_decimal (item, a_value.item)
		end

	set_decimal_reference (a_value: ECOM_DECIMAL)
			-- Set decimal reference value.
		require
			non_void_decimal: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_decimal_reference (item, a_value.item)
		end

	set_currency (a_value: ECOM_CURRENCY)
			-- Set currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_currency (item, a_value.item)
		end

	set_currency_reference (a_value: ECOM_CURRENCY)
			-- Set reference currency value.
		require
			non_void_currency: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_currency_reference (item, a_value.item)
		end

	set_string (a_value: STRING)
			-- Set BSTR value.
		require
			non_void_string: a_value /= Void
		do
			ccom_set_bstr (item, a_value)
		end

	set_string_reference (a_value: CELL[STRING])
			-- Set reference BSTR value.
		require
			non_void_string: a_value /= Void
			valid_value: a_value.item /= Void
		do
			ccom_set_bstr_reference (item, a_value.item)
		end

	set_variant (a_value: ECOM_VARIANT)
			-- Set variant value.
		require
			non_void_variant: a_value /= Void
			valid: a_value.item /= default_pointer
		do
			ccom_set_variant (item, a_value.item)
		end

	set_iunknown (a_value: ECOM_INTERFACE)
			-- Set IUnknown interface value.
		require
			non_void: a_value /= Void
		local
			a_ptr: POINTER
		do
			if (a_value.item = default_pointer) and then attached {ECOM_STUB} a_value as l_stub then
				l_stub.create_item
			end
			a_ptr := a_value.item
			ccom_set_iunknown (item, a_ptr)
		end

	set_iunknown_reference (a_value: CELL [ECOM_INTERFACE])
			-- Set IUnknown interface reference value.
		require
			non_void: a_value /= Void
		local
			a_ptr: POINTER
		do
			if attached a_value.item as i then
				if i.item = default_pointer and then attached {ECOM_STUB} i as l_stub then
					l_stub.create_item
				end
				a_ptr := i.item
			end
			ccom_set_iunknown_reference (item, a_ptr)
		end

	set_idispatch (a_value: ECOM_INTERFACE)
			-- Set IDispatch interface value.
		require
			non_void: a_value /= Void
		local
			a_ptr: POINTER
		do
			if (a_value.item = default_pointer) and then attached {ECOM_STUB} a_value as l_stub then
				l_stub.create_item
			end
			a_ptr := a_value.item
			ccom_set_idispatch (item, a_ptr)
		end

	set_idispatch_reference (a_value: CELL[ECOM_INTERFACE])
			-- Set IDispatch interface reference value.
		require
			non_void: a_value /= Void
		local
			a_ptr: POINTER
		do
			if a_value.item /= Void then
				if (a_value.item.item = default_pointer) and then attached {ECOM_STUB} a_value.item as l_stub then
					l_stub.create_item
				end
				a_ptr := a_value.item.item
			end
			ccom_set_idispatch_reference (item, a_ptr)
		end

	set_integer4_array (a_value: ECOM_ARRAY [INTEGER])
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_long (item, a_value)
		end

	set_short_array (a_value: ECOM_ARRAY [INTEGER])
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_short (item, a_value)
		end

	set_real_array (a_value: ECOM_ARRAY [REAL])
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_float (item, a_value)
		end

	set_double_array (a_value: ECOM_ARRAY [DOUBLE])
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_double (item, a_value)
		end

	set_char_array (a_value: ECOM_ARRAY [CHARACTER])
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_character (item, a_value)
		end

	set_error_array (a_value: ECOM_ARRAY [ECOM_HRESULT])
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_error (item, a_value)
		end

	set_currency_array (a_value: ECOM_ARRAY [ECOM_CURRENCY])
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_currency (item, a_value)
		end

	set_date_array (a_value: ECOM_ARRAY [DATE_TIME])
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_date (item, a_value)
		end

	set_string_array (a_value: ECOM_ARRAY [STRING])
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_bstr (item, a_value)
		end

	set_boolean_array (a_value: ECOM_ARRAY [BOOLEAN])
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_boolean (item, a_value)
		end

	set_array (a_value: ECOM_ARRAY [ECOM_VARIANT])
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_variant (item, a_value)
		end

	set_decimal_array (a_value: ECOM_ARRAY [ECOM_DECIMAL])
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_decimal (item, a_value)
		end

	set_idispatch_array (a_value: ECOM_ARRAY [ECOM_INTERFACE])
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_idispatch (item, a_value)
		end

	set_iunknown_array (a_value: ECOM_ARRAY [ECOM_INTERFACE])
			-- Set ARRAY of ECOM_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_iunknown (item, a_value)
		end

	set_unsigned_character_array (a_value: ECOM_ARRAY[CHARACTER])
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_character (item, a_value)
		end

	set_unsigned_short_array (a_value: ECOM_ARRAY[INTEGER])
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_short (item, a_value)
		end

	set_unsigned_integer4_array (a_value: ECOM_ARRAY[INTEGER])
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_long (item, a_value)
		end

	set_integer_array (a_value: ECOM_ARRAY[INTEGER])
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_integer (item, a_value)
		end

	set_unsigned_integer_array (a_value: ECOM_ARRAY[INTEGER])
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_integer (item, a_value)
		end

	set_integer4_array_reference (a_value: CELL[ECOM_ARRAY [INTEGER]])
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_long_reference (item, a_value.item)
		end

	set_short_array_reference (a_value: CELL[ECOM_ARRAY [INTEGER]])
			-- Set integer ARRAY value
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_short_reference (item, a_value.item)
		end

	set_real_array_reference (a_value: CELL[ECOM_ARRAY [REAL]])
			-- Set ARRAY of reals
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_float_reference (item, a_value.item)
		end

	set_double_array_reference (a_value: CELL[ECOM_ARRAY[DOUBLE]])
			-- Set ARRAY of doubles
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_double_reference (item, a_value.item)
		end

	set_char_array_reference (a_value: CELL[ECOM_ARRAY[CHARACTER]])
			-- Set ARRAY of characters
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_character_reference (item, a_value.item)
		end

	set_error_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_HRESULT]])
			-- Set ARRAY of HRESULTs
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_error_reference (item, a_value.item)
		end

	set_currency_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_CURRENCY]])
			-- Set ARRAY of CURRENCY
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_currency_reference (item, a_value.item)
		end

	set_date_array_reference (a_value: CELL[ECOM_ARRAY[DATE_TIME]])
			-- Set ARRAY of DATE
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_date_reference (item, a_value.item)
		end

	set_string_array_reference (a_value: CELL[ECOM_ARRAY[STRING]])
			-- Set ARRAY of STRING.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_bstr_reference (item, a_value.item)
		end

	set_boolean_array_reference (a_value: CELL[ECOM_ARRAY[BOOLEAN]])
			-- Set ARRAY of BOOLEAN.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_boolean_reference (item, a_value.item)
		end

	set_variant_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_VARIANT]])
			-- Set ARRAY of ECOM_VARIANTs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_variant_reference (item, a_value.item)
		end

	set_decimal_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_DECIMAL]])
			-- Set ARRAY of ECOM_DECIMALs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_decimal_reference (item, a_value.item)
		end

	set_idispatch_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_INTERFACE]])
			-- Set ARRAY of ECOM_AUTOMATION_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_idispatch_reference (item, a_value.item)
		end

	set_iunknown_array_reference (a_value: CELL[ECOM_ARRAY[ECOM_INTERFACE]])
			-- Set ARRAY of ECOM_UNKNOWN_INTERFACEs.
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_iunknown_reference (item, a_value.item)
		end

	set_unsigned_character_array_reference (a_value: CELL[ECOM_ARRAY[CHARACTER]])
			-- Set Array of unsigned character
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_character_reference (item, a_value.item)
		end

	set_unsigned_short_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]])
			-- Set Array of unsigned short
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_short_reference (item, a_value.item)
		end

	set_unsigned_integer4_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]])
			-- Set Array of unsigned long
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_long_reference (item, a_value.item)
		end

	set_integer_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]])
			-- Set Array of integers
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_integer_reference (item, a_value.item)
		end

	set_unsigned_integer_array_reference (a_value: CELL[ECOM_ARRAY[INTEGER]])
			-- Set Array of unsigned int
		require
			non_void_value: a_value /= Void
		do
			ccom_set_safearray_unsigned_integer_reference (item, a_value.item)
		end

feature -- Output

	out: STRING
			-- Printable representation of  value.
		do
			if variable_type = Vt_bool then
				Result:= boolean_value.out
			elseif variable_type = Vt_i1 then
				create Result.make (6)
				Result.append_character ('%Q')
				Result.append (character_value.out)
				Result.append_character ('%'')
			elseif variable_type = Vt_i2 then
				Result := integer2.out
			elseif variable_type = Vt_i4 then
				Result := integer4.out
			elseif variable_type = Vt_int then
				Result := integer_value.out
			elseif variable_type = Vt_r4 then
				Result := real_value.out
			elseif variable_type = Vt_r8 then
				Result := double_value.out
			elseif variable_type = Vt_bstr then
				create Result.make (100)
				Result.append_character ('%"')
				if string_value /= Void then
					Result.append (string_value.out)
				end
				Result.append_character ('%"')
			elseif variable_type = Vt_ui1 then
				Result := unsigned_character_value.out
			elseif variable_type = Vt_uint then
				Result := unsigned_integer.out
			elseif variable_type = Vt_ui2 then
				Result := unsigned_integer2.out
			elseif variable_type = Vt_ui4 then
				Result := unsigned_integer4.out
			elseif variable_type = Vt_date then
				if date_value /= Void then
					Result.append (date_value.out)
				end
			else
				Result := "Variant"
			end
		end

feature {NONE} -- Implementation

	variant_true: INTEGER = -1
			-- True value of type VARIANT_BOOL

	variant_false: INTEGER = 0
			-- False value of type VARIANT_BOOL

feature {NONE} -- Element change

	set_variable_type (a_type: INTEGER)
			-- Set variable type.
		do
			ccom_set_variable_type (item, a_type)
		ensure
			type_set: variable_type = a_type
		end

feature {NONE} -- Removal

	destroy_item
			-- Free `item'
		do
			-- FIXME Paul - Temporary Hack to avoid freeing arrays.
			if not shared and item /= default_pointer and then not is_array (variable_type) then
				ccom_variant_clear (item)
			end
			Precursor {ECOM_STRUCTURE}
		end

feature {NONE} -- Externals

	c_size_of_variant: INTEGER
		external
			"C [macro %"E_variant.h%"]"
		alias
			"sizeof(VARIANT)"
		end

	ccom_variant_clear (a_ptr: POINTER)
		external
			"C [macro %"E_variant.h%"] (VARIANT *)"
		end

	create_ecom_variant: POINTER
		external
			"C ():(VARIANT *) |%"E_variant.h%""
		end

	ccom_variable_type (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *):EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_variable_type (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, VARTYPE) |%"E_variant.h%""
		end

	ccom_character (a_ptr: POINTER): CHARACTER
		external
			"C (VARIANT *): EIF_CHARACTER |%"E_variant.h%""
		end

	ccom_set_character (a_ptr: POINTER; a: CHARACTER)
		external
			"C (VARIANT *, EIF_CHARACTER) |%"E_variant.h%""
		end

	ccom_character_reference (a_ptr: POINTER): CHARACTER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_character_reference (a_ptr: POINTER; a: CHARACTER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_unsigned_character (a_ptr: POINTER): CHARACTER
		external
			"C (VARIANT *): EIF_CHARACTER |%"E_variant.h%""
		end

	ccom_set_unsigned_character (a_ptr: POINTER; a: CHARACTER)
		external
			"C (VARIANT *, EIF_CHARACTER) |%"E_variant.h%""
		end

	ccom_unsigned_character_reference (a_ptr: POINTER): CHARACTER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_unsigned_character_reference (a_ptr: POINTER; a: CHARACTER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_integer2 (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_integer2 (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_integer2_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_integer2_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_unsigned_integer2 (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_unsigned_integer2 (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_unsigned_integer2_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_unsigned_integer2_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_integer4 (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_integer4 (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_integer4_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_integer4_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_unsigned_integer4 (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_unsigned_integer4 (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_unsigned_integer4_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_unsigned_integer4_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_integer (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_integer (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_integer_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_integer_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_unsigned_integer (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_unsigned_integer (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, EIF_INTEGER) |%"E_variant.h%""
		end

	ccom_unsigned_integer_reference (a_ptr: POINTER): INTEGER_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_unsigned_integer_reference (a_ptr: POINTER; a: INTEGER_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_real (a_ptr: POINTER): REAL
		external
			"C (VARIANT *): EIF_REAL |%"E_variant.h%""
		end

	ccom_set_real (a_ptr: POINTER; a: REAL)
		external
			"C (VARIANT *, EIF_REAL) |%"E_variant.h%""
		end

	ccom_real_reference (a_ptr: POINTER): REAL_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_real_reference (a_ptr: POINTER; a: REAL_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_double (a_ptr: POINTER): DOUBLE
		external
			"C (VARIANT *): EIF_DOUBLE |%"E_variant.h%""
		end

	ccom_set_double (a_ptr: POINTER; a: DOUBLE)
		external
			"C (VARIANT *, EIF_DOUBLE) |%"E_variant.h%""
		end

	ccom_double_reference (a_ptr: POINTER): DOUBLE_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_double_reference (a_ptr: POINTER; a: DOUBLE_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_bool (a_ptr: POINTER): BOOLEAN
		external
			"C (VARIANT *): EIF_BOOLEAN |%"E_variant.h%""
		end

	ccom_set_bool (a_ptr: POINTER; a: BOOLEAN)
		external
			"C (VARIANT *, EIF_BOOLEAN) |%"E_variant.h%""
		end

	ccom_bool_reference (a_ptr: POINTER): BOOLEAN_REF
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_bool_reference (a_ptr: POINTER; a: BOOLEAN_REF)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_date (a_ptr: POINTER): DATE_TIME
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_date (a_ptr: POINTER; a: DATE_TIME)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_date_reference (a_ptr: POINTER): CELL[DATE_TIME]
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_date_reference (a_ptr: POINTER; a: CELL[DATE_TIME])
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_error (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_error (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, SCODE) |%"E_variant.h%""
		end

	ccom_error_reference (a_ptr: POINTER): INTEGER
		external
			"C (VARIANT *): EIF_INTEGER |%"E_variant.h%""
		end

	ccom_set_error_reference (a_ptr: POINTER; a: INTEGER)
		external
			"C (VARIANT *, SCODE) |%"E_variant.h%""
		end

	ccom_decimal (a_ptr: POINTER): ECOM_DECIMAL
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_decimal (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, DECIMAL *) |%"E_variant.h%""
		end

	ccom_decimal_reference (a_ptr: POINTER): POINTER
		external
			"C (VARIANT *): EIF_POINTER |%"E_variant.h%""
		end

	ccom_set_decimal_reference (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, DECIMAL *) |%"E_variant.h%""
		end

	ccom_currency (a_ptr: POINTER): ECOM_CURRENCY
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_currency (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, CY *) |%"E_variant.h%""
		end

	ccom_currency_reference (a_ptr: POINTER): POINTER
		external
			"C (VARIANT *): EIF_POINTER |%"E_variant.h%""
		end

	ccom_set_currency_reference (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, CY *) |%"E_variant.h%""
		end

	ccom_bstr (a_ptr: POINTER): STRING
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_bstr (a_ptr: POINTER; a: STRING)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_bstr_reference (a_ptr: POINTER): CELL[STRING]
		external
			"C (VARIANT *): EIF_REFERENCE |%"E_variant.h%""
		end

	ccom_set_bstr_reference (a_ptr: POINTER; a: STRING)
		external
			"C (VARIANT *, EIF_OBJECT) |%"E_variant.h%""
		end

	ccom_variant (a_ptr: POINTER): POINTER
		external
			"C (VARIANT *): EIF_POINTER |%"E_variant.h%""
		end

	ccom_set_variant (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, VARIANT *)  |%"E_variant.h%""
		end

	ccom_iunknown (a_ptr: POINTER):  POINTER
		external
			"C (VARIANT *): EIF_POINTER  |%"E_variant.h%""
		end

	ccom_set_iunknown (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, IUnknown *)  |%"E_variant.h%""
		end

	ccom_iunknown_reference (a_ptr: POINTER):  POINTER
		external
			"C (VARIANT *): EIF_POINTER  |%"E_variant.h%""
		end

	ccom_set_iunknown_reference (a_ptr: POINTER; a: POINTER)
		external
			"C (VARIANT *, IUnknown *)  |%"E_variant.h%""
		end

	ccom_idispatch (a_ptr: POINTER):  POINTER
		external
			"C (VARIANT *): EIF_POINTER  |%"E_variant.h%""
		end

	ccom_set_idispatch (a_ptr: POINTER; a_value: POINTER)
		external
			"C (VARIANT *, IDispatch *)  |%"E_variant.h%""
		end

	ccom_idispatch_reference (a_ptr: POINTER):  POINTER
		external
			"C (VARIANT *): EIF_POINTER  |%"E_variant.h%""
		end

	ccom_set_idispatch_reference (a_ptr: POINTER; a_value: POINTER)
		external
			"C (VARIANT *, IDispatch *)  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_integer (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_integer (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_character (a_ptr: POINTER): ECOM_ARRAY[CHARACTER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_character (a_ptr: POINTER): ECOM_ARRAY[CHARACTER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_short (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_long (a_ptr: POINTER): ECOM_ARRAY[INTEGER]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_float (a_ptr: POINTER): ECOM_ARRAY[REAL]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_double (a_ptr: POINTER): ECOM_ARRAY[DOUBLE]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_currency (a_ptr: POINTER): ECOM_ARRAY[ECOM_CURRENCY]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_date (a_ptr: POINTER): ECOM_ARRAY[DATE_TIME]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_bstr (a_ptr: POINTER): ECOM_ARRAY[STRING]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_idispatch (a_ptr: POINTER): ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_error (a_ptr: POINTER): ECOM_ARRAY[ECOM_HRESULT]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_boolean (a_ptr: POINTER): ECOM_ARRAY[BOOLEAN]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_variant (a_ptr: POINTER): ECOM_ARRAY[ECOM_VARIANT]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_decimal (a_ptr: POINTER): ECOM_ARRAY[ECOM_DECIMAL]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_iunknown (a_ptr: POINTER): ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_integer_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_integer_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_character_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[CHARACTER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_character_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[CHARACTER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_short_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_short_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_long_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_unsigned_long_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[INTEGER]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_float_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[REAL]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_double_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[DOUBLE]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_currency_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_CURRENCY]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_date_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[DATE_TIME]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_bstr_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[STRING]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_idispatch_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_error_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_HRESULT]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_boolean_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[BOOLEAN]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_variant_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_VARIANT]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_decimal_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_DECIMAL]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_safearray_iunknown_reference (a_ptr: POINTER): CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]]
		external
			"C (VARIANT *): EIF_REFERENCE  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_integer (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_integer (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_character (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_character (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_short (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_long (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_float (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_double (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_currency (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_date (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_bstr (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_idispatch (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_INTERFACE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_error (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_boolean (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_variant (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_decimal (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_iunknown (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_INTERFACE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_integer_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_integer_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_character_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_character_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[CHARACTER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_short_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_short_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_long_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_unsigned_long_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[INTEGER])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_float_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[REAL])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_double_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[DOUBLE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_currency_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_CURRENCY])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_date_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[DATE_TIME])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_bstr_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[STRING])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_idispatch_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_INTERFACE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_error_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_HRESULT])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_boolean_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[BOOLEAN])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_variant_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_VARIANT])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_decimal_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_DECIMAL])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

	ccom_set_safearray_iunknown_reference (a_ptr: POINTER; a_value: ECOM_ARRAY[ECOM_INTERFACE])
		external
			"C (VARIANT *, EIF_OBJECT)  |%"E_variant.h%""
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
