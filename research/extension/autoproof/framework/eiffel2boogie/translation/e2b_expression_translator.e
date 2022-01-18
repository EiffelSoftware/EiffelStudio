deferred class
	E2B_EXPRESSION_TRANSLATOR

inherit

	E2B_VISITOR
		redefine
			process_agent_call_b,
			process_argument_b,
			process_array_const_b,
			process_attribute_b,
			process_bin_and_b,
			process_bin_and_then_b,
			process_bin_div_b,
			process_bin_eq_b,
			process_bin_free_b,
			process_bin_ge_b,
			process_bin_gt_b,
			process_bin_implies_b,
			process_bin_le_b,
			process_bin_lt_b,
			process_bin_minus_b,
			process_bin_ne_b,
			process_bin_mod_b,
			process_bin_or_b,
			process_bin_or_else_b,
			process_bin_plus_b,
			process_bin_power_b,
			process_bin_slash_b,
			process_bin_star_b,
			process_bin_tilde_b,
			process_bin_xor_b,
			process_bool_const_b,
			process_char_const_b,
			process_char_val_b,
			process_constant_b,
			process_creation_expr_b,
			process_current_b,
			process_external_b,
			process_feature_b,
			process_if_expression_b,
			process_int64_val_b,
			process_int_val_b,
			process_integer_constant,
			process_local_b,
			process_loop_expr_b,
			process_nat64_val_b,
			process_nat_val_b,
			process_nested_b,
			process_null_conversion_b,
			process_object_test_b,
			process_object_test_local_b,
			process_parameter_b,
			process_paran_b,
			process_result_b,
			process_real_const_b,
			process_routine_creation_b,
			process_string_b,
			process_tuple_access_b,
			process_tuple_const_b,
			process_type_expr_b,
			process_un_free_b,
			process_un_minus_b,
			process_un_not_b,
			process_un_old_b,
			process_un_plus_b,
			process_void_b
		end

	E2B_SHARED_CONTEXT
		export {NONE} all end

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	SHARED_BYTE_CONTEXT

	COMPILER_EXPORTER

feature {NONE} -- Initialization

	make
			-- Initialize translator.
		do
			reset
		end

feature -- Access

	entity_mapping: E2B_ENTITY_MAPPING
			-- Entity mapping used for translation.

	last_expression: IV_EXPRESSION
			-- Last generated expression.

	side_effect: LINKED_LIST [IV_STATEMENT]
			-- List of side effect statements.			

	context_feature: FEATURE_I
			-- Context of expression.

	context_type: CL_TYPE_A
			-- Context of expression.

	context_line_number: INTEGER
			-- (approximate) line number of expression.

	context_tag: detachable STRING
			-- Context tag of expression (if any).

	current_target: IV_EXPRESSION
			-- Current target.

	current_target_type: CL_TYPE_A
			-- Type of current target.

	locals_map: HASH_TABLE [IV_EXPRESSION, INTEGER]
			-- Mapping of object test locals to entities.

	across_handler_map: HASH_TABLE [E2B_ACROSS_HANDLER, INTEGER]
			-- Mapping of object test locals from across loops to across handlers.

	context_writable: IV_EXPRESSION
			-- Writable frame of the enclosing context.
		do
			if local_writable = Void then
				Result := factory.global_writable
			else
				Result := local_writable
			end
		end

	context_readable: IV_EXPRESSION
			-- Readable frame of the enclosing context if defined, otherwise Void.

	use_triggers: BOOLEAN
			-- Should triggers be added to generated quntifiers?

	use_uninterpreted_context_function: BOOLEAN
			-- Translate function calls to `context_feature' with its uninterpreted version.

feature -- Convenience

	class_type_in_current_context (a_type: TYPE_A): CL_TYPE_A
			-- Class type that correspond to `a_type' in the context of `context_type' and possibly `context_feature'.
		require
			a_type_attached: attached a_type
			context_type_attached: attached context_type
			context_feature_attached: attached context_feature
		do
			Result := helper.class_type_in_context (a_type, context_feature.written_class, context_feature, context_type)
		end

	feature_class_type (a_feature: FEATURE_I): CL_TYPE_A
			-- Type of `a_feature' in the context of `current_target_type'			
		require
			a_feature_attached: attached a_feature
			current_target_type_attached: attached current_target_type
		do
			Result := helper.class_type_in_context (a_feature.type, context_type.base_class, a_feature, context_type)
		end

	expression_class_type (a_node: EXPR_B): CL_TYPE_A
			-- Type of `a_expr' in current context (takes redefinition into account).
		require
			a_node_attched: attached a_node
			current_target_type_attached: attached current_target_type
		do
			if attached {EXTERNAL_B} a_node as ext and then ext.is_static_call then
				Result := feature_class_type (helper.feature_for_call_access (ext, ext.static_class_type))
			elseif attached { CALL_ACCESS_B } a_node as ca then
				Result := feature_class_type (helper.feature_for_call_access (ca, current_target_type))
			elseif attached { RESULT_B } a_node as res then
				check attached context_feature and then context_feature.has_return_value end
				Result := feature_class_type (context_feature)
			else
				Result := class_type_in_current_context (a_node.type)
			end
		end

feature -- Element change

	set_current_target (a_expression: IV_EXPRESSION)
			-- Set `current_target' to `a_expression'.
		do
			current_target := a_expression
		end

	set_current_target_type (a_type: CL_TYPE_A)
			-- Set `current_target_type' to `a_type'.
		do
			current_target_type := a_type
		end

	set_last_expression (a_expression: IV_EXPRESSION)
			-- Set `last_expression' to `a_expression'.
		do
			last_expression := a_expression
		end

	set_context_line_number (a_line: INTEGER)
			-- Set (approximate) line number of expression.
		do
			context_line_number := a_line
		end

	set_context_tag (a_tag: STRING)
			-- Set context tag.
		do
			context_tag := a_tag
		end

feature -- Basic operations

	set_context (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Set context of expression to `a_feature' in type `a_type'.
		require
			a_feature_attached: attached a_feature
			a_type_attached: attached a_type
		do
			context_feature := a_feature
			context_type := a_type
			current_target_type := a_type
			if
				attached {IV_ENTITY} entity_mapping.current_expression as e and then
				attached types.for_class_type (a_type) as t and then
				e.type /~ t
			then
					-- A fix for a target of a mapped MML type.
				entity_mapping.set_current (create {IV_ENTITY}.make (e.name, t))
			end
			current_target := entity_mapping.current_expression
			if a_feature /= Void and then a_feature.has_return_value then
				entity_mapping.set_default_result (feature_class_type (a_feature))
			end
		end

	copy_entity_mapping (a_entity_mapping: E2B_ENTITY_MAPPING)
			-- Set `entity_mapping' to a copy of `a_entity_mapping'.
		do
			create entity_mapping.make_copy (a_entity_mapping)
			current_target := entity_mapping.current_expression
		end

	reset
			-- Reset expression translator.
		do
			last_expression := Void
			context_feature := Void
			context_type := Void
			current_target := Void
			current_target_type := Void
			local_writable := Void
			context_readable := Void
			last_set_content_type := Void
			create entity_mapping.make
			create locals_map.make (10)
			create across_handler_map.make (10)
			create safety_check_condition.make
			safety_check_condition.extend (factory.true_)
			create parameters_stack.make
			use_triggers := False
		end

	set_local_writable (a_writable: IV_EXPRESSION)
			-- Set `local_writable' to `a_writable'.
		do
			local_writable := a_writable
		end

	set_context_readable (a_readable: IV_EXPRESSION)
			-- Set `context_readable' to `a_readable'
		do
			context_readable := a_readable
		end

	set_use_triggers (b: BOOLEAN)
			-- Set `use_triggers' to `b'
		do
			use_triggers := b
		end

	set_use_uninterpreted_context_function (b: BOOLEAN)
			-- Set `use_uninterpreted_context_function' to `b'
		do
			use_uninterpreted_context_function := b
		end

feature -- Visitors

	process_agent_call_b (a_node: AGENT_CALL_B)
			-- <Precursor>
		do
			process_feature_b (a_node)
		end

	process_argument_b (a_node: ARGUMENT_B)
			-- <Precursor>
		do
			last_expression := entity_mapping.argument (context_feature, context_type, a_node.position)
		end

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- <Precursor>
		do
			helper.add_unsupported_error (context_feature, {STRING_32} "Manifest array in contract not supported.", context_line_number)
			last_expression := dummy_node (a_node.type)
		end

	process_attribute_b (a_node: ATTRIBUTE_B)
			-- <Precursor>
		local
			l_feature: FEATURE_I
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_feature := helper.feature_for_call_access (a_node, current_target_type)
			l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
			if l_handler /= Void then
				process_special_feature_call (l_handler, l_feature, a_node.parameters)
			else
				process_attribute_call (l_feature)
			end
		end

	process_binary (a_node: BINARY_B; a_operator: STRING)
			-- Process binary node `a_node' with operator `a_operator'.
		local
			l_class: CLASS_C
			l_left, l_right: IV_EXPRESSION
			l_boogie_type: IV_TYPE
			l_fcall: IV_FUNCTION_CALL
			l_fname: STRING
		do
			safe_process (a_node.left)
			l_left := last_expression
			safe_process (a_node.right)
			l_right := last_expression

			l_boogie_type := types.for_class_type (class_type_in_current_context (a_node.type))

			l_class := class_type_in_current_context (a_node.left.type).base_class
			if attached l_class and then helper.is_class_logical (l_class) then
				check a_operator ~ "==" or a_operator ~ "!=" end
				(create {E2B_CUSTOM_LOGICAL_HANDLER}).handle_binary (Current, l_class, l_left, l_right, a_operator)
			elseif is_in_quantifier and options.is_triggering_on_arithmetic then
				if a_operator ~ "+" then
					last_expression := factory.function_call ("add", << l_left, l_right >>, types.int)
				elseif a_operator ~ "-" then
					last_expression := factory.function_call ("subtract", << l_left, l_right >>, types.int)
				elseif a_operator ~ "*" then
					last_expression := factory.function_call ("multiply", << l_left, l_right >>, types.int)
				else
					create {IV_BINARY_OPERATION} last_expression.make (l_left, a_operator, l_right, l_boogie_type)
				end
			else
				create {IV_BINARY_OPERATION} last_expression.make (l_left, a_operator, l_right, l_boogie_type)
			end
			if
				options.is_checking_overflow and then
				(a_node.left.type.is_integer or a_node.left.type.is_natural) and then
				(a_operator ~ "+" or a_operator ~ "-")
			then
					-- Arithmetic operation
				l_fname := "is_" + a_node.left.type.base_class.name.as_lower
				create l_fcall.make (l_fname, types.bool)
				l_fcall.add_argument (last_expression)
				add_safety_check (l_fcall, "overflow", context_tag, context_line_number)
			end
		end

	process_binary_semistrict (a_node: BINARY_B; a_operator: STRING; a_positive: BOOLEAN)
			-- Process binary node `a_node' with operator `a_operator'.
			-- If `a_positive' is set, then the left expression has to `true' to trigger
			-- evaluation of right expression, otherwise it has to be false.
		local
			l_left, l_right: IV_EXPRESSION
			l_safety_check_condition: IV_EXPRESSION
		do
			safe_process (a_node.left)
			l_left := last_expression

			if a_positive then
				l_safety_check_condition := l_left
			else
				l_safety_check_condition := factory.not_ (l_left)
			end
			process_semistrict (l_safety_check_condition, a_node.right)
			l_right := last_expression

			create {IV_BINARY_OPERATION} last_expression.make (l_left, a_operator, l_right, types.bool)
		end

	process_binary_infix (a_node: BINARY_B)
			-- Process binary infix node `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_bin_and_b (a_node: BIN_AND_B)
			-- <Precursor>
		do
			process_binary (a_node, "&&")
		end

	process_bin_and_then_b (a_node: B_AND_THEN_B)
			-- <Precursor>
		do
			process_binary_semistrict (a_node, "&&", True)
		end

	process_bin_div_b (a_node: BIN_DIV_B)
			-- <Precursor>
		do
			if a_node.type.is_real_32 or a_node.type.is_real_64 then
				process_binary (a_node, "/")
			elseif a_node.is_built_in then
				process_binary (a_node, "div")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_eq_b (a_node: BIN_EQ_B)
			-- <Precursor>
		do
			process_binary (a_node, "==")
		end

	process_bin_free_b (a_node: BIN_FREE_B)
			-- <Precursor>
		do
			process_binary_infix (a_node)
		end

	process_bin_ge_b (a_node: BIN_GE_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, ">=")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_gt_b (a_node: BIN_GT_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, ">")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_implies_b (a_node: B_IMPLIES_B)
			-- <Precursor>
		do
			process_binary_semistrict (a_node, "==>", True)
		end

	process_bin_le_b (a_node: BIN_LE_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "<=")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_lt_b (a_node: BIN_LT_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "<")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_minus_b (a_node: BIN_MINUS_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "-")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_mod_b (a_node: BIN_MOD_B)
			-- <Precursor>
		do
			process_binary (a_node, "mod")
		end

	process_bin_ne_b (a_node: BIN_NE_B)
			-- <Precursor>
		do
			process_binary (a_node, "!=")
		end

	process_bin_or_b (a_node: BIN_OR_B)
			-- <Precursor>
		do
			process_binary (a_node, "||")
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B)
			-- <Precursor>
		do
			process_binary_semistrict (a_node, "||", False)
		end

	process_bin_plus_b (a_node: BIN_PLUS_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "+")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_power_b (a_node: BIN_POWER_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "**")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_slash_b (a_node: BIN_SLASH_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "/")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_star_b (a_node: BIN_STAR_B)
			-- <Precursor>
		do
			if a_node.is_built_in then
				process_binary (a_node, "*")
			else
				process_binary_infix (a_node)
			end
		end

	process_bin_xor_b (a_node: BIN_XOR_B)
			-- <Precursor>
		do
			process_binary (a_node, "!=")
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B)
			-- <Precursor>
		do
				-- TODO: handle "is_equal"
			process_binary (a_node, "==")
		end

	process_bool_const_b (a_node: BOOL_CONST_B)
			-- <Precursor>
		do
			if a_node.value then
				last_expression := factory.true_
			else
				last_expression := factory.false_
			end
		end

	process_current_b (a_node: CURRENT_B)
			-- <Precursor>
		do
			last_expression := entity_mapping.current_expression
		end

	process_char_const_b (a_node: CHAR_CONST_B)
			-- <Precursor>
		do
			last_expression := factory.int_value (a_node.value.code)
		end

	process_char_val_b (a_node: CHAR_VAL_B)
			-- <Precursor>
		do
			last_expression := factory.int_value (a_node.value.code)
		end

	process_constant_b (a_node: CONSTANT_B)
			-- <Precursor>
		do
			if attached {BOOL_VALUE_I} a_node.value as l_bool then
				last_expression := if l_bool.boolean_value then factory.true_ else factory.false_ end
			elseif a_node.value.is_integer or a_node.value.is_numeric then
				create {IV_VALUE} last_expression.make (a_node.value.string_value, types.int)
			elseif attached {CHAR_VALUE_I} a_node.value as l_char then
				last_expression := factory.int_value (l_char.character_value.code)
			elseif a_node.value.is_real then
				last_expression := dummy_node (a_node.type)
			else
				last_expression := dummy_node (a_node.type)
			end
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- <Precursor>
		do
			helper.add_unsupported_error (context_feature, {STRING_32} "Creation expression in contract not supported.", context_line_number)
			last_expression := dummy_node (a_node.type)
		end

	process_external_b (a_node: EXTERNAL_B)
			-- <Precursor>
		local
			l_feature: FEATURE_I
			l_current_type: CL_TYPE_A
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_current_type := current_target_type
			if a_node.is_static_call then
				current_target_type := class_type_in_current_context (a_node.static_class_type)
			end

			l_feature := helper.feature_for_call_access (a_node, current_target_type)
			check feature_valid: l_feature /= Void end
			l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
			if l_handler /= Void then
				process_special_feature_call (l_handler, l_feature, a_node.parameters)
			else
				process_routine_call (l_feature, a_node.parameters, False)
			end

			current_target_type := l_current_type
		end

	process_feature_b (a_node: FEATURE_B)
			-- <Precursor>
		local
			l_feature: FEATURE_I
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_feature := helper.feature_for_call_access (a_node, current_target_type)
			check feature_valid: l_feature /= Void end

			l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
			if l_handler /= Void then
				process_special_feature_call (l_handler, l_feature, a_node.parameters)
			else
				if l_feature.is_attribute then
					process_attribute_call (l_feature)
				elseif l_feature.is_constant then
					check
						from_condition: attached {CONSTANT_I} l_feature as l_constant
					then
						process_constant_call (l_constant)
					end
				elseif l_feature.is_routine then
					process_routine_call (l_feature, a_node.parameters, False)
				else
						-- TODO: what else is there?
					check False end
				end
			end
		end

	process_if_expression_b (a_node: IF_EXPRESSION_B)
			-- <Precursor>
		local
			l_cond, l_then, l_else: IV_EXPRESSION
		do
			check a_node.elsif_list = Void or else a_node.elsif_list.is_empty end

			safe_process (a_node.condition)
			l_cond := last_expression

			process_semistrict (l_cond, a_node.then_expression)
			l_then := last_expression

			process_semistrict (factory.not_ (l_cond), a_node.else_expression)
			l_else := last_expression

			create {IV_CONDITIONAL_EXPRESSION} last_expression.make_if_then_else (l_cond, l_then, l_else)
		end

	process_int64_val_b (a_node: INT64_VAL_B)
			-- <Precursor>
		do
			last_expression := factory.int64_value (a_node.value)
		end

	process_int_val_b (a_node: INT_VAL_B)
			-- <Precursor>
		do
			last_expression := factory.int_value (a_node.value)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT)
			-- <Precursor>
		do
			if attached {INTEGER_A} a_node.type then
				last_expression := factory.int64_value (a_node.integer_64_value)
			else
				last_expression := factory.nat64_value (a_node.natural_64_value)
			end
		end

	process_local_b (a_node: LOCAL_B)
			-- <Precursor>
		do
			last_expression := entity_mapping.local_ (a_node.position)
		end

	process_loop_expr_b (a_node: LOOP_EXPR_B)
			-- <Precursor>
		do
			if
				attached {ASSIGN_B} a_node.iteration_code.first as l_assign and then
				attached {OBJECT_TEST_LOCAL_B} l_assign.target as l_object_test_local and then
				attached {NESTED_B} l_assign.source as l_nested and then
				attached l_nested.target.type.base_class as l_class
			then
				is_in_quantifier := True
				if attached translation_mapping.handler_for_across (a_node, Current) as l_across_handler then
					current_target := entity_mapping.current_expression
					current_target_type := context_type
					last_expression := Void
					across_handler_map.put (l_across_handler, l_object_test_local.position)
					l_across_handler.handle_across_expression
					across_handler_map.remove (l_object_test_local.position)
				else
					last_expression := dummy_node (a_node.type)
					helper.add_semantic_error (context_feature, {STRING_32} "Across over type " + l_class.name_in_upper + " not supported", context_line_number)
				end
				is_in_quantifier := False
			end
		end

	process_nat64_val_b (a_node: NAT64_VAL_B)
			-- <Precursor>
		do
			create {IV_VALUE} last_expression.make (a_node.value.out, types.int)
		end

	process_nat_val_b (a_node: NAT_VAL_B)
			-- <Precursor>
		do
			create {IV_VALUE} last_expression.make (a_node.value.out, types.int)
		end

	process_nested_b (a_node: NESTED_B)
			-- <Precursor>
		local
			l_temp_expression: IV_EXPRESSION
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A

			l_handler: E2B_CUSTOM_NESTED_HANDLER
			l_name: STRING
		do
			l_handler := translation_mapping.handler_for_nested (a_node)
			if
				attached {OBJECT_TEST_LOCAL_B} a_node.target as l_object_test_local and then
				attached across_handler_map.item (l_object_test_local.position) as l_across_handler and then
				attached {FEATURE_B} if attached {NESTED_B} a_node.message as l_nested then
						l_nested.target
					else
						a_node.message
					end
				as l_feature
			then
					-- Special mapping of object test local in across loop
				l_name := l_feature.feature_name.as_lower
				if l_name.same_string ("item") then
					l_across_handler.handle_call_item (Void)
				elseif l_name.same_string ("index") or l_name.same_string ("cursor_index") then
					l_across_handler.handle_call_cursor_index (Void)
				elseif l_name.same_string ("after") then
					l_across_handler.handle_call_after (Void)
				elseif l_name.same_string ("is_wrapped") or l_name.same_string ("is_open") then
					last_expression := dummy_node (a_node.type)
				else
					check False end
					last_expression := dummy_node (a_node.type)
				end
				if attached {NESTED_B} a_node.message as l_nested then
					l_target := current_target
					l_target_type := current_target_type

					current_target := last_expression
					current_target_type := class_type_in_current_context (l_nested.target.type)
					l_nested.message.process (Current)

					current_target := l_target
					current_target_type := l_target_type
				end
			elseif l_handler /= Void then
				if attached {E2B_BODY_EXPRESSION_TRANSLATOR} Current as t then
					l_handler.handle_nested_in_body (t, a_node)
				elseif attached {E2B_CONTRACT_EXPRESSION_TRANSLATOR} Current as t then
					l_handler.handle_nested_in_contract (t, a_node)
				else
					check False end
				end
				if last_expression = Void and not a_node.type.is_void then
					last_expression := dummy_node (a_node.type)
				end
			else
				l_temp_expression := last_expression

					-- Evaluate target				
				safe_process (a_node.target)

					-- Use target as new `Current' reference
				l_target := current_target
				l_target_type := current_target_type
				current_target := last_expression
				current_target_type := expression_class_type (a_node.target)

				add_void_call_check (a_node)

					-- Evaluate message with original expression
--				if attached {CL_TYPE_A} current_target_type as l_cl_type then
--					if not l_cl_type.has_associated_class_type (Void) then
--						l_cl_type.associated_class.update_types (l_cl_type)
--					end
--					context.change_class_type_context (
--						l_cl_type.associated_class_type (Void),
--						l_cl_type,
--						l_cl_type.associated_class_type (Void),
--						l_cl_type)
--				end

--				helper.set_up_byte_context (Void, current_target_type)
--				helper.set_up_byte_context_type (current_target_type, context_type)
				last_expression := l_temp_expression

				safe_process (a_node.message)

					-- Restore `Current' reference
--				if attached {CL_TYPE_A} current_target_type as l_cl_type then
--					if context.is_class_type_changed then
--						context.restore_class_type_context
--					else
--						-- TODO: should never happen, but does
--					end
--				end
				current_target := l_target
				current_target_type := l_target_type
--				helper.set_up_byte_context (Void, current_target_type)
--				helper.set_up_byte_context_type (current_target_type, context_type)
			end
		end

	process_null_conversion_b (b: NULL_CONVERSION_B)
		do
			safe_process (b.expr)
		end

	process_object_test_b (a_node: OBJECT_TEST_B)
			-- <Precursor>
		local
			l_type: CL_TYPE_A
			l_type_expr, l_expr: IV_EXPRESSION
			object_test_local: like last_local
		do
			safe_process (a_node.expression)
			l_expr := last_expression
			l_type := class_type_in_current_context
				(if a_node.is_void_check then
					a_node.expression.type
				else
					a_node.target.type
				end)
			if
				attached a_node.target as t and then
				attached context_implementation and then
				attached {LIST [IV_STATEMENT]} side_effect as effect
			then
					-- TODO: handle the case when `context_implementation` is not attached and `side_effect` does not hold `IV_STATEMENT`.
				translation_pool.add_type (l_type)
				create_local (l_type)
				object_test_local := last_local
				effect.extend (create {IV_ASSIGNMENT}.make (object_test_local, l_expr))
				l_expr := object_test_local
			end
			if a_node.is_void_check then
				last_expression := factory.not_equal (l_expr, factory.void_)
			else
				l_type := class_type_in_current_context (a_node.target.type)
				translation_pool.add_type (l_type)
				if l_type.is_integer or l_type.is_natural then
					create {IV_ENTITY} l_type_expr.make ("INTEGER", types.type)
				else
					l_type_expr := factory.type_value (l_type)
				end
				last_expression := factory.function_call ("attached", <<entity_mapping.heap, l_expr, l_type_expr>>, types.bool)
			end
			if attached a_node.target then
					-- Check for possible unboxing of basic types
				if a_node.expression.type.is_reference then
					if a_node.target.type.is_boolean then
						l_expr := factory.function_call ("unboxed_bool", << l_expr >>, types.bool)
					elseif a_node.target.type.is_integer or a_node.target.type.is_natural then
						l_expr := factory.function_call ("unboxed_int", << l_expr >>, types.int)
					end
				end
				locals_map.force (l_expr, a_node.target.position)
			end
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B)
			-- <Precursor>
		do
			if locals_map.has_key (a_node.position) then
				last_expression := locals_map.item (a_node.position)
			else
				check False end
				last_expression := dummy_node (a_node.type)
			end
		end

	process_parameter_b (a_node: PARAMETER_B)
			-- <Precursor>
		local
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A
			l_last_expression: IV_EXPRESSION
		do
			check not parameters_stack.is_empty end

				-- Process arguments in context of feature
			l_target := current_target
			l_target_type := current_target_type
			l_last_expression := last_expression

			current_target := entity_mapping.current_expression
			current_target_type := context_type
			last_expression := Void

			safe_process (a_node.expression)
			parameters_stack.item.extend (last_expression)

			last_expression := l_last_expression
			current_target := l_target
			current_target_type := l_target_type
		end

	process_paran_b (a_node: PARAN_B)
			-- <Precursor>
		do
			safe_process (a_node.expr)
		end

	process_result_b (a_node: RESULT_B)
			-- <Precursor>
		do
			last_expression := entity_mapping.result_expression
		end

	process_real_const_b (a_node: REAL_CONST_B)
			-- <Precursor>
		do
			create {IV_VALUE} last_expression.make (a_node.value, types.real)
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B)
			-- <Precursor>
		do
			helper.add_unsupported_error (context_feature, {STRING_32} "Agents in contract not supported.", context_line_number)
			last_expression := dummy_node (a_node.type)
		end

	process_string_b (a_node: STRING_B)
			-- <Precursor>
		do
			helper.add_unsupported_error (context_feature, {STRING_32} "Manifest string not supported.", context_line_number)
			last_expression := dummy_node (a_node.type)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- <Precursor>
		do
			last_expression := factory.heap_access (
				entity_mapping.heap,
				current_target,
				name_translator.boogie_field_for_tuple_field (current_target_type, a_node.position),
				types.for_class_type (class_type_in_current_context (a_node.type)))
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- <Precursor>
		do
			helper.add_unsupported_error (context_feature, {STRING_32} "Manifest tuple in contract not supported.", context_line_number)
			last_expression := dummy_node (a_node.type)
		end

	process_type_expr_b (a_node: TYPE_EXPR_B)
			-- <Precursor>
		local
			l_type: CL_TYPE_A
		do
			l_type := class_type_in_current_context (a_node.type_type)
			translation_pool.add_type (l_type)
			last_expression := factory.type_value (l_type)
		end

	process_un_free_b (a_node: UN_FREE_B)
			-- <Precursor>
		do
			-- TODO: implement
		end

	process_un_minus_b (a_node: UN_MINUS_B)
			-- <Precursor>
		do
			safe_process (a_node.expr)
			create {IV_UNARY_OPERATION} last_expression.make ("-", last_expression, last_expression.type)
		end

	process_un_not_b (a_node: UN_NOT_B)
			-- <Precursor>
		do
			safe_process (a_node.expr)
			last_expression := factory.not_ (last_expression)
		end

	process_un_old_b (a_node: UN_OLD_B)
			-- <Precursor>
		do
			check False end
			last_expression := dummy_node (a_node.type)
		end

	process_un_plus_b (a_node: UN_PLUS_B)
			-- <Precursor>
		do
			safe_process (a_node.expr)
			-- Nothing to do, there is no unary plus in Boogie
		end

	process_void_b (a_node: VOID_B)
			-- <Precursor>
		do
			last_expression := factory.void_
		end

feature -- Translation

	process_attribute_call (a_feature: FEATURE_I)
			-- Process call to attribute `a_feature'.
		require
			is_attribute: a_feature.is_attribute
		deferred
		end

	process_constant_call (a_feature: CONSTANT_I)
			-- Process call to constant `a_feature'.
		do
			if a_feature.value.is_string then
				last_expression := dummy_node (a_feature.type)
			elseif a_feature.value.is_boolean then
				create {IV_VALUE} last_expression.make (a_feature.value.string_value.as_lower, types.bool)
			elseif a_feature.value.is_integer then
				create {IV_VALUE} last_expression.make (a_feature.value.string_value, types.int)
			elseif a_feature.value.is_character then
				last_expression := dummy_node (a_feature.type)
			else
				last_expression := dummy_node (a_feature.type)
			end
		end

	process_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		require
			not_attribute: a_feature.is_routine
		deferred
		end

	process_special_feature_call (a_handler: E2B_CUSTOM_CALL_HANDLER; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- Process feature call with custom handler.
		deferred
		end

	add_safety_check (a_expression: IV_EXPRESSION; a_name: STRING; a_tag: STRING; a_line: INTEGER)
			-- Add safety check `a_expression' of type `a_name' with tag `a_tag' referring to `a_line'.
		require
			boolean_expression: a_expression.type.is_boolean
		local
			l_assert: IV_ASSERT
		do
			create l_assert.make (implies_safety_expression (a_expression))
			l_assert.node_info.set_type (a_name)
			l_assert.node_info.set_tag (a_tag)
			l_assert.node_info.set_line (a_line)
			l_assert.set_attribute_string (":subsumption 0")
			side_effect.extend (l_assert)
		end

	add_safety_check_with_subsumption (a_expression: IV_EXPRESSION; a_name: STRING; a_tag: STRING; a_line: INTEGER)
			-- Add safety check `a_expression' of type `a_name' with tag `a_tag' referring to `a_line'; do not supress subsumption.
		require
			boolean_expression: a_expression.type.is_boolean
		do
			add_safety_check (a_expression, a_name, a_tag, a_line)
			last_safety_check.set_attribute_string (Void)
		end

	add_assumption (a_expression: IV_EXPRESSION)
			-- Add assumption `a_expression'.
		require
			boolean_expression: a_expression.type.is_boolean
		local
			l_assert: IV_ASSERT
		do
			create l_assert.make_assume (implies_safety_expression (a_expression))
			side_effect.extend (l_assert)
		end

	last_safety_check: IV_ASSERT
			-- Assertion added by the last call to `add_safety_check'.
		do
			if attached {IV_ASSERT} side_effect.last as l_assert then
				Result := l_assert
			end
		end

	safety_check_condition: LINKED_STACK [IV_EXPRESSION]
			-- Stack of safety check conditions.

	implies_safety_expression (a_expr: IV_EXPRESSION): IV_EXPRESSION
		do
			Result := factory.implies_clean (safety_check_condition.item, a_expr)
		end

	if_safety_expression (a_stmt: IV_STATEMENT): IV_STATEMENT
		do
			if safety_check_condition.item.is_true then
				Result := a_stmt
			else
				create {IV_CONDITIONAL} Result.make_if_then (safety_check_condition.item, factory.singleton_block (a_stmt))
			end
		end

	clear_side_effect
			-- Empty the list of side effect instructions.
		do
			create side_effect.make
		end

	restore_side_effect (a_side_effect: like side_effect)
			-- Set `side_effect' to `a_side_effect'.			
		do
			side_effect := a_side_effect
		end

	process_parameters (a_parameters: BYTE_LIST [PARAMETER_B])
			-- Process parameter list `a_parameters'.
		local
			l_list: LINKED_LIST [IV_EXPRESSION]
		do
			create l_list.make
			parameters_stack.extend (l_list)
			safe_process (a_parameters)
			last_parameters := parameters_stack.item
			parameters_stack.remove
		end

	process_argument_expression (a_expr: EXPR_B): IV_EXPRESSION
			-- Process `a_expr' in the context of the routine.
		local
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A
			l_last_expression: IV_EXPRESSION
		do
			l_target := current_target
			l_target_type := current_target_type
			l_last_expression := last_expression

			current_target := entity_mapping.current_expression
			current_target_type := context_type
			last_expression := Void

			safe_process (a_expr)
			Result := last_expression

			last_expression := l_last_expression
			current_target := l_target
			current_target_type := l_target_type
		end

	last_set_content_type: CL_TYPE_A
			-- Type of the set content for the last successful call to `process_as_set'.

	process_as_set (a_expr: EXPR_B; a_content_type: IV_TYPE)
			-- Process `a_expr' of a logical type and convert it to a set of `a_content_type';
			-- if not possible issue a validity error.
		local
			l_expr_type: CL_TYPE_A
			l_class: CLASS_C
			l_feature: FEATURE_I
			l_conversion: READABLE_STRING_8
			t: CL_TYPE_A
		do
			safe_process (a_expr)

			l_expr_type := class_type_in_current_context (a_expr.type)
			l_class := l_expr_type.base_class
			l_feature := l_class.feature_named ("new_cursor")
			l_conversion := helper.function_for_logical (l_feature)
			if l_conversion = Void then
				helper.add_semantic_error (l_class, messages.logical_no_across_conversion, -1)
			else
				t := helper.class_type_in_context (l_feature.type, l_feature.written_class, l_feature, l_expr_type)
				if attached {CL_TYPE_A} t.generics.first as c then
					last_set_content_type := c
				elseif attached {CL_TYPE_A} t.base_class.single_constraint (1) as c then
					last_set_content_type := c
				else
					check class_type_constraint: False then end
				end
				if not l_conversion.is_empty then
					last_expression := factory.function_call (l_conversion, << last_expression >>, types.set (a_content_type))
				end
			end
		end

	process_as_old (a_expr: EXPR_B)
			-- Process `old a_expr'.
		local
			l_temp_heap: IV_EXPRESSION
		do
			l_temp_heap := entity_mapping.heap
			entity_mapping.set_heap (entity_mapping.old_heap)
			safe_process (a_expr)
			entity_mapping.set_heap (l_temp_heap)
		end

	add_void_call_check (a_node: NESTED_B)
			-- Add void check for the target of `a_node' if needed.
		do
			if not (current_target_type.is_expanded or
					helper.is_class_logical (current_target_type.base_class) or
					(attached {FEATURE_B} a_node.message as f and then translation_mapping.void_ok_features.has (f.feature_name))) then
				add_safety_check (factory.not_equal (current_target, factory.void_), "attached", context_tag, context_line_number)
			end
		end

	add_function_precondition_check (a_feature: FEATURE_I; a_fcall: IV_FUNCTION_CALL)
			-- Check the precondition of the function call `a_fcall' of `a_feature'.
		local
			l_fname: READABLE_STRING_8
			l_pre_call: IV_FUNCTION_CALL
		do
			l_fname := name_translator.boogie_function_for_feature (a_feature, current_target_type, False)
				-- Add check
				-- Note: here we assume that there is no default precondition!
			if helper.has_flat_precondition (a_feature) then
				create l_pre_call.make (name_translator.boogie_function_precondition (l_fname), types.bool)
				across a_fcall.arguments as args loop
					l_pre_call.add_argument (args)
				end
				add_safety_check_with_subsumption (l_pre_call, "check", "function_precondition", context_line_number)
				last_safety_check.node_info.set_attribute ("cid", current_target_type.base_class.class_id.out)
				last_safety_check.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
				check system.class_of_id (current_target_type.base_class.class_id).feature_of_rout_id (a_feature.rout_id_set.first).feature_name_id = a_feature.feature_name_id end
			end
--				-- Assume free precondition to trigger the function definition;
--				-- (definitions of logicals do not have free preconditions)
--			if not helper.is_class_logical (current_target_type.base_class) then
--				create l_pre_call.make (name_translator.boogie_free_function_precondition (l_fname), types.bool)
--				across a_fcall.arguments as args loop
--					l_pre_call.add_argument (args.item)
--				end
--				add_assumption (l_pre_call)
--			end
		end

	add_read_frame_check (a_feature: FEATURE_I)
			-- If there is a read frame, check that `a_feature's read frame is a subframe of it.
		local
			l_fcall: IV_FUNCTION_CALL
		do
			if context_readable /= Void and helper.has_functional_representation (a_feature) then
				create l_fcall.make (name_translator.boogie_function_for_read_frame (a_feature, current_target_type), types.frame)
				l_fcall.add_argument (entity_mapping.heap)
				if not helper.is_static (a_feature) then
					l_fcall.add_argument (current_target)
				end
				l_fcall.arguments.append (last_parameters)
					-- Using subsumption here, since in a query call chains it can trigger for the followings checks
				add_safety_check_with_subsumption (factory.function_call ("Frame#Subset", <<l_fcall, context_readable>>, types.bool),
					"access", "frame_readable", context_line_number)
				last_safety_check.node_info.set_attribute ("cid", current_target_type.base_class.class_id.out)
				last_safety_check.node_info.set_attribute ("rid", a_feature.rout_id_set.first.out)
				check system.class_of_id (current_target_type.base_class.class_id).feature_of_rout_id (a_feature.rout_id_set.first).feature_name_id = a_feature.feature_name_id end
			end
		end

	add_termination_check (l_old_variants, l_new_variants: LIST [IV_EXPRESSION])
			-- Given expressions for old and new values of variants, add a safety check that the new variants are strinctly less and the order is well-founded.
		require
			l_old_variants_exists: l_old_variants /= Void
			l_new_variants_exists: l_new_variants /= Void
			same_count: l_old_variants.count = l_new_variants.count
		local
			l_type: IV_TYPE
			l_eq_less: TUPLE [eq: IV_EXPRESSION; less: IV_EXPRESSION]
			l_check_list: ARRAYED_LIST [TUPLE [eq: IV_EXPRESSION; less: IV_EXPRESSION]]
			l_check, l_bounds_check_guard, e1, e2: IV_EXPRESSION
			i: INTEGER
		do
			from
				i := 1
				create l_check_list.make (3)
				l_bounds_check_guard := factory.false_
			until
				i > l_old_variants.count
			loop
				l_type := l_new_variants [i].type
				e1 := l_new_variants [i]
				e2 := l_old_variants [i]
				l_eq_less := [factory.and_ (l_type.rank_leq (e1, e2), l_type.rank_leq (e2, e1)),
					factory.and_ (l_type.rank_leq (e1, e2), factory.not_ (l_type.rank_leq (e2, e1)))]
				l_check_list.extend (l_eq_less)
				if l_new_variants [i].type.is_integer then
					-- Add bounds check, since integers are not already bounded from below;
					-- more precisely, for variant k check:
        					-- new[1] < old[1] || ... || new[k-1] < old[k-1] || new[k] == old[k] || 0 <= old[k]
					add_safety_check (factory.or_clean (l_bounds_check_guard,
													factory.or_ (l_eq_less.eq, factory.less_equal (factory.int_value (0), l_old_variants [i]))),
						"termination", "bounded", context_line_number)
					last_safety_check.node_info.set_attribute ("varid", i.out)
				end
				l_bounds_check_guard := factory.or_clean (l_bounds_check_guard, l_eq_less.less)

				i := i + 1
			end

			if not l_check_list.is_empty then
				-- Go backward through the list and generate "less1 || (eq1 && (less2 || ... eq<n-1> && less<n>))"
				l_check := l_check_list.last.less
				from
					i := l_check_list.count - 1
				until
					i < 1
				loop
					l_check := factory.and_ (l_check_list [i].eq, l_check)
					l_check := factory.or_ (l_check_list [i].less, l_check)
					i := i - 1
				end
				add_safety_check (l_check, "termination", "variant_decreases", context_line_number)
			else
				-- Explicitly marked as possibly non-terminating: do not generate any checks
			end
		end


	add_recursion_termination_check (a_feature: FEATURE_I)
			-- Add termination check for a call to routine `a_feature' with actual arguments `a_parameters' in the current context.
		local
			l_caller_variant, l_callee_variant: IV_FUNCTION_CALL
			l_caller_variants, l_callee_variants: ARRAYED_LIST [IV_EXPRESSION]
			l_decreases_fun: IV_FUNCTION
			i, j: INTEGER
		do
			-- If we are inside a routine and calling the same routine (recursive call)
			if context_feature /= Void and then context_feature.written_in = a_feature.written_in and
												context_feature.feature_id = a_feature.feature_id then
				from
					i := 1
					create l_caller_variants.make (3)
					create l_callee_variants.make (3)
					l_decreases_fun := boogie_universe.function_named (name_translator.boogie_function_for_variant (i, a_feature, current_target_type))
				until
					l_decreases_fun = Void
				loop
					check checked_when_creating: l_decreases_fun.type.has_rank end
					create l_callee_variant.make (l_decreases_fun.name, l_decreases_fun.type)
					l_callee_variant.add_argument (entity_mapping.heap)
					if not helper.is_static (a_feature) then
						l_callee_variant.add_argument (current_target)
					end
					l_callee_variant.arguments.append (last_parameters)
					l_callee_variants.extend (l_callee_variant)

					create l_caller_variant.make (l_decreases_fun.name, l_decreases_fun.type)
					l_caller_variant.add_argument (factory.old_ (entity_mapping.heap))
					if not helper.is_static (a_feature) then
						l_caller_variant.add_argument (entity_mapping.current_expression)
					end
					from
						j := 1
					until
						j > context_feature.argument_count
					loop
						l_caller_variant.add_argument (entity_mapping.argument (context_feature, context_type, j))
						j := j + 1
					end
					l_caller_variants.extend (l_caller_variant)

					i := i + 1
					l_decreases_fun := boogie_universe.function_named (name_translator.boogie_function_for_variant (i, a_feature, current_target_type))
				end
				add_termination_check (l_caller_variants, l_callee_variants)
			end
		end


feature -- Implementation

	parameters_stack: LINKED_STACK [LINKED_LIST [IV_EXPRESSION]]
			-- Stack of procedure calls.

	last_parameters: LINKED_LIST [IV_EXPRESSION]
			-- List of last processed parameters.

	last_local: IV_ENTITY
			-- Last created local.

	local_writable: detachable IV_EXPRESSION
			-- Local writable frame of the enclosing context.			

	create_iterator (a_type: IV_TYPE)
			-- Create new unbound iterator.
		do
			create last_local.make (helper.unique_identifier ("i"), a_type)
		end

	is_in_quantifier: BOOLEAN
			-- Is current expression inside a quantifier?

	dummy_node (a_type: TYPE_A): IV_EXPRESSION
			-- Dummy node for type `a_type'.
		do
			Result := factory.function_call ("unsupported", << >>, types.for_class_type (class_type_in_current_context (a_type)))
		end

	process_semistrict (a_condition: IV_EXPRESSION; a_expr: EXPR_B)
			-- Add `a_condition' to the safety check, then process `a_expr'.
		do
			safety_check_condition.extend (factory.and_clean (safety_check_condition.item, a_condition))
			safe_process (a_expr)
			safety_check_condition.remove
		end

feature {E2B_CUSTOM_OWNERSHIP_HANDLER, E2B_CUSTOM_AGENT_CALL_HANDLER, E2B_CUSTOM_STRING_HANDLER} -- Access

	context_implementation: detachable IV_IMPLEMENTATION
			-- Context of expression.

feature {E2B_CUSTOM_OWNERSHIP_HANDLER, E2B_CUSTOM_AGENT_CALL_HANDLER, E2B_CUSTOM_STRING_HANDLER} -- Modification

	create_local (t: CL_TYPE_A)
			-- Create a new local with type `t`.
		require
			attached context_implementation
		do
			create last_local.make (helper.unique_identifier ("temp"), types.for_class_type (t))
			context_implementation.add_local (last_local.name, last_local.type)
		end

invariant
	has_safety_check_condition: not safety_check_condition.is_empty

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2015 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
