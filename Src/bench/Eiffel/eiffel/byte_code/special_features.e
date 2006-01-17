indexing
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
	
	SHARED_HASH_CODE

feature -- Access

	has (feature_name_id: INTEGER; compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Does Current have `feature_name_id'?
		require
			valid_feature_name_id: feature_name_id > 0
		local
			char: CHAR_I
		do
			if compilation_type then
				Result := c_type_table.has (feature_name_id)
				if Result then
					function_type := c_type_table.found_item
					if function_type = out_type and then target_type.is_char then
						char ?= target_type
						Result := not char.is_wide
					end
				end
			else
				Result := byte_type_table.has (feature_name_id)
				if Result then
					function_type := byte_type_table.found_item
				end
			end
		end

feature -- Access code

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

feature -- Status

	valid_function_type (type: INTEGER): BOOLEAN is
			-- Is `f' a valid function type supported by Current.
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- Byte code special generation

	make_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Generate byte code sequence that will be used with basic types.
		require
			basic_type_not_void: basic_type /= Void
			valid_function_type: valid_function_type (function_type)
		do
			inspect function_type
			when is_equal_type then
				ba.append (Bc_eq)
			when to_character_type then
				check integer_type: type_of (basic_type) = integer_type end
				ba.append (Bc_cast_char)
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
			when max_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_max)
			when min_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_min)
			when generator_type then
				ba.append (Bc_basic_operations)
				ba.append (Bc_generator)
			when offset_type then
				if type_of (basic_type) = pointer_type then
					ba.append (Bc_basic_operations)
					ba.append (Bc_offset)
				else
					ba.append (Bc_plus)
				end
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
				basic_type.make_default_byte_code (ba)
			when bit_and_type..bit_test_type, set_bit_with_mask_type, set_bit_type then
				check integer_type: type_of (basic_type) = integer_type end
				make_bit_operation_code (ba, function_type)
			when three_way_comparison_type then
				ba.append (bc_basic_operations)
				ba.append (bc_three_way_comparison)

			when twin_type then
					-- Nothing to do, top of the stack has correct value
			end
		end

feature -- C special code generation

	generate (buffer: GENERATION_BUFFER; basic_type: BASIC_I; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
		require
			valid_output_buffer: buffer /= Void
			valid_target: target /= Void
			valid_function_type: valid_function_type (function_type)
		local
			parameter: REGISTRABLE
		do
			if parameters /= Void then
				parameter := parameters.first
			end
			inspect function_type
			when lower_type, upper_type then
				generate_lower_upper (buffer, basic_type, function_type, target)
			when is_space_type then
				generate_is_space (buffer, basic_type, target)
			when is_digit_type then
				generate_is_digit (buffer, basic_type, target)
			when is_equal_type then
				generate_equal (buffer, target, parameter)
			when to_character_type then
				buffer.put_string ("(EIF_CHARACTER) ")
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
				if target.c_type.is_pointer then
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
			when offset_type then
				generate_offset (buffer, type_of (basic_type), target, parameter)
			when out_type then
				generate_out (buffer, type_of (basic_type), target)
			when hash_code_type then
				generate_hashcode (buffer, type_of (basic_type), target)
			when max_type then
				generate_max (buffer, type_of (basic_type), target, parameter)
			when min_type then
				generate_min (buffer, type_of (basic_type), target, parameter)
			when three_way_comparison_type then
				generate_three_way_comparison (buffer, type_of (basic_type), target, parameter)
			when abs_type then
				generate_abs (buffer, type_of (basic_type), target)
			when generator_type then
				generate_generator (buffer, type_of (basic_type))
			when default_type then
				basic_type.generate_default_value (buffer)
			when bit_and_type..bit_test_type then
				check
					integer_type: type_of (basic_type) = integer_type
				end
				generate_bit_operation (buffer, function_type, target, parameter)
			when set_bit_with_mask_type then
				check
					integer_type: type_of (basic_type) = integer_type
					parameters_not_void: parameters /= Void
				end
				generate_set_bit_with_mask (buffer, target, parameters)
			when set_bit_type then
				check
					integer_type: type_of (basic_type) = integer_type
					parameters_not_void: parameters /= Void
				end
				generate_set_bit (buffer, target, parameters)
			when zero_type then
				generate_zero (buffer, type_of (basic_type))
			when one_type then
				generate_one (buffer, type_of (basic_type))
			when memory_move, memory_copy, memory_set, memory_alloc, memory_free, memory_calloc then
				check pointer_type: type_of (basic_type) = pointer_type end
				generate_memory_routine (buffer, function_type, target, parameters)
			when twin_type then
				target.print_register
			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	c_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (100)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (out_type, {PREDEFINED_NAMES}.out_name_id)
			Result.put (hash_code_type, {PREDEFINED_NAMES}.hash_code_name_id)
			Result.put (hash_code_type, {PREDEFINED_NAMES}.code_name_id)
			Result.put (max_type, {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, {PREDEFINED_NAMES}.min_name_id)
			Result.put (abs_type, {PREDEFINED_NAMES}.abs_name_id)
			Result.put (zero_type, {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, {PREDEFINED_NAMES}.one_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generator_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generating_type_name_id)
			Result.put (to_character_type, {PREDEFINED_NAMES}.to_character_name_id)
			Result.put (to_character_type, {PREDEFINED_NAMES}.ascii_char_name_id)
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
			Result.put (as_natural_8_type, {PREDEFINED_NAMES}.as_natural_8_name_id)
			Result.put (as_natural_16_type, {PREDEFINED_NAMES}.as_natural_16_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.as_natural_32_name_id)
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
			Result.put (offset_type, {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (default_type, {PREDEFINED_NAMES}.default_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.infix_and_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.infix_or_name_id)
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
			Result.put (twin_type, {PREDEFINED_NAMES}.twin_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.deep_copy_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.standard_copy_name_id)
		end

	byte_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (100)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.is_equal_name_id)
			Result.put (is_equal_type, {PREDEFINED_NAMES}.standard_is_equal_name_id)
			Result.put (max_type, {PREDEFINED_NAMES}.max_name_id)
			Result.put (min_type, {PREDEFINED_NAMES}.min_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generator_name_id)
			Result.put (generator_type, {PREDEFINED_NAMES}.generating_type_name_id)
			Result.put (offset_type, {PREDEFINED_NAMES}.infix_plus_name_id)
			Result.put (zero_type, {PREDEFINED_NAMES}.zero_name_id)
			Result.put (one_type, {PREDEFINED_NAMES}.one_name_id)
			Result.put (default_type, {PREDEFINED_NAMES}.default_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.bit_and_name_id)
			Result.put (bit_and_type, {PREDEFINED_NAMES}.infix_and_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.bit_or_name_id)
			Result.put (bit_or_type, {PREDEFINED_NAMES}.infix_or_name_id)
			Result.put (bit_xor_type, {PREDEFINED_NAMES}.bit_xor_name_id)
			Result.put (bit_not_type, {PREDEFINED_NAMES}.bit_not_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.bit_shift_left_name_id)
			Result.put (bit_shift_left_type, {PREDEFINED_NAMES}.infix_shift_left_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.bit_shift_right_name_id)
			Result.put (bit_shift_right_type, {PREDEFINED_NAMES}.infix_shift_right_name_id)
			Result.put (bit_test_type, {PREDEFINED_NAMES}.bit_test_name_id)
			Result.put (set_bit_type, {PREDEFINED_NAMES}.set_bit_name_id)
			Result.put (set_bit_with_mask_type, {PREDEFINED_NAMES}.set_bit_with_mask_name_id)
			Result.put (to_character_type, {PREDEFINED_NAMES}.to_character_name_id)
			Result.put (to_character_type, {PREDEFINED_NAMES}.ascii_char_name_id)
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
			Result.put (as_natural_8_type, {PREDEFINED_NAMES}.as_natural_8_name_id)
			Result.put (as_natural_16_type, {PREDEFINED_NAMES}.as_natural_16_name_id)
			Result.put (as_natural_32_type, {PREDEFINED_NAMES}.as_natural_32_name_id)
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
			Result.put (twin_type, {PREDEFINED_NAMES}.twin_name_id)
--			Result.put (set_item_type, feature {PREDEFINED_NAMES}.set_item_name_id)
		end

feature {NONE} -- Fast access to feature name

	min_type_id: INTEGER is 1
	is_equal_type: INTEGER is 1
	set_item_type: INTEGER is 2
	out_type: INTEGER is 3
	hash_code_type: INTEGER is 4
	max_type: INTEGER is 5
	min_type: INTEGER is 6
	abs_type: INTEGER is 7
	generator_type: INTEGER is 8
	to_integer_32_type: INTEGER is 9
	offset_type: INTEGER is 10
	default_type: INTEGER is 11
	bit_and_type: INTEGER is 12
	bit_or_type: INTEGER is 13
	bit_xor_type: INTEGER is 14
	bit_not_type: INTEGER is 15
	bit_shift_left_type: INTEGER is 16
	bit_shift_right_type: INTEGER is 17
	bit_test_type: INTEGER is 18
	zero_type: INTEGER is 19
	one_type: INTEGER is 20
	memory_move: INTEGER is 21
	memory_copy: INTEGER is 22
	memory_set: INTEGER is 23
	to_integer_8_type: INTEGER is 24
	to_integer_16_type: INTEGER is 25
	to_integer_64_type: INTEGER is 26
	set_bit_with_mask_type: INTEGER is 27
	memory_alloc: INTEGER is 28
	memory_free: INTEGER is 29
	to_character_type: INTEGER is 30
	upper_type: INTEGER is 31
	lower_type: INTEGER is 32
	is_digit_type: INTEGER is 33
	memory_calloc: INTEGER is 34
	to_real_64_type: INTEGER is 35
	to_real_32_type: INTEGER is 36
	three_way_comparison_type: INTEGER is 37
	to_natural_8_type: INTEGER is 38
	to_natural_16_type: INTEGER is 39
	to_natural_32_type: INTEGER is 40
	to_natural_64_type: INTEGER is 41
	twin_type: INTEGER is 42
	as_integer_8_type: INTEGER is 43
	as_integer_16_type: INTEGER is 44
	as_integer_32_type: INTEGER is 45
	as_integer_64_type: INTEGER is 46
	as_natural_8_type: INTEGER is 47
	as_natural_16_type: INTEGER is 48
	as_natural_32_type: INTEGER is 49
	as_natural_64_type: INTEGER is 50
	set_bit_type: INTEGER is 51
	is_space_type: INTEGER is 52
	max_type_id: INTEGER is 52

feature {NONE} -- Byte code generation

	make_bit_operation_code (ba: BYTE_ARRAY; op: INTEGER) is
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
			basic_type: BASIC_I; f_type: INTEGER; target: REGISTRABLE)
		is
			-- Generate fast wrapper for call on `upper' and `lower' of CHARACTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type
			valid_function_type: f_type = lower_type or f_type = upper_type
		do
			if function_type = lower_type then
				buffer.put_string ("(EIF_CHARACTER) tolower(")
			else
				buffer.put_string ("(EIF_CHARACTER) toupper(")
			end
			target.print_register
			buffer.put_character (')')

				-- Add `ctype.h' for C compilation where `tolower' and `toupper' are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.ctype_header_name_id)
		end

	generate_is_digit (buffer: GENERATION_BUFFER;
			basic_type: BASIC_I; target: REGISTRABLE)
		is
			-- Generate fast wrapper for call on `is_digit'.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type
		do
			buffer.put_string ("EIF_TEST(isdigit(")
			target.print_register
			buffer.put_character (')')
			buffer.put_character (')')

				-- Add `ctype.h' for C compilation where `isdigit' is declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.ctype_header_name_id)
		end

	generate_is_space (buffer: GENERATION_BUFFER;
			basic_type: BASIC_I; target: REGISTRABLE)
		is
			-- Generate fast wrapper for call on `is_space' of CHARACTER.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			character_type: type_of (basic_type) = character_type
		do
			buffer.put_string ("EIF_TEST(isspace(")
			target.print_register
			buffer.put_character (')')
			buffer.put_character (')')

				-- Add `ctype.h' for C compilation where `isspace' is declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.ctype_header_name_id)
		end

	generate_equal (buffer: GENERATION_BUFFER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `equal' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			target.print_register
			buffer.put_character (' ')
			buffer.put_character ('=')
			buffer.put_character ('=')
			buffer.put_character (' ')
			parameter.print_register
		end

	generate_offset (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
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
			when pointer_type then
				buffer.put_string ("RTPOF(")
				target.print_register
				buffer.put_character (',')
				parameter.print_register
				buffer.put_character (')')
			when character_type then
				if is_wide then
					buffer.put_string ("(EIF_WIDE_CHAR) (((EIF_INTEGER_32) ")
				else
					buffer.put_string ("(EIF_CHARACTER) (((EIF_INTEGER_32) ")
				end
				target.print_register
				buffer.put_string (") + ")
				parameter.print_register
				buffer.put_character (')')
			else
				buffer.put_character ('(')
				target.print_register
				buffer.put_string (" + ")
				parameter.print_register
				buffer.put_character (')')
			end
		end

	generate_out (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `out' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			if type_of_basic = boolean_type then
				buffer.put_character ('(');
				target.print_register
				buffer.put_string (" ? makestr (%"True%", 4) : makestr (%"False%", 5))")

					-- Add `eif_plug.h' for C compilation where `makestr' is -- declared
				shared_include_queue.put ({PREDEFINED_NAMES}.eif_plug_header_name_id)
			else
				inspect
					type_of_basic
				when character_type then
					check
						not_is_wide: not is_wide
					end
					buffer.put_string ("c_outc(")
				when integer_type then
					if is_signed_integer then
						inspect
							integer_size
						when 8, 16, 32 then buffer.put_string ("c_outi(")
						when 64 then buffer.put_string ("c_outi64(")
						end
					else
						inspect
							integer_size
						when 8, 16, 32 then buffer.put_string ("c_outu(")
						when 64 then buffer.put_string ("c_outu64(")
						end
					end
				when pointer_type then
					buffer.put_string ("c_outp(")
				when real_32_type then
					buffer.put_string ("c_outr32(")
				when real_64_type then
					buffer.put_string ("c_outr64(")
				end
				target.print_register
				buffer.put_character (')')

					-- Add `eif_out.h' for C compilation where all output functions are declared.
				shared_include_queue.put ({PREDEFINED_NAMES}.eif_out_header_name_id)
			end
		end

	generate_hashcode (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `hash_code' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				buffer.put_string ("1L")
			when character_type then
				buffer.put_string ("(EIF_INTEGER_32) (")
				target.print_register
				buffer.put_character(')')
			else
				buffer.put_string ("(EIF_INTEGER_32) (0x7FFFFFFF & (EIF_INTEGER_32) (")
				target.print_register
				buffer.put_string ("))")
			end
		end

	generate_generator (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `generator' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
		do
			inspect
				type_of_basic
			when boolean_type then
				buffer.put_string (" RTMS_EX(%"BOOLEAN%", 7)")
			when character_type then
				if is_wide then
					buffer.put_string (" RTMS_EX(%"WIDE_CHARACTER%", 14)")
				else
					buffer.put_string (" RTMS_EX(%"CHARACTER%", 9)")
				end
			when integer_type then
				if is_signed_integer then
					buffer.put_string (" RTMS_EX(%"INTEGER")
					inspect
						integer_size
					when 8 then buffer.put_string ("_8%", 9)")
					when 16 then buffer.put_string ("_16%", 10)")
					when 32 then buffer.put_string ("%", 7)")
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
			when pointer_type then
				buffer.put_string (" RTMS_EX(%"POINTER%", 7)")
			when real_32_type then
				buffer.put_string (" RTMS_EX(%"REAL%", 4)")
			when real_64_type then
				buffer.put_string (" RTMS_EX(%"DOUBLE%", 6)")
			end
		end

	generate_max (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `max' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type then
				if is_wide then
					buffer.put_string ("eif_max_wide_char (")
				else
					buffer.put_string ("eif_max_char (")
				end
			when integer_type then
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
			when real_32_type then
				buffer.put_string ("eif_max_real32 (")
			when real_64_type then
				buffer.put_string ("eif_max_real64 (")
			end
			
			target.print_register
			buffer.put_character (',')
			parameter.print_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_min (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `min' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type then
				if is_wide then
					buffer.put_string ("eif_min_wide_char (")
				else
					buffer.put_string ("eif_min_char (")
				end
			when integer_type then
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
			when real_32_type then
				buffer.put_string ("eif_min_real32 (")
			when real_64_type then
				buffer.put_string ("eif_min_real64 (")
			end
			
			target.print_register
			buffer.put_character (',')
			parameter.print_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_three_way_comparison (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target, parameter: REGISTRABLE) is
			-- Generate fast wrapper for call on `three_way_comparison' where target and parameter
			-- are both basic types.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
			parameter_not_void: parameter /= Void
		do
			inspect
				type_of_basic
			when character_type then
				if is_wide then
					buffer.put_string ("eif_twc_wide_char (")
				else
					buffer.put_string ("eif_twc_char (")
				end
			when integer_type then
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
			when real_32_type then
				buffer.put_string ("eif_twc_real32 (")
			when real_64_type then
				buffer.put_string ("eif_twc_real64 (")
			end
			
			target.print_register
			buffer.put_character (',')
			parameter.print_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_abs (buffer: GENERATION_BUFFER; type_of_basic: INTEGER; target: REGISTRABLE) is
			-- Generate fast wrapper for call on `abs' where target
			-- is a basic type.
		require
			buffer_not_void: buffer /= Void
			target_not_void: target /= Void
		do
			inspect
				type_of_basic
			when integer_type then
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
			when real_32_type then
				buffer.put_string ("eif_abs_real32 (")
			when real_64_type then
				buffer.put_string ("eif_abs_real64 (")
			end
			
			target.print_register
			buffer.put_character (')')

				-- Add `eif_helpers.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_helpers_header_name_id)
		end

	generate_memory_routine (buffer: GENERATION_BUFFER; f_type: INTEGER; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
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
			shared_include_queue.put ({PREDEFINED_NAMES}.string_header_name_id)

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
				parameters.i_th (1).print_register
				buffer.put_string (", (size_t) ")
				parameters.i_th (2).print_register
			when memory_alloc then
				check
					valid_paramters: parameters.count = 1
				end
				parameters.i_th (1).print_register
			else
			end

			buffer.put_string (")")
		end

	generate_bit_operation (buffer: GENERATION_BUFFER; op: INTEGER; target, parameter: REGISTRABLE) is
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
				parameter.print_register
			end
			buffer.put_character (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_set_bit (buffer: GENERATION_BUFFER; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
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
			parameters.i_th (1).print_register
			buffer.put_character (',')
			parameters.i_th (2).print_register
			buffer.put_character (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_set_bit_with_mask (buffer: GENERATION_BUFFER; target: REGISTRABLE; parameters: BYTE_LIST [EXPR_B]) is
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
			parameters.i_th (1).print_register
			buffer.put_character (',')
			parameters.i_th (2).print_register
			buffer.put_character (')')

				-- Add `eif_misc.h' for C compilation where all bit functions are declared.
			shared_include_queue.put ({PREDEFINED_NAMES}.eif_misc_header_name_id)
		end

	generate_zero (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `zero' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type or else
								 type_of_basic = real_32_type or else
								 type_of_basic = real_64_type
		do
			inspect
				type_of_basic
			when integer_type then
				buffer.put_string ("0")
			when real_32_type, real_64_type then
				buffer.put_string ("0.0")
			end
		end

	generate_one (buffer: GENERATION_BUFFER; type_of_basic: INTEGER) is
			-- Generate fast wrapper for call on `one' for INTEGER,
			-- REAL and DOUBLE.
		require
			buffer_not_void: buffer /= Void
			valid_type_of_basic: type_of_basic = integer_type or else
								 type_of_basic = real_32_type or else
								 type_of_basic = real_64_type
		do
			inspect
				type_of_basic
			when integer_type then
				buffer.put_string ("1")
			when real_32_type, real_64_type then
				buffer.put_string ("1.0")
			end
		end

feature {NONE} -- Type information

	boolean_type: INTEGER is 1
	character_type: INTEGER is 2
	integer_type: INTEGER is 3
	pointer_type: INTEGER is 4
	real_32_type: INTEGER is 5
	real_64_type: INTEGER is 6
			-- Constant defining type

	integer_size: INTEGER
			-- Size of datatype when `type_of' returns `integer_type'.

	is_signed_integer: BOOLEAN
			-- Is `integer_type' a INTEGER_XX type?
			-- False for NATURAL_XX type.

	is_wide: BOOLEAN
			-- Is `character_type' returned by `type_of' a WIDE_CHARACTER?

	type_of (b: BASIC_I): INTEGER is
			-- Returns corresponding type constants to `b'.
		require
			b_not_void: b /= Void
			b_not_bit: not b.is_bit
		local
			l_int: INTEGER_I
			l_nat: NATURAL_I
			t: TYPED_POINTER_I
		do
			inspect b.hash_code
			when Boolean_code then Result := boolean_type
			when Character_code then
				Result := character_type
				is_wide := False

			when Wide_char_code then
				Result := character_type
				is_wide := True

			when
				natural_8_code, natural_16_code,
				natural_32_code, natural_64_code
			then
				Result := integer_type
				is_signed_integer := False
				l_nat ?= b
				integer_size := l_nat.size

			when
				Integer_8_code, Integer_16_code,
				Integer_32_code, Integer_64_code
			then
				Result := integer_type
				is_signed_integer := True
				l_int ?= b
				integer_size := l_int.size

			when Pointer_code then Result := pointer_type
			when Real_32_code then Result := real_32_type
			when Real_64_code then Result := real_64_type
			
			else
				t ?= b
				if t /= Void then
					Result := pointer_type
				end
			end
		ensure
			valid_type: Result = boolean_type or else Result = character_type or else
						Result = integer_type or else Result = pointer_type or else
						Result = real_32_type or else Result = real_64_type
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
