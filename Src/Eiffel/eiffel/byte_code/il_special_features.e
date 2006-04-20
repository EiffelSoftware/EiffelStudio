indexing
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
			Result := (target_type.is_basic and not target_type.is_bit) or else target_type.is_enum

			if Result then
				inspect
					type_of (target_type)
				when
					boolean_type, character_type, integer_type, real_32_type,
					real_64_type, pointer_type
				then
					Result := basic_type_table.has (feat.feature_name_id)
					function_type := basic_type_table.found_item

				else
					if target_type.is_enum then
						Result := True
						inspect
							feat.feature_name_id
						when Infix_and_name_id then
							function_type := basic_type_table.item (Infix_and_name_id)
						when Infix_or_name_id then
							function_type := basic_type_table.item (Infix_or_name_id)
						when To_integer_name_id then
							function_type := From_enum_to_integer_type
						when From_integer_name_id then
							function_type := From_integer_to_enum_type
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

	valid_function_type (type: INTEGER): BOOLEAN is
			-- Is `f' a valid function type supported by Current.
		do
			Result := type >= min_type_id and type <= max_type_id
		ensure
			valid: Result implies (type >= min_type_id and type <= max_type_id)
		end

feature -- IL code generation

	generate_il (a_generator: IL_NODE_GENERATOR; feat: FEATURE_B; type: CL_TYPE_I; parameters: BYTE_LIST [EXPR_B]) is
			-- Generate IL code sequence that will be used with basic types.
		require
			a_generator_not_void: a_generator /= Void
			a_generator_valid: a_generator.is_valid
			feat_not_void: feat /= Void
			valid_function_type: valid_function_type (function_type)
			type_not_void: type /= Void
		local
			f_type: INTEGER
			long: INTEGER_I
			nat: NATURAL_I
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
				il_generator.generate_min (type)

			when max_type then
				check
					parameters_not_void: parameters /= Void
					valid_count: parameters.count = 1
				end
				parameters.process (a_generator)
				il_generator.generate_max (type)

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

			when out_type then
				il_generator.generate_out (type)

			when hash_code_type then
				generate_hash_code (type)

			when to_character_8_type then
				il_generator.convert_to_character_8

			when to_character_32_type then
				il_generator.convert_to_character_32

			when abs_type then
				il_generator.generate_abs (type)

			when generator_type then
				il_generator.pop
				il_generator.put_manifest_string (type.name)

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

			when twin_type then
					-- Nothing to do, top of the stack has correct value

			else

			end
		end

feature {NONE} -- C and Byte code corresponding Eiffel function calls

	basic_type_table: HASH_TABLE [INTEGER, INTEGER] is
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
			Result.put (set_bit_type, set_bit_name_id)
			Result.put (set_bit_with_mask_type, set_bit_with_mask_name_id)
 			Result.put (max_type, max_name_id)
 			Result.put (min_type, min_name_id)
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
 			Result.put (generator_type, generating_type_name_id)
 			Result.put (three_way_comparison_type, three_way_comparison_name_id)
			Result.put (twin_type, twin_name_id)
			Result.put (upper_type, upper_name_id)
			Result.put (lower_type, lower_name_id)
			Result.put (is_upper_type, is_upper_name_id)
			Result.put (is_lower_type, is_lower_name_id)

-- FIXME: Manu 10/24/2001. Not yet implemented.
-- 			Result.put (memory_copy, memory_copy_name_id)
-- 			Result.put (memory_move, memory_move_name_id)
-- 			Result.put (memory_set, memory_set_name_id)
		end

feature -- Fast access to feature name

	min_type_id: INTEGER is 1
	unused_1: INTEGER is 1
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
	to_real_32_type: INTEGER is 28
	to_character_8_type: INTEGER is 29
	From_integer_to_enum_type: INTEGER is 30
	From_enum_to_integer_type: INTEGER is 31
	is_digit_type: INTEGER is 32
	to_real_64_type: INTEGER is 33
	three_way_comparison_type: INTEGER is 34
	to_natural_8_type: INTEGER is 35
	to_natural_16_type: INTEGER is 36
	to_natural_32_type: INTEGER is 37
	to_natural_64_type: INTEGER is 38
	twin_type: INTEGER is 39
	as_integer_8_type: INTEGER is 40
	as_integer_16_type: INTEGER is 41
	as_integer_32_type: INTEGER is 42
	as_integer_64_type: INTEGER is 43
	as_natural_8_type: INTEGER is 44
	as_natural_16_type: INTEGER is 45
	as_natural_32_type: INTEGER is 46
	as_natural_64_type: INTEGER is 47
	lower_type: INTEGER is 48
	upper_type: INTEGER is 49
	is_lower_type: INTEGER is 50
	is_upper_type: INTEGER is 51
	set_bit_type: INTEGER is 52
	set_bit_with_mask_type: INTEGER is 53
	to_character_32_type: INTEGER is 54
	max_type_id: INTEGER is 54

feature {NONE} -- IL code generation

	generate_il_operation_code (op: INTEGER; is_natural: BOOLEAN) is
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

	generate_hash_code (type: CL_TYPE_I) is
			-- Generate hash-code for current basic type at top of evaluation stack.
		require
			type_not_void: type /= Void
		do
			inspect
				type_of (type)
			when boolean_type then
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

	generate_three_way_comparison (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_I; a_expr: EXPR_B) is
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

	generate_set_item (a_generator: IL_NODE_GENERATOR; feat: FEATURE_B; type: CL_TYPE_I; parameters: BYTE_LIST [EXPR_B]) is
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
		do
			l_parent := feat.parent
			if l_parent /= Void and then l_parent.target.is_assignable then
				l_access := l_parent.target
				if l_access.is_local or l_access.is_result then
					il_generator.pop
					parameters.process (a_generator)
					a_generator.generate_il_assignment (l_access, type)
				elseif l_access.is_attribute then
						-- This is an expression of type `my_attribute.copy (a)'.
						-- Top of the stack is properly initialized in ATTRIBYUTE_B.generate_il_call
						-- so that object where `l_access' attribute belongs to is on
						-- top of the evaluation stack.
					parameters.process (a_generator)
					a_generator.generate_il_assignment (l_access, type)
				end

			end
		end

	generate_set_bit (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_I; parameters: BYTE_LIST [EXPR_B]) is
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

	generate_set_bit_with_mask (a_generator: IL_NODE_GENERATOR; a_type: CL_TYPE_I; parameters: BYTE_LIST [EXPR_B]) is
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

	boolean_type: INTEGER is 1
	character_type: INTEGER is 2
	integer_type: INTEGER is 3
	pointer_type: INTEGER is 4
	real_32_type: INTEGER is 5
	real_64_type: INTEGER is 6
	any_type: INTEGER is 7
	unknown_type: INTEGER is 8
			-- Constant defining type

	is_signed_integer: BOOLEAN
			-- Is integer_type corresponding to INTEGER_I?
			-- False when corresponding to NATURAL_I.

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
			when Character_code, Wide_char_code then Result := character_type
			when Boolean_code then Result := boolean_type
			when
				Integer_8_code, Integer_16_code,
				Integer_32_code, Integer_64_code
			then
				Result := integer_type
				is_signed_integer := True

			when
				natural_8_code, natural_16_code,
				natural_32_code, natural_64_code
			then
				Result := integer_type
				is_signed_integer := False

			when Real_32_code then	Result := real_32_type
			when Real_64_code then Result := real_64_type
			when Pointer_code then Result := pointer_type
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
						Result = real_32_type or else Result = real_64_type or else
						Result = any_type or else Result = unknown_type
		end

invariant
	il_generation: System.il_generation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
