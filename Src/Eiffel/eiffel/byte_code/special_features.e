note
	description: "Special optimization on calls where target is a basic type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	limitation: "We cannot handle `set_item', `copy', `standard_copy' or `deep_copy'%
			%because when called on attributes whose types are basic types we cannot%
			%store the result back to the attribute."

class SPECIAL_FEATURES

inherit
	BYTE_CONST

	SHARED_INCLUDE

	SHARED_WORKBENCH

feature -- Access

	has (feature_name_id: INTEGER; is_c_compilation: BOOLEAN; target_type: BASIC_A): BOOLEAN
			-- Does Current have `feature_name_id'?
		require
			valid_feature_name_id: feature_name_id > 0
		do
			if is_c_compilation then
				c_type_table.search (feature_name_id)
				if c_type_table.found then
					function_type := c_type_table.found_item
					if target_type.is_character_32 then
							-- Do not inline `lower', `upper' on CHARACTER 32 because the code is only
							-- provided in the Eiffel code.
						inspect function_type
						when lower_type, upper_type then
						else
							Result := True
						end
					else
						Result := True
					end
				end
			else
				byte_type_table.search (feature_name_id)
				if byte_type_table.found then
					function_type := byte_type_table.found_item
					Result := True
				end
			end
		end

feature -- Access code

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

feature -- Status

	valid_function_type (type: INTEGER): BOOLEAN
			-- Is `f' a valid function type supported by Current?
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- Byte code special generation

	make_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_A; result_type: TYPE_A)
			-- Generate byte code sequence that will be used with basic types.
		require
			basic_type_not_void: basic_type /= Void
			valid_function_type: valid_function_type (function_type)
		do
			inspect function_type
			when is_equal_type then
				ba.append (Bc_eq)
			when is_less_type then
				ba.append (bc_lt)
			when is_less_equal_type then
				ba.append (bc_le)
			when is_greater_type then
				ba.append (bc_gt)
			when is_greater_equal_type then
				ba.append (bc_ge)
			when to_character_8_type then
				check
					valid_type: type_of (basic_type) = integer_type_id or
						type_of (basic_type) = character_type_id
				end
				ba.append (bc_cast_char8)
			when to_character_32_type then
				check
					valid_type: type_of (basic_type) = integer_type_id or
						type_of (basic_type) = character_type_id
				end
				ba.append (bc_cast_char32)
			when as_natural_8_type, to_natural_8_type then
				ba.append (bc_cast_natural)
				ba.append_integer (8)
			when as_natural_16_type, to_natural_16_type then
				ba.append (bc_cast_natural)
				ba.append_integer (16)
			when as_natural_32_type, to_natural_32_type then
				ba.append (bc_cast_natural)
				ba.append_integer (32)
			when as_natural_64_type, to_natural_64_type then
				ba.append (bc_cast_natural)
				ba.append_integer (64)
			when as_integer_8_type, to_integer_8_type then
				ba.append (Bc_cast_integer)
				ba.append_integer (8)
			when as_integer_16_type, to_integer_16_type then
				ba.append (Bc_cast_integer)
				ba.append_integer (16)
			when as_integer_32_type, to_integer_32_type then
				ba.append (Bc_cast_integer)
				ba.append_integer (32)
			when as_integer_64_type, to_integer_64_type then
				ba.append (Bc_cast_integer)
				ba.append_integer (64)
			when to_real_64_type then
				ba.append (Bc_cast_real64)
			when to_real_32_type then
				ba.append (Bc_cast_real32)
			when floor_real_type then
				ba.append (bc_cast_real64)
				ba.append (bc_floor)
				if basic_type.is_real_32 then
					ba.append (bc_cast_real32)
				end
			when is_nan_type then
				ba.append (bc_basic_operations)
				ba.append (bc_is_nan)
			when is_negative_infinity_type then
				ba.append (bc_basic_operations)
				ba.append (bc_is_negative_infinity)
			when is_positive_infinity_type then
				ba.append (bc_basic_operations)
				ba.append (bc_is_positive_infinity)
			when nan_type then
				ba.append (bc_basic_operations)
				ba.append (bc_nan)
			when negative_infinity_type then
				ba.append (bc_basic_operations)
				ba.append (bc_negative_infinity)
			when positive_infinity_type then
				ba.append (bc_basic_operations)
				ba.append (bc_positive_infinity)
			when ceiling_real_type then
				ba.append (bc_cast_real64)
				ba.append (bc_ceil)
				if basic_type.is_real_32 then
					ba.append (bc_cast_real32)
				end
			when max_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_max)
			when min_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_min)
			when generator_type then
				ba.append (Bc_basic_operations)
				if
					attached result_type.actual_type as t and then
					t.has_associated_class and then
					attached system.string_32_class as s and then
					s.is_compiled and then
					t.base_class.class_id = s.compiled_class.class_id
				then
						-- Result is of type STRING_32.
					ba.append (bc_generator__s4)
				else
						-- Result is of type STRING_8.
					ba.append (bc_generator__s1)
				end
			when plus_type then
				if type_of (basic_type) = pointer_type_id then
					ba.append (Bc_basic_operations)
					ba.append (Bc_offset)
				else
					ba.append (Bc_plus)
				end
			when minus_type then
				if type_of (basic_type) = pointer_type_id then
					ba.append (bc_uminus)
					ba.append (Bc_basic_operations)
					ba.append (Bc_offset)
				else
					ba.append (Bc_minus)
				end
			when product_type then
				ba.append (bc_star)
			when quotient_type then
				ba.append (bc_slash)
			when integer_quotient_type then
				ba.append (bc_div)
			when integer_remainder_type then
				ba.append (bc_mod)
			when power_type then
				ba.append (bc_power)
			when zero_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_zero)
			when one_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_one)
			when default_type then
					-- We do not need target, so let's get rid of
					-- it for now.
				ba.append (bc_pop)
				ba.append_uint32_integer (1)
				basic_type.c_type.make_default_byte_code (ba)
			when negated_type then
				ba.append (bc_not)
			when opposite_type then
				ba.append (bc_uminus)
			when bit_and_type..bit_test_type, set_bit_with_mask_type, set_bit_type then
				check integer_type: type_of (basic_type) = integer_type_id end
				make_bit_operation_code (ba, function_type)
			when three_way_comparison_type then
				ba.append (bc_basic_operations)
				ba.append (bc_three_way_comparison)
			when identity_type, twin_type, as_attached_type then
					-- Nothing to do, top of the stack has correct value
			when do_nothing_type then
					-- We simply pop the top of the stack.
				ba.append (bc_pop)
				ba.append_uint32_integer (1)
			when is_default_pointer_type then
					-- We have the pointer on the stack, we load the default pointer
					-- type and then compare them for equality.
				basic_type.c_type.make_default_byte_code (ba)
				ba.append (bc_eq)
			when is_character_8_type then
					-- Check that the character code value is less than 255.
				check
					integer_type: type_of (basic_type) = character_type_id
				end
				ba.append (bc_wchar)
				ba.append_character_32 ({CHARACTER_8}.max_value.to_character_32)
				ba.append (bc_le)
			end
		end

feature -- C special code generation

	generate (basic_type: BASIC_A; target: REGISTRABLE; parameters: BYTE_LIST [PARAMETER_B]; result_type: TYPE_A; buffer: GENERATION_BUFFER)
		require
			valid_output_buffer: buffer /= Void
			valid_target: target /= Void
			valid_function_type: valid_function_type (function_type)
		local
			parameter: PARAMETER_BL
		do
			if attached parameters then
				parameter := {PARAMETER_BL} / parameters.first
				check
					paramater_attached: attached parameter
				end
			end
			inspect function_type
			when lower_type, upper_type then
				generate_lower_upper (buffer, basic_type, function_type, target)
			when is_space_type then
				generate_is_space (buffer, basic_type, target)
			when is_digit_type then
				generate_is_digit (buffer, basic_type, target)
			when
				is_equal_type,
				is_less_type,
				is_less_equal_type,
				is_greater_type,
				is_greater_equal_type
			then
				generate_comparison (buffer, basic_type, target, parameter)
			when to_character_8_type then
				buffer.put_string ("(EIF_CHARACTER_8) ")
				target.print_register
			when to_character_32_type then
				buffer.put_string ("(EIF_CHARACTER_32) ")
				target.print_register
			when as_natural_8_type, to_natural_8_type then
				buffer.put_string ("(EIF_NATURAL_8) ")
				target.print_register
			when as_natural_16_type, to_natural_16_type then
				buffer.put_string ("(EIF_NATURAL_16) ")
				target.print_register
			when as_natural_32_type, to_natural_32_type then
				buffer.put_string ("(EIF_NATURAL_32) ")
				target.print_register
			when as_natural_64_type, to_natural_64_type then
				buffer.put_string ("(EIF_NATURAL_64) ")
				target.print_register
			when as_integer_8_type, to_integer_8_type then
				buffer.put_string ("(EIF_INTEGER_8) ")
				target.print_register
			when as_integer_16_type, to_integer_16_type then
				buffer.put_string ("(EIF_INTEGER_16) ")
				target.print_register
			when as_integer_32_type, to_integer_32_type then
				buffer.put_string ("(EIF_INTEGER_32) ")
				if basic_type.is_pointer then
						-- Special code generation for conversion from POINTER to INTEGER without
						-- raising a warning at the C compilation level on platforms where the pointer
						-- size is different from the size of an INTEGER_32.
					buffer.put_string ("(rt_int_ptr) ")
				end
				target.print_register
			when as_integer_64_type, to_integer_64_type then
				buffer.put_string ("(EIF_INTEGER_64) ")
				target.print_register
			when to_real_64_type then
					-- We are using `c_type' here, but in some descendants of
					-- REGISTRABLE such as NESTED_BL it is the `c_type' of the
					-- first nested call, not of the whole. However it seems that
					-- here we never get a NESTED_BL so it works just fine.
				target.c_type.generate_conversion_to_real_64 (buffer)
				target.print_register
				buffer.put_character (')')
			when to_real_32_type then
					-- We are using `c_type' here, but in some descendants of
					-- REGISTRABLE such as NESTED_BL it is the `c_type' of the
					-- first nested call, not of the whole. However it seems that
					-- here we never get a NESTED_BL so it works just fine.
				target.c_type.generate_conversion_to_real_32 (buffer)
				target.print_register
				buffer.put_character (')')
			when ceiling_real_type then
				basic_type.c_type.generate_cast (buffer)
				buffer.put_string ("ceil ((double)")
				target.print_register
				buffer.put_character (')')
					-- Add `<math.h>' for C declaration of `ceil'.
				shared_include_queue_put ({PREDEFINED_NAMES}.math_header_name_id)
			when floor_real_type then
				basic_type.c_type.generate_cast (buffer)
				buffer.put_string ("floor ((double)")
				target.print_register
				buffer.put_character (')')
					-- Add `<math.h>' for C declaration of `floor'.
				shared_include_queue_put ({PREDEFINED_NAMES}.math_header_name_id)

			when is_nan_type, is_negative_infinity_type, is_positive_infinity_type then
				buffer.put_four_character ('e', 'i', 'f', '_')
				inspect function_type
				when is_nan_type then buffer.put_string ("is_nan_")
				when is_negative_infinity_type then buffer.put_string ("is_negative_infinity_")
				when is_positive_infinity_type then buffer.put_string ("is_positive_infinity_")
				end
				if basic_type.is_real_32 then
					buffer.put_string ("real_32")
				else
					buffer.put_string ("real_64")
				end
				buffer.put_two_character (' ', '(')
				target.print_register
				buffer.put_character (')')
					-- Add `eif_helpers.h' for C declaration of `floor'.
				shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)

			when nan_type, negative_infinity_type, positive_infinity_type then
				buffer.put_four_character ('e', 'i', 'f', '_')
				if basic_type.is_real_32 then
					buffer.put_string ("real_32_")
				else
					buffer.put_string ("real_64_")
				end
				inspect function_type
				when nan_type then buffer.put_string ("nan")
				when negative_infinity_type then buffer.put_string ("negative_infinity")
				when positive_infinity_type then buffer.put_string ("positive_infinity")
				end
					-- Add `eif_helpers.h' for C declaration of `floor'.
				shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)

			when plus_type then
				generate_plus (buffer, type_of (basic_type), target, parameter, False)
			when minus_type then
				generate_plus (buffer, type_of (basic_type), target, parameter, True)
			when product_type then
				buffer.put_character ('(')
				target.print_register
				buffer.put_three_character (' ', '*', ' ')
				parameter.print_immediate_register
				buffer.put_character (')')
			when quotient_type then
				generate_real_division (basic_type, target, parameter, result_type, buffer)
			when integer_quotient_type then
				buffer.put_character ('(')
				target.print_register
				buffer.put_three_character (' ', '/', ' ')
				parameter.print_immediate_register
				buffer.put_character (')')
			when integer_remainder_type then
				buffer.put_character ('(')
				target.print_register
				buffer.put_three_character (' ', '%%', ' ')
				parameter.print_immediate_register
				buffer.put_character (')')
			when power_type then
				generate_power (basic_type, target, parameter, result_type, buffer)
			when out_type then
				generate_out (buffer, basic_type, target, result_type)
			when hash_code_type then
				generate_hashcode (buffer, type_of (basic_type), target)
			when hash_code_64_type then
				generate_hashcode_64 (buffer, type_of (basic_type), target)
			when max_type then
				generate_max (buffer, type_of (basic_type), target, parameter)
			when min_type then
				generate_min (buffer, type_of (basic_type), target, parameter)
			when three_way_comparison_type then
				generate_three_way_comparison (buffer, type_of (basic_type), target, parameter)
			when abs_type then
				generate_abs (buffer, type_of (basic_type), target)
			when generator_type then
				if
					attached result_type.actual_type as t and then
					t.has_associated_class and then
					attached system.string_32_class as s and then
					s.is_compiled and then
					t.base_class.class_id = s.compiled_class.class_id
				then
					generate_generator__s4 (buffer, type_of (basic_type))
				else
					generate_generator__s1 (buffer, type_of (basic_type))
				end
			when default_type then
				basic_type.c_type.generate_default_value (buffer)
			when negated_type then
				buffer.put_string ("(EIF_BOOLEAN) !")
				target.print_register
			when opposite_type then
				basic_type.c_type.generate_cast (buffer)
				buffer.put_character ('-')
				target.print_register
			when bit_and_type..bit_test_type then
				check
					integer_type: type_of (basic_type) = integer_type_id
				end
				generate_bit_operation (buffer, function_type, target, parameter)
			when set_bit_with_mask_type then
				check
					integer_type: type_of (basic_type) = integer_type_id
					parameters_not_void: parameters /= Void
				end
				generate_set_bit_with_mask (buffer, target, parameters)
			when set_bit_type then
				check
					integer_type: type_of (basic_type) = integer_type_id
					parameters_not_void: parameters /= Void
				end
				generate_set_bit (buffer, target, parameters)
			when zero_type then
				generate_zero (buffer, type_of (basic_type))
			when one_type then
				generate_one (buffer, type_of (basic_type))
			when memory_move, memory_copy, memory_set, memory_alloc, memory_free, memory_calloc then
				check pointer_type: type_of (basic_type) = pointer_type_id end
				generate_memory_routine (buffer, function_type, target, parameters)
			when identity_type, twin_type, as_attached_type then
					-- There is nothing to do, just print the previous value.
				target.print_register
			when do_nothing_type then
				if not target.is_predefined then
						-- There is something to do when `target' is not a predefined entities.
						-- See eweasel test#exec191 and test#exec324.
					buffer.put_string ("eif_do_nothing_value.")
					basic_type.c_type.generate_typed_field (buffer)
					buffer.put_three_character (' ', '=', ' ')
					target.print_register
				end

			when is_default_pointer_type then
				buffer.put_character('!')
				target.print_register

			when is_character_8_type then
				check
					integer_type: type_of (basic_type) = character_type_id
				end
				buffer.put_character ('(')
				target.print_register
				buffer.put_four_character (' ', '<', '=', ' ')
				buffer.put_hex_natural_32 ({CHARACTER_8}.max_value.to_natural_32)
				buffer.put_character (')')
			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	c_type_table: HASH_TABLE [INTEGER, INTEGER]
		once
			create Result.make (100)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_deep_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (is_less_type, {PREDEFINED_NAMES}.is_less_name_id)
			Result.put (is_less_equal_type, {PREDEFINED_NAMES}.is_less_equal_name_id)
			Result.put (is_greater_type, {PREDEFINED_NAMES}.is_greater_name_id)
			Result.put (is_greater_equal_type, {PREDEFINED_NAMES}.is_greater_equal_name_id)
			Result.put (out_type, {PREDEFINED_NAMES}.out_name_id)
			Result.put (hash_code_64_type, {PREDEFINED_NAMES}.hash_code_64_name_id)
			Result.put (hash_code_type, {PREDEFINED_NAMES}.hash_code_name_id)
			Result.put (hash_code_type, {PREDEFINED_NAMES}.code_name_id)
			Result.put (max_type, {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, {PREDEFINED_NAMES}.min_name_id)
			Result.put (abs_type, {PREDEFINED_NAMES}.abs_name_id)
			Result.put (zero_type, {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, {PREDEFINED_NAMES}.one_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generator_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.to_character_8_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.to_character_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.ascii_char_name_id)
			Result.put (to_character_32_type, {PREDEFINED_NAMES}.to_character_32_name_id)
			Result.put (as_integer_8_type, {PREDEFINED_NAMES}.as_integer_8_name_id)
			Result.put (as_integer_16_type, {PREDEFINED_NAMES}.as_integer_16_name_id)
			Result.put (as_integer_32_type, {PREDEFINED_NAMES}.as_integer_32_name_id)
			Result.put (as_integer_64_type, {PREDEFINED_NAMES}.as_integer_64_name_id)
			Result.put (to_integer_8_type, {PREDEFINED_NAMES}.to_integer_8_name_id)
			Result.put (to_integer_16_type, {PREDEFINED_NAMES}.to_integer_16_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.truncated_to_integer_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.to_integer_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.to_integer_32_name_id)
			Result.put (to_integer_64_type, {PREDEFINED_NAMES}.to_integer_64_name_id)
			Result.put (to_integer_64_type, {PREDEFINED_NAMES}.truncated_to_integer_64_name_id)
			Result.put (as_natural_8_type, {PREDEFINED_NAMES}.as_natural_8_name_id)
			Result.put (as_natural_16_type, {PREDEFINED_NAMES}.as_natural_16_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.as_natural_32_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.natural_32_code_name_id)
			Result.put (as_natural_64_type, {PREDEFINED_NAMES}.as_natural_64_name_id)
			Result.put (to_natural_8_type, {PREDEFINED_NAMES}.to_natural_8_name_id)
			Result.put (to_natural_16_type, {PREDEFINED_NAMES}.to_natural_16_name_id)
			Result.put (to_natural_32_type, {PREDEFINED_NAMES}.to_natural_32_name_id)
			Result.put (to_natural_64_type, {PREDEFINED_NAMES}.to_natural_64_name_id)
			Result.put (to_real_64_type, {PREDEFINED_NAMES}.to_real_64_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.to_real_32_name_id)
			Result.put (to_real_64_type, {PREDEFINED_NAMES}.to_double_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.to_real_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.truncated_to_real_name_id)
			Result.put (identity_type, {PREDEFINED_NAMES}.identity_name_id)
			Result.put (opposite_type, {PREDEFINED_NAMES}.opposite_name_id)
			Result.put (plus_type, {PREDEFINED_NAMES}.plus_name_id)
			Result.put (plus_type, {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (minus_type, {PREDEFINED_NAMES}.minus_name_id)
			Result.put (product_type, {PREDEFINED_NAMES}.product_name_id)
			Result.put (quotient_type, {PREDEFINED_NAMES}.quotient_name_id)
			Result.put (integer_quotient_type, {PREDEFINED_NAMES}.integer_quotient_name_id)
			Result.put (integer_remainder_type, {PREDEFINED_NAMES}.integer_remainder_name_id)
			Result.put (power_type, {PREDEFINED_NAMES}.power_name_id)
			Result.put (negated_type, {PREDEFINED_NAMES}.negated_name_id)
--			Result.put (conjuncted_type, {PREDEFINED_NAMES}.conjuncted_name_id)
--			Result.put (conjuncted_semistrict_type, {PREDEFINED_NAMES}.conjuncted_semistrict_name_id)
--			Result.put (disjuncted_type, {PREDEFINED_NAMES}.disjuncted_name_id)
--			Result.put (disjuncted_semistrict_type, {PREDEFINED_NAMES}.disjuncted_semistrict_name_id)
--			Result.put (disjuncted_exclusive_type, {PREDEFINED_NAMES}.disjuncted_exclusive_name_id)
--			Result.put (implication_type, {PREDEFINED_NAMES}.implication_name_id)
			Result.put (default_type, {PREDEFINED_NAMES}.default_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.infix_bit_and_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.infix_bit_or_name_id)
			Result.put (bit_xor_type, {PREDEFINED_NAMES}.bit_xor_name_id)
			Result.put (bit_not_type, {PREDEFINED_NAMES}.bit_not_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.bit_shift_left_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.infix_shift_left_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.bit_shift_right_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.infix_shift_right_name_id)
			Result.put (bit_test_type, {PREDEFINED_NAMES}.bit_test_name_id)
			Result.put (set_bit_type, {PREDEFINED_NAMES}.set_bit_name_id)
			Result.put (set_bit_with_mask_type, {PREDEFINED_NAMES}.set_bit_with_mask_name_id)
			Result.put (memory_copy, {PREDEFINED_NAMES}.memory_copy_name_id)
			Result.put (memory_move, {PREDEFINED_NAMES}.memory_move_name_id)
			Result.put (memory_set, {PREDEFINED_NAMES}.memory_set_name_id)
			Result.put (memory_calloc, {PREDEFINED_NAMES}.memory_calloc_name_id)
			Result.put (memory_alloc, {PREDEFINED_NAMES}.memory_alloc_name_id)
			Result.put (memory_free, {PREDEFINED_NAMES}.memory_free_name_id)
			Result.put (lower_type, {PREDEFINED_NAMES}.lower_name_id)
			Result.put (lower_type, {PREDEFINED_NAMES}.as_lower_name_id)
			Result.put (upper_type, {PREDEFINED_NAMES}.upper_name_id)
			Result.put (upper_type, {PREDEFINED_NAMES}.as_upper_name_id)
			Result.put (is_digit_type, {PREDEFINED_NAMES}.is_digit_name_id)
			Result.put (is_space_type, {PREDEFINED_NAMES}.is_space_name_id)
			Result.put (three_way_comparison_type, {PREDEFINED_NAMES}.three_way_comparison_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.standard_twin_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.twin_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.deep_twin_name_id)
			Result.put (as_attached_type, {PREDEFINED_NAMES}.as_attached_name_id)
			Result.put (ceiling_real_type, {PREDEFINED_NAMES}.ceiling_real_32_name_id)
			Result.put (ceiling_real_type, {PREDEFINED_NAMES}.ceiling_real_64_name_id)
			Result.put (floor_real_type, {PREDEFINED_NAMES}.floor_real_32_name_id)
			Result.put (floor_real_type, {PREDEFINED_NAMES}.floor_real_64_name_id)
			Result.put (is_nan_type, {PREDEFINED_NAMES}.is_nan_name_id)
			Result.put (is_negative_infinity_type, {PREDEFINED_NAMES}.is_negative_infinity_name_id)
			Result.put (is_positive_infinity_type, {PREDEFINED_NAMES}.is_positive_infinity_name_id)
			Result.put (nan_type, {PREDEFINED_NAMES}.nan_name_id)
			Result.put (negative_infinity_type, {PREDEFINED_NAMES}.negative_infinity_name_id)
			Result.put (positive_infinity_type, {PREDEFINED_NAMES}.positive_infinity_name_id)
			Result.put (do_nothing_type, {PREDEFINED_NAMES}.do_nothing_name_id)
			Result.put (is_default_pointer_type, {PREDEFINED_NAMES}.is_default_pointer_name_id)
			Result.put (is_character_8_type, {PREDEFINED_NAMES}.is_character_8_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.deep_copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.standard_copy_name_id)
		end

	byte_type_table: HASH_TABLE [INTEGER, INTEGER]
		once
			create Result.make (100)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_deep_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (is_less_type, {PREDEFINED_NAMES}.is_less_name_id)
			Result.put (is_less_equal_type, {PREDEFINED_NAMES}.is_less_equal_name_id)
			Result.put (is_greater_type, {PREDEFINED_NAMES}.is_greater_name_id)
			Result.put (is_greater_equal_type, {PREDEFINED_NAMES}.is_greater_equal_name_id)
			Result.put (max_type, {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, {PREDEFINED_NAMES}.min_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generator_name_id)
			Result.put (identity_type, {PREDEFINED_NAMES}.identity_name_id)
			Result.put (opposite_type, {PREDEFINED_NAMES}.opposite_name_id)
			Result.put (plus_type, {PREDEFINED_NAMES}.plus_name_id)
			Result.put (plus_type, {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (minus_type, {PREDEFINED_NAMES}.minus_name_id)
			Result.put (product_type, {PREDEFINED_NAMES}.product_name_id)
			Result.put (quotient_type, {PREDEFINED_NAMES}.quotient_name_id)
			Result.put (integer_quotient_type, {PREDEFINED_NAMES}.integer_quotient_name_id)
			Result.put (integer_remainder_type, {PREDEFINED_NAMES}.integer_remainder_name_id)
			Result.put (power_type, {PREDEFINED_NAMES}.power_name_id)
			Result.put (negated_type, {PREDEFINED_NAMES}.negated_name_id)
--			Result.put (conjuncted_type, {PREDEFINED_NAMES}.conjuncted_name_id)
--			Result.put (conjuncted_semistrict_type, {PREDEFINED_NAMES}.conjuncted_semistrict_name_id)
--			Result.put (disjuncted_type, {PREDEFINED_NAMES}.disjuncted_name_id)
--			Result.put (disjuncted_semistrict_type, {PREDEFINED_NAMES}.disjuncted_semistrict_name_id)
--			Result.put (disjuncted_exclusive_type, {PREDEFINED_NAMES}.disjuncted_exclusive_name_id)
--			Result.put (implication_type, {PREDEFINED_NAMES}.implication_name_id)
			Result.put (default_type, {PREDEFINED_NAMES}.default_name_id)
			Result.put (zero_type, {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, {PREDEFINED_NAMES}.one_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.infix_bit_and_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.infix_bit_or_name_id)
			Result.put (bit_xor_type, {PREDEFINED_NAMES}.bit_xor_name_id)
			Result.put (bit_not_type, {PREDEFINED_NAMES}.bit_not_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.bit_shift_left_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.infix_shift_left_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.bit_shift_right_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.infix_shift_right_name_id)
			Result.put (bit_test_type, {PREDEFINED_NAMES}.bit_test_name_id)
			Result.put (set_bit_type, {PREDEFINED_NAMES}.set_bit_name_id)
			Result.put (set_bit_with_mask_type, {PREDEFINED_NAMES}.set_bit_with_mask_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.to_character_8_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.to_character_name_id)
			Result.put (to_character_8_type, {PREDEFINED_NAMES}.ascii_char_name_id)
			Result.put (to_character_32_type, {PREDEFINED_NAMES}.to_character_32_name_id)
			Result.put (as_integer_8_type, {PREDEFINED_NAMES}.as_integer_8_name_id)
			Result.put (as_integer_16_type, {PREDEFINED_NAMES}.as_integer_16_name_id)
			Result.put (as_integer_32_type, {PREDEFINED_NAMES}.as_integer_32_name_id)
			Result.put (as_integer_64_type, {PREDEFINED_NAMES}.as_integer_64_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.truncated_to_integer_name_id)
			Result.put (to_integer_8_type, {PREDEFINED_NAMES}.to_integer_8_name_id)
			Result.put (to_integer_16_type, {PREDEFINED_NAMES}.to_integer_16_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.to_integer_name_id)
			Result.put (to_integer_32_type, {PREDEFINED_NAMES}.to_integer_32_name_id)
			Result.put (to_integer_64_type, {PREDEFINED_NAMES}.to_integer_64_name_id)
			Result.put (to_integer_64_type, {PREDEFINED_NAMES}.truncated_to_integer_64_name_id)
			Result.put (as_natural_8_type, {PREDEFINED_NAMES}.as_natural_8_name_id)
			Result.put (as_natural_16_type, {PREDEFINED_NAMES}.as_natural_16_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.as_natural_32_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.natural_32_code_name_id)
			Result.put (as_natural_64_type, {PREDEFINED_NAMES}.as_natural_64_name_id)
			Result.put (to_natural_8_type, {PREDEFINED_NAMES}.to_natural_8_name_id)
			Result.put (to_natural_16_type, {PREDEFINED_NAMES}.to_natural_16_name_id)
			Result.put (to_natural_32_type, {PREDEFINED_NAMES}.to_natural_32_name_id)
			Result.put (to_natural_64_type, {PREDEFINED_NAMES}.to_natural_64_name_id)
			Result.put (to_real_64_type, {PREDEFINED_NAMES}.to_real_64_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.to_real_32_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.truncated_to_real_name_id)
			Result.put (to_real_64_type, {PREDEFINED_NAMES}.to_double_name_id)
			Result.put (to_real_32_type, {PREDEFINED_NAMES}.to_real_name_id)
			Result.put (three_way_comparison_type, {PREDEFINED_NAMES}.three_way_comparison_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.standard_twin_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.twin_name_id)
			Result.put (twin_type, {PREDEFINED_NAMES}.deep_twin_name_id)
			Result.put (as_attached_type, {PREDEFINED_NAMES}.as_attached_name_id)
			Result.put (ceiling_real_type, {PREDEFINED_NAMES}.ceiling_real_32_name_id)
			Result.put (ceiling_real_type, {PREDEFINED_NAMES}.ceiling_real_64_name_id)
			Result.put (floor_real_type, {PREDEFINED_NAMES}.floor_real_32_name_id)
			Result.put (floor_real_type, {PREDEFINED_NAMES}.floor_real_64_name_id)
			Result.put (is_nan_type, {PREDEFINED_NAMES}.is_nan_name_id)
			Result.put (is_negative_infinity_type, {PREDEFINED_NAMES}.is_negative_infinity_name_id)
			Result.put (is_positive_infinity_type, {PREDEFINED_NAMES}.is_positive_infinity_name_id)
			Result.put (nan_type, {PREDEFINED_NAMES}.nan_name_id)
			Result.put (negative_infinity_type, {PREDEFINED_NAMES}.negative_infinity_name_id)
			Result.put (positive_infinity_type, {PREDEFINED_NAMES}.positive_infinity_name_id)
			Result.put (do_nothing_type, {PREDEFINED_NAMES}.do_nothing_name_id)
			Result.put (is_default_pointer_type, {PREDEFINED_NAMES}.is_default_pointer_name_id)
			Result.put (is_character_8_type, {PREDEFINED_NAMES}.is_character_8_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
		end

feature {NONE} -- Fast access to feature name

	min_type_id: INTEGER = 1

	is_equal_type: INTEGER = 1
	set_item_type: INTEGER = 2
	out_type: INTEGER = 3
	hash_code_type: INTEGER = 4
	max_type: INTEGER = 5
	min_type: INTEGER = 6
	abs_type: INTEGER = 7
	generator_type: INTEGER = 8
	to_integer_32_type: INTEGER = 9
	plus_type: INTEGER = 10
	default_type: INTEGER = 11
	bit_and_type: INTEGER = 12
	bit_or_type: INTEGER = 13
	bit_xor_type: INTEGER = 14
	bit_not_type: INTEGER = 15
	bit_shift_left_type: INTEGER = 16
	bit_shift_right_type: INTEGER = 17
	bit_test_type: INTEGER = 18
	zero_type: INTEGER = 19
	one_type: INTEGER = 20
	memory_move: INTEGER = 21
	memory_copy: INTEGER = 22
	memory_set: INTEGER = 23
	to_integer_8_type: INTEGER = 24
	to_integer_16_type: INTEGER = 25
	to_integer_64_type: INTEGER = 26
	set_bit_with_mask_type: INTEGER = 27
	memory_alloc: INTEGER = 28
	memory_free: INTEGER = 29
	to_character_8_type: INTEGER = 30
	upper_type: INTEGER = 31
	lower_type: INTEGER = 32
	is_digit_type: INTEGER = 33
	memory_calloc: INTEGER = 34
	to_real_64_type: INTEGER = 35
	to_real_32_type: INTEGER = 36
	three_way_comparison_type: INTEGER = 37
	to_natural_8_type: INTEGER = 38
	to_natural_16_type: INTEGER = 39
	to_natural_32_type: INTEGER = 40
	to_natural_64_type: INTEGER = 41
	twin_type: INTEGER = 42
	as_integer_8_type: INTEGER = 43
	as_integer_16_type: INTEGER = 44
	as_integer_32_type: INTEGER = 45
	as_integer_64_type: INTEGER = 46
	as_natural_8_type: INTEGER = 47
	as_natural_16_type: INTEGER = 48
	as_natural_32_type: INTEGER = 49
	as_natural_64_type: INTEGER = 50
	set_bit_type: INTEGER = 51
	is_space_type: INTEGER = 52
	to_character_32_type: INTEGER = 53
	ceiling_real_type: INTEGER = 54
	floor_real_type: INTEGER = 55
	as_attached_type: INTEGER = 56
	is_nan_type: INTEGER = 57
	is_negative_infinity_type: INTEGER = 58
	is_positive_infinity_type: INTEGER = 59
	nan_type: INTEGER = 60
	negative_infinity_type: INTEGER = 61
	positive_infinity_type: INTEGER = 62
	do_nothing_type: INTEGER = 63
	is_default_pointer_type: INTEGER = 64
	is_character_8_type: INTEGER = 65
	hash_code_64_type: INTEGER = 66
	identity_type: INTEGER = 67
	opposite_type: INTEGER = 68
	minus_type: INTEGER = 69
	product_type: INTEGER = 70
	quotient_type: INTEGER = 71
	integer_quotient_type: INTEGER = 72
	integer_remainder_type: INTEGER = 73
	power_type: INTEGER = 74
	is_less_type: INTEGER = 75
	is_less_equal_type: INTEGER = 76
	is_greater_type: INTEGER = 77
	is_greater_equal_type: INTEGER = 78
	negated_type: INTEGER = 79
	conjuncted_type: INTEGER = 80
	conjuncted_semistrict_type: INTEGER = 81
	disjuncted_type: INTEGER = 82
	disjuncted_semistrict_type: INTEGER = 83
	disjuncted_exclusive_type: INTEGER = 84
	implication_type: INTEGER = 85

	max_type_id: INTEGER = 85

feature {NONE} -- Byte code generation

	make_bit_operation_code (ba: BYTE_ARRAY; op: INTEGER)
			-- Make byte code for call on bit operations from INTEGER.
		require
			ba_not_void: ba /= Void
		do
			ba.append (Bc_int_bit_op)
 			inspect
 				op
 			when bit_and_type then
 				ba.append (Bc_int_bit_and)
 			when bit_or_type then
 				ba.append (Bc_int_bit_or)
 			when bit_xor_type then
 				ba.append (Bc_int_bit_xor)
 			when bit_not_type then
 				ba.append (Bc_int_bit_not)
			when bit_shift_left_type then
 				ba.append (Bc_int_bit_shift_left)
 			when bit_shift_right_type then
 				ba.append (Bc_int_bit_shift_right)
 			when bit_test_type then
 				ba.append (Bc_int_bit_test)
 			when set_bit_type then
 				ba.append (Bc_int_set_bit)
 			when set_bit_with_mask_type then
 				ba.append (Bc_int_set_bit_with_mask)
			end
		end

feature {NONE} -- C code generation

	generate_lower_upper (buffer: GENERATION_BUFFER;
			basic_type: BASIC_A; f_type: INTEGER; target: REGISTRABLE)
			-- Generate fast wrapper for call on `upper' and `lower' of CHARACTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type_id
			valid_function_type: f_type = lower_type or f_type = upper_type
		do
			buffer.put_string
				(if function_type = lower_type then
					"eif_builtin_CHARACTER_8_as_lower__"
				else
					"eif_builtin_CHARACTER_8_as_upper__"
				end)
			{BUILT_IN_EXTENSION_I}.append_type_name (basic_type, system.byte_context.context_class_type, buffer)
			buffer.put_character ('_')
			{BUILT_IN_EXTENSION_I}.append_type_name (basic_type, system.byte_context.context_class_type, buffer)
			buffer.put_character ('(')
			target.print_register
			buffer.put_character (')')

				-- Add "eif_built_in.h" for C compilation where all output functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_built_in_header_name_id)
		end

	generate_is_digit (buffer: GENERATION_BUFFER;
			basic_type: BASIC_A; target: REGISTRABLE)

			-- Generate fast wrapper for call on `is_digit'.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type_id
		do
			buffer.put_string ("EIF_TEST(isdigit(")
			target.print_register
			buffer.put_character (')')
			buffer.put_character (')')

				-- Add `ctype.h' for C compilation where `isdigit' is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.ctype_header_name_id)
		end

	generate_is_space (buffer: GENERATION_BUFFER;
			basic_type: BASIC_A; target: REGISTRABLE)

			-- Generate fast wrapper for call on `is_space' of CHARACTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type_id
		do
			buffer.put_string ("EIF_TEST(isspace(")
			target.print_register
			buffer.put_character (')')
			buffer.put_character (')')

				-- Add `ctype.h' for C compilation where `isspace' is declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.ctype_header_name_id)
		end

	generate_comparison (buffer: GENERATION_BUFFER; basic_type: BASIC_A; target: REGISTRABLE; parameter: PARAMETER_BL)
			-- Generate a call to "is_equal", "<", "<=", ">", ">=" where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
			valid_function_type:
				(<<is_equal_type, is_less_type, is_less_equal_type, is_greater_type, is_greater_equal_type>>).has (function_type)
		do
			if (basic_type.is_real_32 or else basic_type.is_real_64) and then system.total_order_on_reals then
				shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
				buffer.put_string
					(inspect function_type
					when is_equal_type then
						"eif_is_equal_real_"
					when is_less_type then
						"eif_is_less_real_"
					when is_less_equal_type then
						"eif_is_less_equal_real_"
					when is_greater_type then
						"eif_is_greater_real_"
					when is_greater_equal_type then
						"eif_is_greater_equal_real_"
					end)
				if basic_type.is_real_32 then
					buffer.put_two_character ('3', '2')
				else
					buffer.put_two_character ('6', '4')
				end
				buffer.put_two_character (' ', '(')
				target.print_register
				buffer.put_two_character (',', ' ')
				parameter.print_immediate_register
				buffer.put_character (')')
			else
				target.print_register
				buffer.put_character (' ')
				inspect function_type
				when is_equal_type then
					buffer.put_character ('=')
					buffer.put_character ('=')
				when is_less_type then
					buffer.put_character ('<')
				when is_less_equal_type then
					buffer.put_character ('<')
					buffer.put_character ('=')
				when is_greater_type then
					buffer.put_character ('>')
				when is_greater_equal_type then
					buffer.put_character ('>')
					buffer.put_character ('=')
				end
				buffer.put_character (' ')
				parameter.print_immediate_register
			end
		end

	generate_plus (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE; parameter: PARAMETER_BL; is_minus: BOOLEAN)
			-- Generate fast wrapper for call on `+' where target and parameter
			-- are both basic types. Only `POINTER' and `CHARACTER' are handled, the
			-- other basic types have their own handling by the compiler.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when pointer_type_id then
				buffer.put_string ("RTPOF(")
				target.print_register
				buffer.put_character (',')
				if is_minus then
					buffer.put_three_character (' ', '-', '(')
				end
			when character_type_id then
				if is_wide then
					buffer.put_string ("(EIF_CHARACTER_32) (((EIF_NATURAL_32) ")
				else
					buffer.put_string ("(EIF_CHARACTER_8) (((EIF_INTEGER_32) ")
				end
				target.print_register
				buffer.put_four_character (')', ' ', if is_minus then '-' else '+' end,' ')
			else
				buffer.put_character ('(')
				target.print_register
				buffer.put_three_character (' ', if is_minus then '-' else '+' end,' ')
			end
			parameter.print_immediate_register
			if is_minus and then type_of_basic = pointer_type_id then
				buffer.put_character (')')
			end
			buffer.put_character (')')
		end

	generate_real_division (basic_type: BASIC_A; target: REGISTRABLE; parameter: PARAMETER_BL; result_type: TYPE_A; buffer: GENERATION_BUFFER)
			-- Generate real division (quotient), usually for operator "/" for `target` and ` `basic_type`, in buffer `buffer`
		do
			workbench.system.byte_context.real_type (result_type).c_type.generate_cast (buffer)
			buffer.put_character ('(')
			basic_type.c_type.generate_conversion_to_real_64 (buffer)
			target.print_register
			buffer.put_four_character (')', ' ', '/', ' ')
			basic_type.c_type.generate_conversion_to_real_64 (buffer)
			parameter.print_immediate_register
			buffer.put_character (')')
			buffer.put_character (')')
		end

	generate_power (basic_type: BASIC_A; target: REGISTRABLE; parameter: PARAMETER_BL; result_type: TYPE_A; buffer: GENERATION_BUFFER)
		local
			power_value: REAL_64
			done: BOOLEAN
		do
			if attached {REAL_CONST_B} parameter.expression as power_nb then
				power_value := power_nb.value.to_real_64
				if power_value = 0.0 then
					done := True
					buffer.put_string ("(EIF_REAL_64) 1")
				elseif power_value = 1.0 then
					done := True
					basic_type.c_type.generate_conversion_to_real_64 (buffer)
					target.print_register
					buffer.put_character (')')
				elseif power_value = 2.0 or power_value = 3.0 then
					done := True
					buffer.put_string ("(EIF_REAL_64) (")
					basic_type.c_type.generate_conversion_to_real_64 (buffer)
					target.print_register
					buffer.put_string (") * ")
					basic_type.c_type.generate_conversion_to_real_64 (buffer)
					target.print_register
					if power_value = 3.0 then
						buffer.put_string (") * ")
						basic_type.c_type.generate_conversion_to_real_64 (buffer)
						target.print_register
					end
					buffer.put_two_character (')', ')')
				end
			end
			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				shared_include_queue_put ({PREDEFINED_NAMES}.math_header_name_id)
				buffer.put_string ("(EIF_REAL_64) pow (")
				basic_type.c_type.generate_conversion_to_real_64 (buffer)
				target.print_register
				buffer.put_string ("), ")
				workbench.system.byte_context.real_type (parameter.type).c_type.generate_conversion_to_real_64 (buffer)
				parameter.print_immediate_register
				buffer.put_two_character (')', ')')
			end
		end

	generate_out (buffer: GENERATION_BUFFER; basic_type: BASIC_A; target: REGISTRABLE; result_type: TYPE_A)
			-- Generate fast wrapper for call on `out' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		local
			is_string_32: BOOLEAN
		do
			if
				attached result_type.actual_type as t and then
				t.has_associated_class and then
				attached system.string_32_class as s and then
				s.is_compiled and then
				t.base_class.class_id = s.compiled_class.class_id
			then
				is_string_32 := True
			end
			if basic_type.is_boolean then
				buffer.put_character ('(')
				target.print_register
				if is_string_32 then
					buffer.put_three_character (' ', '?', ' ')
					buffer.generate_manifest_string_32 ("True", False)
					buffer.put_three_character (' ', ':', ' ')
					buffer.generate_manifest_string_32 ("False", False)
					buffer.put_character (')')
				else
					buffer.put_string (" ? makestr (%"True%", 4) : makestr (%"False%", 5))")
						-- Add `eif_plug.h' for C compilation where `makestr' is -- declared
					shared_include_queue_put ({PREDEFINED_NAMES}.eif_plug_header_name_id)
				end
			else
				buffer.put_string ("eif_out__")
				{BUILT_IN_EXTENSION_I}.append_type_name (basic_type, system.byte_context.context_class_type, buffer)
				buffer.put_character ('_')
				{BUILT_IN_EXTENSION_I}.append_type_name (result_type, system.byte_context.context_class_type, buffer)
				buffer.put_character ('(')
				target.print_register
				buffer.put_character (')')

					-- Add "eif_out.h" for C compilation where all output functions are declared.
				shared_include_queue_put ({PREDEFINED_NAMES}.eif_out_header_name_id)
			end
		end

	generate_hashcode (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE)
			-- Generate fast wrapper for call on `hash_code' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when boolean_type_id then
				buffer.put_character ('(')
				target.print_register
				buffer.put_string (" ? 1L : 0L)")
			when character_type_id then
				buffer.put_string ("(EIF_INTEGER_32) (")
				target.print_register
				buffer.put_character(')')
			else
				buffer.put_string ("(EIF_INTEGER_32) (0x7FFFFFFF & (EIF_INTEGER_32) ((rt_int_ptr) (")
				target.print_register
				buffer.put_three_character (')', ')', ')')
			end
		end

	generate_hashcode_64 (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE)
			-- Generate fast wrapper for call on `hash_code' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when boolean_type_id then
				buffer.put_character ('(')
				target.print_register
				buffer.put_string (" ? 1L : 0L)")
			when character_type_id then
				buffer.put_string ("(EIF_NATURAL_64) (")
				target.print_register
				buffer.put_character(')')
			else
				buffer.put_string ("(EIF_NATURAL_64) (rt_int_ptr) (")
				target.print_register
				buffer.put_character (')')
			end
		end

	generate_generator__s1 (buffer: GENERATION_BUFFER; type_of_basic: INTEGER)
			-- Generate fast wrapper for call on `generator' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
		do
			inspect
				type_of_basic
			when boolean_type_id then
				buffer.put_string (" RTMS_EX(%"BOOLEAN%", 7)")
			when character_type_id then
				if is_wide then
					buffer.put_string (" RTMS_EX(%"CHARACTER_32%", 12)")
				else
					buffer.put_string (" RTMS_EX(%"CHARACTER_8%", 11)")
				end
			when integer_type_id then
				if is_signed_integer then
					buffer.put_string (" RTMS_EX(%"INTEGER")
					inspect
						integer_size
					when 8 then buffer.put_string ("_8%", 9)")
					when 16 then buffer.put_string ("_16%", 10)")
					when 32 then buffer.put_string ("_32%", 10)")
					when 64 then buffer.put_string ("_64%", 10)")
					end
				else
					buffer.put_string (" RTMS_EX(%"NATURAL_")
					inspect
						integer_size
					when 8 then buffer.put_string ("8%", 9)")
					when 16 then buffer.put_string ("16%", 10)")
					when 32 then buffer.put_string ("32%", 10)")
					when 64 then buffer.put_string ("64%", 10)")
					end
				end
			when pointer_type_id then
				buffer.put_string (" RTMS_EX(%"POINTER%", 7)")
			when real_32_type_id then
				buffer.put_string (" RTMS_EX(%"REAL_32%", 7)")
			when real_64_type_id then
				buffer.put_string (" RTMS_EX(%"REAL_64%", 7)")
			end
		end

	generate_generator__s4 (buffer: GENERATION_BUFFER; type_of_basic: INTEGER)
			-- Generate fast wrapper for call on `generator' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
		do
			buffer.generate_manifest_string_32
				(inspect type_of_basic
				when boolean_type_id then
					{STRING_32} "BOOLEAN"
				when character_type_id then
					if is_wide then
						{STRING_32} "CHARACTER_32"
					else
						{STRING_32} "CHARACTER_8"
					end
				when integer_type_id then
					if is_signed_integer then
						inspect
							integer_size
						when 8 then {STRING_32} "INTEGER_8"
						when 16 then {STRING_32} "INTEGER_16"
						when 32 then {STRING_32} "INTEGER_32"
						when 64 then {STRING_32} "INTEGER_64"
						end
					else
						inspect
							integer_size
						when 8 then {STRING_32} "NATURAL_8"
						when 16 then {STRING_32} "NATURAL_16"
						when 32 then {STRING_32} "NATURAL_32"
						when 64 then {STRING_32} "NATURAL_64"
						end
					end
				when pointer_type_id then
					{STRING_32} "POINTER"
				when real_32_type_id then
					{STRING_32} "REAL_32"
				when real_64_type_id then
					{STRING_32} "REAL_64"
				end,
				False)
		end

	generate_max (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE; parameter: PARAMETER_BL)
			-- Generate fast wrapper for call on `max' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type_id then
				if is_wide then
					buffer.put_string ("eif_max_wide_char (")
				else
					buffer.put_string ("eif_max_char (")
				end
			when integer_type_id then
				if is_signed_integer then
					buffer.put_string ("eif_max_")
				else
					buffer.put_string ("eif_max_u")
				end
				inspect integer_size
				when 8 then buffer.put_string ("int8 (")
				when 16 then buffer.put_string ("int16 (")
				when 32 then buffer.put_string ("int32 (")
				when 64 then buffer.put_string ("int64 (")
				end
			when real_32_type_id then
				buffer.put_string ("eif_max_real32 (")
			when real_64_type_id then
				buffer.put_string ("eif_max_real64 (")
			end

			target.print_register
			buffer.put_character (',')
			parameter.print_immediate_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_min (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE; parameter: PARAMETER_BL)
			-- Generate fast wrapper for call on `min' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type_id then
				if is_wide then
					buffer.put_string ("eif_min_wide_char (")
				else
					buffer.put_string ("eif_min_char (")
				end
			when integer_type_id then
				if is_signed_integer then
					buffer.put_string ("eif_min_")
				else
					buffer.put_string ("eif_min_u")
				end
				inspect integer_size
				when 8 then buffer.put_string ("int8 (")
				when 16 then buffer.put_string ("int16 (")
				when 32 then buffer.put_string ("int32 (")
				when 64 then buffer.put_string ("int64 (")
				end
			when real_32_type_id then
				buffer.put_string ("eif_min_real32 (")
			when real_64_type_id then
				buffer.put_string ("eif_min_real64 (")
			end

			target.print_register
			buffer.put_character (',')
			parameter.print_immediate_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_three_way_comparison (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE; parameter: PARAMETER_BL)
			-- Generate fast wrapper for call on `three_way_comparison' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type_id then
				if is_wide then
					buffer.put_string ("eif_twc_wide_char (")
				else
					buffer.put_string ("eif_twc_char (")
				end
			when integer_type_id then
				if is_signed_integer then
					buffer.put_string ("eif_twc_")
				else
					buffer.put_string ("eif_twc_u")
				end
				inspect integer_size
				when 8 then buffer.put_string ("int8 (")
				when 16 then buffer.put_string ("int16 (")
				when 32 then buffer.put_string ("int32 (")
				when 64 then buffer.put_string ("int64 (")
				end
			when real_32_type_id then
				buffer.put_string ("eif_twc_real32 (")
			when real_64_type_id then
				buffer.put_string ("eif_twc_real64 (")
			end

			target.print_register
			buffer.put_character (',')
			parameter.print_immediate_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_abs (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE)
			-- Generate fast wrapper for call on `abs' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when integer_type_id then
				if is_signed_integer then
					buffer.put_string ("eif_abs_")
				else
					buffer.put_string ("eif_abs_u")
				end
				inspect integer_size
				when 8 then buffer.put_string ("int8 (")
				when 16 then buffer.put_string ("int16 (")
				when 32 then buffer.put_string ("int32 (")
				when 64 then buffer.put_string ("int64 (")
				end
			when real_32_type_id then
				buffer.put_string ("eif_abs_real32 (")
			when real_64_type_id then
				buffer.put_string ("eif_abs_real64 (")
			end

			target.print_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_memory_routine (buffer: GENERATION_BUFFER; f_type: INTEGER; target: REGISTRABLE; parameters: BYTE_LIST [PARAMETER_B])
			-- Generate fast wrapper for call on `memory_copy',
			-- `memory_move', `memory_set' and `memory_calloc' from POINTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			valid_paramaters: f_type /= memory_free implies parameters /= Void
			valid_function_type:
				f_type = memory_move or f_type = memory_copy or
				f_type = memory_set or f_type = memory_free or
				f_type = memory_alloc or f_type = memory_calloc
		do
			shared_include_queue_put ({PREDEFINED_NAMES}.string_header_name_id)
			inspect
				f_type
			when memory_move then
				buffer.put_string ("memmove((void *)")
			when memory_copy then
				buffer.put_string ("memcpy((void *)")
			when memory_set then
				buffer.put_string ("memset((void *)")
			when memory_alloc then
				buffer.put_string ("malloc((size_t)")
			when memory_calloc then
				buffer.put_string ("calloc((size_t)")
			when memory_free then
				buffer.put_string ("free(")
			end
			if f_type /= memory_alloc and f_type /= memory_calloc then
				target.print_register
			end
			inspect
				f_type
			when memory_free, memory_alloc, memory_calloc then
			when memory_set then
				buffer.put_string (", (int) ")
			else
				buffer.put_string (", (const void *) ")
			end
			inspect
				f_type
			when memory_move, memory_set, memory_copy, memory_calloc then
				check
					valid_parameters: parameters.count = 2
				end
				if attached {PARAMETER_BL} parameters [1] as parameter then
					parameter.print_immediate_register
				end
				buffer.put_string (", (size_t) ")
				if attached {PARAMETER_BL} parameters [2] as parameter then
					parameter.print_immediate_register
				end
			when memory_alloc then
				check
					valid_paramters: parameters.count = 1
				end
				if attached {PARAMETER_BL} parameters [1] as parameter then
					parameter.print_immediate_register
				end
			else
			end
			buffer.put_string (")")
		end

	generate_bit_operation (buffer: GENERATION_BUFFER; op: INTEGER; target: REGISTRABLE; parameter: PARAMETER_BL)
			-- Generate fast wrapper for call on `bit_xxx' where target and parameter
			-- are both basic types of type INTEGER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void:  (op /= bit_not_type) implies parameter /= Void
		do
			if op = bit_not_type then
				buffer.put_string ("eif_bit_not(")
				target.print_register
			else
				inspect
					op
				when bit_and_type then
					buffer.put_string ("eif_bit_and(")
				when bit_or_type then
					buffer.put_string ("eif_bit_or(")
				when bit_xor_type then
					buffer.put_string ("eif_bit_xor(")
				when bit_shift_left_type then
					buffer.put_string ("eif_bit_shift_left(")
				when bit_shift_right_type then
					buffer.put_string ("eif_bit_shift_right(")
				when bit_test_type then
					buffer.put_string ("eif_bit_test(")
					target.c_type.generate (buffer)
					buffer.put_character (',')
				end
				target.print_register
				buffer.put_character (',')
				parameter.print_immediate_register
			end
			buffer.put_character (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_set_bit (buffer: GENERATION_BUFFER; target: REGISTRABLE; parameters: BYTE_LIST [PARAMETER_B])
			-- Generate fast wrapper for call on `set_bit' where target and parameter
			-- are both basic types of type INTEGER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 2
		do
			buffer.put_string ("eif_set_bit(")
			target.c_type.generate (buffer)
			buffer.put_character (',')
			target.print_register
			buffer.put_character (',')
			if attached {PARAMETER_BL} parameters [1] as parameter then
				parameter.print_immediate_register
			end
			buffer.put_character (',')
			if attached {PARAMETER_BL} parameters [2] as parameter then
				parameter.print_immediate_register
			end
			buffer.put_character (')')
				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_set_bit_with_mask (buffer: GENERATION_BUFFER; target: REGISTRABLE; parameters: BYTE_LIST [PARAMETER_B])
			-- Generate fast wrapper for call on `set_bit_with_mask' where target and parameter
			-- are both basic types of type INTEGER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 2
		do
			buffer.put_string ("eif_set_bit_with_mask(")
			target.print_register
			buffer.put_character (',')
			if attached {PARAMETER_BL} parameters [1] as parameter then
				parameter.print_immediate_register
			end
			buffer.put_character (',')
			if attached {PARAMETER_BL} parameters [2] as parameter then
				parameter.print_immediate_register
			end
			buffer.put_character (')')
				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue_put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_zero (buffer: GENERATION_BUFFER; type_of_basic: INTEGER)
			-- Generate fast wrapper for call on `zero' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type_id or else
								 type_of_basic = real_32_type_id or else
								 type_of_basic = real_64_type_id
		do
			inspect
				type_of_basic
			when integer_type_id then
				buffer.put_string ("0")
			when real_32_type_id, real_64_type_id then
				buffer.put_string ("0.0")
			end
		end

	generate_one (buffer: GENERATION_BUFFER; type_of_basic: INTEGER)
			-- Generate fast wrapper for call on `one' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type_id or else
								 type_of_basic = real_32_type_id or else
								 type_of_basic = real_64_type_id
		do
			inspect
				type_of_basic
			when integer_type_id then
				buffer.put_string ("1")
			when real_32_type_id, real_64_type_id then
				buffer.put_string ("1.0")
			end
		end

feature {NONE} -- Type information

	boolean_type_id: INTEGER = 1
	character_type_id: INTEGER = 2
	integer_type_id: INTEGER = 3
	pointer_type_id: INTEGER = 4
	real_32_type_id: INTEGER = 5
	real_64_type_id: INTEGER = 6
			-- Constant defining type

	integer_size: INTEGER
			-- Size of datatype when `type_of' returns `integer_type_id'.

	is_signed_integer: BOOLEAN
			-- Is `integer_type_id' a INTEGER_XX type?
			-- False for NATURAL_XX type.

	is_wide: BOOLEAN
			-- Is `character_type_id' returned by `type_of' a WIDE_CHARACTER?

	type_of (b: BASIC_A): INTEGER
			-- Returns corresponding type constants to `b'.
		require
			b_not_void: b /= Void
		do
			inspect b.sk_value (Void)
			when {SK_CONST}.sk_bool then Result := boolean_type_id
			when {SK_CONST}.sk_char8 then
				Result := character_type_id
				is_wide := False

			when {SK_CONST}.sk_char32 then
				Result := character_type_id
				is_wide := True

			when
				{SK_CONST}.sk_uint8, {SK_CONST}.sk_uint16,
				{SK_CONST}.sk_uint32, {SK_CONST}.sk_uint64
			then
				Result := integer_type_id
				is_signed_integer := False
				integer_size := if attached {NATURAL_A} b as t then t.size else {INTEGER_8} 0 end

			when
				{SK_CONST}.sk_int8, {SK_CONST}.sk_int16,
				{SK_CONST}.sk_int32, {SK_CONST}.sk_int64
			then
				Result := integer_type_id
				is_signed_integer := True
				integer_size := if attached {INTEGER_A} b as t then t.size else {INTEGER_8} 0 end

			when {SK_CONST}.sk_pointer then Result := pointer_type_id
			when {SK_CONST}.sk_real32 then Result := real_32_type_id
			when {SK_CONST}.sk_real64 then Result := real_64_type_id

			else
				if attached {TYPED_POINTER_A} b as t then
					Result := pointer_type_id
				end
			end
		ensure
			valid_type_id: Result = boolean_type_id or else Result = character_type_id or else
						Result = integer_type_id or else Result = pointer_type_id or else
						Result = real_32_type_id or else Result = real_64_type_id
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
