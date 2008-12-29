note
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

inherit
	INTERNAL_HELPER

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := c_type_conforms_to ({ISE_RUNTIME}.dynamic_type ($object), type_id)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		do
			Result := c_type_conforms_to (type1, type2)
		end

feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
			class_type_not_empty: not class_type.is_empty
			is_valid_type_string: is_valid_type_string (class_type)
		local
			l_cstr: C_STRING
			l_table: like internal_dynamic_type_string_table
			l_pre_ecma_status: BOOLEAN
		do
			l_table := internal_dynamic_type_string_table
			l_table.search (class_type)
			if l_table.found then
				Result := l_table.found_item
			else
				create l_cstr.make (class_type)
					-- Take into consideration possible pre-ECMA mapping.
				l_pre_ecma_status := {ISE_RUNTIME}.pre_ecma_mapping_status
				{ISE_RUNTIME}.set_pre_ecma_mapping (not is_pre_ecma_mapping_disabled)
				Result := {ISE_RUNTIME}.type_id_from_name (l_cstr.item)
				{ISE_RUNTIME}.set_pre_ecma_mapping (l_pre_ecma_status)
				l_table.put (Result, class_type)
			end
		ensure
			dynamic_type_from_string_valid: Result = -1 or Result = none_type or Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.
		require
			type_id_nonnegative: type_id >= 0
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
			-- basic type, use `SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		do
			create Result.make (count)
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
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_special_any_type (type_id)
		end

	is_special_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_is_special_type (type_id)
		end

	is_special (object: ANY): BOOLEAN
			-- Is `object' a special object?
		require
			object_not_void: object /= Void
		do
			Result := c_is_special ($object)
		end

	is_tuple (object: ANY): BOOLEAN
			-- Is `object' a TUPLE object?
		require
			object_not_void: object /= Void
		do
			Result := c_is_tuple ($object)
		end

	is_tuple_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent a TUPLE?
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_is_tuple_type (type_id)
		end

	is_marked (obj: ANY): BOOLEAN
			-- Is `obj' marked?
		require
			object_exists: obj /= Void
		do
			Result := c_is_marked ($obj)
		end

feature -- Access

	none_type: INTEGER = -2
			-- Type ID representation for NONE.

	Pointer_type: INTEGER = 0

	Reference_type: INTEGER = 1

	character_8_type, Character_type: INTEGER = 2

	Boolean_type: INTEGER = 3

	Integer_type, integer_32_type: INTEGER = 4

	Real_type, real_32_type: INTEGER = 5

	Double_type, real_64_type: INTEGER = 6

	Expanded_type: INTEGER = 7

	Bit_type: INTEGER = 8

	Integer_8_type: INTEGER = 9

	Integer_16_type: INTEGER = 10

	Integer_64_type: INTEGER = 11

	character_32_type, Wide_character_type: INTEGER = 12

	natural_8_type: INTEGER = 13

	natural_16_type: INTEGER = 14

	natural_32_type: INTEGER = 15

	natural_64_type: INTEGER = 16

	max_predefined_type: INTEGER = 16

	class_name (object: ANY): STRING
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end

	class_name_of_type (type_id: INTEGER): STRING
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
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
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := {ISE_RUNTIME}.c_generating_type_of_type (type_id)
		end

	dynamic_type (object: ANY): INTEGER
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := {ISE_RUNTIME}.dynamic_type ($object)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_count (obj: ANY): INTEGER
			-- Number of generic parameter in `obj'.
		require
			obj_not_void: obj /= Void
		do
			Result := eif_gen_count_with_dftype ({ISE_RUNTIME}.dynamic_type ($obj))
		end

	generic_count_of_type (type_id: INTEGER): INTEGER
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := eif_gen_count_with_dftype (type_id)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_not_void: object /= Void
			object_generic: generic_count (object) > 0
			i_valid: i > 0 and i <= generic_count (object)
		do
			Result := eif_gen_param_id (- 1, {ISE_RUNTIME}.dynamic_type ($object), i)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_dynamic_type_of_type (type_id: INTEGER; i: INTEGER): INTEGER
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		do
			Result := eif_gen_param_id (- 1, type_id, i)
		ensure
			dynamic_type_nonnegative: Result >= 0
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
			type_id_nonnegative: type_id >= 0
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
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_type_of_type (i - 1, type_id)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_static_type_of_type (i - 1, type_id)
		ensure
			field_type_nonnegative: Result >= 0
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

	character_8_field, character_field (i: INTEGER; object: ANY): CHARACTER_8
			-- CHARACTER_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_8_field: field_type (i, object) = Character_8_type
		do
			Result := c_character_8_field (i - 1, $object)
		end

	character_32_field (i: INTEGER; object: ANY): CHARACTER_32
			-- CHARACTER_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_32_field: field_type (i, object) = Character_32_type
		do
			Result := c_character_32_field (i - 1, $object)
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

	natural_8_field (i: INTEGER; object: ANY): NATURAL_8
			-- NATURAL_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			Result := c_natural_8_field (i - 1, $object)
		end

	natural_16_field (i: INTEGER; object: ANY): NATURAL_16
			-- NATURAL_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			Result := c_natural_16_field (i - 1, $object)
		end

	natural_32_field (i: INTEGER; object: ANY): NATURAL_32
			-- NATURAL_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			Result := c_natural_32_field (i - 1, $object)
		end

	natural_64_field (i: INTEGER; object: ANY): NATURAL_64
			-- NATURAL_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			Result := c_natural_64_field (i - 1, $object)
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8
			-- INTEGER_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result := c_integer_8_field (i - 1, $object)
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16
			-- INTEGER_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result := c_integer_16_field (i - 1, $object)
		end

	integer_field, integer_32_field (i: INTEGER; object: ANY): INTEGER
			-- INTEGER_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			Result := c_integer_32_field (i - 1, $object)
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64
			-- INTEGER_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result := c_integer_64_field (i - 1, $object)
		end

	real_32_field, real_field (i: INTEGER; object: ANY): REAL
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			Result := c_real_32_field (i - 1, $object)
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

	real_64_field, double_field (i: INTEGER; object: ANY): DOUBLE
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			Result := c_real_64_field (i - 1, $object)
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
			value_conforms_to_field_static_type:
				value /= Void implies
					type_conforms_to (dynamic_type (value),
						field_static_type_of_type (i, dynamic_type (object)))
		do
			c_set_reference_field (i - 1, $object, $value)
		end

	set_real_64_field, set_double_field (i: INTEGER; object: ANY; value: DOUBLE)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			c_set_real_64_field (i - 1, $object, value)
		end

	set_character_8_field, set_character_field (i: INTEGER; object: ANY; value: CHARACTER_8)
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_8_type
		do
			c_set_character_8_field (i - 1, $object, value)
		end

	set_character_32_field (i: INTEGER; object: ANY; value: CHARACTER_32)
			-- Set character 32 value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_32_type
		do
			c_set_character_32_field (i - 1, $object, value)
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

	set_natural_8_field (i: INTEGER; object: ANY; value: NATURAL_8)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			c_set_natural_8_field (i - 1, $object, value)
		end

	set_natural_16_field (i: INTEGER; object: ANY; value: NATURAL_16)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			c_set_natural_16_field (i - 1, $object, value)
		end

	set_natural_32_field (i: INTEGER; object: ANY; value: NATURAL_32)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			c_set_natural_32_field (i - 1, $object, value)
		end

	set_natural_64_field (i: INTEGER; object: ANY; value: NATURAL_64)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			c_set_natural_64_field (i - 1, $object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			c_set_integer_8_field (i - 1, $object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			c_set_integer_16_field (i - 1, $object, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; object: ANY; value: INTEGER)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			c_set_integer_32_field (i - 1, $object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			c_set_integer_64_field (i - 1, $object, value)
		end

	set_real_32_field, set_real_field (i: INTEGER; object: ANY; value: REAL)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			c_set_real_32_field (i - 1, $object, value)
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
		require
			type_id_nonnegative: type_id >= 0
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
			-- Mark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_not_marked: not is_marked (obj)
		do
			c_mark ($obj)
		ensure
			is_marked: is_marked (obj)
		end

	unmark (obj: ANY)
			-- Unmark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_marked: is_marked (obj)
		do
			c_unmark ($obj)
		ensure
			is_not_marked: not is_marked (obj)
		end

	lock_marking
			-- Get a lock on `mark' and `unmark' routine so that 2 threads cannot `mark' and
			-- `unmark' at the same time.
		external
			"C blocking use %"eif_traverse.h%""
		alias
			"eif_lock_marking"
		end

	unlock_marking
			-- Release a lock on `mark' and `unmark', so that another thread can
			-- use `mark' and `unmark'.
		external
			"C use %"eif_traverse.h%""
		alias
			"eif_unlock_marking"
		end

feature {NONE} -- Cached data

	internal_dynamic_type_string_table: HASH_TABLE [INTEGER, STRING]
			-- Table of dynamic type indexed by type name
		once
			create Result.make (100)
		ensure
			internal_dynamic_type_string_table_not_void: Result /= Void
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

	c_character_8_field (i: INTEGER; object: POINTER): CHARACTER_8
			-- Character value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_CHARACTER use %"eif_internal.h%""
		alias
			"ei_char_field"
		end

	c_character_32_field (i: INTEGER; object: POINTER): CHARACTER_32
			-- Character value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_WIDE_CHAR use %"eif_internal.h%""
		alias
			"ei_char_32_field"
		end

	c_boolean_field (i: INTEGER; object: POINTER): BOOLEAN
			-- Boolean value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_BOOLEAN use %"eif_internal.h%""
		alias
			"ei_bool_field"
		end

	c_natural_8_field (i: INTEGER; object: POINTER): NATURAL_8
			-- NATURAL_8 value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_NATURAL_8 use %"eif_internal.h%""
		alias
			"ei_uint_8_field"
		end

	c_natural_16_field (i: INTEGER; object: POINTER): NATURAL_16
			-- NATURAL_16 value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_NATURAL_16 use %"eif_internal.h%""
		alias
			"ei_uint_16_field"
		end

	c_natural_32_field (i: INTEGER; object: POINTER): NATURAL_32
			-- NATURAL_32 value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_NATURAL_32 use %"eif_internal.h%""
		alias
			"ei_uint_32_field"
		end

	c_natural_64_field (i: INTEGER; object: POINTER): NATURAL_64
			-- NATURAL_64 value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_NATURAL_64 use %"eif_internal.h%""
		alias
			"ei_uint_64_field"
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

	c_integer_32_field (i: INTEGER; object: POINTER): INTEGER
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_int_32_field"
		end

	c_integer_64_field (i: INTEGER; object: POINTER): INTEGER_64
			-- Integer value of `i'-th field of `object'
		external
			"C macro signature (long, EIF_REFERENCE): EIF_INTEGER_64 use %"eif_internal.h%""
		alias
			"ei_int_64_field"
		end

	c_real_32_field (i: INTEGER; object: POINTER): REAL
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

	c_real_64_field (i: INTEGER; object: POINTER): DOUBLE
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

	c_is_tuple (object: POINTER): BOOLEAN
			-- Is `object' a TUPLE object?
		external
			"C (EIF_REFERENCE): EIF_BOOLEAN | %"eif_internal.h%""
		alias
			"ei_tuple"
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

	c_set_real_64_field (i: INTEGER; object: POINTER; value: DOUBLE)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_DOUBLE) use %"eif_internal.h%""
		alias
			"ei_set_double_field"
		end

	c_set_character_8_field (i: INTEGER; object: POINTER; value: CHARACTER_8)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_CHARACTER) use %"eif_internal.h%""
		alias
			"ei_set_char_field"
		end

	c_set_character_32_field (i: INTEGER; object: POINTER; value: CHARACTER_32)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_CHARACTER) use %"eif_internal.h%""
		alias
			"ei_set_char_32_field"
		end

	c_set_boolean_field (i: INTEGER; object: POINTER; value: BOOLEAN)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_BOOLEAN) use %"eif_internal.h%""
		alias
			"ei_set_boolean_field"
		end

	c_set_natural_8_field (i: INTEGER; object: POINTER; value: NATURAL_8)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_NATURAL_8) use %"eif_internal.h%""
		alias
			"ei_set_natural_8_field"
		end

	c_set_natural_16_field (i: INTEGER; object: POINTER; value: NATURAL_16)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_NATURAL_16) use %"eif_internal.h%""
		alias
			"ei_set_natural_16_field"
		end

	c_set_natural_32_field (i: INTEGER; object: POINTER; value: NATURAL_32)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_NATURAL_32) use %"eif_internal.h%""
		alias
			"ei_set_natural_32_field"
		end

	c_set_natural_64_field (i: INTEGER; object: POINTER; value: NATURAL_64)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_NATURAL_64) use %"eif_internal.h%""
		alias
			"ei_set_natural_64_field"
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

	c_set_integer_32_field (i: INTEGER; object: POINTER; value: INTEGER)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER) use %"eif_internal.h%""
		alias
			"ei_set_integer_32_field"
		end

	c_set_integer_64_field (i: INTEGER; object: POINTER; value: INTEGER_64)
		external
			"C macro signature (long, EIF_REFERENCE, EIF_INTEGER_64) use %"eif_internal.h%""
		alias
			"ei_set_integer_64_field"
		end

	c_set_real_32_field (i: INTEGER; object: POINTER; value: REAL)
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

	eif_gen_count_with_dftype (type_id: INTEGER): INTEGER
			-- Number of generic parameters of `obj'.
		external
			"C signature (int16): int use %"eif_gen_conf.h%""
		end

	eif_gen_param_id (stype: INTEGER; dftype: INTEGER; pos: INTEGER): INTEGER
			-- Type of generic parameter in `obj' at position `pos'.
		external
			"C (int16, int16, int): EIF_INTEGER | %"eif_gen_conf.h%""
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
			"RTLNSMART"
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

	c_eif_is_tuple_type (type_id: INTEGER): BOOLEAN
			-- Is type represented by `type_id' represent a TUPLE?
		external
			"C signature (EIF_INTEGER): BOOLEAN use %"eif_internal.h%""
		alias
			"eif_is_tuple_type"
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
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class INTERNAL
