note
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_positive: type_id > 0
		do
			Result := c_is_instance_of (type_id, $object)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		require
			type1_positive: type1 > 0
			type2_positive: type2 > 0
		do
			Result := c_type_conforms_to (type1, type2)
		end
		
feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
		local
			a: ANY
		do
			a := class_type.to_c
			Result := {ISE_RUNTIME}.type_id_from_name ($a)
		ensure
			valid_result: Result = -1 or else Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.
		require
			type_id_positive: type_id > 0
			not_special_type: not is_special_type (type_id)
		do
			Result := c_new_instance_of (type_id)
		ensure
			not_special_type: not is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [ANY]
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `TO_SPECIAL'.
		require
			count_valid: count >= 0
			type_id_positive: type_id > 0
			special_type: is_special_any_type (type_id)
		local
			l_sp: TO_SPECIAL [ANY]
		do
			create l_sp.make_area (count)
			Result := l_sp.area
			c_set_dynamic_type ($Result, type_id)
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = count
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_valid: type_id > 0
		do
			Result := c_eif_special_any_type (type_id)
		end

	is_special_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_valid: type_id > 0
		do
			Result := c_eif_is_special_type (type_id)
		end

	is_special (object: ANY): BOOLEAN
			-- Is `object' a special object?
			-- It only recognized a special object 
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		do
			Result := c_is_special ($object)
		end

	is_marked (obj: ANY): BOOLEAN
			-- Is `obj' marked?
		require
			object_exists: obj /= Void
		do
			Result := c_is_marked ($obj)
		end

feature -- Access

	Pointer_type: INTEGER = 0

	Reference_type: INTEGER = 1

	Character_type: INTEGER = 2

	Boolean_type: INTEGER = 3

	Integer_type: INTEGER = 4
	
	Integer_32_type: INTEGER = 4

	Real_type: INTEGER = 5

	Double_type: INTEGER = 6

	Expanded_type: INTEGER = 7

	Bit_type: INTEGER = 8

	Integer_8_type: INTEGER = 9

	Integer_16_type: INTEGER = 10

	Integer_64_type: INTEGER = 11

	Wide_character_type: INTEGER = 12

	class_name (object: ANY): STRING
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end
		
	class_name_of_type (type_id: INTEGER): STRING
			-- Name of class associated with dynamic type `type_id'.
		do
			Result := {ISE_RUNTIME}.c_generator_of_type (type_id)
		end

	type_name (object: ANY): STRING
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type
		end

	type_name_of_type (type_id: INTEGER): STRING
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		do
			Result := {ISE_RUNTIME}.c_generating_type_of_type (type_id)
		end

	dynamic_type (object: ANY): INTEGER
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := {ISE_RUNTIME}.dynamic_type ($object)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		do
			Result := eif_gen_param_id (- 1, $object, i)
		end
		
	field (i: INTEGER; object: ANY): ANY
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := c_field (i - 1, $object)
		end

	field_name (i: INTEGER; object: ANY): STRING
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			create Result.make_from_c (c_field_name_of_type (i - 1, {ISE_RUNTIME}.dynamic_type ($object)))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		do
			create Result.make_from_c (c_field_name_of_type (i - 1, type_id))
		end

	field_offset (i: INTEGER; object: ANY): INTEGER
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := c_field_offset (i - 1, $object)
		end

	field_type (i: INTEGER; object: ANY): INTEGER
			-- Abstract type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := c_field_type_of_type (i - 1, {ISE_RUNTIME}.dynamic_type ($object))
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_type_of_type (i - 1, type_id)
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_static_type_of_type (i - 1, type_id)
		end
		
	expanded_field_type (i: INTEGER; object: ANY): STRING
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_expanded: field_type (i, object) = Expanded_type
		do
			Result := c_expanded_type (i - 1, $object)
		ensure
			Result_exists: Result /= Void
		end

	character_field (i: INTEGER; object: ANY): CHARACTER
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			Result := c_character_field (i - 1, $object)
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result := c_boolean_field (i - 1, $object)
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result := c_integer_8_field (i - 1, $object)
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result := c_integer_16_field (i - 1, $object)
		end

	integer_field (i: INTEGER; object: ANY): INTEGER
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			Result := c_integer_field (i - 1, $object)
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result := c_integer_64_field (i - 1, $object)
		end

	real_field (i: INTEGER; object: ANY): REAL
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			Result := c_real_field (i - 1, $object)
		end

	pointer_field (i: INTEGER; object: ANY): POINTER
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result := c_pointer_field (i - 1, $object)
		end

	double_field (i: INTEGER; object: ANY): DOUBLE
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			Result := c_double_field (i - 1, $object)
		end

feature -- Version

	compiler_version: INTEGER
		external
			"C [macro %"eif_project.h%"]"
		alias
			"egc_compiler_tag"
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
		do
			c_set_reference_field (i - 1, $object, $value)
		end

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			c_set_double_field (i - 1, $object, value)
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER)
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			c_set_character_field (i - 1, $object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			c_set_boolean_field (i - 1, $object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_8_type
		do
			c_set_integer_8_field (i - 1, $object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_16_type
		do
			c_set_integer_16_field (i - 1, $object, value)
		end

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			c_set_integer_field (i - 1, $object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_64_type
		do
			c_set_integer_64_field (i - 1, $object, value)
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			c_set_real_field (i - 1, $object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			c_set_pointer_field (i - 1, $object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := field_count_of_type ({ISE_RUNTIME}.dynamic_type ($object))
		end

	field_count_of_type (type_id: INTEGER): INTEGER
			-- Number of logical fields in dynamic type `type_id'.
		external
			"C macro signature (EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_count_field_of_type"
		end

	bit_size (i: INTEGER; object: ANY): INTEGER
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_bit: field_type (i, object) = Bit_type
		do
			Result := c_bit_size (i - 1, $object)
		ensure
			positive_result: Result > 0
		end

	physical_size (object: ANY): INTEGER
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := c_size ($object)
		end

feature -- Marking

	mark (obj: ANY)
			-- Mark object `obj'
		require
			object_not_void: obj /= Void
		do
			c_mark ($obj)
		end

	unmark (obj: ANY)
			-- Unmark object `obj'
		require
			object_not_void: obj /= Void
		do
			c_unmark ($obj)
		end

feature {NONE} -- Implementation

	c_is_instance_of (type1: INTEGER; obj: POINTER): BOOLEAN
			-- Is `obj' an instance of `type1'?
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTRA"
		end

	c_field (i: INTEGER; object: POINTER): ANY
			-- Object referenced by the `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_REFERENCE | %"eif_internal.h%""
		alias
			"ei_field"
		end

	c_field_name_of_type (i: INTEGER; type_id: INTEGER): POINTER
			-- C pointer to name of `i'-th field of `object'
		external
			"C macro signature (EIF_INTEGER, EIF_INTEGER): EIF_POINTER use %"eif_internal.h%""
		alias
			"ei_field_name_of_type"
		end

	c_field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Abstract type of `i'-th field of dynamic type `type_id'
		external
			"C signature (long, EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_field_type_of_type"
		end

	c_field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Static type of `i'-th field of dynamic type `type_id'
		external
			"C signature (long, EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_field_static_type_of_type"
		end

	c_expanded_type (i: INTEGER; object: POINTER): STRING
			-- Class name of the `i'-th expanded field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_REFERENCE | %"eif_internal.h%""
		alias
			"ei_exp_type"
		end

	c_character_field (i: INTEGER; object: POINTER): CHARACTER
			-- Character value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_CHARACTER use %"eif_internal.h%""
		alias
			"ei_char_field"
		end

	c_boolean_field (i: INTEGER; object: POINTER): BOOLEAN
			-- Boolean value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_BOOLEAN use %"eif_internal.h%""
		alias
			"ei_bool_field"
		end

	c_integer_8_field (i: INTEGER; object: POINTER): INTEGER_8
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER_8 use %"eif_internal.h%""
		alias
			"ei_int_8_field"
		end

	c_integer_16_field (i: INTEGER; object: POINTER): INTEGER_16
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER_16 use %"eif_internal.h%""
		alias
			"ei_int_16_field"
		end

	c_integer_field (i: INTEGER; object: POINTER): INTEGER
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_int_field"
		end

	c_integer_64_field (i: INTEGER; object: POINTER): INTEGER_64
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER_64 use %"eif_internal.h%""
		alias
			"ei_int_64_field"
		end

	c_real_field (i: INTEGER; object: POINTER): REAL
			-- Real value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_REAL use %"eif_internal.h%""
		alias
			"ei_float_field"
		end

	c_pointer_field (i: INTEGER; object: POINTER): POINTER
			-- Pointer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_POINTER use %"eif_internal.h%""
		alias
			"ei_ptr_field"
		end

	c_double_field (i: INTEGER; object: POINTER): DOUBLE
			-- Double precision value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_DOUBLE use %"eif_internal.h%""
		alias
			"ei_double_field"
		end

	c_is_special (object: POINTER): BOOLEAN
			-- Is `object' a special object?
		external
			"C (EIF_REFERENCE): EIF_BOOLEAN | %"eif_internal.h%""
		alias
			"ei_special"
		end

	c_field_offset (i: INTEGER; object: POINTER): INTEGER
			-- Offset of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_offset"
		end

	c_bit_size (i: INTEGER; object: POINTER): INTEGER
			-- Size (in bit) of the `i'-th bit field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_bit_size"
		end

	c_size (object: POINTER): INTEGER
			-- Physical size of `object'
		external
			"C (EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_size"
		end

	c_set_reference_field (i: INTEGER; object: POINTER; value: POINTER)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_REFERENCE) use %"eif_internal.h%""
		alias
			"ei_set_reference_field"
		end

	c_set_double_field (i: INTEGER; object: POINTER; value: DOUBLE)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_DOUBLE) use %"eif_internal.h%""
		alias
			"ei_set_double_field"
		end

	c_set_character_field (i: INTEGER; object: POINTER; value: CHARACTER)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_CHARACTER) use %"eif_internal.h%""
		alias
			"ei_set_char_field"
		end

	c_set_boolean_field (i: INTEGER; object: POINTER; value: BOOLEAN)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_BOOLEAN) use %"eif_internal.h%""
		alias
			"ei_set_boolean_field"
		end

	c_set_integer_8_field (i: INTEGER; object: POINTER; value: INTEGER_8)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER_8) use %"eif_internal.h%""
		alias
			"ei_set_integer_8_field"
		end

	c_set_integer_16_field (i: INTEGER; object: POINTER; value: INTEGER_16)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER_16) use %"eif_internal.h%""
		alias
			"ei_set_integer_16_field"
		end

	c_set_integer_field (i: INTEGER; object: POINTER; value: INTEGER)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER) use %"eif_internal.h%""
		alias
			"ei_set_integer_field"
		end

	c_set_integer_64_field (i: INTEGER; object: POINTER; value: INTEGER_64)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER_64) use %"eif_internal.h%""
		alias
			"ei_set_integer_64_field"
		end

	c_set_real_field (i: INTEGER; object: POINTER; value: REAL)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_REAL) use %"eif_internal.h%""
		alias
			"ei_set_float_field"
		end

	c_set_pointer_field (i: INTEGER; object: POINTER; value: POINTER)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_POINTER) use %"eif_internal.h%""
		alias
			"ei_set_pointer_field"
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER
			-- Type of generic parameter in `obj' at position `pos'.
		external
			"C (int16, EIF_REFERENCE, int): EIF_INTEGER | %"eif_gen_conf.h%""
		end

	c_new_instance_of (type_id: INTEGER): ANY
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.	
		external
			"C macro use %"eif_macros.h%""
		alias
			"RTLN"
		end
		
	c_set_dynamic_type (obj: POINTER; dtype: INTEGER)
			-- Set `obj' dynamic type to `dtype'.
		external
			"C signature (EIF_REFERENCE, EIF_INTEGER) use %"eif_internal.h%""
		alias
			"eif_set_dynamic_type"
		end

	c_eif_special_any_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		external
			"C signature (EIF_INTEGER): EIF_BOOLEAN use %"eif_internal.h%""
		alias
			"eif_special_any_type"
		end

	c_eif_is_special_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type or
			-- a basic type.
		external
			"C signature (EIF_INTEGER): BOOLEAN use %"eif_internal.h%""
		alias
			"eif_is_special_type"
		end

	c_type_conforms_to (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		external
			"C signature (int16, int16): EIF_BOOLEAN use %"eif_gen_conf.h%""
		alias
			"eif_gen_conf"
		end
		
	c_is_marked (obj: POINTER): BOOLEAN
		external
			"C macro signature (EIF_REFERENCE): EIF_BOOLEAN use %"eif_internal.h%""
		alias
			"ei_is_marked"
		end

	c_unmark (obj: POINTER)
		external
			"C macro signature (EIF_REFERENCE) use %"eif_internal.h%""
		alias
			"ei_unmark"
		end

	c_mark (obj: POINTER)
		external
			"C macro signature (EIF_REFERENCE) use %"eif_internal.h%""
		alias
			"ei_mark"
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTERNAL
