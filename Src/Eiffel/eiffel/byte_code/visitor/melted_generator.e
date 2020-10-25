note
	description: "Visitor for BYTE_NODE objects which generates the Eiffel melted code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_GENERATOR

inherit
	BYTE_NODE_VISITOR

	BYTE_CONST
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	INTEGER_TYPE_MASKS

	SHARED_BN_STATELESS_VISITOR
		export
			{NONE} all
		end

	COMPILER_EXPORTER

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Initialize

	generate (a_ba: BYTE_ARRAY; a_node: BYTE_NODE)
			-- Generate `a_node''s code into `a_ba'.
		require
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
		do
			ba := a_ba
			a_node.process (Current)
			ba := Void
		end

	generate_old_expression_initialization (a_ba: BYTE_ARRAY; a_node: UN_OLD_B)
			-- Generate `a_node''s code into `a_ba'.
		require
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
		do
			ba := a_ba
			a_node.expr.process (Current)
				-- Write the end of last old expression evaluation.
			a_ba.write_forward
			a_ba.append (bc_old)
			a_ba.append_short_integer (a_node.position)
			a_ba.append_short_integer (a_node.exception_position)
				-- Mark start of next old expression evaluation.
			a_ba.mark_forward
			ba := Void
		end

feature -- Access

	ba: BYTE_ARRAY
			-- Byte array where melted code is stored.

	is_in_creation_call: BOOLEAN
			-- Is current call a creation instruction?

	is_active_region: BOOLEAN
			-- Should a separate region be active when it is created?

feature {NONE} -- Status report

	is_initialization: BOOLEAN
			-- Is initialization code being processed?

feature -- Routine visitor

	process_std_byte_code (a_node: STD_BYTE_CODE)
			-- Process current element.
		do
		end

feature {NONE} -- Implementation visitors

	process_hidden_if_b (a_node: HIDDEN_IF_B)
			-- Process `a_node'.
		do
			process_if_b (a_node)
		end

	process_hidden_b (a_node: HIDDEN_B)
			-- Process `a_node'.
		do
			context.enter_hidden_code
			process_byte_list (a_node)
			context.exit_hidden_code
		end

	process_do_rescue_b (a_node: DO_RESCUE_B)
			-- Process `a_node'
		do
			ba.mark_retry
			if attached a_node.compound as l_compound then
				ba.append (bc_do_rescue)
				if a_node.rescue_clause /= Void then
					ba.append_boolean (True)
					ba.mark_forward3
				else
					ba.append_boolean (False)
				end

					-- Compound byte code
				l_compound.process (Current)
				ba.append (Bc_do_rescue_end)
				if attached a_node.rescue_clause as l_rescue_clause then
					ba.append (bc_jmp)
					ba.mark_forward4
						-- Mark the start of the rescue clause
					ba.write_forward3
					ba.append (Bc_rescue)
					l_rescue_clause.process (Current)
					--| No Bc_end_rescue, since we do not want to exit the routine
					ba.append (Bc_end_rescue)
						-- Mark the end of the rescue clause.
					ba.write_forward4
				end
			end
		end

	process_try_b (a_node: TRY_B)
			-- Process `a_node'
		local
			l_except_part: detachable BYTE_LIST [BYTE_NODE]
		do
			if attached a_node.compound as l_compound then
				ba.append (bc_try)
				l_except_part := a_node.except_part
				if l_except_part /= Void then
					ba.append_boolean (True)
					ba.mark_forward2
				else
					ba.append_boolean (False)
				end

					-- Compound byte code
				l_compound.process (Current)
				ba.append (bc_try_end)

				if l_except_part /= Void then
					ba.append (bc_jmp)
					ba.mark_forward3
						-- Mark the start of the except part
					ba.write_forward2
					l_except_part.process (Current)
					ba.append (Bc_try_end_except)
						-- Mark the end of the try/except clause.
					ba.write_forward3
				end
			end
		end

feature {NONE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B)
			-- Process `a_node'.
		do
			a_node.expr.process (Current)
		end

	process_address_b (a_node: ADDRESS_B)
			-- Process `a_node'.
		do
			ba.append (Bc_addr)
			ba.append_integer (
				system.address_table.id_of_dollar_feature (a_node.feature_class_id, a_node.feature_id, context.class_type))
		end

	process_argument_b (a_node: ARGUMENT_B)
			-- Process `a_node'.
		do
			ba.append (Bc_arg)
			ba.append_short_integer (a_node.position)
		end

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- Process `a_node'.
		local
			l_real_ty: GEN_TYPE_A
			l_feat_i: FEATURE_I
			l_expr: EXPR_B
			l_target_type: TYPE_A
			l_base_class: CLASS_C
			l_special_info: CREATE_TYPE
			l_special_type: TYPE_A
			i: INTEGER
		do
			l_real_ty ?= context.real_type (a_node.type)
			l_target_type := l_real_ty.generics.first

				-- We first create a SPECIAL in which we will store the information above before
				-- creating the ARRAY using `make_from_special'.
				-- First push the number of elements in the SPECIAL
			ba.append (Bc_int32)
			ba.append_integer (a_node.expressions.count)
				-- Then create an instance of the SPECIAL.
			ba.append (bc_spcreate)
			if system.is_using_new_special then
					-- We are going to use `make_empty'
				ba.append_boolean (False)
				ba.append_boolean (True)
			else
					-- We are going to use `make'
				ba.append_boolean (False)
				ba.append_boolean (False)
			end
			l_special_info := a_node.special_info.updated_info
			l_special_info.make_byte_code (ba)
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
			l_special_type := l_special_info.type
			check
				is_special_type: l_special_type /= Void and then l_special_type.base_class.lace_class = System.special_class
			end
			if attached {SPECIAL_CLASS_TYPE} l_special_type.associated_class_type (context.context_class_type.type) as l_special_class_type then
				l_special_class_type.make_creation_byte_code (ba)

					-- We compute the expressions and store them into the special
				from
					a_node.expressions.start
					i := 0
				until
					a_node.expressions.after
				loop
					l_expr ?= a_node.expressions.item
					check
						l_expr_not_void: l_expr /= Void
					end
					make_expression_byte_code_for_type (l_expr, l_target_type)
					ba.append (bc_special_extend)
					ba.append_integer (i)
					i := i + 1
					a_node.expressions.forth
				end

					-- Now we create the ARRAY instance vi the call to `to_array' from SPECIAL
				l_base_class := l_special_class_type.associated_class
				l_feat_i := l_base_class.feature_table.item_id ({PREDEFINED_NAMES}.to_array_name_id)
				ba.append (Bc_array)
				ba.append_integer (l_feat_i.rout_id_set.first)
			else
				check is_special_class_type: False then end
			end
		end

	process_assert_b (a_node: ASSERT_B)
			-- Process `a_node'.
		do
			make_assert_b (a_node)
		end

	process_assign_b (a_node: ASSIGN_B)
			-- Process `a_node'.
		local
			l_target_type: TYPE_A
			l_target_node: ACCESS_B
			l_mark_count: NATURAL
		do
			l_target_node := a_node.target
			l_target_type := Context.real_type (l_target_node.type)
			generate_melted_debugger_hook (ba)

				-- Generate expression byte code
			if a_node.is_creation_instruction then
					-- Avoid object cloning.
				a_node.source.process (Current)
			else
					-- Clone source object depending on its type and type of target.
				make_expression_byte_code_for_type (a_node.source, l_target_type)
			end

			if a_node.source.is_hector then
				if attached {HECTOR_B} a_node.source as l_hector_b then
					make_protected_byte_code (l_hector_b, 0)
				else
						-- Address expressions are disallowed for attachement
					check False end
				end
			end

				-- Generate assignment header depending of the type
				-- of the target (local, attribute or result).
			if l_target_type.is_true_expanded then
					-- Target is expanded: copy with possible exception
				ba.append (l_target_node.expanded_assign_code)
			else
					-- Target is basic or reference: simple attachment
				ba.append (l_target_node.assign_code)
			end
			melted_assignment_generator.generate_assignment (ba, l_target_node)
				-- Write marks if required.
			from
			until
				l_mark_count = 0
			loop
				ba.write_forward
				l_mark_count := l_mark_count - 1
			variant
				l_mark_count.as_integer_32
			end
		end

	process_attribute_b (a_node: ATTRIBUTE_B)
			-- Process `a_node'.
		do
			if attached a_node.wrapper as f then
				process_feature_b (f)
			elseif not a_node.context_type.is_basic then
					-- Access to `item' from non-basic types
					-- when the right value is not yet on the stack.
				if a_node.is_first then
					ba.append (bc_current)
					ba.append (bc_attribute)
				else
					ba.append (bc_attribute_inv)
					ba.append_raw_string (a_node.attribute_name)
				end
				ba.append_integer (a_node.routine_id)
				ba.append_natural_32 (context.real_type (a_node.type).sk_value (context.context_class_type.type))
			end
		end

	process_bin_and_b (a_node: BIN_AND_B)
			-- Process `a_node'.
		do
			process_bin_and_then_b (a_node)
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B)
			-- Process `a_node'.
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				ba.append (bc_and_then)
				ba.mark_forward
				a_node.right.process (Current)
				ba.append (bc_and)
				ba.write_forward
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_div_b (a_node: BIN_DIV_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_div)
		end

	process_bin_eq_b (a_node: BIN_EQ_B)
			-- Process `a_node'.
		do
			make_binary_equal_b (a_node, bc_eq, bc_false_compar)
		end

	process_bin_free_b (a_node: BIN_FREE_B)
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_bin_ge_b (a_node: BIN_GE_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_ge)
		end

	process_bin_gt_b (a_node: BIN_GT_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_gt)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B)
			-- Process `a_node'.
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				ba.append (bc_not)
				ba.append (bc_or_else)
				ba.mark_forward
				a_node.right.process (Current)
				ba.append (bc_or)
				ba.write_forward
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_le_b (a_node: BIN_LE_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_le)
		end

	process_bin_lt_b (a_node: BIN_LT_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_lt)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_minus)
		end

	process_bin_mod_b (a_node: BIN_MOD_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_mod)
		end

	process_bin_ne_b (a_node: BIN_NE_B)
			-- Process `a_node'.
		do
			make_binary_equal_b (a_node, bc_ne, bc_true_compar)
		end

	process_bin_not_tilde_b (a_node: BIN_NOT_TILDE_B)
			-- Process `a_node'.
		do
			process_bin_tilde_b (a_node)
			ba.append (bc_not)
		end

	process_bin_or_b (a_node: BIN_OR_B)
			-- Process `a_node'.
		do
			process_bin_or_else_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B)
			-- Process `a_node'.
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				ba.append (Bc_or_else)
				ba.mark_forward
				a_node.right.process (Current)
				ba.append (bc_or)
				ba.write_forward
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_plus_b (a_node: BIN_PLUS_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_plus)
		end

	process_bin_power_b (a_node: BIN_POWER_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_power)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_slash)
		end

	process_bin_star_b (a_node: BIN_STAR_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_star)
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B)
			-- Process `a_node'.
		local
			l_lt, l_rt: TYPE_A
		do
			l_lt := context.real_type (a_node.left.type)
			l_rt := context.real_type (a_node.right.type)

				-- For values of the same basic type the equality test is generated.
			if l_lt.is_basic and then l_rt.is_basic and then l_lt.same_as (l_rt) then
				a_node.left.process (Current)
				a_node.right.process (Current)
				ba.append (bc_eq)
			elseif
				(l_lt.is_expanded and then l_rt.is_none) or else
				(l_lt.is_none and then l_rt.is_expanded) or else
				(l_lt.is_expanded and then l_rt.is_expanded and then
				l_lt.has_associated_class and then l_rt.has_associated_class and then
				l_lt.base_class.class_id /= l_rt.base_class.class_id)
			then
					-- A value of an expanded type is not Void.
					-- Two values of different expanded types are not equal.
					-- In both cases we simply evaluate the expressions and
					-- then remove them from the stack to insert the expected value.
				a_node.left.process (Current)
				a_node.right.process (Current)
				ba.append (bc_pop)
				ba.append_uint32_integer (2)
				ba.append (bc_bool)
				ba.append_boolean (False)
			else
				a_node.left.process (Current)
				if l_lt.is_basic and then l_rt.is_reference then
					ba.append (Bc_metamorphose)
				end
				a_node.right.process (Current)
				if l_lt.is_reference and then l_rt.is_basic then
					ba.append (Bc_metamorphose)
				end
					-- FIXME: This call assumes that `is_equal' from ANY always takes
					-- `like Current' as argument, but actually it could be different.
				ba.append (bc_standard_equal)
			end
		end

	process_bin_xor_b (a_node: BIN_XOR_B)
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_xor)
		end

	process_bool_const_b (a_node: BOOL_CONST_B)
			-- Process `a_node'.
		do
			ba.append (bc_bool)
			ba.append_boolean (a_node.value)
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE])
			-- Process `a_node'.
		local
			l_area: SPECIAL [BYTE_NODE]
			i, nb: INTEGER
		do
			from
				l_area := a_node.area
				nb := a_node.count
			until
				i = nb
			loop
				l_area.item (i).process (Current)
				i := i + 1
			end
		end

	process_case_b (a_node: CASE_B)
			-- Process `a_node'.
		local
			i: INTEGER
		do
			from
				i := a_node.interval.count
			until
				i < 1
			loop
				ba.write_forward2
				i := i - 1
			end
			if attached a_node.compound as c then
				c.process (Current)
			end
				-- To end of inspect
			ba.append (Bc_jmp)
			ba.mark_forward
		end

	process_case_expression_b (b: CASE_EXPRESSION_B)
			-- <Precursor>
		local
			i: INTEGER
		do
			generate_melted_debugger_hook (ba)
			from
				i := b.interval.count
			until
				i < 1
			loop
				ba.write_forward2
				i := i - 1
			end
			b.content.process (Current)
				-- To end of inspect
			ba.append (Bc_jmp)
			ba.mark_forward
		end

	process_case_expression_b_for_type (b: CASE_EXPRESSION_B; t: TYPE_A)
			-- Same as `process_case_expression_b`, but converts result value to type `t`.
		local
			i: INTEGER
		do
			generate_melted_debugger_hook (ba)
			from
				i := b.interval.count
			until
				i < 1
			loop
				ba.write_forward2
				i := i - 1
			end
			make_expression_byte_code_for_type (b.content, t)
				-- To end of inspect
			ba.append (Bc_jmp)
			ba.mark_forward
		end

	process_char_const_b (a_node: CHAR_CONST_B)
			-- Process `a_node'.
		do
			if a_node.is_character_32 then
				ba.append (Bc_wchar)
				ba.append_character_32 (a_node.value)
			else
				ba.append (Bc_char)
				ba.append (a_node.value.to_character_8)
			end
		end

	process_char_val_b (a_node: CHAR_VAL_B)
			-- Process `a_node'.
		do
			ba.append (Bc_wchar)
			ba.append_character_32 (a_node.value)
		end

	process_check_b (a_node: CHECK_B)
			-- Process `a_node'.
		do
			if a_node.check_list /= Void then
					-- Set assertion type
				context.set_assertion_type ({ASSERT_TYPE}.In_check)

				ba.append (Bc_check)
					-- In case, the check assertions won't be checked, we
					-- have to put a jump offset
				ba.mark_forward
					-- Assertion byte code
				a_node.check_list.process (Current)
					-- Jump offset evaluation
				ba.write_forward

				context.set_assertion_type (0)
			end
		end

	process_constant_b (a_node: CONSTANT_B)
			-- Process `a_node'.
		do
			a_node.access.process (Current)
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- Process `a_node'.
		local
			l_call: ROUTINE_B
			l_nested: NESTED_B
			l_is_make_filled: BOOLEAN
			target_type: TYPE_A
		do
			target_type := context.real_type (a_node.type)
			if attached {BASIC_A} target_type as l_basic_type then
					-- Special cases for basic types where nothing needs to be created, we
					-- simply need to push a default value as their creation procedure
					-- is `default_create' and it does nothing.
				l_basic_type.c_type.make_default_byte_code (ba)
			else
				l_call := a_node.call
				if
					a_node.is_special_creation and then
					attached {SPECIAL_CLASS_TYPE} target_type.associated_class_type (context.context_class_type.type) as l_class_type
				then
					check
						is_special_call_valid: a_node.is_special_call_valid
						is_special_type:
							target_type.has_associated_class and then
							target_type.base_class.lace_class = system.special_class
					end
				 	l_is_make_filled := a_node.is_special_make_filled
					l_call.parameters.first.process (Current)
					if l_is_make_filled then
						l_call.parameters.i_th (2).process (Current)
					end
					ba.append (Bc_spcreate)
						-- Say whether or not we should fill the SPECIAL.
					ba.append_boolean (l_is_make_filled)
					ba.append_boolean (a_node.is_special_make_empty)
					a_node.info.updated_info.make_byte_code (ba)
					ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					l_class_type.make_creation_byte_code (ba)
					if l_is_make_filled then
						create l_nested
						l_nested.set_target (a_node)
						l_nested.set_message (l_call)
						l_call.set_parent (l_nested)
						make_call_access_b (l_call, bc_feature, bc_feature_inv, True, a_node.is_active)
						l_call.set_parent (Void)
					end
				else
					ba.append (Bc_create)
						-- If there is a call, we need to duplicate newly created object
						-- after its creation. This information is used by the runtime
						-- to perform this duplication.
						-- The duplication is not needed for once creation procedure calls
						-- that act as functions and return the object.
					ba.append_boolean
						(not (target_type.has_associated_class and then target_type.base_class.is_once) and then attached l_call)

						-- Create associated object.
					a_node.info.updated_info.make_byte_code (ba)
					ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)

						-- Call creation procedure if any.
					if l_call /= Void then
						create l_nested
						l_nested.set_target (a_node)
						l_nested.set_message (l_call)
						l_call.set_parent (l_nested)
						is_in_creation_call := True
						is_active_region := a_node.is_active
						l_call.process (Current)
						is_active_region := False
						is_in_creation_call := False
						l_call.set_parent (Void)
					end
				end
			end
		end

	process_current_b (a_node: CURRENT_B)
			-- Process `a_node'.
		do
			ba.append (bc_current)
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B)
			-- Process `a_node'.
		do
			check
				not_applicable: False
			end
		end

	process_debug_b (a_node: DEBUG_B)
			-- Process `a_node'.
		do
			if a_node.compound /= Void then
				ba.append (Bc_debug)
				if a_node.keys = Void then
					ba.append_integer (0)
				else
					ba.append_integer (a_node.keys.count)
					from
						a_node.keys.start
					until
						a_node.keys.after
					loop
						ba.append_integer (a_node.keys.item.count)
						ba.append_raw_string (a_node.keys.item)
						a_node.keys.forth
					end
				end
				ba.mark_forward
				a_node.compound.process (Current)
				ba.write_forward
			end
		end

	process_elsif_b (a_node: ELSIF_B)
			-- Process `a_node'.
		do
				-- Generate hook for the condition test
			generate_melted_debugger_hook (ba)

				-- Generate byte code for expression
			a_node.expr.process (Current)

				-- Test if False
			ba.append (Bc_jmp_f)
			ba.mark_forward

			if a_node.compound /= Void then
					-- Generate alternative compound byte code
				a_node.compound.process (Current)
			end
			ba.append (Bc_jmp)
			ba.mark_forward2
			ba.write_forward
		end

	process_elsif_expression_b (a_node: ELSIF_EXPRESSION_B)
			-- <Precursor>
		do
				-- Generate hook for the condition test.
			generate_melted_debugger_hook (ba)

				-- Generate byte code for condition.
			a_node.condition.process (Current)

				-- Test if False.
			ba.append (Bc_jmp_f)
			ba.mark_forward

				-- Generate hook for Then_part.
			generate_melted_debugger_hook (ba)
				-- Generate alternative expression byte code.
			a_node.expression.process (Current)
			ba.append (Bc_jmp)
			ba.mark_forward2
			ba.write_forward
		end

	process_elsif_expression_b_for_type (a_node: ELSIF_EXPRESSION_B; t: TYPE_A)
			-- Same as `process_elsif_expression_b`, but converts result value to type `t`.
		do
				-- Generate hook for the condition test.
			generate_melted_debugger_hook (ba)

				-- Generate byte code for condition.
			a_node.condition.process (Current)

				-- Test if False.
			ba.append (Bc_jmp_f)
			ba.mark_forward

				-- Generate hook for Then_part.
			generate_melted_debugger_hook (ba)
				-- Generate alternative expression byte code.
			make_expression_byte_code_for_type (a_node.expression, t)
			ba.append (Bc_jmp)
			ba.mark_forward2
			ba.write_forward
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B)
			-- Process `a_node'.
			--| Generation is exactly the same as in `process_hector_b'.
		local
			l_type: TYPE_A
		do
			l_type := Context.real_type (a_node.expr.type)
			if l_type.is_basic then
					-- Getting the address of a basic type can be done
					-- only once all the expressions have been evaluated
				ba.append (Bc_reserve)
			else
				a_node.expr.process (Current)
				if l_type.is_reference then
					ba.append (Bc_ref_to_ptr)
				end
			end
		end

	process_external_b (a_node: EXTERNAL_B)
			-- Process `a_node'.
		local
			i: INTEGER
			l_has_hector: BOOLEAN
			l_parameter_b: PARAMETER_B
			l_nb_expr_address: INTEGER
			l_pos: INTEGER
			l_is_in_creation_call: like is_in_creation_call
			l_is_active_region: like is_active_region
			creation_expression: CREATION_EXPR_B
		do
			l_is_in_creation_call := is_in_creation_call
			is_in_creation_call := False
			l_is_active_region := is_active_region
			is_active_region := False
			if a_node.parameters /= Void then
					-- Generate the expression address byte code
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_parameter_b := a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_has_hector := True
						if
							attached {EXPR_ADDRESS_B} l_parameter_b.expression as l_expr_address_b
							and then l_expr_address_b.is_protected
						then
							l_expr_address_b.expr.process (Current)
							l_nb_expr_address := l_nb_expr_address + 1
						end
					end
					a_node.parameters.forth
				end

				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					a_node.parameters.item.process (Current)
					a_node.parameters.forth
				end
			end

			if l_has_hector then
				from
					 a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_pos := l_pos + 1
					l_parameter_b := a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						if attached {HECTOR_B} l_parameter_b.expression as l_hector_b then
							make_protected_byte_code (l_hector_b, a_node.parameters.count - l_pos)
						elseif
							attached {EXPR_ADDRESS_B} l_parameter_b.expression as l_expr_address_b and then
							l_expr_address_b.is_protected
						then
							i := i + 1
							l_expr_address_b.make_protected_byte_code (ba,
								a_node.parameters.count - l_pos,
								a_node.parameters.count + l_nb_expr_address - i)
						end
					end
					a_node.parameters.forth
				end
			end

			if attached a_node.static_class_type as p then
				if a_node.is_class_target_needed then
						-- Generate an empty object to be used as a target of the call.
					create creation_expression
					creation_expression.set_info (p.create_info)
					creation_expression.set_type (p)
					process_creation_expr_b (creation_expression)
				else
					ba.append (bc_current)
				end
				ba.append (bc_extern)
				ba.append_integer (a_node.routine_id)
				make_precursor_byte_code (a_node)
			else
				make_call_access_b (a_node, bc_extern, bc_extern_inv, l_is_in_creation_call, l_is_active_region)
			end

			if l_nb_expr_address > 0 then
				ba.append (Bc_pop)
				ba.append_uint32_integer (l_nb_expr_address)
			end

			if context.real_type (a_node.type).is_reference then
					-- Box return value if required.
				ba.append (bc_metamorphose)
			end
		end

	process_feature_b (a_node: FEATURE_B)
			-- Process `a_node'.
		local
			i, l_pos, l_nb_expr_address: INTEGER
			l_has_hector: BOOLEAN
			l_parameter_b: PARAMETER_B
			l_access_expression_b: ACCESS_EXPR_B
			l_is_in_creation_call: like is_in_creation_call
			l_is_active_region: like is_active_region
		do
			l_is_in_creation_call := is_in_creation_call
			is_in_creation_call := False
			l_is_active_region := is_active_region
			is_active_region := False
			if a_node.parameters /= Void then
					-- Generate the expression address byte code
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_parameter_b := a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_has_hector := True
						if
							attached {EXPR_ADDRESS_B} l_parameter_b.expression as l_expr_address_b and then
							l_expr_address_b.is_protected
						then
							l_expr_address_b.expr.process (Current)
							l_nb_expr_address := l_nb_expr_address + 1
						end
					end
					a_node.parameters.forth
				end

				l_has_hector := l_has_hector or else (a_node.parent /= Void and then a_node.parent.target.is_hector)

					-- Generate byte code for parameters
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					a_node.parameters.item.process (Current)
					a_node.parameters.forth
				end
			end

			if l_has_hector then
				if a_node.parent /= Void and then a_node.parent.target.is_hector then
						-- We are in the case of a nested calls which have
						-- a target using the `$' operator. It can only be the case
						-- of `($a).f (..)'. where `($a)' represents an
						-- ACCESS_EXPR_B object which contains an HECTOR_B
						-- or an EXPR_ADDESS_B object.
					l_access_expression_b ?= a_node.parent.target
					check
						has_access_expression: l_access_expression_b /= Void
					end
					if attached {HECTOR_B} l_access_expression_b.expr as l_hector_b then
						make_protected_byte_code (l_hector_b, a_node.parameters.count)
					elseif
						attached {EXPR_ADDRESS_B} l_parameter_b.expression as l_expr_address_b and then
						l_expr_address_b.is_protected
					then
						i := i + 1
						l_expr_address_b.make_protected_byte_code (ba,
							a_node.parameters.count,
							a_node.parameters.count + l_nb_expr_address - i)
					end
				end
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_pos := l_pos + 1
					l_parameter_b := a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						if attached {HECTOR_B} l_parameter_b.expression as l_hector_b then
							make_protected_byte_code (l_hector_b, a_node.parameters.count - l_pos)
						elseif
							attached {EXPR_ADDRESS_B} l_parameter_b.expression as l_expr_address_b and then
							l_expr_address_b.is_protected
						then
							i := i + 1
							l_expr_address_b.make_protected_byte_code (ba,
								a_node.parameters.count - l_pos,
								a_node.parameters.count + l_nb_expr_address - i)
						end
					end
					a_node.parameters.forth
				end
			end

			make_call_access_b (a_node, bc_feature, bc_feature_inv, l_is_in_creation_call, l_is_active_region)

			if l_nb_expr_address > 0 then
				ba.append (Bc_pop)
				ba.append_uint32_integer (l_nb_expr_address)
			end

			if context.real_type (a_node.type).is_reference then
					-- Box return value if required.
				ba.append (bc_metamorphose)
			end
		end

	process_agent_call_b (a_node: AGENT_CALL_B)
			-- Process `a_node'.
		do
			process_feature_b (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B)
			-- Process `a_node'.
		local
			l_type, l_expr_type: TYPE_A
		do
			a_node.expr.process (Current)

			l_type := context.real_type (a_node.type)
			l_expr_type := context.real_type (a_node.expr.type)
			if a_node.is_conversion_needed (l_expr_type, l_type) then
				if l_expr_type.is_basic then
					ba.append (bc_metamorphose)
				else
					ba.append (bc_clone)
				end
			end
		end

	process_guard_b (a_node: GUARD_B)
			-- <Precursor>
		do
				-- Generate hook for the condition test.
			if attached a_node.check_list as c then
					-- Generated byte code for assertions.
				context.set_assertion_type ({ASSERT_TYPE}.In_guard)
				c.process (Current)
				context.set_assertion_type (0)
			end
			if attached a_node.compound as c then
					-- Generated byte code for compound.
				c.process (Current)
			end
		end

	process_hector_b (a_node: HECTOR_B)
			-- Process `a_node'.
		local
			l_type: TYPE_A
		do
			l_type := context.real_type (a_node.expr.type)
			if l_type.is_basic then
					-- Getting the address of a basic type can be done
					-- only once all the expressions have been evaluated
				ba.append (Bc_reserve)
			else
				a_node.expr.process (Current)
				if l_type.is_reference then
					ba.append (Bc_ref_to_ptr)
				end
			end
		end

	process_if_b (a_node: IF_B)
			-- Process `a_node'.
		local
			i, nb_jumps: INTEGER
		do
			if attached {HIDDEN_IF_B} a_node then
				context.enter_hidden_code
				a_node.condition.process (Current)
				context.exit_hidden_code
			else
					-- Generate hook for the condition test
				generate_melted_debugger_hook (ba)

					-- Generated byte code for condition
				a_node.condition.process (Current)
			end

				-- Generated a test
			ba.append (Bc_jmp_f)

				-- Deferred writing of the jump value
			ba.mark_forward

			if attached a_node.compound as c then
					-- Generate byte code for first compound (if any).
				c.process (Current)
			end
			ba.append (Bc_jmp)
			ba.mark_forward2
			nb_jumps := nb_jumps + 1

				-- Write the relative jump value.
			ba.write_forward

			if attached a_node.elsif_list as l then
					-- Generate byte code for alternatives.
				across
					l as e
				loop
					e.item.process (Current)
					nb_jumps := nb_jumps + 1
				end
			end

			if a_node.else_part /= Void then
					-- Generate byte code for default compound.
				a_node.else_part.process (Current)
			end

			from
					-- Generate jump values for unconditional jumps
					-- after the `nb_jumps' compounds encountered in the
					-- entire instruction.
				i := 1
			until
				i > nb_jumps
			loop
				ba.write_forward2
				i := i + 1
			end
		end

	process_if_expression_b (a_node: IF_EXPRESSION_B)
			-- <Precursor>
		local
			nb_jumps: INTEGER
			t: TYPE_A
		do
			t := context.real_type (a_node.type)

				-- Generate byte code for condition.
			a_node.condition.process (Current)

				-- Generate a test.
			ba.append (Bc_jmp_f)

				-- Deferred writing of the jump value.
			ba.mark_forward

			if a_node.has_breakpoints then
					-- Generate hook for Then_part.
				generate_melted_debugger_hook (ba)
			end
				-- Generate expression for Then_part.
			make_expression_byte_code_for_type (a_node.then_expression, t)

			ba.append (Bc_jmp)
			ba.mark_forward2
			nb_jumps := 1

				-- Write relative jump value.
			ba.write_forward

			if attached a_node.elsif_list as l then
					-- Generate byte code for alternatives.
				across
					l as c
				loop
					process_elsif_expression_b_for_type (c.item, t)
				end
				nb_jumps := nb_jumps + l.count
			end

			if a_node.has_breakpoints then
					-- Generate hook for Else_part.
				generate_melted_debugger_hook (ba)
			end
				-- Generate expression for Else_part.
			make_expression_byte_code_for_type (a_node.else_expression, t)

			from
					-- Generate jump values for unconditional jumps
					-- after the `nb_jumps' expressions encountered in the
					-- entire conditional expression.
			until
				nb_jumps <= 0
			loop
				ba.write_forward2
				nb_jumps := nb_jumps - 1
			end
		end

	process_inspect_b (b: INSPECT_B)
			-- <Precursor>
		local
			i, l_nb_jump: INTEGER
		do
			generate_melted_debugger_hook (ba)

				-- Generate switch expression byte code
			b.switch.process (Current)
			if attached b.case_list as cs then
				l_nb_jump := cs.count
					-- Generate code for the inspect intervals.
					-- Because `ba.mark_forward2` and `ba.write_forward2`use a stack,
					-- the order of intervals need to be reversed, so that compounds come
					-- in source order to preserve breakpoints order.
				across cs.new_cursor.reversed is c loop make_case_range (c) end
					-- Go to else part.
				ba.append (Bc_jmp)
				ba.mark_forward3
					-- Generate code for the inspect cases.
				across cs is c loop process_case_b (c) end
				ba.write_forward3
			end
			if attached b.else_part as p then
					-- We need to pop the value of the expression since we do not need it anymore.
				ba.append (bc_pop)
				ba.append_natural_32 (1)
				p.process (Current)
			else
				ba.append (Bc_inspect_excep)
			end

				-- Jumps for cases.
			from
				i := l_nb_jump
			until
				i < 1
			loop
				ba.write_forward
				i := i - 1
			end
		end

	process_inspect_expression_b (b: INSPECT_EXPRESSION_B)
			-- <Precursor>
		local
			i, l_nb_jump: INTEGER
			t: TYPE_A
		do
			t := context.real_type (b.type)

				-- Generate switch expression byte code.
			b.switch.process (Current)
			if attached b.case_list as cs then
				l_nb_jump := cs.count
					-- Generate code for the inspect intervals.
					-- Because `ba.mark_forward2` and `ba.write_forward2`use a stack,
					-- the order of intervals need to be reversed, so that compounds come
					-- in source order to preserve breakpoints order.
				across cs.new_cursor.reversed is c loop make_case_range (c) end
					-- Go to else part.
				ba.append (Bc_jmp)
				ba.mark_forward3
					-- Generate code for the inspect cases.
				across cs is c loop process_case_expression_b_for_type (c, t) end
				ba.write_forward3
			end
			if attached b.else_part as p then
				generate_melted_debugger_hook (ba)
					-- Pop the value of the expression that is not needed anymore.
				ba.append (bc_pop)
				ba.append_natural_32 (1)
					-- Generate code for default case.
				make_expression_byte_code_for_type (p, t)
			else
				ba.append (Bc_inspect_excep)
			end

				-- Jumps for cases.
			from
				i := l_nb_jump
			until
				i < 1
			loop
				ba.write_forward
				i := i - 1
			end
		end

	process_instr_call_b (a_node: INSTR_CALL_B)
			-- Process `a_node'.
		do
			generate_melted_debugger_hook (ba)
			a_node.call.process (Current)
		end

	process_instr_list_b (a_node: INSTR_LIST_B)
			-- Process `a_node'.
		do
			a_node.compound.process (Current)
		end

	process_int64_val_b (a_node: INT64_VAL_B)
			-- Process `a_node'.
		do
			ba.append (bc_int64)
			ba.append_integer_64 (a_node.value)
		end

	process_int_val_b (a_node: INT_VAL_B)
			-- Process `a_node'.
		do
			ba.append (bc_int32)
			ba.append_integer (a_node.value)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT)
			-- Process `a_node'.
		do
			a_node.make_byte_code (ba)
		end

	process_inv_assert_b (a_node: INV_ASSERT_B)
			-- Process `a_node'.
		do
			make_assert_b (a_node)
		end

	process_invariant_b (a_node: INVARIANT_B)
			-- Process `a_node'.
		local
			l_local_list: ARRAYED_LIST [TYPE_A]
			l_tmp_ba: BYTE_ARRAY
			l_context: like context
		do
			l_context := context
			l_local_list := l_context.local_list
			l_local_list.wipe_out
			l_context.add_locals (a_node.object_test_locals)

			create l_tmp_ba.make
			l_tmp_ba.clear

				-- Default precond- and postcondition offsets
			--l_tmp_ba.append_integer (0)
			--l_tmp_ba.append_integer (0)

				-- This is not once routine.		
			l_tmp_ba.append ('%U')

			l_tmp_ba.append (Bc_start)

				-- no Routine id
			l_tmp_ba.append_integer (0)
				-- no Real body id ( -1 because it's an invariant. We can't set a breakpoint )
			l_tmp_ba.append_integer (-1)

				-- Void result type
			l_tmp_ba.append_natural_32 (Void_type.c_type.sk_value)
				-- No arguments
			l_tmp_ba.append_short_integer (0)


			ba.append_raw_string ("_invariant")
			ba.append_short_integer (context.class_type.static_type_id - 1)

				-- No rescue
			ba.append ('%U')
			l_context.set_assertion_type ({ASSERT_TYPE}.in_invariant)

			l_context.set_original_body_index (a_node.associated_class.invariant_feature.body_index)

				-- Allocate memory for once manifest strings if required
			l_context.make_once_string_allocation_byte_code (ba, a_node.once_manifest_string_count)

			a_node.byte_list.process (Current)
			ba.append (Bc_inv_null)

				-- Generate information about types of locals.
			generate_local_types (l_local_list, l_tmp_ba)

			l_context.byte_prepend (ba, l_tmp_ba)

				-- Reset assertion type
			l_context.set_assertion_type (0)
		end

	process_local_b (a_node: LOCAL_B)
			-- Process `a_node'.
		do
			ba.append (bc_local)
			ba.append_short_integer (a_node.position)
		end

	process_loop_b (a_node: LOOP_B)
			-- Process `a_node'.
		local
			local_list: ARRAYED_LIST [TYPE_A]
			variant_local_number: INTEGER
			invariant_breakpoint_slot: INTEGER
			body_breakpoint_slot: INTEGER
			l_context: like context
			exit_count: NATURAL
			l_old_hidden_code_level: INTEGER
		do
			l_context := context
			l_old_hidden_code_level := l_context.hidden_code_level
			l_context.set_hidden_code_level (0)

			if attached a_node.iteration_initialization as i then
					-- Generate byte code for iteration initialization.
				generate_melted_debugger_hook (ba)
				l_context.enter_hidden_code
				i.process (Current)
				l_context.exit_hidden_code
			end
			if a_node.from_part /= Void then
					-- Generate byte code for the from part
				a_node.from_part.process (Current)
			end

			if a_node.variant_part /= Void then
					-- Initialization of the variant control variable
				local_list := l_context.local_list
				l_context.add_local (integer_32_type)
				variant_local_number := local_list.count
				ba.append (Bc_init_variant)
				ba.append_short_integer (variant_local_number)
			end

				-- Record context.
			invariant_breakpoint_slot := l_context.get_breakpoint_slot

			if not (a_node.invariant_part = Void and then a_node.variant_part = Void) then
				ba.append (Bc_loop)
					-- In case the loop assertion are not checked, we
					-- have to put a jump value.
				ba.mark_forward

					-- Invariant loop byte code
				if a_node.invariant_part /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					a_node.invariant_part.process (Current)
				end
					-- Variant loop byte code
				if a_node.variant_part /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					a_node.variant_part.process (Current)
					ba.append_short_integer (variant_local_number)
				end

					-- Evaluation of the jump value
				ba.write_forward
				l_context.set_assertion_type (0)
			end

				-- Generate byte code for exit expression
			ba.mark_backward

			if attached a_node.iteration_exit_condition as e then
					-- Generate a test for iteration exit condition.
				e.process (Current)
				ba.append (Bc_jmp_t)
					-- Deferred writing of the jump relative value
				ba.mark_forward
				exit_count := 1
			end
			if attached a_node.stop as s then
					-- Generate breakpoint slot.
				generate_melted_debugger_hook (ba)
					-- Generate a test for loop exit condition.
				s.process (Current)
				ba.append (Bc_jmp_t)
					-- Deferred writing of the jump relative value
				ba.mark_forward
				exit_count := exit_count + 1
			end

			if a_node.compound /= Void then
				a_node.compound.process (Current)
			end
			if attached a_node.advance_code as a then
				a.process (Current)
			end

				-- Save hook context & restore recorded context.
			body_breakpoint_slot := l_context.get_breakpoint_slot
			l_context.set_breakpoint_slot (invariant_breakpoint_slot)

			if not (a_node.invariant_part = Void and then a_node.variant_part = Void) then
				ba.append (Bc_loop)
					-- In case the loop assertion are not checked, we
					-- have to put a jump value.
				ba.mark_forward

					-- Invariant loop byte code
				if a_node.invariant_part /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					a_node.invariant_part.process (Current)
				end
					-- Variant loop byte code
				if a_node.variant_part /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					a_node.variant_part.process (Current)
					ba.append_short_integer (variant_local_number)
				end

					-- Evaluation of the jump value
				ba.write_forward
				l_context.set_assertion_type (0)
			end

				-- Restore hook context
			l_context.set_breakpoint_slot (body_breakpoint_slot)

				-- Generate an unconditional jump
			ba.append (Bc_jmp)
				-- Write offset value for unconditinal jump
			ba.write_backward

				-- Write jump value for the conditional exit(s).
			from
			until
				exit_count = 0
			loop
				ba.write_forward
				exit_count := exit_count - 1
			end

			l_context.set_hidden_code_level (l_old_hidden_code_level)
		end

	process_loop_expr_b (a_node: LOOP_EXPR_B)
			-- <Precursor>
		local
			local_list: ARRAYED_LIST [TYPE_A]
			variant_local_number: INTEGER
			result_local_number: INTEGER
			invariant_breakpoint_slot: INTEGER
			body_breakpoint_slot: INTEGER
			l_context: like context
			v: detachable VARIANT_B
			i: detachable BYTE_LIST [BYTE_NODE]
			exit_count: NATURAL
			l_old_hidden_code_level: INTEGER
		do
			l_context := context
			l_old_hidden_code_level := l_context.hidden_code_level
			l_context.set_hidden_code_level (0)

				-- Allow the debugger to stop after a nested call.
			generate_melted_debugger_hook_nested
				-- Initialize cursor without generating a debugger hook.
			l_context.enter_hidden_code
			a_node.iteration_code.process (Current)
			l_context.exit_hidden_code

			local_list := l_context.local_list

				-- Add a local to keep the loop expression result.
			l_context.add_local (boolean_type)
			result_local_number := local_list.count
			ba.append (bc_bool)
			ba.append_boolean (a_node.is_all)
			ba.append (bc_lassign)
			ba.append_short_integer (result_local_number)

			v := a_node.variant_code
			if v /= Void then
					-- Initialization of the variant control variable
				l_context.add_local (integer_32_type)
				variant_local_number := local_list.count
				ba.append (Bc_init_variant)
				ba.append_short_integer (variant_local_number)
			end

				-- Record context.
			invariant_breakpoint_slot := l_context.get_breakpoint_slot

			i := a_node.invariant_code
			if i /= Void or else v /= Void then
				ba.append (Bc_loop)
					-- In case the loop assertion are not checked, we
					-- have to put a jump value.
				ba.mark_forward
					-- Invariant loop byte code
				if i /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					i.process (Current)
				end
					-- Variant loop byte code
				if v /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					v.process (Current)
					ba.append_short_integer (variant_local_number)
				end
					-- Evaluation of the jump value
				ba.write_forward
				l_context.set_assertion_type (0)
			end

			ba.mark_backward

				-- Generate byte code for result of loop expression.
			ba.append (bc_local)
			ba.append_short_integer (result_local_number)
			if a_node.is_all then
				ba.append (bc_jmp_f)
			else
				ba.append (bc_jmp_t)
			end
				-- Deferred writing of the jump relative value
			ba.mark_forward

				-- Generate byte code for iteration exit condition.
			a_node.iteration_exit_condition_code.process (Current)
			ba.append (Bc_jmp_t)
				-- Deferred writing of the jump relative value.
			ba.mark_forward
			exit_count := 2 -- One exit condition is controlled by the loop expression variable.

			if attached a_node.exit_condition_code as e then
					-- Generate byte code for optional exit condition.
				generate_melted_debugger_hook (ba)
				e.process (Current)
				ba.append (Bc_jmp_t)
					-- Deferred writing of the jump relative value.
				ba.mark_forward
				exit_count := 3
			end

			generate_melted_debugger_hook (ba)
			a_node.expression_code.process (Current)
			ba.append (bc_lassign)
			ba.append_short_integer (result_local_number)

				-- Allow the debugger to stop after a nested call.
			generate_melted_debugger_hook_nested
				-- Advance cursor without generating a debugger hook.
			l_context.enter_hidden_code
			a_node.advance_code.process (Current)
			l_context.exit_hidden_code

				-- Save hook context & restore recorded context.
			body_breakpoint_slot := l_context.get_breakpoint_slot
			l_context.set_breakpoint_slot (invariant_breakpoint_slot)

			if i /= Void or else v /= Void then
				ba.append (Bc_loop)
					-- In case the loop assertion are not checked, we
					-- have to put a jump value.
				ba.mark_forward

					-- Invariant loop byte code
				if i /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					i.process (Current)
				end
					-- Variant loop byte code
				if v /= Void then
					l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					v.process (Current)
					ba.append_short_integer (variant_local_number)
				end

					-- Evaluation of the jump value
				ba.write_forward
				l_context.set_assertion_type (0)
			end

				-- Restore hook context
			l_context.set_breakpoint_slot (body_breakpoint_slot)

				-- Generate an unconditional jump
			ba.append (Bc_jmp)
				-- Write offset value for unconditinal jump
			ba.write_backward

				-- Write jump value for the conditional exits.
			from
			until
				exit_count = 0
			loop
				ba.write_forward
				exit_count := exit_count - 1
			end

			ba.append (bc_local)
			ba.append_short_integer (result_local_number)
			l_context.set_hidden_code_level (l_old_hidden_code_level)
		end

	process_nat64_val_b (a_node: NAT64_VAL_B)
			-- Process `a_node'.
		do
			ba.append (bc_uint64)
			ba.append_natural_64 (a_node.value)
		end

	process_nat_val_b (a_node: NAT_VAL_B)
			-- Process `a_node'.
		do
			ba.append (Bc_uint32)
			ba.append_natural_32 (a_node.value)
		end

	process_nested_b (a_node: NESTED_B)
			-- Process `a_node'.
		do
			a_node.target.process (Current)
			if a_node.target.is_feature then
				generate_melted_debugger_hook_nested
			end
			a_node.message.process (Current)
		end

	process_null_conversion_b (a_node: NULL_CONVERSION_B)
			-- Process `a_node'.
		local
			l_expr_type, l_type: TYPE_A
		do
			a_node.expr.process (Current)
			l_expr_type := context.real_type (a_node.expr.type)
			l_type := context.real_type (a_node.type)
			if not l_type.same_as (l_expr_type) then
				inspect l_type.sk_value (Void)
				when {SK_CONST}.sk_char32 then ba.append (bc_cast_char32)
				when {SK_CONST}.sk_char8 then ba.append (bc_cast_char8)
				when {SK_CONST}.sk_int8 then ba.append (bc_cast_integer) ba.append_integer (8)
				when {SK_CONST}.sk_int16 then ba.append (bc_cast_integer) ba.append_integer (16)
				when {SK_CONST}.sk_int32 then ba.append (bc_cast_integer) ba.append_integer (32)
				when {SK_CONST}.sk_int64 then ba.append (bc_cast_integer) ba.append_integer (64)
				when {SK_CONST}.sk_uint8 then ba.append (bc_cast_natural) ba.append_integer (8)
				when {SK_CONST}.sk_uint16 then ba.append (bc_cast_natural) ba.append_integer (16)
				when {SK_CONST}.sk_uint32 then ba.append (bc_cast_natural) ba.append_integer (32)
				when {SK_CONST}.sk_uint64 then ba.append (bc_cast_natural) ba.append_integer (64)
				when {SK_CONST}.sk_real32 then ba.append (bc_cast_real32)
				when {SK_CONST}.sk_real64 then ba.append (bc_cast_real64)
				else
				end
			end
		end

	process_object_test_b (a_node: OBJECT_TEST_B)
			-- Process `a_node'.
		local
			l_source_type: TYPE_A
			l_target_type: TYPE_A
		do
				-- Generate expression byte code
			l_source_type := context.real_type (a_node.expression.type)
			l_target_type := context.real_type (a_node.target.type)

			make_expression_byte_code_for_type (a_node.expression, l_target_type)

			if
					-- Assignment on something of type NONE always fails.
				l_target_type.is_none or else
					-- Assignment to an expanded variable.
				l_target_type.is_expanded and then
					-- Assigning Void to expanded.
				(l_source_type.is_none or else
					-- Non-conforming expanded types.
				l_source_type.is_expanded and then not l_source_type.conform_to (context.associated_class, l_target_type))
			then
					-- Remove expression value because it is not used.
				ba.append (bc_pop)
				ba.append_uint32_integer (1)
					-- Types do not conform or expression is not attached.
				ba.append (bc_bool)
				ba.append_boolean (False)
			elseif l_target_type.is_expanded and then l_source_type.is_expanded then
					-- Do normal assignment.
				check
					from_conformance_test_of_expanded_types:
						l_source_type.conform_to (context.associated_class, l_target_type)
				end
				ba.append
					(if l_target_type.is_basic then
						a_node.target.assign_code
					else
						a_node.target.expanded_assign_code
					end)
				melted_assignment_generator.generate_assignment (ba, a_node.target)
					-- Types conform.
				ba.append (bc_bool)
				ba.append_boolean (True)
			else
					-- Target is a reference, source is a reference, or both
				if system.is_scoop and then not l_target_type.is_separate and then l_source_type.is_separate then
						-- Check if expression object belongs to the current processor.
					ba.append (bc_separate)
						-- Placeholders not used in this instruction sequence.
					ba.append_argument_count (0)
					ba.append_boolean (True)
				end
				ba.append (bc_object_test)
				ba.append_short_integer (context.object_test_local_position (a_node.target))
					-- Generate type of target
				a_node.info.updated_info.make_byte_code (ba)
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
			end
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B)
		do
			ba.append (bc_local)
			ba.append_short_integer (context.object_test_local_position (a_node))
		end

	process_once_string_b (a_node: ONCE_STRING_B)
			-- Process `a_node'.
		local
			l_is_str32: BOOLEAN
			l_value: STRING
			l_value_32: STRING_32
		do
			l_is_str32 := a_node.is_string_32
			if l_is_str32 then
				if a_node.is_immutable then
					ba.append (bc_once_immstring32)
				else
					ba.append (bc_once_string32)
				end
			else
				if a_node.is_immutable then
					ba.append (Bc_once_immstring8)
				else
					ba.append (bc_once_string)
				end
			end
			ba.append_integer (a_node.body_index - 1)
			ba.append_integer (a_node.number - 1)
			if l_is_str32 then
				l_value_32 := a_node.value_32
					-- Bytes to read.
				ba.append_integer (l_value_32.count * 4)
				ba.append_raw_string_32 (l_value_32)
			else
				l_value := a_node.value_8
					-- Bytes to read
				ba.append_integer (l_value.count)
				ba.append_raw_string (l_value)
			end
		end

	process_operand_b (a_node: OPERAND_B)
			-- Process `a_node'.
		do
			-- Nothing to be done.
		end

	process_parameter_b (a_node: PARAMETER_B)
			-- Process `a_node'.
		local
			l_target_type, l_source_type: TYPE_A
		do
			l_target_type := context.real_type (a_node.attachment_type)
			l_source_type := context.real_type (a_node.expression.type)
			make_expression_byte_code_for_type (a_node.expression, l_target_type)
			if l_target_type.is_expanded and then l_source_type.is_none then
				ba.append (Bc_exp_excep)
			end
		end

	process_paran_b (a_node: PARAN_B)
			-- Process `a_node'.
		do
			a_node.expr.process (Current)
		end

	process_real_const_b (a_node: REAL_CONST_B)
			-- Process `a_node'.
		do
			if a_node.real_size = 64 then
				ba.append (bc_real64)
			else
				ba.append (bc_real32)
			end
			ba.append_double (a_node.value.to_double)
		end

	process_require_b (a_node: REQUIRE_B)
		do
			make_assert_b (a_node)
		end

	process_result_b (a_node: RESULT_B)
			-- Process `a_node'.
		do
			ba.append (bc_result)
		end

	process_retry_b (a_node: RETRY_B)
			-- Process `a_node'.
		do
			generate_melted_debugger_hook (ba)
			ba.append (bc_retry)
			ba.write_retry
		end

	process_reverse_b (a_node: REVERSE_B)
			-- Process `a_node'.
		local
			l_source_type: TYPE_A
			l_target_type: TYPE_A
		do
			generate_melted_debugger_hook (ba)

				-- Generate expression byte code
			l_source_type := context.real_type (a_node.source.type)
			l_target_type := context.real_type (a_node.target.type)

			make_expression_byte_code_for_type (a_node.source, l_target_type)

			if l_target_type.is_none then
				ba.append (Bc_none_assign)
			elseif l_target_type.is_expanded and then l_source_type.is_expanded then
					-- NOOP if classes are different or normal assignment otherwise.
				if
					attached {CL_TYPE_A} l_source_type as l_source_class_type and then
					attached {CL_TYPE_A} l_target_type as l_target_class_type and then
					l_target_class_type.class_id = l_source_class_type.class_id
				then
						-- Do normal assignment.
					if l_target_type.is_basic then
						ba.append (a_node.target.assign_code)
					else
						ba.append (a_node.target.expanded_assign_code)
					end
					melted_assignment_generator.generate_assignment (ba, a_node.target)
				else
						-- Remove expression value because it is not used.
					ba.append (bc_pop)
					ba.append_uint32_integer (1)
				end
			else
					-- Target is a reference
				ba.append (a_node.target.reverse_code)
				melted_assignment_generator.generate_assignment (ba, a_node.target)
					-- Generate type of target
				a_node.info.updated_info.make_byte_code (ba)
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
			end
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B)
			-- Process `a_node'.
		local
			l_type: TYPE_A
		do
				-- Closed operands
			if a_node.arguments /= Void then
				a_node.arguments.process (Current)
			end

				-- Open map
			if a_node.open_positions /= Void then
				a_node.open_positions.process (Current)
			end

				-- Now create routine object
			ba.append (Bc_rcreate)

				-- Do we have arguments (a TUPLE) on the stack?
			ba.append_boolean (a_node.arguments /= Void)

				-- Generate byte code for `a_node.type'.
			l_type := context.real_type (a_node.type)
			l_type.make_full_type_byte_code (ba, context.context_class_type.type)

				-- Routine ID of the routine
			ba.append_integer_32 (a_node.rout_id)
				-- is_basic
			ba.append_boolean (a_node.is_basic)
				-- is_target_closed
			ba.append_boolean (a_node.is_target_closed)
				-- is_inline_agent
			if a_node.is_inline_agent then
				ba.append_integer_32 (a_node.class_type.static_type_id (context.current_type) - 1)
			else
				ba.append_integer_32 (-1)
			end
				-- open_count
			if a_node.omap /= Void then
				ba.append_integer (a_node.omap.count)
			else
				ba.append_integer (0)
			end
		end

	process_separate_b (a_node: SEPARATE_INSTRUCTION_B)
			-- <Precursor>
		do
				-- Generate evaluation of arguments.
			a_node.arguments.process (Current)
				-- Check if a compound needs to be generated.
			if attached a_node.compound as c and then not c.is_empty then
				if system.is_scoop then
						-- Generate byte code to add a request group.
						-- Push all arguments to the evaluation stack.
					across
						a_node.arguments as a
					loop
						check attached {OBJECT_TEST_LOCAL_B} a.item.target as argument then
							argument.process (Current)
						end
					end
						-- Create a request group.
					ba.append (bc_start_separate)
					ba.append_natural_16 (a_node.arguments.count.as_natural_16)
				end
					-- Generate byte code for the compound.
				c.process (Current)
				if system.is_scoop then
						-- Generate byte code to remove a request group.
					ba.append (bc_end_separate)
				end
			end
		end

	process_string_b (a_node: STRING_B)
			-- Process `a_node'.
		local
			l_value: STRING_8
			l_value_32: STRING_32
		do
			if a_node.is_string_32 then
				l_value_32 := a_node.value_32
				if a_node.is_immutable then
					ba.append (Bc_immstring32)
				else
					ba.append (Bc_string32)
				end
					-- Bytes to read
				ba.append_integer (l_value_32.count * 4)
				ba.append_raw_string_32 (l_value_32)
			else
				l_value := a_node.value_8
				if a_node.is_immutable then
					ba.append (Bc_immstring8)
				else
					ba.append (Bc_string)
				end
					-- Bytes to read
				ba.append_integer (l_value.count)
				ba.append_raw_string (l_value)
			end
		end

	process_strip_b (a_node: STRIP_B)
			-- Process `a_node'.
		local
			l_attr_names: LINKED_LIST [STRING]
		do
			l_attr_names := a_node.attribute_names
			across
				l_attr_names as names
			loop
				ba.append (Bc_add_strip)
				ba.append_raw_string (names.item)
			end
			ba.append (Bc_end_strip)
			ba.append_short_integer (context.class_type.type_id - 1)
			ba.append_integer (l_attr_names.count)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- Process `a_node'.
		local
			l_tuple_type: TYPE_A
		do
			l_tuple_type := context.real_type (a_node.tuple_element_type)
				-- It is guaranteed that the TUPLE object is on the stack because
				-- TUPLE_ACCESS_B is always the message of a NESTED_B node.
			if a_node.source /= Void then
					-- Assignment to a tuple entry.
				a_node.source.process (Current)
				if a_node.source.is_hector then
					if attached {HECTOR_B} a_node.source.expression as l_hector_b then
						make_protected_byte_code (l_hector_b, 0)
					else
							-- Address expressions are disallowed.
						check False end
					end
				end
				if l_tuple_type.c_type.is_reference then
					context.make_tuple_catcall_check (ba, a_node.position)
				end
				if system.is_scoop and then a_node.context_type.is_separate then
						-- Perform separate tuple access if required.
					ba.append (bc_separate)
						-- There is one argument and the access is not synchronized.
					ba.append_argument_count (1)
					ba.append_boolean (False)
						-- Make sure that target is at the top.
					ba.append (bc_rotate)
					ba.append_short_integer (2)
				end
				ba.append (bc_tuple_assign)
				ba.append_integer_32 (a_node.position)
			else
					-- Access to tuple field.
				if system.is_scoop and then a_node.context_type.is_separate then
						-- Perform separate tuple access if required.
					ba.append (bc_separate)
						-- There are no arguments and the access is synchronized.
					ba.append_argument_count (0)
					ba.append_boolean (True)
				end
				ba.append (bc_tuple_access)
				ba.append_integer_32 (a_node.position)
				ba.append_natural_32 (l_tuple_type.sk_value (context.context_class_type.type))
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- Process `a_node'.
		local
			l_real_ty: TUPLE_TYPE_A
			l_expr: EXPR_B
		do
			l_real_ty ?= context.real_type (a_node.type)
				-- Need to insert expression into
				-- the stack back to front in order
				-- to be inserted into the area correctly
			from
				a_node.expressions.finish
			until
				a_node.expressions.before
			loop
				l_expr := a_node.expressions.item
				check l_expr_not_void: l_expr /= Void end
				l_expr.process (Current)
				if l_expr.is_hector then
					if attached {HECTOR_B} l_expr as l_hector_b then
						make_protected_byte_code (l_hector_b, 0)
					else
							-- Address expressions are disallowed for tuple
							-- initialization.
						check False end
					end
				end
				a_node.expressions.back
			end
			ba.append (Bc_tuple)
			l_real_ty.make_type_byte_code (ba, True, context.context_class_type.type)
			ba.append_short_integer (-1)
			ba.append_integer (a_node.expressions.count + 1)
			if l_real_ty.is_basic_uniform then
				ba.append_integer (1)
			else
				ba.append_integer (0)
			end
		end

	process_type_expr_b (a_node: TYPE_EXPR_B)
			-- Process `a_node'.
		local
			l_type_type: TYPE_A
		do
			ba.append (Bc_create_type)
				-- There is no feature call:
			ba.append_boolean (False)

			l_type_type := context.descendant_type (a_node.type_type)
			l_type_type.create_info.make_byte_code (ba)
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)

				-- Add annotations, if any, of the declaration of the manifest type.
				-- For example, we could have `detachable like x', the above code only
				-- generates the type of `like x' and does not include the attachment mark.
				-- Discard the upper bits as `RTLNTY2' only accepts the lower part.
			ba.append_natural_16 (l_type_type.annotation_flags & 0x00FF)
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B])
			-- Process `a_node'.
		do
			-- Nothing to be done.
		end

	process_un_free_b (a_node: UN_FREE_B)
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_minus_b (a_node: UN_MINUS_B)
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_uminus)
		end

	process_un_not_b (a_node: UN_NOT_B)
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_not)
		end

	process_un_old_b (a_node: UN_OLD_B)
			-- Process `a_node'.
		do
			if a_node.is_exception_block_needed then
				ba.append (Bc_retrieve_old)
				ba.append_short_integer (a_node.position)
				ba.append_short_integer (a_node.exception_position)
			else
				ba.append (bc_local)
				ba.append_short_integer (a_node.position)
			end
		end

	process_un_plus_b (a_node: UN_PLUS_B)
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_uplus)
		end

	process_variant_b (a_node: VARIANT_B)
			-- Process `a_node'.
		do
			make_assert_b (a_node)
		end

	process_void_b (a_node: VOID_B)
			-- Process `a_node'.
		do
			ba.append (bc_void)
		end

feature {NONE} -- Implementation

	make_expression_byte_code_for_type (an_expr: EXPR_B; a_target_type: TYPE_A)
			-- Generate byte code for the expression which is about
			-- to be assigned or compared to the type `a_target_type'.
		require
			expr_not_void: an_expr /= Void
			target_type_not_void: a_target_type /= Void
		local
			l_expression_type: TYPE_A
		do
			an_expr.process (Current)
			l_expression_type := context.real_type (an_expr.type)

			if a_target_type.is_reference then
				if l_expression_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose
					ba.append (Bc_metamorphose)
				elseif l_expression_type.is_expanded then
						-- Source is expanded and target is a reference:
						-- clone
					ba.append (Bc_clone)
				else
						-- Source can be a boxed expanded object.
					generate_dynamic_clone (an_expr, l_expression_type)
				end
			elseif l_expression_type.is_none then
					-- Reattachment of void to expanded.
				ba.append (Bc_exp_excep)
			elseif not a_target_type.is_basic then
				if l_expression_type.is_true_expanded then
						-- Source and target are expanded:
						-- clone
					ba.append (Bc_clone)
				elseif not l_expression_type.is_basic then
						-- Source can be a boxed expanded object.
					generate_dynamic_clone (an_expr, l_expression_type)
				end
			end
		end

	generate_dynamic_clone (expression: EXPR_B; type: TYPE_A)
			-- Generate code that clones result of an `expression' depending on
			-- dynamic type of object of static type `type'.
		require
			expression_not_void: expression /= Void
			type_not_void: type /= Void
			type_is_reference: type.is_reference
		do
			if expression.is_dynamic_clone_required (type) then
				ba.append (bc_cclone)
			end
		end

	make_assert_b (a_node: ASSERT_B)
			-- Generate code for `ASSERT_B' node.
		require
			a_node_not_void: a_node /= Void
		do
				-- Assertion mark
			if context.assertion_type = {ASSERT_TYPE}.in_precondition then
				make_precondition_byte_code (a_node)
			else
				if context.assertion_type /= {ASSERT_TYPE}.in_invariant then
						-- No hooks when it is an invariant
					generate_melted_debugger_hook (ba)
				end
				ba.append (Bc_assert)
				inspect
					context.assertion_type
				when {ASSERT_TYPE}.in_postcondition then
					ba.append (Bc_pst)
				when {ASSERT_TYPE}.in_check then
					ba.append (Bc_chk)
				when {ASSERT_TYPE}.in_guard then
					ba.append (Bc_guard)
				when {ASSERT_TYPE}.in_loop_invariant then
					ba.append (Bc_linv)
				when {ASSERT_TYPE}.in_loop_variant then
					ba.append (Bc_lvar)
				when {ASSERT_TYPE}.in_invariant then
					ba.append (Bc_inv)
				end

					-- Generate the tag name if any.
				if a_node.tag = Void then
					ba.append (Bc_notag)
				else
					ba.append (Bc_tag)
					ba.append_raw_string (a_node.tag)
				end

					-- Assertion byte code
				a_node.expr.process (Current)

					-- End assertion mark
				if context.assertion_type = {ASSERT_TYPE}.in_loop_variant then
					ba.append (bc_end_variant)
				else
						-- For guards, we do not want the `in_assertion' to be affected,
						-- so we generate an extra boolean computation to let the interpreter
						-- do the right thing.
					ba.append (bc_end_assert)
					ba.append_boolean (context.assertion_type /= {ASSERT_TYPE}.in_guard)
				end
			end
		end

	make_precondition_byte_code (a_node: ASSERT_B)
			-- Generate byte code for a precondition.
		local
			l_context: like context
			l_ba: like ba
		do
			l_context := context
			l_ba := ba
			if l_context.is_new_precondition_block then
				l_context.set_new_precondition_block (False)
				if l_context.is_first_precondition_block_generated then
					from
					until
						l_ba.forward_marks4.count = 0
					loop
						l_ba.write_forward4
					end
					l_ba.append (Bc_goto_body)
					ba.mark_forward
				else
					l_context.set_first_precondition_block_generated (True)
				end
			end

				-- generate a debugger hook
			generate_melted_debugger_hook (ba)

			l_ba.append (Bc_assert)
			l_ba.append (Bc_pre)
			if a_node.tag = Void then
				l_ba.append (Bc_notag)
			else
				l_ba.append (Bc_tag)
				l_ba.append_raw_string (a_node.tag)
			end
				-- It's possible that there is a wait condition.
				-- Whether this is true or not is detected at run-time
				-- by inspecting if the argument used in the precondition
				-- as a separate target is controlled or not.
			separate_target_collector.clean
			a_node.expr.process (separate_target_collector)
			if separate_target_collector.has_separate_target then
					-- Enumerate all separate arguments used as a target of a call.
				across
					separate_target_collector.target as s
				loop
					l_ba.append (bc_wait_arg)
					l_ba.append_short_integer (s.item)
				end
			end
				-- Assertion byte code
			a_node.expr.process (Current)
			l_ba.append (Bc_end_pre)
			l_ba.mark_forward4
		end

	make_protected_byte_code (a_node: HECTOR_B; a_pos: INTEGER)
			-- Generate byte code for an unprotected external call argument
		require
			a_node_not_void: a_node /= Void
		local
			l_type: TYPE_A
		do
			l_type := context.real_type (a_node.expr.type)
			if l_type.is_basic then
				ba.append (Bc_object_addr)
				ba.append_uint32_integer (a_pos)
				a_node.expr.process (Current)
			end
		end

	make_binary_b (a_node: BINARY_B; a_node_opcode: CHARACTER)
			-- Generate code for `a_node'
		require
			a_node_not_void: a_node /= Void
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				a_node.right.process (Current)
					-- Write binary operator.
				ba.append (a_node_opcode)
			else
				a_node.nested_b.process (Current)
			end
		end

	make_binary_equal_b (a_node: BIN_EQUAL_B; a_node_opcode, a_node_obvious_opcode: CHARACTER)
			-- Generate code for `a_node'
		require
			a_node_not_void: a_node /= Void
			a_node_opcode_valid: a_node_opcode = bc_eq or a_node_opcode = bc_ne
			a_node_obvious_opcode_valid: a_node_obvious_opcode = bc_true_compar or
				a_node_obvious_opcode = bc_false_compar
		local
			l_lt, l_rt: TYPE_A
			l_flag: BOOLEAN
		do
			l_lt := context.real_type (a_node.left.type)
			l_rt := context.real_type (a_node.right.type)

			a_node.left.process (Current)
			if l_lt.is_basic and then l_rt.is_reference then
				ba.append (Bc_metamorphose)
				l_flag := True
			end

			a_node.right.process (Current)
			if l_lt.is_reference and then l_rt.is_basic then
				ba.append (Bc_metamorphose)
				l_flag := True
			end

			if l_lt.is_true_expanded or else l_rt.is_true_expanded or else l_flag then
					-- Standard equality
				ba.append (bc_standard_equal)
				if a_node_opcode = bc_ne then
					ba.append (bc_not)
				end
			elseif (l_lt.is_basic and then l_rt.is_none) or else (l_lt.is_none and then l_rt.is_basic) then
					-- A basic type is neither Void
				ba.append (a_node_obvious_opcode)
			elseif
				l_lt.is_reference and then
				l_rt.is_reference and then
				a_node.left.is_dynamic_clone_required (l_lt) and then
				a_node.right.is_dynamic_clone_required (l_rt)
			then
					-- Reference type equality.
					-- Check if one of the operands is of expanded type
					-- and use object comparison. Use reference comparison
					-- otherwise.
				ba.append (Bc_cequal)
				if a_node_opcode = bc_ne then
					ba.append (bc_not)
				end
			else
					-- Pure reference or basic type equality.
				ba.append (a_node_opcode)
			end
		end

	make_unary_b (a_node: UNARY_B; a_node_opcode: CHARACTER)
			-- Generate code for unary operator
		require
			a_node_not_void: a_node /= Void
		do
			if a_node.is_built_in then
				a_node.expr.process (Current)
					-- Write unary operator
				ba.append (a_node_opcode)
			else
				a_node.nested_b.process (Current)
			end
		end

	make_case_range (a_node: ABSTRACT_CASE_B [BYTE_NODE])
			-- Generate range byte code
		require
			a_node_not_void: a_node /= Void
		local
			i: INTEGER
			l_inter: INTERVAL_B
		do
			from
				i := a_node.interval.count
			until
				i < 1
			loop
				l_inter := a_node.interval.i_th (i)
				l_inter.lower.process (Current)
				l_inter.upper.process (Current)
				ba.append (bc_range)
				ba.mark_forward2
				i := i - 1
			end
		end

	make_call_access_b (a_node: ROUTINE_B; code_first, code_next: CHARACTER; is_creation: BOOLEAN; is_active: BOOLEAN)
			-- Generate call to EXTERNAL_B/FEATURE_B.
			-- Generate byte code for a feature call.
			-- `is_creation' indicates if this is a call to a creation procedure and `is_active' tells that an active region is to be created in case of a separate target type.
			-- if `meta', metamorphose the feature call.
			-- Doesn't process the parameters
		require
			a_node_not_void: a_node /= Void
		local
			l_inst_cont_type: TYPE_A
			l_finish_byte_code: BOOLEAN
			creation_expression: CREATION_EXPR_B
		do
			l_inst_cont_type := a_node.context_type
			if system.is_scoop and then l_inst_cont_type.is_separate then
					-- The call may be separate.
				ba.append (bc_separate)
					-- Arguments need to be passed together with feature information.
				if attached a_node.parameters as p then
					ba.append_argument_count (p.count)
				else
					ba.append_argument_count (0)
				end
					-- Indicate if this is a query or procedure call and in case of separate creation whether the target region is active.
				ba.append_boolean (not a_node.type.is_void or else is_active)
			end
				-- Note: Manu 08/08/2002: if `a_node.precursor_type' is not Void, it can only means
				-- that we are currently performing a static access call on a feature
				-- from a basic class. Assuming otherwise is not correct as you
				-- cannot seriously inherit from a basic class.
			if l_inst_cont_type.is_basic and a_node.precursor_type = Void and then attached {BASIC_A} l_inst_cont_type as l_basic_type then
				if a_node.is_feature_special (False, l_basic_type) then
					a_node.make_special_byte_code (ba, l_basic_type, a_node.type)
				else
						-- Process the call via the `feature_name' in the
						-- associated reference type
					if a_node.parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (a_node.parameters.count + 1)
					end
					ba.append (Bc_metamorphose)
					l_finish_byte_code := True
				end
			else
				if a_node.is_first then
						--! Cannot melt basic calls hence is_first
						--! is not used in the above if meta statement.
					if a_node.is_class_target_needed then
							-- Generate an empty object to be used as a target of the call.
						check
							instance_free_call_has_precursor_type: attached a_node.precursor_type as p
						then
							create creation_expression
							creation_expression.set_info (p.create_info)
							creation_expression.set_type (p)
							process_creation_expr_b (creation_expression)
						end
					else
						ba.append (Bc_current)
					end
				else
					if a_node.parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (a_node.parameters.count + 1)
					end
				end
				l_finish_byte_code := True
			end
			if l_finish_byte_code then
				if is_creation then
					ba.append (bc_creation)
				elseif a_node.is_first then
					ba.append (code_first)
				else
					ba.append (code_next)
					ba.append_raw_string (a_node.feature_name)
				end
				ba.append_integer (a_node.routine_id)
				make_precursor_byte_code (a_node)
			end
		end

	make_precursor_byte_code (a_node: ROUTINE_B)
			-- Generate precursor byte code if needed.
		local
			l_type: TYPE_A
		do
			if a_node.is_target_type_fixed then
				l_type := context.real_type (a_node.precursor_type)
				if l_type.is_multi_constrained then
					check
						has_multi_constraint_static: a_node.has_multi_constraint_static
					end
					l_type := context.real_type (a_node.multi_constraint_static)
				end
				ba.append_short_integer (l_type.static_type_id (context.context_class_type.type) - 1)
			else
				ba.append_short_integer (-1)
			end
		end

feature {BYTE_NODE} -- Debugger hook

	generate_melted_debugger_hook (a_ba: BYTE_ARRAY)
			-- Record breakable point (standard)
		require
			a_ba_attached: a_ba /= Void
		local
			lnr: INTEGER
			ctx: like context
		do
			ctx := context
			if
				not ctx.is_inside_hidden_code and then
				attached ctx.current_feature as cf and then
				cf.supports_step_in
			then
				lnr := ctx.get_next_breakpoint_slot
				check
					valid_line: lnr > 0
				end
				a_ba.generate_melted_debugger_hook (lnr)
			end
		end

	generate_melted_debugger_hook_nested
			-- Record breakable point for nested call
		local
			l_line, l_nested: INTEGER
			ctx: like context
		do
			ctx := context
			if
				not ctx.is_inside_hidden_code and then
				attached ctx.current_feature as cf and then
				cf.supports_step_in
			then
				l_line := ctx.get_breakpoint_slot
				if l_line > 0 then
						-- Generate a hook when there is really need for one.
						-- (E.g. we do not need a hook for the code generation
						-- of an invariant).
					l_nested := ctx.get_next_breakpoint_nested_slot
					ba.generate_melted_debugger_hook_nested (l_line, l_nested)
				end
			end
		end

feature -- Type information

	generate_local_types (l: ARRAYED_LIST [TYPE_A]; b: BYTE_ARRAY)
			-- Generate types of locals `l' into byte array `b'.
		require
			l_attached: attached l
			b_attached: attached b
		do
			b.append_short_integer (l.count)
			across l as loc loop
				generate_local_type (loc.item, b)
			end
		end

	generate_local_type (t: TYPE_A; b: BYTE_ARRAY)
			-- Generate type information for a local of type `t' into byte array `b'.
		local
			r: TYPE_A
		do
			r := context.real_type (t)
			b.append_natural_32 (r.sk_value (context.context_class_type.type))
			if r.is_true_expanded then
					-- Generate full type info.
				t.make_full_type_byte_code (b, context.context_class_type.type)
			end
		end

feature {NONE} -- SCOOP

	separate_target_collector: SEPARATE_TARGET_COLLECTOR
			-- Visitor to detect wait conditions.
		once
			create Result
		end

note
	ca_ignore: "CA033", "CA033: too large class"
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
