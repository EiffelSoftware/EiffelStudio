indexing
	description: "Special optimization on calls where target is a basic type."
	date: "$Date$"
	revision: "$Revision$"
	limitation: "We cannot handle `set_item', `copy', `standard_copy' or `deep_copy'%
			%because when called on attributes whose types are basic types we cannot%
			%store the result back to the attribute."

class IL_SPECIAL_FEATURES

inherit
	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end
		
	SHARED_HASH_CODE
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

	IL_CONST
		export
			{NONE} all
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

feature -- Access

	has (feat: FEATURE_B; target_type: CL_TYPE_I): BOOLEAN is
			-- Does Current have `feat.feature_name_id'?
		require
			valid_feat: feat /= Void
			target_type_not_void: target_type /= Void
		do
			Result := target_type.is_basic or else target_type.is_enum

			if Result then
				inspect 
					type_of (target_type)
				when
					boolean_type, character_type, integer_type, real_type,
					double_type, pointer_type
				then
					Result := basic_type_table.has (feat.feature_name_id)
					function_type := basic_type_table.found_item
					
				else
					if target_type.is_enum then
						Result := feat.feature_name_id = infix_or_name_id	
						function_type := basic_type_table.item (infix_or_name_id)
					else
						Result := False
					end
				end
			else
				Result := any_type_table.has (feat.feature_name_id) and then
					context.real_type (feat.parameters.i_th (1).type).is_basic
				function_type := any_type_table.found_item
			end
		end

feature -- Access code

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

	not_need_target: SEARCH_TABLE [INTEGER] is
			-- List of feature that does not need a target,
			-- and therefore in our code generation we should
			-- pop target from the stack.
		once
			create Result.make (10)
			Result.put (equal_type)
		end

feature -- Status

	valid_function_type (type: INTEGER): BOOLEAN is
			-- Is `f' a valid function type supported by Current.
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- IL code generation

	generate_il (type: CL_TYPE_I; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate IL code sequence that will be used with basic types.
		require
			valid_function_type: valid_function_type (function_type)
			type_not_void: type /= Void
		local
			f_type: INTEGER
		do
			f_type := function_type
			inspect f_type
			when bit_and_type..bit_shift_right_type then
				if parameters /= Void then
					parameters.generate_il
				end
				generate_il_operation_code (f_type)

			when bit_test_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				il_generator.put_integer_32_constant (1)
				parameters.i_th (1).generate_il
				generate_il_operation_code (bit_shift_left_type)
				generate_il_operation_code (bit_and_type)

			when is_equal_type, equal_type then
				check
					parameters_not_void: parameters /= Void
				end
				parameters.generate_il
				il_generator.generate_binary_operator (il_eq)

			when zero_type then
				il_generator.put_default_value (type)

			when one_type then
				il_generator.put_integer_constant (type, 1)

			when to_integer_8_type then
				il_generator.convert_to_integer_8

			when to_integer_16_type then
				il_generator.convert_to_integer_16

			when to_integer_32_type then
				il_generator.convert_to_integer_32

			when to_integer_64_type then
				il_generator.convert_to_integer_64

			when min_type then
				check
					parameters_not_void: parameters /= Void
				end
				parameters.generate_il
				il_generator.generate_min (type)

			when max_type then
				check
					parameters_not_void: parameters /= Void
				end
				parameters.generate_il
				il_generator.generate_max (type)

			when offset_type then
				check
					parameters_not_void: parameters /= Void
				end
				parameters.generate_il
				il_generator.generate_binary_operator (il_plus)
				
			when to_real_type then
				il_generator.convert_to_real
			
			when out_type then
				il_generator.generate_out (type)

			when hash_code_type then
				il_generator.convert_to_integer_32

			when to_character_type then
				il_generator.convert_to_character

			when abs_type then
				il_generator.generate_abs (type)

			else
			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls
		
	any_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (40)
			Result.put (equal_type, equal_name_id)
		end

	basic_type_table: HASH_TABLE [INTEGER, INTEGER] is
		once
			create Result.make (50)
			Result.put (equal_type, equal_name_id)
			Result.put (is_equal_type, is_equal_name_id)
			Result.put (is_equal_type, standard_is_equal_name_id)
			Result.put (equal_type, deep_equal_name_id)
			Result.put (equal_type, standard_deep_equal_name_id)
			Result.put (zero_type, zero_name_id)
			Result.put (one_type, one_name_id)
			Result.put (to_integer_32_type, truncated_to_integer_name_id)
			Result.put (to_integer_8_type, to_integer_8_name_id)
			Result.put (to_integer_16_type, to_integer_16_name_id)
			Result.put (to_integer_32_type, to_integer_32_name_id)
			Result.put (to_integer_32_type, to_integer_name_id)
			Result.put (to_integer_64_type, to_integer_64_name_id)
			Result.put (bit_and_type, bit_and_name_id)
			Result.put (bit_and_type, infix_and_name_id)
			Result.put (bit_or_type, bit_or_name_id)
			Result.put (bit_or_type, infix_or_name_id)
			Result.put (bit_xor_type, bit_xor_name_id)
			Result.put (bit_not_type, bit_not_name_id)
			Result.put (bit_shift_left_type, bit_shift_left_name_id)
			Result.put (bit_shift_left_type, infix_shift_left_name_id)
			Result.put (bit_shift_right_type, bit_shift_right_name_id)
			Result.put (bit_shift_right_type, infix_shift_right_name_id)
			Result.put (bit_test_type, bit_test_name_id)
 			Result.put (max_type, max_name_id)
 			Result.put (min_type, min_name_id)
 			Result.put (offset_type, infix_plus_name_id)
 			Result.put (to_real_type, truncated_to_real_name_id)
 			Result.put (out_type, out_name_id)
 			Result.put (hash_code_type, hash_code_name_id)
 			Result.put (hash_code_type, code_name_id)
			Result.put (to_character_type, to_character_name_id)
			Result.put (to_character_type, ascii_char_name_id)
 			Result.put (abs_type, abs_name_id)

-- FIXME: Manu 10/24/2001. Not yet implemented.
-- 			Result.put (generator_type, generator_name_id)
-- 			Result.put (generator_type, generating_type_name_id)
-- 			Result.put (default_type, default_name_id)
-- 			Result.put (memory_copy, memory_copy_name_id)
-- 			Result.put (memory_move, memory_move_name_id)
-- 			Result.put (memory_set, memory_set_name_id)
--			Result.put (set_item_type, set_item_name_id)
--			Result.put (set_item_type, copy_name_id)
--			Result.put (set_item_type, deep_copy_name_id)
--			Result.put (set_item_type, standard_copy_name_id)
		end

feature {NONE} -- Fast access to feature name

	min_type_id: INTEGER is 1
	equal_type: INTEGER is 1
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
	is_equal_type: INTEGER is 27
	to_real_type: INTEGER is 28
	to_character_type: INTEGER is 29
	max_type_id: INTEGER is 29

feature {NONE} -- IL code generation

	generate_il_operation_code (op: INTEGER) is
			-- Make byte code for call on bit operations from INTEGER.
		do
 			inspect
 				op
 			when bit_and_type then
				il_generator.generate_binary_operator (il_and)
 			when bit_or_type then
				il_generator.generate_binary_operator (il_or)
			when bit_xor_type then
 				il_generator.generate_binary_operator (il_xor)
 			when bit_not_type then
				il_generator.generate_unary_operator (il_bitwise_not)
			when bit_shift_left_type then
				il_generator.generate_binary_operator (il_shl)
 			when bit_shift_right_type then
				il_generator.generate_binary_operator (il_shr)
			else
				check
					not_implemented_yet: False
				end
			end
		end

feature {NONE} -- Type information

	boolean_type: INTEGER is 1
	character_type: INTEGER is 2
	integer_type: INTEGER is 3
	pointer_type: INTEGER is 4
	real_type: INTEGER is 5
	double_type: INTEGER is 6
	any_type: INTEGER is 7
	unknown_type: INTEGER is 8
			-- Constant defining type

	is_wide: BOOLEAN
			-- Is `character_type' returned by `type_of' a WIDE_CHARACTER?

	type_of (t: CL_TYPE_I): INTEGER is
			-- Returns corresponding type constants to `b'.
		require
			t_not_void: t /= Void
			t_not_bit: not t.is_bit
		do
			inspect
				t.hash_code
			when Character_code, Wide_char_code then
				Result := character_type

			when Boolean_code then
				Result := boolean_type

			when
				Integer8_code, Integer16_code,
				Integer32_code, Integer64_code
			then
				Result := integer_type
			
			when Real_code then
				Result := real_type

			when Double_code then
				Result := double_type

			when Pointer_code then
				Result := pointer_type

			else
				if t.base_class.is_class_any then
					Result := any_type
				else
					Result := unknown_type
				end
			end
		ensure
			valid_type: Result = boolean_type or else Result = character_type or else
						Result = integer_type or else Result = pointer_type or else
						Result = real_type or else Result = double_type or else 
						Result = any_type or else Result = unknown_type
		end

invariant
	il_generation: System.il_generation

end
