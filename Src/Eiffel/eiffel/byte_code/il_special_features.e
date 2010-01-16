note
	description: "Special optimization on calls where target is a basic type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	limitation: "We cannot handle `set_item', `copy', `standard_copy' or `deep_copy'%
			%because when called on attributes whose types are basic types we cannot%
			%store the result back to the attribute."

class IL_SPECIAL_FEATURES

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
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

	SHARED_TYPES
		export
			{NONE} all
		end

feature -- Access

	has (feature_name_id: INTEGER; target_type: CL_TYPE_A): BOOLEAN
			-- Does Current have `feature_name_id'?
		require
			valid_feature_name_id: feature_name_id > 0
			target_type_not_void: target_type /= Void
		do
			Result := (target_type.is_basic and not target_type.is_bit) or else target_type.is_enum

			if Result then
				inspect
					type_of (target_type)
				when
					boolean_type_id, character_type_id, integer_type_id, real_32_type_id,
					real_64_type_id, pointed_type_id
				then
					Result := basic_type_table.has_key (feature_name_id)
					function_type := basic_type_table.found_item
					if function_type = out_type then
							-- {REAL_32}.out and {REAL_64}.out are processed
							-- as non-built-in to avoid issues with locale settings.
							-- {CHARACTER_32}.out is processed as non-built-in since it shows
							-- an hexadecimal representation of the character.
						Result := not target_type.is_real_32 and then not target_type.is_real_64 and then
							not target_type.is_character_32
					end

				else
					if target_type.is_enum then
						Result := True
						inspect
							feature_name_id
						when infix_bit_and_name_id, bit_and_name_id then
							function_type := basic_type_table.item (infix_bit_and_name_id)
						when infix_bit_or_name_id, bit_or_name_id then
							function_type := basic_type_table.item (infix_bit_or_name_id)
						when to_integer_name_id then
							function_type := from_enum_to_integer_type
						when from_integer_name_id then
							function_type := from_integer_to_enum_type
						else
							Result := False
						end
					else
						Result := False
					end
				end
			end
		end

feature -- Access code

	function_type: INTEGER
			-- Is current call based on an operator instead of a function
			-- call?

feature -- Status

	valid_function_type (type: INTEGER): BOOLEAN
			-- Is `f' a valid function type supported by Current.
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- IL code generation

	generate_il (a_generator: IL_NODE_GENERATOR; feat: CALL_ACCESS_B; type: CL_TYPE_A; parameters: BYTE_LIST [EXPR_B])
			-- Generate IL code sequence that will be used with basic types.
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			feat_not_void: feat /= Void
			valid_function_type: valid_function_type (function_type)
			type_not_void: type /= Void
		local
			f_type: INTEGER
			long: INTEGER_A
			nat: NATURAL_A
			typed_pointer_i: TYPED_POINTER_A
		do
			f_type := function_type
			inspect f_type
			when
				bit_and_type,
				bit_or_type,
				bit_xor_type,
				bit_not_type,
				bit_shift_right_type
			then
				if parameters /= Void then
					parameters.process (a_generator)
				end
				generate_il_operation_code (f_type, type.is_natural)

			when bit_shift_left_type then
				if parameters /= Void then
					parameters.process (a_generator)
				end
				generate_il_operation_code (bit_shift_left_type, type.is_natural)
				long ?= feat.real_type (feat.type)
				if long /= Void and then long.size < 32 then
						-- IL extended "int8" and "int16" to "int32" which has to be converted back
					il_generator.convert_to (long)
				else
					nat ?= feat.real_type (feat.type)
					if nat /= Void and then nat.size < 32 then
						il_generator.convert_to (nat)
					end
				end

			when bit_test_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
					valid_type: type.is_integer or type.is_natural
				end
				il_generator.put_numeric_integer_constant (type, 1)
				parameters.i_th (1).process (a_generator)
				generate_il_operation_code (bit_shift_left_type, type.is_natural)
				generate_il_operation_code (bit_and_type, type.is_natural)
				il_generator.put_default_value (type)
				il_generator.generate_binary_operator (il_ne, type.is_natural)

			when set_bit_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 2
					valid_type: type.is_integer or type.is_natural
				end
				generate_set_bit (a_generator, type, parameters)

			when set_bit_with_mask_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 2
					valid_type: type.is_integer or type.is_natural
				end
				generate_set_bit_with_mask (a_generator, type, parameters)

			when is_equal_type then
				check
					parameters_not_void: parameters /= Void
				end
				parameters.process (a_generator)
				il_generator.generate_binary_operator (il_eq, type.is_natural)

			when zero_type, default_type then
					-- No need to keep pushed value as we are going
					-- to put something else.
				il_generator.pop
				il_generator.put_default_value (type)

			when one_type then
					-- No need to keep pushed value as we are going
					-- to put something else.
				il_generator.pop
				il_generator.put_numeric_integer_constant (type, 1)

			when as_natural_8_type, to_natural_8_type then
				il_generator.convert_to_natural_8

			when as_natural_16_type, to_natural_16_type then
				il_generator.convert_to_natural_16

			when as_natural_32_type, to_natural_32_type then
				il_generator.convert_to_natural_32

			when as_natural_64_type, to_natural_64_type then
				il_generator.convert_to_natural_64

			when as_integer_8_type, to_integer_8_type then
				il_generator.convert_to_integer_8

			when as_integer_16_type, to_integer_16_type then
				il_generator.convert_to_integer_16

			when as_integer_32_type, to_integer_32_type then
				il_generator.convert_to_integer_32

			when as_integer_64_type, to_integer_64_type then
				il_generator.convert_to_integer_64

			when min_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				parameters.process (a_generator)
				il_generator.generate_math_two_arguments ("Min", type)

			when max_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				parameters.process (a_generator)
				il_generator.generate_math_two_arguments ("Max", type)

			when three_way_comparison_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				generate_three_way_comparison (a_generator, type, parameters.i_th (1))

			when offset_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				parameters.process (a_generator)
				il_generator.generate_binary_operator (il_plus, type.is_natural)

			when to_real_32_type then
				il_generator.convert_to_real_32

			when to_real_64_type then
				il_generator.convert_to_real_64

			when ceiling_real_type then
				il_generator.convert_to_real_64
				il_generator.generate_math_one_argument ("Ceiling", real_64_type)
				if type.is_real_32 then
					il_generator.convert_to_real_32
				end

			when floor_real_type then
				il_generator.convert_to_real_64
				il_generator.generate_math_one_argument ("Floor", real_64_type)
				if type.is_real_32 then
					il_generator.convert_to_real_32
				end

			when out_type then
				il_generator.generate_out (type)

			when hash_code_type then
				generate_hash_code (type)

			when to_character_8_type then
				il_generator.convert_to_character_8

			when to_character_32_type then
				il_generator.convert_to_character_32

			when abs_type then
				il_generator.generate_math_one_argument ("Abs", type)

			when generator_type then
				il_generator.pop
				typed_pointer_i ?= type
				if typed_pointer_i /= Void then
					il_generator.put_manifest_string ("POINTER")
				else
					il_generator.put_manifest_string (type.dump)
				end

			when from_integer_to_enum_type then
					-- Argument value becomes the enum value, we discard
					-- original value of enum.
				il_generator.pop
				parameters.process (a_generator)

			when from_enum_to_integer_type then
					-- Nothing to do, as enums are basically integers.

			when set_item_type then
				generate_set_item (a_generator, feat, type, parameters)

			when is_digit_type then
				il_generator.generate_is_query_on_character ("IsDigit")

			when is_lower_type then
				il_generator.generate_is_query_on_character ("IsLower")

			when is_upper_type then
				il_generator.generate_is_query_on_character ("IsUpper")

			when lower_type then
				il_generator.generate_upper_lower (False)

			when upper_type then
				il_generator.generate_upper_lower (True)

			when twin_type, as_attached_type then
					-- Nothing to do, top of the stack has correct value

			when is_nan_type then
				il_generator.generate_is_query_on_real (type.is_real_32, "IsNaN")

			when is_negative_infinity_type then
				il_generator.generate_is_query_on_real (type.is_real_32, "IsNegativeInfinity")

			when is_positive_infinity_type then
				il_generator.generate_is_query_on_real (type.is_real_32, "IsPositiveInfinity")

			when nan_type then
				if feat.need_target then
					il_generator.pop
				end
				if type.is_real_32 then
					il_generator.put_real_32_constant ({REAL_32}.nan)
				else
					il_generator.put_real_64_constant ({REAL_64}.nan)
				end
			when negative_infinity_type then
				if feat.need_target then
					il_generator.pop
				end
				if type.is_real_32 then
					il_generator.put_real_32_constant ({REAL_32}.negative_infinity)
				else
					il_generator.put_real_64_constant ({REAL_64}.negative_infinity)
				end

			when positive_infinity_type then
				if feat.need_target then
					il_generator.pop
				end
				if type.is_real_32 then
					il_generator.put_real_32_constant ({REAL_32}.positive_infinity)
				else
					il_generator.put_real_64_constant ({REAL_64}.positive_infinity)
				end

			else

			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	basic_type_table: HASH_TABLE [INTEGER, INTEGER]
		once
			create Result.make (100)
			Result.put (is_equal_type, is_equal_name_id)
			Result.put (is_equal_type, standard_is_equal_name_id)
			Result.put (zero_type, zero_name_id)
			Result.put (one_type, one_name_id)
			Result.put (as_integer_8_type, as_integer_8_name_id)
			Result.put (as_integer_16_type, as_integer_16_name_id)
			Result.put (as_integer_32_type, as_integer_32_name_id)
			Result.put (as_integer_64_type, as_integer_64_name_id)
			Result.put (to_integer_8_type, to_integer_8_name_id)
			Result.put (to_integer_16_type, to_integer_16_name_id)
			Result.put (to_integer_32_type, to_integer_32_name_id)
			Result.put (to_integer_32_type, truncated_to_integer_name_id)
			Result.put (to_integer_32_type, to_integer_name_id)
			Result.put (to_integer_64_type, to_integer_64_name_id)
			Result.put (to_integer_64_type, truncated_to_integer_64_name_id)
			Result.put (as_natural_8_type, as_natural_8_name_id)
			Result.put (as_natural_16_type, as_natural_16_name_id)
			Result.put (as_natural_32_type, as_natural_32_name_id)
			Result.put (as_natural_32_type, natural_32_code_name_id)
			Result.put (as_natural_64_type, as_natural_64_name_id)
			Result.put (to_natural_8_type, to_natural_8_name_id)
			Result.put (to_natural_16_type, to_natural_16_name_id)
			Result.put (to_natural_32_type, to_natural_32_name_id)
			Result.put (to_natural_64_type, to_natural_64_name_id)
			Result.put (bit_and_type, bit_and_name_id)
			Result.put (bit_and_type, infix_bit_and_name_id)
			Result.put (bit_or_type, bit_or_name_id)
			Result.put (bit_or_type, infix_bit_or_name_id)
			Result.put (bit_xor_type, bit_xor_name_id)
			Result.put (bit_not_type, bit_not_name_id)
			Result.put (bit_shift_left_type, bit_shift_left_name_id)
			Result.put (bit_shift_left_type, infix_shift_left_name_id)
			Result.put (bit_shift_right_type, bit_shift_right_name_id)
			Result.put (bit_shift_right_type, infix_shift_right_name_id)
			Result.put (bit_test_type, bit_test_name_id)
			Result.put (set_bit_type, set_bit_name_id)
			Result.put (set_bit_with_mask_type, set_bit_with_mask_name_id)
 			Result.put (max_type, max_name_id)
 			Result.put (min_type, min_name_id)
 			Result.put (offset_type, plus_name_id)
 			Result.put (offset_type, infix_plus_name_id)
			Result.put (to_real_64_type, to_real_64_name_id)
			Result.put (to_real_32_type, to_real_32_name_id)
 			Result.put (to_real_32_type, truncated_to_real_name_id)
 			Result.put (to_real_32_type, to_real_name_id)
 			Result.put (to_real_64_type, to_double_name_id)
 			Result.put (out_type, out_name_id)
 			Result.put (hash_code_type, hash_code_name_id)
 			Result.put (hash_code_type, code_name_id)
			Result.put (to_character_8_type, to_character_name_id)
			Result.put (to_character_8_type, to_character_8_name_id)
			Result.put (to_character_8_type, ascii_char_name_id)
			Result.put (to_character_32_type, to_character_32_name_id)
 			Result.put (abs_type, abs_name_id)
			Result.put (default_type, default_name_id)
			Result.put (set_item_type, set_item_name_id)
			Result.put (set_item_type, copy_name_id)
			Result.put (set_item_type, deep_copy_name_id)
			Result.put (set_item_type, standard_copy_name_id)
			Result.put (is_digit_type, is_digit_name_id)
 			Result.put (generator_type, generator_name_id)
 			Result.put (three_way_comparison_type, three_way_comparison_name_id)
			Result.put (twin_type, twin_name_id)
			Result.put (twin_type, deep_twin_name_id)
			Result.put (as_attached_type, as_attached_name_id)
			Result.put (upper_type, upper_name_id)
			Result.put (lower_type, lower_name_id)
			Result.put (is_upper_type, is_upper_name_id)
			Result.put (is_lower_type, is_lower_name_id)
			Result.put (is_nan_type, is_nan_name_id)
			Result.put (is_negative_infinity_type, is_negative_infinity_name_id)
			Result.put (is_positive_infinity_type, is_positive_infinity_name_id)
			Result.put (ceiling_real_type, ceiling_real_32_name_id)
			Result.put (ceiling_real_type, ceiling_real_64_name_id)
			Result.put (floor_real_type, floor_real_32_name_id)
			Result.put (floor_real_type, floor_real_64_name_id)
			Result.put (nan_type, nan_name_id)
			Result.put (negative_infinity_type, negative_infinity_name_id)
			Result.put (positive_infinity_type, positive_infinity_name_id)

-- FIXME: Manu 10/24/2001. Not yet implemented.
-- 			Result.put (memory_copy, memory_copy_name_id)
-- 			Result.put (memory_move, memory_move_name_id)
-- 			Result.put (memory_set, memory_set_name_id)
		end

feature -- Fast access to feature name

	min_type_id: INTEGER = 1
	unused_1: INTEGER = 1
	set_item_type: INTEGER = 2
	out_type: INTEGER = 3
	hash_code_type: INTEGER = 4
	max_type: INTEGER = 5
	min_type: INTEGER = 6
	abs_type: INTEGER = 7
	generator_type: INTEGER = 8
	to_integer_32_type: INTEGER = 9
	offset_type: INTEGER = 10
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
	is_equal_type: INTEGER = 27
	to_real_32_type: INTEGER = 28
	to_character_8_type: INTEGER = 29
	From_integer_to_enum_type: INTEGER = 30
	From_enum_to_integer_type: INTEGER = 31
	is_digit_type: INTEGER = 32
	to_real_64_type: INTEGER = 33
	three_way_comparison_type: INTEGER = 34
	to_natural_8_type: INTEGER = 35
	to_natural_16_type: INTEGER = 36
	to_natural_32_type: INTEGER = 37
	to_natural_64_type: INTEGER = 38
	twin_type: INTEGER = 39
	as_integer_8_type: INTEGER = 40
	as_integer_16_type: INTEGER = 41
	as_integer_32_type: INTEGER = 42
	as_integer_64_type: INTEGER = 43
	as_natural_8_type: INTEGER = 44
	as_natural_16_type: INTEGER = 45
	as_natural_32_type: INTEGER = 46
	as_natural_64_type: INTEGER = 47
	lower_type: INTEGER = 48
	upper_type: INTEGER = 49
	is_lower_type: INTEGER = 50
	is_upper_type: INTEGER = 51
	set_bit_type: INTEGER = 52
	set_bit_with_mask_type: INTEGER = 53
	to_character_32_type: INTEGER = 54
	as_attached_type: INTEGER = 55
	ceiling_real_type: INTEGER = 56
	floor_real_type: INTEGER = 57
	is_nan_type: INTEGER = 58
	is_negative_infinity_type: INTEGER = 59
	is_positive_infinity_type: INTEGER = 60
	nan_type: INTEGER = 61
	negative_infinity_type: INTEGER = 62
	positive_infinity_type: INTEGER = 63
	max_type_id: INTEGER = 63

feature {NONE} -- IL code generation

	generate_il_operation_code (op: INTEGER; is_natural: BOOLEAN)
			-- Make byte code for call on bit operations from INTEGER.
		do
 			inspect
 				op
 			when bit_and_type then
				il_generator.generate_binary_operator (il_and, is_natural)
 			when bit_or_type then
				il_generator.generate_binary_operator (il_or, is_natural)
			when bit_xor_type then
 				il_generator.generate_binary_operator (il_xor, is_natural)
 			when bit_not_type then
				il_generator.generate_unary_operator (il_bitwise_not)
			when bit_shift_left_type then
				il_generator.generate_binary_operator (il_shl, is_natural)
 			when bit_shift_right_type then
				il_generator.generate_binary_operator (il_shr, is_natural)
			else
				check
					not_implemented_yet: False
				end
			end
		end

	generate_hash_code (type: CL_TYPE_A)
			-- Generate hash-code for current basic type at top of evaluation stack.
		require
			type_not_void: type /= Void
		do
			inspect
				type_of (type)
			when boolean_type_id then
					-- Remove top of type (i.e. boolean value)
					-- and put `1' instead.
				il_generator.pop
				il_generator.put_integer_32_constant (1)

			else
					-- Convert type on stack to an integer and applies
					-- proper computation to get a positive hash-code.
				il_generator.generate_hash_code
			end
		end

	generate_three_way_comparison (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_A; a_expr: EXPR_B)
			-- Generate three_way_comparison computation for basic type objects
			-- at top of evaluation stack.
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			a_type_not_void: a_type /= Void
			a_expr_not_void: a_expr /= Void
		local
			l_local: INTEGER
			l_elseif_label, l_else_label, l_end_label: IL_LABEL
		do
				-- We will generate the code below for Current.three_way_comparison (x)
				-- if Current < x then
				--   Result := - 1
				-- elseif x < Current
				--   Result := 1
				-- else
				--   Result := 0
				-- end

				-- Label for branching		
			l_elseif_label := il_generator.create_label
			l_else_label := il_generator.create_label
			l_end_label := il_generator.create_label

				-- Duplicate Current.
			il_generator.duplicate_top

				-- Generate parameter and store it in a local variable
			a_expr.process (a_generator)
			il_generator.duplicate_top
			context.add_local (a_type)
			l_local := context.local_list.count
			il_generator.put_dummy_local_info (a_type, l_local)
			il_generator.generate_local_assignment (l_local)

				-- Generate: if Current < x then Result := -1
			il_generator.generate_binary_operator ({IL_CONST}.il_lt, a_type.is_natural)
			il_generator.branch_on_false (l_elseif_label)
				-- Remove duplicate occurrence of `Current' that we push in case
				-- we had to perform one more comparison.
			il_generator.pop
			il_generator.put_integer_32_constant (-1)
			il_generator.branch_to (l_end_label)

				-- Generate: elseif x < Current then Result := 1
			il_generator.mark_label (l_elseif_label)
			il_generator.generate_local (l_local)
			il_generator.generate_binary_operator ({IL_CONST}.il_gt, a_type.is_natural)
			il_generator.branch_on_false (l_else_label)
			il_generator.put_integer_32_constant (1)
			il_generator.branch_to (l_end_label)

				-- Generate: else Result := 0
			il_generator.mark_label (l_else_label)
			il_generator.put_integer_32_constant (0)

			il_generator.mark_label (l_end_label)
		end

	generate_set_item (a_generator: IL_NODE_GENERATOR; feat: CALL_ACCESS_B; type: CL_TYPE_A; parameters: BYTE_LIST [EXPR_B])
			-- Generate IL code sequence that will be used with basic types.
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			feat_not_void: feat /= Void
			valid_function_type: function_type = set_item_type
			type_not_void: type /= Void
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 1
		local
			l_parent: NESTED_B
			l_access: ACCESS_B
			l_arg: ARGUMENT_B
		do
			l_parent := feat.parent
			if l_parent /= Void then
				l_access := l_parent.target
				if l_access.is_attribute then
						-- This is an expression of type `my_attribute.copy (a)'.
						-- Top of the stack is properly initialized in ATTRIBYUTE_B.generate_il_call
						-- so that object where `l_access' attribute belongs to is on
						-- top of the evaluation stack.
					parameters.process (a_generator)
					a_generator.generate_il_assignment (l_access, type)
				else
						-- Remove target as it will be attached directly
					il_generator.pop
					if l_access.is_local or l_access.is_result then
						parameters.process (a_generator)
						a_generator.generate_il_assignment (l_access, type)
					elseif l_access.is_argument then
						parameters.process (a_generator)
						l_arg ?= l_access
						il_generator.generate_argument_assignment (l_arg.position)
					end
				end
			else
					-- Modification of Current results in NOP
				il_generator.pop
			end
		end

	generate_set_bit (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_A; parameters: BYTE_LIST [EXPR_B])
			-- Generate IL code sequence for `set_bit'
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			valid_function_type: function_type = set_bit_type
			type_not_void: a_type /= Void
			type_valid: a_type.is_integer or a_type.is_natural
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 2
		local
			l_target, l_result: INTEGER
			l_else, l_end: IL_LABEL
		do
				-- Store target and result of call in temporary locals
			context.add_local (a_type)
			l_target := context.local_list.count
			il_generator.put_dummy_local_info (a_type, l_target)
			il_generator.generate_local_assignment (l_target)

			context.add_local (a_type)
			l_result := context.local_list.count
			il_generator.put_dummy_local_info (a_type, l_result)

				-- Get labels for branching.
			l_else := il_label_factory.new_label
			l_end := il_label_factory.new_label

				-- Generate boolean value.
			parameters.i_th (1).process (a_generator)

				-- Generate case where boolean value is True:
				-- `item | (a_type) 1 << n'
			il_generator.branch_on_false (l_else)
			il_generator.generate_local (l_target)
			il_generator.put_numeric_integer_constant (a_type, 1)
			parameters.i_th (2).process (a_generator)
			il_generator.generate_binary_operator (il_shl, a_type.is_natural)
			il_generator.generate_binary_operator (il_or, a_type.is_natural)
			il_generator.generate_local_assignment (l_result)
			il_generator.branch_to (l_end)

				-- Generate case where boolean value is False:
				-- `item & ~(a_type) 1 << n'
			il_generator.mark_label (l_else)
			il_generator.generate_local (l_target)
			il_generator.put_numeric_integer_constant (a_type, 1)
			parameters.i_th (2).process (a_generator)
			il_generator.generate_binary_operator (il_shl, a_type.is_natural)
			il_generator.generate_unary_operator (il_bitwise_not)
			il_generator.generate_binary_operator (il_and, a_type.is_natural)
			il_generator.generate_local_assignment (l_result)

			il_generator.mark_label (l_end)
			il_generator.generate_local (l_result)
		end

	generate_set_bit_with_mask (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_A; parameters: BYTE_LIST [EXPR_B])
			-- Generate IL code sequence for `set_bit'
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			valid_function_type: function_type = set_bit_with_mask_type
			type_not_void: a_type /= Void
			type_valid: a_type.is_integer or a_type.is_natural
			parameters_not_void: parameters /= Void
			valid_parameters: parameters.count = 2
		local
			l_target, l_result: INTEGER
			l_else, l_end: IL_LABEL
		do
				-- Store target and result of call in temporary locals
			context.add_local (a_type)
			l_target := context.local_list.count
			il_generator.put_dummy_local_info (a_type, l_target)
			il_generator.generate_local_assignment (l_target)

			context.add_local (a_type)
			l_result := context.local_list.count
			il_generator.put_dummy_local_info (a_type, l_result)

				-- Get labels for branching.
			l_else := il_label_factory.new_label
			l_end := il_label_factory.new_label

				-- Generate boolean value.
			parameters.i_th (1).process (a_generator)

				-- Generate case where boolean value is True:
				-- `item | (a_type) 1 << n'
			il_generator.branch_on_false (l_else)
			il_generator.generate_local (l_target)
			parameters.i_th (2).process (a_generator)
			il_generator.generate_binary_operator (il_or, a_type.is_natural)
			il_generator.generate_local_assignment (l_result)
			il_generator.branch_to (l_end)

				-- Generate case where boolean value is False:
				-- `item & ~(a_type) 1 << n'
			il_generator.mark_label (l_else)
			il_generator.generate_local (l_target)
			parameters.i_th (2).process (a_generator)
			il_generator.generate_unary_operator (il_bitwise_not)
			il_generator.generate_binary_operator (il_and, a_type.is_natural)
			il_generator.generate_local_assignment (l_result)

			il_generator.mark_label (l_end)
			il_generator.generate_local (l_result)
		end

feature {NONE} -- Type information

	boolean_type_id: INTEGER = 1
	character_type_id: INTEGER = 2
	integer_type_id: INTEGER = 3
	pointed_type_id: INTEGER = 4
	real_32_type_id: INTEGER = 5
	real_64_type_id: INTEGER = 6
	any_type_id: INTEGER = 7
	unknown_type_id: INTEGER = 8
			-- Constant defining type

	is_signed_integer: BOOLEAN
			-- Is `integer_type_id' corresponding to INTEGER_A?
			-- False when corresponding to NATURAL_A.

	is_wide: BOOLEAN
			-- Is `character_type_id' returned by `type_of' a WIDE_CHARACTER?

	type_of (t: CL_TYPE_A): INTEGER
			-- Returns corresponding type constants to `t'.
		require
			t_not_void: t /= Void
			t_not_bit: not t.is_bit
		local
			l_typed_pointer: TYPED_POINTER_A
		do
			inspect
				t.hash_code
			when {SHARED_HASH_CODE}.Character_code, {SHARED_HASH_CODE}.Wide_char_code then
				Result := character_type_id
			when {SHARED_HASH_CODE}.Boolean_code then Result := boolean_type_id
			when
				{SHARED_HASH_CODE}.Integer_8_code, {SHARED_HASH_CODE}.Integer_16_code,
				{SHARED_HASH_CODE}.Integer_32_code, {SHARED_HASH_CODE}.Integer_64_code
			then
				Result := integer_type_id
				is_signed_integer := True

			when
				{SHARED_HASH_CODE}.natural_8_code, {SHARED_HASH_CODE}.natural_16_code,
				{SHARED_HASH_CODE}.natural_32_code, {SHARED_HASH_CODE}.natural_64_code
			then
				Result := integer_type_id
				is_signed_integer := False

			when {SHARED_HASH_CODE}.Real_32_code then Result := real_32_type_id
			when {SHARED_HASH_CODE}.Real_64_code then Result := real_64_type_id
			when {SHARED_HASH_CODE}.Pointer_code then Result := pointed_type_id
			else
				l_typed_pointer ?= t
				if l_typed_pointer /= Void then
					Result := pointed_type_id
				elseif t.associated_class.is_class_any then
					Result := any_type_id
				else
					Result := unknown_type_id
				end
			end
		ensure
			valid_type: Result = boolean_type_id or else Result = character_type_id or else
						Result = integer_type_id or else Result = pointed_type_id or else
						Result = real_32_type_id or else Result = real_64_type_id or else
						Result = any_type_id or else Result = unknown_type_id
		end

invariant
	il_generation: System.il_generation

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
