indexing
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

feature -- Initialize

	generate (a_ba: BYTE_ARRAY; a_node: BYTE_NODE) is
			-- Generate `a_node''s code into `a_ba'.
		require
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
		do
			ba := a_ba
			a_node.process (Current)
			ba := Void
		end

	generate_old_expression_initialization (a_ba: BYTE_ARRAY; a_node: UN_OLD_B) is
			-- Generate `a_node''s code into `a_ba'.
		require
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
		do
			ba := a_ba
			a_node.expr.process (Current)
				-- Write the end of last old expression evaluation.
			ba.write_forward
			ba.append (bc_old)
			ba.append_short_integer (a_node.position)
			ba.append_short_integer (a_node.exception_position)
				-- Mark start of next old expression evaluation.
			ba.mark_forward
			ba := Void
		end

feature -- Access

	ba: BYTE_ARRAY
			-- Byte array where melted code is stored.

	is_in_creation_call: BOOLEAN
			-- Is current call a creation instruction?


feature -- Routine visitor

	process_std_byte_code (a_node: STD_BYTE_CODE) is
			-- Process current element.
		do
		end

feature {NONE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B) is
			-- Process `a_node'.
		do
			a_node.expr.process (Current)
		end

	process_address_b (a_node: ADDRESS_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_addr)
			ba.append_integer (
				system.address_table.id_of_dollar_feature (a_node.feature_class_id, a_node.feature_id, context.class_type))
		end

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_arg)
			ba.append_short_integer (a_node.position)
		end

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		local
			l_real_ty: GEN_TYPE_A
			l_feat_i: FEATURE_I
			l_expr: EXPR_B
			l_target_type: TYPE_A
			l_base_class: CLASS_C
			l_rout_info: ROUT_INFO
		do
			fixme ("We should use `info' to create byte code")
			l_real_ty ?= context.real_type (a_node.type)
			l_target_type := l_real_ty.generics.item (1)
			l_base_class := l_real_ty.associated_class
			l_feat_i := l_base_class.feature_table.item_id ({PREDEFINED_NAMES}.make_name_id)
			from
				a_node.expressions.start
			until
				a_node.expressions.after
			loop
				l_expr ?= a_node.expressions.item
				check
					l_expr_not_void: l_expr /= Void
				end
				make_expression_byte_code_for_type (l_expr, l_target_type)
				a_node.expressions.forth
			end
			if l_base_class.is_precompiled then
				ba.append (Bc_parray)
				l_rout_info := System.rout_info_table.item (l_feat_i.rout_id_set.first)
				ba.append_integer (l_rout_info.origin)
				ba.append_integer (l_rout_info.offset)
				ba.append_short_integer (l_real_ty.type_id (context.context_class_type.type) - 1)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				l_real_ty.make_gen_type_byte_code (ba, True, context.context_class_type.type)
				ba.append_short_integer (-1)
			else
				ba.append (Bc_array)
				ba.append_short_integer (l_real_ty.static_type_id (context.context_class_type.type) - 1)
				ba.append_short_integer (l_real_ty.type_id (context.context_class_type.type) - 1)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				l_real_ty.make_gen_type_byte_code (ba, True, context.context_class_type.type)
				ba.append_short_integer (-1)
				ba.append_short_integer (l_feat_i.feature_id)
			end
			ba.append_integer (a_node.expressions.count)
		end

	process_assert_b (a_node: ASSERT_B) is
			-- Process `a_node'.
		do
			make_assert_b (a_node, bc_end_assert)
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		local
			l_target_type: TYPE_A
			l_target_node: ACCESS_B
			l_hector_b: HECTOR_B
		do
			generate_melted_debugger_hook
				-- Generate expression byte code	
			l_target_node := a_node.target
			l_target_type := Context.real_type_fixed (l_target_node.type)
			if a_node.is_creation_instruction then
					-- Avoid object cloning.
				a_node.source.process (Current)
				if a_node.source.is_hector then
					l_hector_b ?= a_node.source
					check l_hector_b_not_void: l_hector_b /= Void end
					make_protected_byte_code (l_hector_b, 0)
				end
			else
					-- Clone source object depending on its type and type of target.
				make_expression_byte_code_for_type (a_node.source, l_target_type)
			end
				-- Generate assignment header depending of the type
				-- of the target (local, attribute or result).
			if l_target_type.is_bit then
				ba.append (l_target_node.bit_assign_code)
			elseif l_target_type.is_true_expanded then
					-- Target is expanded: copy with possible exception
				ba.append (l_target_node.expanded_assign_code)
			else
					-- Target is basic or reference: simple attachment
				ba.append (l_target_node.assign_code)
			end
			melted_assignment_generator.generate_assignment (ba, l_target_node)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_type: TYPE_A
			l_cl_type: CL_TYPE_A
			l_rout_info: ROUT_INFO
		do
			l_type := context.real_type (a_node.type)
			l_cl_type ?= a_node.context_type
			if l_cl_type.is_basic and not l_cl_type.is_bit then
					-- Access to `item' from basic types.
					-- Nothing to be done since the right value is already on the stack.
			else
				if a_node.is_first then
					ba.append (bc_current)
				end
				if l_cl_type.associated_class.is_precompiled then
					l_rout_info := system.rout_info_table.item (a_node.routine_id)
					if a_node.is_first then
						ba.append (bc_pattribute)
					else
						ba.append (bc_pattribute_inv)
						ba.append_raw_string (a_node.attribute_name)
					end
					ba.append_integer (l_rout_info.origin)
					ba.append_integer (l_rout_info.offset)
				else
					if a_node.is_first then
						ba.append (bc_attribute)
					else
						ba.append (bc_attribute_inv)
						ba.append_raw_string (a_node.attribute_name)
					end
					ba.append_integer (a_node.real_feature_id (l_cl_type))
					ba.append_short_integer (l_cl_type.static_type_id (context.context_class_type.type) - 1)
				end
				ba.append_uint32_integer (l_type.sk_value (context.context_class_type.type))
			end
		end

	process_bin_and_b (a_node: BIN_AND_B) is
			-- Process `a_node'.
		do
			process_bin_and_then_b (a_node)
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B) is
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

	process_bin_div_b (a_node: BIN_DIV_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_div)
		end

	process_bin_eq_b (a_node: BIN_EQ_B) is
			-- Process `a_node'.
		do
			make_binary_equal_b (a_node, bc_eq, bc_false_compar)
		end

	process_bin_free_b (a_node: BIN_FREE_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_bin_ge_b (a_node: BIN_GE_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_ge)
		end

	process_bin_gt_b (a_node: BIN_GT_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_gt)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B) is
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

	process_bin_le_b (a_node: BIN_LE_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_le)
		end

	process_bin_lt_b (a_node: BIN_LT_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_lt)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_minus)
		end

	process_bin_mod_b (a_node: BIN_MOD_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_mod)
		end

	process_bin_ne_b (a_node: BIN_NE_B) is
			-- Process `a_node'.
		do
			make_binary_equal_b (a_node, bc_ne, bc_true_compar)
		end

	process_bin_or_b (a_node: BIN_OR_B) is
			-- Process `a_node'.
		do
			process_bin_or_else_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B) is
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

	process_bin_plus_b (a_node: BIN_PLUS_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_plus)
		end

	process_bin_power_b (a_node: BIN_POWER_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_power)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_slash)
		end

	process_bin_star_b (a_node: BIN_STAR_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_star)
		end

	process_bin_xor_b (a_node: BIN_XOR_B) is
			-- Process `a_node'.
		do
			make_binary_b (a_node, bc_xor)
		end

	process_bit_const_b (a_node: BIT_CONST_B) is
			-- Process `a_node'.
		do
			ba.append (bc_bit)
			ba.append_integer (a_node.value.count)
			ba.append_bit (a_node.value)
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
			ba.append (bc_bool)
			ba.append_boolean (a_node.value)
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE]) is
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

	process_case_b (a_node: CASE_B) is
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
			if a_node.compound /= Void then
				a_node.compound.process (Current)
			end
				-- To end of inspect
			ba.append (Bc_jmp)
			ba.mark_forward
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
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

	process_char_val_b (a_node: CHAR_VAL_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_wchar)
			ba.append_character_32 (a_node.value)
		end

	process_check_b (a_node: CHECK_B) is
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
			end
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		do
			a_node.access.process (Current)
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B) is
			-- Process `a_node'.
		local
			l_basic_type: BASIC_A
			l_special_type: GEN_TYPE_A
			l_class_type: SPECIAL_CLASS_TYPE
			l_call: CALL_ACCESS_B
			l_nested: NESTED_B
		do
			l_basic_type ?= context.real_type_fixed (a_node.type)
			if l_basic_type /= Void then
					-- Special cases for basic types where nothing needs to be created, we
					-- simply need to push a default value as their creation procedure
					-- is `default_create' and it does nothing.
				l_basic_type.c_type.make_default_byte_code (ba)
			else
				l_call := a_node.call
				if l_call /= Void and then l_call.routine_id = system.special_make_rout_id then
					l_special_type ?= context.creation_type (a_node.type)
					check
						is_special_call_valid: a_node.is_special_call_valid
						is_special_type: l_special_type /= Void and then
							l_special_type.associated_class.lace_class = system.special_class
					end
					l_class_type ?= l_special_type.associated_class_type (context.context_class_type.type)
					check
						l_class_type_not_void: l_class_type /= Void
					end
					l_call.parameters.first.process (Current)
					ba.append (Bc_spcreate)
					a_node.info.make_byte_code (ba)
					l_class_type.make_creation_byte_code (ba)
				else
					ba.append (Bc_create)
						-- If there is a call, we need to duplicate newly created object
						-- after its creation. This information is used by the runtime
						-- to do this duplication.
					ba.append_boolean (l_call /= Void)

						-- Create associated object.
					a_node.info.make_byte_code (ba)

						-- Call creation procedure if any.
					if l_call /= Void then
						create l_nested
						l_nested.set_target (a_node)
						l_nested.set_message (l_call)
						l_call.set_parent (l_nested)
						is_in_creation_call := True
						l_call.process (Current)
						is_in_creation_call := False
						l_call.set_parent (Void)
					end
				end
					-- Runtime is in charge to make sure that newly created object
					-- has been duplicated so that we can check the invariant.
				ba.append (Bc_create_inv)
			end
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		do
			ba.append (bc_current)
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B) is
			-- Process `a_node'.
		do
			check
				not_applicable: False
			end
		end

	process_debug_b (a_node: DEBUG_B) is
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

	process_elsif_b (a_node: ELSIF_B) is
			-- Process `a_node'.
		do
				-- Generate hook for the condition test
			generate_melted_debugger_hook

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

	process_expr_address_b (a_node: EXPR_ADDRESS_B) is
			-- Process `a_node'.
		do
			if a_node.expr.type.is_basic then
					-- computation of the offset will be done once
					-- all the arguements are pushed on the stack.
				ba.append (Bc_reserve)
			else
				a_node.expr.process (Current)
			end
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		local
			i, l_type_id: INTEGER
			l_has_hector: BOOLEAN
			l_parameter_b: PARAMETER_B
			l_hector_b: HECTOR_B
			l_expr_address_b: EXPR_ADDRESS_B
			l_nb_expr_address: INTEGER
			l_pos, r_id: INTEGER
			l_cl_type: CL_TYPE_A
			l_is_in_creation_call: like is_in_creation_call
			l_rout_info: ROUT_INFO
		do
			l_is_in_creation_call := is_in_creation_call
			is_in_creation_call := False
			if a_node.parameters /= Void then
					-- Generate the expression address byte code
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_parameter_b ?= a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_has_hector := True
						l_expr_address_b ?= l_parameter_b.expression
						if l_expr_address_b /= Void and then l_expr_address_b.is_protected then
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
					l_parameter_b ?= a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_hector_b ?= l_parameter_b.expression
						if l_hector_b /= Void then
							make_protected_byte_code (l_hector_b, a_node.parameters.count - l_pos)
						else
								-- Cannot be Void
							l_expr_address_b ?= l_parameter_b.expression
							if l_expr_address_b.is_protected then
								i := i + 1
								l_expr_address_b.make_protected_byte_code (ba,
									a_node.parameters.count - l_pos,
									a_node.parameters.count + l_nb_expr_address - i)
							end
						end
					end
					a_node.parameters.forth
				end
			end

			if a_node.is_static_call then
				ba.append (bc_current)
				l_cl_type ?= context.real_type (a_node.static_class_type)
				if l_cl_type.associated_class.is_precompiled then
					r_id := a_node.routine_id
					l_rout_info := System.rout_info_table.item (r_id)
					ba.append (bc_pextern)
					ba.append_integer (l_rout_info.origin)
					ba.append_integer (l_rout_info.offset)
				else
					ba.append (bc_extern)
					ba.append_integer (a_node.real_feature_id (l_cl_type))
					l_type_id := l_cl_type.static_type_id (context.context_class_type.type) - 1
					ba.append_short_integer (l_type_id)
				end
				make_precursor_byte_code (a_node)
			else
				make_call_access_b (
					a_node, bc_extern, bc_extern_inv, bc_pextern, bc_pextern_inv, l_is_in_creation_call)
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

	process_feature_b (a_node: FEATURE_B) is
			-- Process `a_node'.
		local
			i, l_pos, l_nb_expr_address: INTEGER
			l_has_hector: BOOLEAN
			l_parameter_b: PARAMETER_B
			l_hector_b: HECTOR_B
			l_expr_address_b: EXPR_ADDRESS_B
			l_access_expression_b: ACCESS_EXPR_B
			l_is_in_creation_call: like is_in_creation_call
		do
			l_is_in_creation_call := is_in_creation_call
			is_in_creation_call := False
			if a_node.parameters /= Void then
					-- Generate the expression address byte code
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_parameter_b ?= a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_has_hector := True
						l_expr_address_b ?= l_parameter_b.expression
						if l_expr_address_b /= Void and then l_expr_address_b.is_protected then
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
				if (a_node.parent /= Void and then a_node.parent.target.is_hector) then
						-- We are in the case of a nested calls which have
						-- a target using the `$' operator. It can only be the case
						-- of `($a).f (..)'. where `($a)' represents an
						-- ACCESS_EXPR_B object which contains an HECTOR_B
						-- or an EXPR_ADDESS_B object.
					l_access_expression_b ?= a_node.parent.target
					check
						has_access_expression: l_access_expression_b /= Void
					end
					l_hector_b ?= l_access_expression_b.expr
					if l_hector_b /= Void then
						make_protected_byte_code (l_hector_b, a_node.parameters.count)
					else
						l_expr_address_b ?= l_parameter_b.expression
						check
							expr_address_b_not_void: l_expr_address_b /= Void
						end
						if l_expr_address_b.is_protected then
							i := i + 1
							l_expr_address_b.make_protected_byte_code (ba,
								a_node.parameters.count,
								a_node.parameters.count + l_nb_expr_address - i)
						end
					end
				end
				from
					a_node.parameters.start
				until
					a_node.parameters.after
				loop
					l_pos := l_pos + 1
					l_parameter_b ?= a_node.parameters.item
					if l_parameter_b /= Void and then l_parameter_b.is_hector then
						l_hector_b ?= l_parameter_b.expression
						if l_hector_b /= Void then
							make_protected_byte_code (l_hector_b, a_node.parameters.count - l_pos)
						else
								-- Cannot be Void
							l_expr_address_b ?= l_parameter_b.expression
							if l_expr_address_b.is_protected then
								i := i + 1
								l_expr_address_b.make_protected_byte_code (ba,
									a_node.parameters.count - l_pos,
									a_node.parameters.count + l_nb_expr_address - i)
							end
						end
					end
					a_node.parameters.forth
				end
			end

			make_call_access_b (
				a_node, bc_feature, bc_feature_inv, bc_pfeature, bc_pfeature_inv, l_is_in_creation_call)

			if l_nb_expr_address > 0 then
				ba.append (Bc_pop)
				ba.append_uint32_integer (l_nb_expr_address)
			end

			if context.real_type (a_node.type).is_reference then
					-- Box return value if required.
				ba.append (bc_metamorphose)
			end
		end

	process_agent_call_b (a_node: AGENT_CALL_B) is
			-- Process `a_node'.
		do
			process_feature_b (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B) is
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

	process_hector_b (a_node: HECTOR_B) is
			-- Process `a_node'.
		do
			if not a_node.is_pointer or else a_node.expr.type.is_basic then
					-- Getting the address of a basic type can be done
					-- only once all the expressions have been evaluated
				ba.append (Bc_reserve)
			else
				a_node.expr.process (Current)
				if a_node.expr.type.is_reference then
					ba.append (Bc_ref_to_ptr)
				end
			end
		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		local
			l_elsif_clause: ELSIF_B
			i, nb_jumps: INTEGER
		do
				-- Generate hook for the condition test
			generate_melted_debugger_hook

				-- Generated byte code for condition
			a_node.condition.process (Current)

				-- Generated a test
			ba.append (Bc_jmp_f)

				-- Deferred writing of the jump value
			ba.mark_forward

			if a_node.compound /= Void then
					-- Generated byte code for first compound (if any).
				a_node.compound.process (Current)
			end
			ba.append (Bc_jmp)
			ba.mark_forward2
			nb_jumps := nb_jumps + 1

				-- Writes the relative jump value.
			ba.write_forward

			if a_node.elsif_list /= Void then
					-- Generates byte code for alternatives
				from
					a_node.elsif_list.start
				until
					a_node.elsif_list.after
				loop
					l_elsif_clause ?= a_node.elsif_list.item
					check l_elsif_clause_not_void: l_elsif_clause /= Void end
					l_elsif_clause.process (Current)
					nb_jumps := nb_jumps + 1
					a_node.elsif_list.forth
				end
			end

			if a_node.else_part /= Void then
					-- Generates byte code for default compound.
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

	process_inspect_b (a_node: INSPECT_B) is
			-- Process `a_node'.
		local
			i, l_nb_jump: INTEGER
			l_case: CASE_B
		do
			generate_melted_debugger_hook

				-- Generate switch expression byte code
			a_node.switch.process (Current)
			if a_node.case_list /= Void then
				from
					i := a_node.case_list.count
					l_nb_jump := i
				until
					i < 1
				loop
					l_case ?= a_node.case_list.i_th (i)
					check
						l_case_not_void: l_case /= Void
					end
					make_case_range (l_case)
					i := i - 1
				end
				ba.append (Bc_jmp)
				ba.mark_forward3		-- To else part
				a_node.case_list.process (Current)
				ba.write_forward3
			end
			if a_node.else_part /= Void then
				a_node.else_part.process (Current)
			else
				ba.append (Bc_inspect_excep)
			end

				-- Jumps for cases compounds
			from
				i := l_nb_jump
			until
				i < 1
			loop
				ba.write_forward
				i := i - 1
			end
			ba.append (Bc_inspect)
		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do
			generate_melted_debugger_hook
			a_node.call.process (Current)
		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do
			a_node.compound.process (Current)
		end

	process_int64_val_b (a_node: INT64_VAL_B) is
			-- Process `a_node'.
		do
			ba.append (bc_int64)
			ba.append_integer_64 (a_node.value)
		end

	process_int_val_b (a_node: INT_VAL_B) is
			-- Process `a_node'.
		do
			ba.append (bc_int32)
			ba.append_integer (a_node.value)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		do
			a_node.make_byte_code (ba)
		end

	process_inv_assert_b (a_node: INV_ASSERT_B) is
			-- Process `a_node'.
		do
			make_assert_b (a_node, bc_end_assert)
		end

	process_invariant_b (a_node: INVARIANT_B) is
			-- Process `a_node'.
		local
			l_local_list: LINKED_LIST [TYPE_A]
			l_tmp_ba: BYTE_ARRAY
			l_context: like context
		do
			l_context := context
			l_local_list := l_context.local_list
			l_local_list.wipe_out

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
			l_tmp_ba.append_integer (Void_type.c_type.sk_value)
				-- No arguments
			l_tmp_ba.append_short_integer (0)

				-- No rescue
			ba.append ('%U')
			l_context.set_assertion_type ({ASSERT_TYPE}.in_invariant)

			l_context.set_original_body_index (a_node.associated_class.invariant_feature.body_index)

				-- Allocate memory for once manifest strings if required
			l_context.make_once_string_allocation_byte_code (ba, a_node.once_manifest_string_count)

			a_node.byte_list.process (Current)
			ba.append (Bc_inv_null)

			from
				l_tmp_ba.append_short_integer (l_local_list.count)
				l_local_list.start
			until
				l_local_list.after
			loop
				l_tmp_ba.append_integer (l_local_list.item.sk_value (context.context_class_type.type))
				l_local_list.forth
			end

			l_context.byte_prepend (ba, l_tmp_ba)
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			ba.append (bc_local)
			ba.append_short_integer (a_node.position)
		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		local
			local_list: LINKED_LIST [TYPE_A]
			variant_local_number: INTEGER
			invariant_breakpoint_slot: INTEGER
			body_breakpoint_slot: INTEGER
			l_context: like context
		do
			l_context := context
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
					-- Set the assertion type
				l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)

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
			end

				-- Generate byte code for exit expression
			ba.mark_backward
			generate_melted_debugger_hook
			a_node.stop.process (Current)

				-- Generate a test
			ba.append (Bc_jmp_t)

				-- Deferred writing of the jump relative value
			ba.mark_forward

			if a_node.compound /= Void then
				a_node.compound.process (Current)
			end

				-- Save hook context & restore recorded context.
			body_breakpoint_slot := l_context.get_breakpoint_slot
			l_context.set_breakpoint_slot (invariant_breakpoint_slot)

			if not (a_node.invariant_part = Void and then a_node.variant_part = Void) then
					-- Set the assertion type
				l_context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)

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
			end

				-- Restore hook context
			l_context.set_breakpoint_slot (body_breakpoint_slot)

				-- Generate an unconditional jump
			ba.append (Bc_jmp)
				-- Write offset value for unconditinal jump
			ba.write_backward

				-- Write jump value for conditional exit
			ba.write_forward
		end

	process_nat64_val_b (a_node: NAT64_VAL_B) is
			-- Process `a_node'.
		do
			ba.append (bc_uint64)
			ba.append_natural_64 (a_node.value)
		end

	process_nat_val_b (a_node: NAT_VAL_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_uint32)
			ba.append_natural_32 (a_node.value)
		end

	process_nested_b (a_node: NESTED_B) is
			-- Process `a_node'.
		do
			a_node.target.process (Current)
			if a_node.target.is_feature then
				generate_melted_debugger_hook_nested
			end
			a_node.message.process (Current)
		end

	process_object_test_b (a_node: OBJECT_TEST_B) is
			-- Process `a_node'.
		local
			l_source_type: TYPE_A
			l_target_type: TYPE_A
			l_source_class_type: CL_TYPE_A
			l_target_class_type: CL_TYPE_A
		do
				-- Generate expression byte code
			l_source_type := context.real_type (a_node.expression.type)
			l_target_type := context.creation_type (a_node.target.type)

			make_expression_byte_code_for_type (a_node.expression, l_target_type)

			if l_target_type.is_none then
					-- Remove expression value because it is not used.
				ba.append (bc_pop)
				ba.append_uint32_integer (1)
					-- Types do not conform or expression is not attached.
				ba.append (bc_bool)
				ba.append_boolean (False)
			elseif l_target_type.is_expanded and then l_source_type.is_expanded then
					-- NOOP if classes are different or normal assignment otherwise.
				l_source_class_type ?= l_source_type
				l_target_class_type ?= l_target_type
				if
					l_target_class_type /= Void and then l_source_class_type /= Void and then
					l_target_class_type.class_id = l_source_class_type.class_id
				then
						-- Do normal assignment.
					if l_target_type.is_bit then
						ba.append (a_node.target.bit_assign_code)
					elseif l_target_type.is_basic then
						ba.append (a_node.target.assign_code)
					else
						ba.append (a_node.target.expanded_assign_code)
					end
					melted_assignment_generator.generate_assignment (ba, a_node.target)
						-- Types conform.
					ba.append (bc_bool)
					ba.append_boolean (True)
				else
						-- Remove expression value because it is not used.
					ba.append (bc_pop)
					ba.append_uint32_integer (1)
						-- Types do not conform.
					ba.append (bc_bool)
					ba.append_boolean (False)
				end
			else
					-- Target is a reference, source is a reference, or both
				ba.append (bc_object_test)
				ba.append_short_integer (a_node.target.position)
					-- Generate type of target
				a_node.info.make_byte_code (ba)
			end
		end

	process_once_string_b (a_node: ONCE_STRING_B) is
			-- Process `a_node'.
		do
			ba.append (bc_once_string)
			ba.append_integer (a_node.body_index - 1)
			ba.append_integer (a_node.number - 1)
			ba.append_integer (a_node.value.count)
			ba.append_raw_string (a_node.value)
		end

	process_operand_b (a_node: OPERAND_B) is
			-- Process `a_node'.
		do
			-- Nothing to be done.
		end

	process_parameter_b (a_node: PARAMETER_B) is
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

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
			a_node.expr.process (Current)
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
			if a_node.real_size = 64 then
				ba.append (bc_real64)
			else
				ba.append (bc_real32)
			end
			ba.append_double (a_node.value.to_double)
		end

	process_require_b (a_node: REQUIRE_B) is
		do
			make_assert_b (a_node, bc_end_assert)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			ba.append (bc_result)
		end

	process_retry_b (a_node: RETRY_B) is
			-- Process `a_node'.
		do
			generate_melted_debugger_hook
			ba.append (bc_retry)
			ba.write_retry
		end

	process_reverse_b (a_node: REVERSE_B) is
			-- Process `a_node'.
		local
			l_source_type: TYPE_A
			l_target_type: TYPE_A
			l_source_class_type: CL_TYPE_A
			l_target_class_type: CL_TYPE_A
		do
			generate_melted_debugger_hook

				-- Generate expression byte code
			l_source_type := context.real_type (a_node.source.type)
			l_target_type := context.real_type (a_node.target.type)

			make_expression_byte_code_for_type (a_node.source, l_target_type)

			if l_target_type.is_none then
				ba.append (Bc_none_assign)
			elseif l_target_type.is_expanded and then l_source_type.is_expanded then
					-- NOOP if classes are different or normal assignment otherwise.
				l_source_class_type ?= l_source_type
				l_target_class_type ?= l_target_type
				if
					l_target_class_type /= Void and then l_source_class_type /= Void and then
					l_target_class_type.class_id = l_source_class_type.class_id
				then
						-- Do normal assignment.
					if l_target_type.is_bit then
						ba.append (a_node.target.bit_assign_code)
					elseif l_target_type.is_basic then
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
				a_node.info.make_byte_code (ba)
			end
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B) is
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

			if a_node.is_precompiled then
				ba.append_integer (a_node.rout_origin)
				ba.append_integer (a_node.rout_offset)
			else
					-- Note that we use `context.current_type' because we do not adapt
					-- `a_node.class_type' to `context.context_class_type' for the simple reasons
					-- that `feature_id' is the one from where the agent creation is declared.
					-- If we were to adapt it, then we would need something like `{CALL_ACCESS_B}.real_feature_id'
					-- for a proper code generation.
				ba.append_integer (a_node.class_type.static_type_id (context.current_type) - 1)
					-- feature_id
				ba.append_integer (a_node.feature_id)
			end
				-- is_precompiled
			ba.append_boolean (a_node.is_precompiled)
				-- is_basic
			ba.append_boolean (a_node.is_basic)
				-- is_target_closed
			ba.append_boolean (a_node.is_target_closed)
				-- is_inline_agent
			ba.append_boolean (a_node.is_inline_agent)
				-- open_count
			if a_node.omap /= Void then
				ba.append_integer (a_node.omap.count)
			else
				ba.append_integer (0)
			end
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_string)
			ba.append_integer (a_node.value.count)
			ba.append_raw_string (a_node.value)
		end

	process_strip_b (a_node: STRIP_B) is
			-- Process `a_node'.
		local
			l_attr_names: LINKED_LIST [STRING]
		do
			l_attr_names := a_node.attribute_names
			from
				l_attr_names.start
			until
				l_attr_names.after
			loop
				ba.append (Bc_add_strip)
				ba.append_raw_string (l_attr_names.item)
				l_attr_names.forth
			end
			ba.append (Bc_end_strip)
			ba.append_short_integer (context.class_type.type_id - 1)
			ba.append_integer (l_attr_names.count)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B) is
			-- Process `a_node'.
		do
				-- It is guaranteed that the TUPLE object is on the stack because
				-- TUPLE_ACCESS_B is always the message of a NESTED_B node.
			if a_node.source /= Void then
					-- Assignment to a tuple entry.
				generate_melted_debugger_hook
				a_node.source.process (Current)
				ba.append (bc_tuple_assign)
			else
					-- Access to tuple entry.
				ba.append (bc_tuple_access)
			end
			ba.append_integer_32 (a_node.position)
			ba.append_uint32_integer (a_node.tuple_element_type.sk_value (context.context_class_type.type))
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B) is
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
				l_expr ?= a_node.expressions.item
				check l_expr_not_void: l_expr /= Void end
				l_expr.process (Current)
				a_node.expressions.back
			end
			if l_real_ty.associated_class.is_precompiled then
				ba.append (Bc_ptuple)
				ba.append_short_integer (l_real_ty.type_id (context.context_class_type.type) - 1)
				ba.append_short_integer (context.class_type.static_type_id-1)
				l_real_ty.make_gen_type_byte_code (ba, True, context.context_class_type.type)
				ba.append_short_integer (-1)
			else
				ba.append (Bc_tuple)
				ba.append_short_integer (l_real_ty.type_id (context.context_class_type.type) - 1)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				l_real_ty.make_gen_type_byte_code (ba, True, context.context_class_type.type)
				ba.append_short_integer (-1)
			end
			ba.append_integer (a_node.expressions.count + 1)
			if l_real_ty.is_basic_uniform then
				ba.append_integer (1)
			else
				ba.append_integer (0)
			end
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		local
			l_type_creator: CREATE_TYPE
		do
			fixme ("Instance should be unique.")
			ba.append (Bc_create)
				-- There is no feature call:
			ba.append_boolean (False)

			create l_type_creator.make (context.real_type (a_node.type_data))
			l_type_creator.make_byte_code (ba)

				-- Runtime is in charge to make sure that newly created object
				-- has been duplicated so that we can check the invariant.
			ba.append (bc_create_inv)
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B]) is
			-- Process `a_node'.
		do
			-- Nothing to be done.
		end

	process_un_free_b (a_node: UN_FREE_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_minus_b (a_node: UN_MINUS_B) is
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_uminus)
		end

	process_un_not_b (a_node: UN_NOT_B) is
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_not)
		end

	process_un_old_b (a_node: UN_OLD_B) is
			-- Process `a_node'.
		do
			ba.append (Bc_retrieve_old)
			ba.append_short_integer (a_node.position)
			ba.append_short_integer (a_node.exception_position)
		end

	process_un_plus_b (a_node: UN_PLUS_B) is
			-- Process `a_node'.
		do
			make_unary_b (a_node, bc_uplus)
		end

	process_variant_b (a_node: VARIANT_B) is
			-- Process `a_node'.
		do
			make_assert_b (a_node, bc_end_variant)
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		do
			ba.append (bc_void)
		end

feature {NONE} -- Implementation

	make_expression_byte_code_for_type (an_expr: EXPR_B; a_target_type: TYPE_A) is
			-- Generate byte code for the expression which is about
			-- to be assigned or compared to the type `a_target_type'.
		require
			expr_not_void: an_expr /= Void
			target_type_not_void: a_target_type /= Void
		local
			l_expression_type: TYPE_A
			l_hector_b: HECTOR_B
		do
			an_expr.process (Current)
			l_expression_type := context.real_type (an_expr.type)

			if an_expr.is_hector then
				l_hector_b ?= an_expr
				check l_hector_b_not_void: l_hector_b /= Void end
				make_protected_byte_code (l_hector_b, 0)
			end

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
			elseif not a_target_type.is_basic and then l_expression_type.is_true_expanded then
					-- Source and target are expanded:
					-- clone
				ba.append (Bc_clone)
			end
		end

	generate_dynamic_clone (expression: EXPR_B; type: TYPE_A) is
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

	make_assert_b (a_node: ASSERT_B; a_byte_for_end: CHARACTER) is
			-- Generate code for `ASSERT_B' node.
		require
			a_node_not_void: a_node /= Void
		do
				-- Assertion mark
			inspect
				context.assertion_type
			when {ASSERT_TYPE}.in_precondition then
				make_precondition_byte_code (a_node)
			when {ASSERT_TYPE}.in_postcondition then
					-- generate a debugger hook
				generate_melted_debugger_hook
				ba.append (Bc_assert)
				ba.append (Bc_pst)
			when {ASSERT_TYPE}.in_check then
					-- generate a debugger hook
				generate_melted_debugger_hook
				ba.append (Bc_assert)
				ba.append (Bc_chk)
			when {ASSERT_TYPE}.in_loop_invariant then
					-- generate a debugger hook
				generate_melted_debugger_hook
				ba.append (Bc_assert)
				ba.append (Bc_linv)
			when {ASSERT_TYPE}.in_loop_variant then
					-- generate a debugger hook
				generate_melted_debugger_hook
				ba.append (Bc_assert)
				ba.append (Bc_lvar)
			when {ASSERT_TYPE}.in_invariant then
					-- Do not generate a hook.
				ba.append (Bc_assert)
				ba.append (Bc_inv)
			end
			if context.assertion_type /= {ASSERT_TYPE}.in_precondition then
				if a_node.tag = Void then
					ba.append (Bc_notag)
				else
					ba.append (Bc_tag)
					ba.append_raw_string (a_node.tag)
				end
					-- Assertion byte code
				a_node.expr.process (Current)

					-- End assertion mark
				ba.append (a_byte_for_end)
			end
		end

	make_precondition_byte_code (a_node: ASSERT_B) is
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
			generate_melted_debugger_hook

			l_ba.append (Bc_assert)
			l_ba.append (Bc_pre)
			if a_node.tag = Void then
				l_ba.append (Bc_notag)
			else
				l_ba.append (Bc_tag)
				l_ba.append_raw_string (a_node.tag)
			end

				-- Assertion byte code
			a_node.expr.process (Current)
			l_ba.append (Bc_end_pre)
			l_ba.mark_forward4
		end

	make_protected_byte_code (a_node: HECTOR_B; a_pos: INTEGER) is
			-- Generate byte code for an unprotected external call argument
		require
			a_node_not_void: a_node /= Void
		do
			if not a_node.is_pointer or else a_node.expr.type.is_basic then
				ba.append (Bc_object_addr)
				ba.append_uint32_integer (a_pos)
				a_node.expr.process (Current)
			end
		end

	make_binary_b (a_node: BINARY_B; a_node_opcode: CHARACTER) is
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

	make_binary_equal_b (a_node: BIN_EQUAL_B; a_node_opcode, a_node_obvious_opcode: CHARACTER) is
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
			if (l_lt.is_basic and then l_rt.is_reference) then
				ba.append (Bc_metamorphose)
				l_flag := True
			end

			a_node.right.process (Current)
			if (l_lt.is_reference and then l_rt.is_basic) then
				ba.append (Bc_metamorphose)
				l_flag := True
			end

			if l_lt.is_true_expanded or else l_rt.is_true_expanded or else l_flag then
					-- Standard equality
				ba.append (bc_standard_equal)
				if a_node_opcode = bc_ne then
					ba.append (bc_not)
				end
			elseif l_lt.is_bit and then l_rt.is_bit then
					-- Bit equality
				ba.append (bc_bit_standard_equal)
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

	make_unary_b (a_node: UNARY_B; a_node_opcode: CHARACTER) is
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

	make_case_range (a_node: CASE_B) is
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

	make_call_access_b (a_node: CALL_ACCESS_B; code_first, code_next, precomp_code_first, precomp_code_next: CHARACTER; flag: BOOLEAN) is
			-- Generate call to EXTERNAL_B/FEATURE_B.
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
			-- if `meta', metamorphose the feature call.
			-- Doesn't process the parameters
		require
			a_node_not_void: a_node /= Void
		local
			l_basic_type: BASIC_A
			l_cl_type: CL_TYPE_A
			l_associated_class: CLASS_C
			l_feat_tbl: FEATURE_TABLE
			l_inst_cont_type: TYPE_A
			l_metamorphosed: BOOLEAN
			r_id: INTEGER
			l_rout_info: ROUT_INFO
		do
			l_inst_cont_type := a_node.context_type
			l_metamorphosed := l_inst_cont_type.is_basic and then not l_inst_cont_type.is_bit
				-- Note: Manu 08/08/2002: if `a_node.precursor_type' is not Void, it can only means
				-- that we are currently performing a static access call on a feature
				-- from a basic class. Assuming otherwise is not correct as you
				-- cannot seriously inherit from a basic class.
			if l_metamorphosed and a_node.precursor_type = Void then
				l_basic_type ?= l_inst_cont_type
				if a_node.is_feature_special (False, l_basic_type) then
					a_node.make_special_byte_code (ba, l_basic_type)
				else
						-- Process the feature id of `feature_name' in the
						-- associated reference type
					l_associated_class := l_basic_type.reference_type.associated_class
					l_feat_tbl := l_associated_class.feature_table
					if a_node.parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (a_node.parameters.count + 1)
					end
					ba.append (Bc_metamorphose)
					if l_associated_class.is_precompiled then
						r_id := l_feat_tbl.item_id (a_node.feature_name_id).rout_id_set.first
						l_rout_info := System.rout_info_table.item (r_id)
						if a_node.is_first or flag then
							ba.append (precomp_code_first)
						else
							ba.append (precomp_code_next)
							ba.append_raw_string (a_node.feature_name)
						end
						ba.append_integer (l_rout_info.origin)
						ba.append_integer (l_rout_info.offset)
						make_precursor_byte_code (a_node)
					else
						if a_node.is_first or flag then
							ba.append (code_first)
						else
							ba.append (code_next)
							ba.append_raw_string (a_node.feature_name)
						end
						ba.append_integer (l_feat_tbl.item_id (a_node.feature_name_id).feature_id)
						ba.append_short_integer (l_basic_type.associated_reference_class_type.static_type_id - 1)
						make_precursor_byte_code (a_node)
					end
				end
			else
				l_cl_type ?= l_inst_cont_type
				if a_node.is_first then
						--! Cannot melt basic calls hence is_first
						--! is not used in the above if meta statement.
					ba.append (Bc_current)
				else
					if a_node.parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (a_node.parameters.count + 1)
					end
				end
				l_associated_class := l_cl_type.associated_class
				if l_associated_class.is_precompiled then
					r_id := a_node.routine_id
					l_rout_info := System.rout_info_table.item (r_id)
					if a_node.is_first or flag then
						ba.append (precomp_code_first)
					else
						ba.append (precomp_code_next)
						ba.append_raw_string (a_node.feature_name)
					end
					ba.append_integer (l_rout_info.origin)
					ba.append_integer (l_rout_info.offset)
					make_precursor_byte_code (a_node)
				else
					if a_node.is_first or flag then
						ba.append (code_first)
					else
						ba.append (code_next)
						ba.append_raw_string (a_node.feature_name)
					end
					ba.append_integer (a_node.real_feature_id (l_cl_type))
					ba.append_short_integer (l_cl_type.static_type_id (context.context_class_type.type) - 1)
					make_precursor_byte_code (a_node)
				end
			end
		end

	make_precursor_byte_code (a_node: CALL_ACCESS_B) is
			-- Generate precursor byte code if needed.
		local
			l_cl_type: CL_TYPE_A
		do
			if a_node.precursor_type /= Void then
				l_cl_type ?= context.real_type (a_node.precursor_type)
				check l_cl_type_not_void: l_cl_type /= Void end
				ba.append_short_integer (l_cl_type.static_type_id (context.context_class_type.type) - 1)
			else
				ba.append_short_integer (-1)
			end
		end

	generate_melted_debugger_hook is
			-- Record breakable point (standard)
		local
			lnr: INTEGER
		do
			if context.current_feature /= Void and then context.current_feature.supports_step_in then
				lnr := context.get_next_breakpoint_slot
				check
					valid_line: lnr > 0
				end
				ba.generate_melted_debugger_hook (lnr)
			end
		end

	generate_melted_debugger_hook_nested is
			-- Record breakable point for nested call
		local
			l_line: INTEGER
		do
			if context.current_feature /= Void and then context.current_feature.supports_step_in then
				l_line := context.get_breakpoint_slot
				if l_line > 0 then
						-- Generate a hook when there is really need for one.
						-- (E.g. we do not need a hook for the code generation
						-- of an invariant).
					ba.generate_melted_debugger_hook_nested (l_line)
				end
			end
		end

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
