indexing

	description:
		"[
		Access to internal object properties.
		This class may be used as ancestor by classes needing its
		facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
		do
			Result := c_is_instance_of (type_id, $object)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		external
			"C | %"eif_gen_conf.h%""
		alias
			"eif_gen_conf"
		end
		
feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER is
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
		local
			a: ANY
		do
			a := class_type.to_c
			Result := c_type_id ($a)
		ensure
			valid_result: Result = -1 or else Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTLN"
		end

feature -- Access

	Pointer_type: INTEGER is 0

	Reference_type: INTEGER is 1

	Character_type: INTEGER is 2

	Boolean_type: INTEGER is 3

	Integer_type: INTEGER is 4
	
	Integer_32_type: INTEGER is 4

	Real_type: INTEGER is 5

	Double_type: INTEGER is 6

	Expanded_type: INTEGER is 7

	Bit_type: INTEGER is 8

	Integer_8_type: INTEGER is 9

	Integer_16_type: INTEGER is 10

	Integer_64_type: INTEGER is 11

	Wide_character_type: INTEGER is 12

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := c_dynamic_type ($object)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		do
			Result := eif_gen_param_id (- 1, $object, i)
		end
		
	field (i: INTEGER; object: ANY): ANY is
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

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			create Result.make_from_c (c_field_name_of_type (i - 1, c_dynamic_type ($object)))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		do
			create Result.make_from_c (c_field_name_of_type (i - 1, type_id))
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := c_field_offset (i - 1, $object)
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := c_field_type_of_type (i - 1, c_dynamic_type ($object))
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Type of `i'-th field of dynamic type `type_id'
		require
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_type_of_type (i - 1, type_id)
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
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

	character_field (i: INTEGER; object: ANY): CHARACTER is
			-- Character value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			Result := c_character_field (i - 1, $object)
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result := c_boolean_field (i - 1, $object)
		end

	integer_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			Result := c_integer_field (i - 1, $object)
		end

	real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			Result := c_real_field (i - 1, $object)
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result := c_pointer_field (i - 1, $object)
		end

	double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			Result := c_double_field (i - 1, $object)
		end

feature -- Status report

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
			-- It only recognized a special object 
			-- initialized within a TO_SPECIAL object.
		require
			object_not_void: object /= Void
		do
			Result := c_is_special ($object)
		end

feature -- Version

	compiler_version: INTEGER is
		external
			"C [macro %"eif_project.h%"]"
		alias
			"egc_compiler_tag"
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
		do
			c_set_reference_field (i - 1, $object, $value)
		end

	set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			double_field: field_type (i, object) = Double_type
		do
			c_set_double_field (i - 1, $object, value)
		end

	set_character_field (i: INTEGER; object: ANY; value: CHARACTER) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_type
		do
			c_set_character_field (i - 1, $object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			c_set_boolean_field (i - 1, $object, value)
		end

	set_integer_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_field: field_type (i, object) = Integer_type
		do
			c_set_integer_field (i - 1, $object, value)
		end

	set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_field: field_type (i, object) = Real_type
		do
			c_set_real_field (i - 1, $object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			c_set_pointer_field (i - 1, $object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := field_count_of_type (c_dynamic_type ($object))
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of logical fields in dynamic type `type_id'.
		external
			"C macro signature (EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_count_field_of_type"
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
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

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := c_size ($object)
		end

feature {NONE} -- Implementation

	c_is_instance_of (type1: INTEGER; obj: POINTER): BOOLEAN is
			-- Is `obj' an instance of `type1'?
		external
			"C [macro %"eif_macros.h%"]"
		alias
			"RTRA"
		end

	c_dynamic_type (object: POINTER): INTEGER is
			-- Dynamic type of `object'
		external
			"C macro signature (EIF_REFERENCE): EIF_INTEGER use %"eif_macros.h%""
		alias
			"Dftype"
		end

	c_field (i: INTEGER; object: POINTER): ANY is
			-- Object referenced by the `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_REFERENCE | %"eif_internal.h%""
		alias
			"ei_field"
		end

	c_field_name_of_type (i: INTEGER; type_id: INTEGER): POINTER is
			-- C pointer to name of `i'-th field of `object'
		external
			"C macro signature (EIF_INTEGER, EIF_INTEGER): EIF_POINTER use %"eif_internal.h%""
		alias
			"ei_field_name_of_type"
		end

	c_field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Type of `i'-th field of dynamic type `type_id'
		external
			"C signature (long, EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_field_type_of_type"
		end

	c_expanded_type (i: INTEGER; object: POINTER): STRING is
			-- Class name of the `i'-th expanded field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_REFERENCE | %"eif_internal.h%""
		alias
			"ei_exp_type"
		end

	c_character_field (i: INTEGER; object: POINTER): CHARACTER is
			-- Character value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_CHARACTER | %"eif_internal.h%""
		alias
			"ei_char_field"
		end

	c_boolean_field (i: INTEGER; object: POINTER): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_BOOLEAN | %"eif_internal.h%""
		alias
			"ei_bool_field"
		end

	c_integer_field (i: INTEGER; object: POINTER): INTEGER is
			-- Integer value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_int_field"
		end

	c_real_field (i: INTEGER; object: POINTER): REAL is
			-- Real value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_REAL | %"eif_internal.h%""
		alias
			"ei_float_field"
		end

	c_pointer_field (i: INTEGER; object: POINTER): POINTER is
			-- Pointer value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_POINTER | %"eif_internal.h%""
		alias
			"ei_ptr_field"
		end

	c_double_field (i: INTEGER; object: POINTER): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_DOUBLE | %"eif_internal.h%""
		alias
			"ei_double_field"
		end

	c_is_special (object: POINTER): BOOLEAN is
			-- Is `object' a special object?
		external
			"C (EIF_REFERENCE): EIF_BOOLEAN | %"eif_internal.h%""
		alias
			"ei_special"
		end

	c_field_offset (i: INTEGER; object: POINTER): INTEGER is
			-- Offset of `i'-th field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_offset"
		end

	c_bit_size (i: INTEGER; object: POINTER): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		external
			"C (long, EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_bit_size"
		end

	c_size (object: POINTER): INTEGER is
			-- Physical size of `object'
		external
			"C (EIF_REFERENCE): EIF_INTEGER | %"eif_internal.h%""
		alias
			"ei_size"
		end

	c_set_reference_field (i: INTEGER; object: POINTER; value: POINTER) is
		external
			"C (long, EIF_REFERENCE, EIF_REFERENCE) | %"eif_internal.h%""
		alias
			"ei_set_reference_field"
		end

	c_set_double_field (i: INTEGER; object: POINTER; value: DOUBLE) is
		external
			"C (long, EIF_REFERENCE, EIF_DOUBLE) | %"eif_internal.h%""
		alias
			"ei_set_double_field"
		end

	c_set_character_field (i: INTEGER; object: POINTER; value: CHARACTER) is
		external
			"C (long, EIF_REFERENCE, EIF_CHARACTER) | %"eif_internal.h%""
		alias
			"ei_set_char_field"
		end

	c_set_boolean_field (i: INTEGER; object: POINTER; value: BOOLEAN) is
		external
			"C (long, EIF_REFERENCE, EIF_BOOLEAN) | %"eif_internal.h%""
		alias
			"ei_set_boolean_field"
		end

	c_set_integer_field (i: INTEGER; object: POINTER; value: INTEGER) is
		external
			"C (long, EIF_REFERENCE, EIF_INTEGER) | %"eif_internal.h%""
		alias
			"ei_set_integer_field"
		end

	c_set_real_field (i: INTEGER; object: POINTER; value: REAL) is
		external
			"C (long, EIF_REFERENCE, EIF_REAL) | %"eif_internal.h%""
		alias
			"ei_set_float_field"
		end

	c_set_pointer_field (i: INTEGER; object: POINTER; value: POINTER) is
		external
			"C (long, EIF_REFERENCE, EIF_POINTER) | %"eif_internal.h%""
		alias
			"ei_set_pointer_field"
		end

	c_type_id (s: POINTER): INTEGER is
		external
			"C (char *): EIF_INTEGER | %"eif_cecil.h%""
		alias
			"eif_type_id"
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
			-- Type of generic parameter in `obj' at position `pos'.
		external
			"C (int16, EIF_REFERENCE, int): EIF_INTEGER | %"eif_gen_conf.h%""
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
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
