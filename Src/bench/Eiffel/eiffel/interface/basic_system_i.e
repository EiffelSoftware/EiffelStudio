indexing
	description: "Basic classes in a system"
	date: "$Date$"
	revision: "$Revision$"

deferred class BASIC_SYSTEM_I 

feature -- Generation type

	il_generation: BOOLEAN is
		deferred
		end

feature -- Access

	any_class, system_object_class: CLASS_I
			-- Class ANY

	ancestor_class_to_all_classes: CLASS_I is
		do
			if il_generation then
				Result := system_object_class
			else
				Result := any_class
			end
		ensure
			result_not_void: Result /= Void
		end

	boolean_class: CLASS_I
			-- Class BOOLEAN

	character_class: CLASS_I
			-- Class CHARACTER

	wide_char_class: CLASS_I
			-- Class UNICODE_CHARACTER

	integer_8_class, integer_16_class,
	integer_32_class, integer_64_class: CLASS_I
			-- Class INTEGER 8, 16, 32 and 64 btis

	real_class: CLASS_I
			-- Class REAL

	double_class: CLASS_I
			-- Class DOUBLE

	pointer_class: CLASS_I
			-- Class POINTER

	string_class, system_string_class: CLASS_I
			-- Class STRING

	array_class: CLASS_I
			-- Class ARRAY

	special_class, to_special_class, native_array_class: CLASS_I
			-- Class SPECIAL, TO_SPECIAL and NATIVE_ARRAY

	bit_class: CLASS_I
			-- Class BIT_REF

	character_ref_class: CLASS_I
			-- Class CHARACTER_REF

	wide_char_ref_class: CLASS_I
			-- Class UNICODE_CHARACTER_REF

	boolean_ref_class: CLASS_I
			-- Class BOOLEAN_REF

	integer_8_ref_class, integer_16_ref_class,
	integer_32_ref_class, integer_64_ref_class: CLASS_I
			-- Class INTEGER_REF 8, 16, 32 and 64 bits

	real_ref_class: CLASS_I
			-- Class REAL_REF

	double_ref_class: CLASS_I
			-- Class DOUBLE_REF

	pointer_ref_class: CLASS_I
			-- Class POINTER_REF

	memory_class_i: CLASS_I
			-- Class MEMORY

	tuple_class: CLASS_I
			-- Class TUPLE

	routine_class: CLASS_I
			-- Class ROUTINE

	procedure_class: CLASS_I
			-- Class PROCEDURE

	function_class: CLASS_I
			-- Class FUNCTION

	ancestor_class_to_all_classes_id: INTEGER is
		do
			if il_generation then
				Result := system_object_id
			else
				Result := any_id
			end
		ensure
			valid_result: Result > 0
		end

	any_id: INTEGER is
			-- Id of class ANY
		require
			any_class_exists: any_class /= Void
			compiled: any_class.compiled
		do
			Result := any_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	system_object_id: INTEGER is
			-- Id of class SYSTEM_OBJECT
		require
			system_object_class_exists: system_object_class /= Void
			compiled: system_object_class.compiled
		do
			Result := system_object_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	array_id: INTEGER is
			-- Id of class ARRAY
		require
			array_class_exists: array_class /= Void
			compiled: array_class.compiled
		do
			Result := array_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	string_id: INTEGER is
			-- Id of class STRING
		require
			string_class_exists: string_class /= Void
			compiled: string_class.compiled
		do
			Result := string_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	special_id: INTEGER is
			-- Id of class SPECIAL
		require
			special_class_exists: special_class /= Void
			compiled: special_class.compiled
		do
			Result := special_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	to_special_id: INTEGER is
			-- Id of class TO_SPECIAL
		require
			to_special_class_exists: to_special_class /= Void
			compiled: to_special_class.compiled
		do
			Result := to_special_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	bit_id: INTEGER is
			-- Id of class BIT_REF
		require
			bit_class_exists: bit_class /= Void
			compiled: bit_class.compiled
		do
			Result := bit_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	tuple_id: INTEGER is
			-- Id of class TUPLE
		require
			tuple_class_exists: tuple_class /= Void
			compiled: tuple_class.compiled
		do
			Result := tuple_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	routine_class_id: INTEGER is
			-- Id of class ROUTINE
		require
			routine_class_exists: routine_class /= Void
			compiled: routine_class.compiled
		do
			Result := routine_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	procedure_class_id: INTEGER is
			-- Id of class PROCEDURE
		require
			procedure_class_exists: procedure_class /= Void
			compiled: procedure_class.compiled
		do
			Result := procedure_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	function_class_id: INTEGER is
			-- Id of class FUNCTION
		require
			function_class_exists: function_class /= Void
			compiled: function_class.compiled
		do
			Result := function_class.compiled_class.class_id
		ensure
			valid_result: Result > 0
		end

	pointer_ref_dtype: INTEGER is
			-- Id of class POINTER_REF
		require
			pointer_ref_class_exists: pointer_ref_class /= Void
			compiled: pointer_ref_class.compiled
		do
			Result := pointer_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	double_ref_dtype: INTEGER is
			-- Dynamic type_id of class DOUBLE_REF
		require
			double_ref_class_exists: double_ref_class /= Void
			compiled: double_ref_class.compiled
		do
			Result := double_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	real_ref_dtype: INTEGER is
			-- Dynamic type_id of class REAL_REF
		require
			real_ref_class_exists: real_ref_class /= Void
			compiled: real_ref_class.compiled
		do
			Result := real_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	integer_ref_dtype (n: INTEGER): INTEGER is
			-- Dynamic type_id of class INTEGER_REF with `n' bits.
		require
			int_ref_class_exists: integer_8_ref_class /= Void and then
						integer_16_ref_class /= Void and then
						integer_32_ref_class /= Void and then
						integer_64_ref_class /= Void
			compiled: integer_8_ref_class.compiled and then
						integer_16_ref_class.compiled and then
						integer_32_ref_class.compiled and then
						integer_64_ref_class.compiled
		do
			inspect n
			when 8 then Result := integer_8_ref_class.compiled_class.types.first.type_id
			when 16 then Result := integer_16_ref_class.compiled_class.types.first.type_id
			when 32 then Result := integer_32_ref_class.compiled_class.types.first.type_id
			when 64 then Result := integer_64_ref_class.compiled_class.types.first.type_id
			end
		ensure
			valid_result: Result > 0
		end

	boolean_ref_dtype: INTEGER is
			-- Dynamic type_id of class BOOLEAN_REF
		require
			bool_ref_class_exists: boolean_ref_class /= Void
			compiled: boolean_ref_class.compiled
		do
			Result := boolean_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	character_ref_dtype: INTEGER is
			-- Dynamic type_id of class CHARACTER_REF
		require
			char_ref_class_exists: character_ref_class /= Void
			compiled: character_ref_class.compiled
		do
			Result := character_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

	wide_char_ref_dtype: INTEGER is
			-- Dynamic type_id of class UNICODE_CHARACTER_REF
		require
			unicode_char_ref_class_exists: wide_char_ref_class /= Void
			compiled: wide_char_ref_class.compiled
		do
			Result := wide_char_ref_class.compiled_class.types.first.type_id
		ensure
			valid_result: Result > 0
		end

feature -- Settings
	set_any_class (c: CLASS_I) is
			-- Assign `c' to `any_class'.
		require
			c_not_void: c /= Void
		do
			any_class := c
		ensure
			any_class_set: any_class = c
		end

	set_system_object_class (c: CLASS_I) is
			-- Assign `c' to `system_object_class
		require
			c_not_void: c /= Void
		do
			system_object_class := c
		ensure
			system_object_class_set: system_object_class = c
		end

	set_boolean_class (c: CLASS_I) is
			-- Assign `c' to `boolean_class'.
		require
			c_not_void: c /= Void
		do
			boolean_class := c
		ensure
			boolean_class_set: boolean_class = c
		end

	set_character_class (c: CLASS_I; is_wide: BOOLEAN) is
			-- Assign `c' to `character_class'.
		require
			c_not_void: c /= Void
		do
			if is_wide then
				wide_char_class := c
			else
				character_class := c
			end
		ensure
			wide_char_set: is_wide implies wide_char_class = c
			char_set: not is_wide implies character_class = c
		end

	set_integer_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_class'.
		require
			c_not_void: c /= Void
		do
			inspect n
			when 8 then integer_8_class := c
			when 16 then integer_16_class := c
			when 32 then integer_32_class := c
			when 64 then integer_64_class := c
			end
		ensure
			integer_8_class_set: n = 8 implies integer_8_class = c
			integer_16_class_set: n = 16 implies integer_16_class = c
			integer_32_class_set: n = 32 implies integer_32_class = c
			integer_64_class_set: n = 64 implies integer_64_class = c
		end

	set_real_class (c: CLASS_I) is
			-- Assign `c' to `real_class'.
		require
			c_not_void: c /= Void
		do
			real_class := c
		ensure
			real_class_set: real_class = c
		end

	set_double_class (c: CLASS_I) is
			-- Assign `c' to `double_class'.
		require
			c_not_void: c /= Void
		do
			double_class := c
		ensure
			double_class_set: double_class = c
		end

	set_pointer_class (c: CLASS_I) is
			-- Assign `c' to `pointer_class'.
		require
			c_not_void: c /= Void
		do
			pointer_class := c
		ensure
			pointer_class_set: pointer_class = c
		end

	set_string_class (c: CLASS_I) is
			-- Assign `c' to `string_class'.
		require
			c_not_void: c /= Void
		do
			string_class := c
		ensure
			string_class_set: string_class = c
		end

	set_system_string_class (c: CLASS_I) is
			-- Assign `c' to `system_string_class'.
		require
			c_not_void: c /= Void
		do
			system_string_class := c
		ensure
			system_string_class_set: system_string_class = c
		end

	set_array_class (c: CLASS_I) is
			-- Assign `c' to `array_class'.
		require
			c_not_void: c /= Void
		do
			array_class := c
		ensure
			array_class_set: array_class = c
		end

	set_special_class (c: CLASS_I) is
			-- Assign `c' to `special_class'.
		require
			c_not_void: c /= Void
		do
			special_class := c
		ensure
			special_class_set: special_class = c
		end

	set_to_special_class (c: CLASS_I) is
			-- Assign `c' to `to_special_class'.
		require
			c_not_void: c /= Void
		do
			to_special_class := c
		ensure
			to_special_class_set: to_special_class = c
		end

	set_native_array_class (c: CLASS_I) is
			-- Assign `c' to `native_array_class'.
		require
			c_not_void: c /= Void
		do
			native_array_class := c
		ensure
			native_array_class_set: native_array_class = c
		end

	set_bit_class (c: CLASS_I) is
			-- Assign `c' to `bit_class'.
		require
			c_not_void: c /= Void
		do
			bit_class := c
		ensure
			bit_class_set: bit_class = c
		end

	set_character_ref_class (c: CLASS_I; is_wide: BOOLEAN) is
			-- Assign `c' to `character_ref_class'.
		require
			c_not_void: c /= Void
		do
			if is_wide then
				wide_char_ref_class := c
			else
				character_ref_class := c
			end
		ensure
			wide_char_ref_set: is_wide implies wide_char_ref_class = c
			char_ref_set: not is_wide implies character_ref_class = c
		end

	set_boolean_ref_class (c: CLASS_I) is
			-- Assign `c' to `boolean_ref_class'.
		require
			c_not_void: c /= Void
		do
			boolean_ref_class := c
		ensure
			boolean_ref_class_set: boolean_ref_class = c
		end

	set_integer_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_ref_class'.
		require
			c_not_void: c /= Void
		do
			inspect n
			when 8 then integer_8_ref_class := c
			when 16 then integer_16_ref_class := c
			when 32 then integer_32_ref_class := c
			when 64 then integer_64_ref_class := c
			end
		ensure
			integer_8_ref_class_set: n = 8 implies integer_8_ref_class = c
			integer_16_ref_class_set: n = 16 implies integer_16_ref_class = c
			integer_32_ref_class_set: n = 32 implies integer_32_ref_class = c
			integer_64_ref_class_set: n = 64 implies integer_64_ref_class = c
		end

	set_real_ref_class (c: CLASS_I) is
			-- Assign `c' to `real_ref_class'.
		require
			c_not_void: c /= Void
		do
			real_ref_class := c
		ensure
			real_ref_class_set: real_ref_class = c
		end

	set_double_ref_class (c: CLASS_I) is
			-- Assign `c' to `double_ref_class'.
		require
			c_not_void: c /= Void
		do
			double_ref_class := c
		ensure
			double_ref_class_set: double_ref_class = c
		end

	set_pointer_ref_class (c: CLASS_I) is
			-- Assign `c' to `pointer_ref_class'.
		require
			c_not_void: c /= Void
		do
			pointer_ref_class := c
		ensure
			pointer_ref_class_set: pointer_ref_class = c
		end

	set_memory_class_i (c: CLASS_I) is
			-- Assign `c' to `memory_class_i'.
		require
			c_not_void: c /= Void
		do
			memory_class_i := c
		ensure
			memory_class_set: memory_class_i = c
		end

	set_tuple_class (c: CLASS_I) is
			-- Assign `c' to `tuple_class'.
		require
			c_not_void: c /= Void
		do
			tuple_class := c
		ensure
			tuple_class_set: tuple_class = c
		end

	set_routine_class (c: CLASS_I) is
			-- Assign `c' to `routine_class'.
		require
			c_not_void: c /= Void
		do
			routine_class := c
		ensure
			routine_class_set: routine_class = c
		end

	set_procedure_class (c: CLASS_I) is
			-- Assign `c' to `procedure_class'.
		require
			c_not_void: c /= Void
		do
			procedure_class := c
		ensure
			procedure_class_set: procedure_class = c
		end

	set_function_class (c: CLASS_I) is
			-- Assign `c' to `function_class'.
		require
			c_not_void: c /= Void
		do
			function_class := c
		ensure
			function_class_set: function_class = c
		end

end -- class BASIC_SYSTEM_I
