-- Basic classes in a system

class BASIC_SYSTEM_I 

feature 

	any_class: CLASS_I
			-- Class ANY

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

	string_class: CLASS_I
			-- Class STRING

	array_class: CLASS_I
			-- Class ARRAY

	special_class: CLASS_I
			-- Class SPECIAL

	to_special_class: CLASS_I
			-- Class TO_SPECIAL

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

	set_any_class (c: CLASS_I) is
			-- Assign `c' to `any_class'.
		do
			any_class := c
		end

	set_boolean_class (c: CLASS_I) is
			-- Assign `c' to `boolean_class'.
		do
			boolean_class := c
		end

	set_character_class (c: CLASS_I; is_wide: BOOLEAN) is
			-- Assign `c' to `character_class'.
		do
			if is_wide then
				wide_char_class := c
			else
				character_class := c
			end
		end

	set_integer_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_class'.
		do
			inspect n
			when 8 then integer_8_class := c
			when 16 then integer_16_class := c
			when 32 then integer_32_class := c
			when 64 then integer_64_class := c
			end
		end

	set_real_class (c: CLASS_I) is
			-- Assign `c' to `real_class'.
		do
			real_class := c
		end

	set_double_class (c: CLASS_I) is
			-- Assign `c' to `double_class'.
		do
			double_class := c
		end

	set_pointer_class (c: CLASS_I) is
			-- Assign `c' to `pointer_class'.
		do
			pointer_class := c
		end

	set_string_class (c: CLASS_I) is
			-- Assign `c' to `string_class'.
		do
			string_class := c
		end

	set_array_class (c: CLASS_I) is
			-- Assign `c' to `array_class'.
		do
			array_class := c
		end

	set_special_class (c: CLASS_I) is
			-- Assign `c'to `special_class'.
		do
			special_class := c
		end

	set_to_special_class (c: CLASS_I) is
			-- Assign `c' to `to_special_class'.
		do
			to_special_class := c
		end

	set_bit_class (c: CLASS_I) is
			-- Assign `c' to `bit_class'.
		do
			bit_class := c
		end

	set_character_ref_class (c: CLASS_I; is_wide: BOOLEAN) is
			-- Assign `c' to `character_ref_class'.
		do
			if is_wide then
				wide_char_ref_class := c
			else
				character_ref_class := c
			end
		end

	set_boolean_ref_class (c: CLASS_I) is
			-- Assign `c' to `boolean_ref_class'.
		do
			boolean_ref_class := c
		end

	set_integer_ref_class (c: CLASS_I; n: INTEGER) is
			-- Assign `c' to `integer_n_ref_class'.
		do
			inspect n
			when 8 then integer_8_ref_class := c
			when 16 then integer_16_ref_class := c
			when 32 then integer_32_ref_class := c
			when 64 then integer_64_ref_class := c
			end
		end

	set_real_ref_class (c: CLASS_I) is
			-- Assign `c' to `real_ref_class'.
		do
			real_ref_class := c
		end

	set_double_ref_class (c: CLASS_I) is
			-- Assign `c' to `double_ref_class'.
		do
			double_ref_class := c
		end

	set_pointer_ref_class (c: CLASS_I) is
			-- Assign `c' to `pointer_ref_class'.
		do
			pointer_ref_class := c
		end

	set_memory_class_i (c: CLASS_I) is
			-- Assign `c' to `memory_class_i'.
		do
			memory_class_i := c
		end

	set_tuple_class (c: CLASS_I) is
			-- Assign `c' to `tuple_class'.
		do
			tuple_class := c
		end

	set_routine_class (c: CLASS_I) is
			-- Assign `c' to `routine_class'.
		do
			routine_class := c
		end

	set_procedure_class (c: CLASS_I) is
			-- Assign `c' to `procedure_class'.
		do
			procedure_class := c
		end

	set_function_class (c: CLASS_I) is
			-- Assign `c' to `function_class'.
		do
			function_class := c
		end

	any_id: INTEGER is
			-- Id of class ANY
		require
			any_class_exists: any_class /= Void
			compiled: any_class.compiled
		do
			Result := any_class.compiled_class.class_id
		end

	array_id: INTEGER is
			-- Id of class ARRAY
		require
			array_class_exists: array_class /= Void
			compiled: array_class.compiled
		do
			Result := array_class.compiled_class.class_id
		end

	string_id: INTEGER is
			-- Id of class STRING
		require
			string_class_exists: string_class /= Void
			compiled: string_class.compiled
		do
			Result := string_class.compiled_class.class_id
		end; -- string_id

	special_id: INTEGER is
			-- Id of class SPECIAL
		require
			special_class_exists: special_class /= Void
			compiled: special_class.compiled
		do
			Result := special_class.compiled_class.class_id
		end; -- special_id

	to_special_id: INTEGER is
			-- Id of class TO_SPECIAL
		require
			to_special_class_exists: to_special_class /= Void
			compiled: to_special_class.compiled
		do
			Result := to_special_class.compiled_class.class_id
		end; -- to_special_id

	bit_id: INTEGER is
			-- Id of class BIT_REF
		require
			bit_class_exists: bit_class /= Void
			compiled: bit_class.compiled
		do
			Result := bit_class.compiled_class.class_id
		end; -- bit_id

	tuple_id: INTEGER is
			-- Id of class TUPLE
		require
			tuple_class_exists: tuple_class /= Void
			compiled: tuple_class.compiled
		do
			Result := tuple_class.compiled_class.class_id
		end

	routine_class_id: INTEGER is
			-- Id of class ROUTINE
		require
			routine_class_exists: routine_class /= Void
			compiled: routine_class.compiled
		do
			Result := routine_class.compiled_class.class_id
		end

	procedure_class_id: INTEGER is
			-- Id of class PROCEDURE
		require
			procedure_class_exists: procedure_class /= Void
			compiled: procedure_class.compiled
		do
			Result := procedure_class.compiled_class.class_id
		end

	function_class_id: INTEGER is
			-- Id of class FUNCTION
		require
			function_class_exists: function_class /= Void
			compiled: function_class.compiled
		do
			Result := function_class.compiled_class.class_id
		end

	pointer_ref_dtype: INTEGER is
			-- Id of class POINTER_REF
		require
			pointer_ref_class_exists: pointer_ref_class /= Void
			compiled: pointer_ref_class.compiled
		do
			Result := pointer_ref_class.compiled_class.types.first.type_id
		end; 

	double_ref_dtype: INTEGER is
			-- Dynamic type_id of class DOUBLE_REF
		require
			double_ref_class_exists: double_ref_class /= Void
			compiled: double_ref_class.compiled
		do
			Result := double_ref_class.compiled_class.types.first.type_id
		end; 

	real_ref_dtype: INTEGER is
			-- Dynamic type_id of class REAL_REF
		require
			real_ref_class_exists: real_ref_class /= Void
			compiled: real_ref_class.compiled
		do
			Result := real_ref_class.compiled_class.types.first.type_id
		end; 

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
		end; 

	boolean_ref_dtype: INTEGER is
			-- Dynamic type_id of class BOOLEAN_REF
		require
			bool_ref_class_exists: boolean_ref_class /= Void
			compiled: boolean_ref_class.compiled
		do
			Result := boolean_ref_class.compiled_class.types.first.type_id
		end; 

	character_ref_dtype: INTEGER is
			-- Dynamic type_id of class CHARACTER_REF
		require
			char_ref_class_exists: character_ref_class /= Void
			compiled: character_ref_class.compiled
		do
			Result := character_ref_class.compiled_class.types.first.type_id
		end; 

	wide_char_ref_dtype: INTEGER is
			-- Dynamic type_id of class UNICODE_CHARACTER_REF
		require
			unicode_char_ref_class_exists: wide_char_ref_class /= Void
			compiled: wide_char_ref_class.compiled
		do
			Result := wide_char_ref_class.compiled_class.types.first.type_id
		end; 

end -- class BASIC_SYSTEM_I
