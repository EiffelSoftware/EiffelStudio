note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CONTRACT_EXPRESSION_TRANSLATOR

inherit

	E2B_EXPRESSION_TRANSLATOR
		redefine
			side_effect,
			reset,
			set_context,
			class_type_in_current_context,
			process_creation_expr_b,
			process_un_old_b
		end

create
	make

feature -- Access

	origin_class: CLASS_C
			-- Context where the expression in inherited from.

	side_effect: LINKED_LIST [IV_ASSERT]
			-- List of side effect statements (only safety checks generated here).

	field_accesses: LINKED_LIST [TUPLE [o: IV_EXPRESSION; f: IV_ENTITY]]
			-- List of field accesses.

	class_type_in_current_context (a_type: TYPE_A): CL_TYPE_A
			-- Class type that correspond to `a_type' in the context of `context_type' and possibly `context_feature'.
		do
			Result := helper.class_type_in_context (a_type, origin_class, context_feature, context_type)
		end

feature -- Element change

	set_origin_class (a_class: CLASS_C)
			-- Set `origin_class' to `a_class'.
		do
			origin_class := a_class
		end

feature -- Basic operations

	set_context (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Set context of expression to `a_feature' in type `a_type'.
		do
			Precursor (a_feature, a_type)
			origin_class := a_type.base_class
		end

	reset
			-- Reset expression translator.
		do
			Precursor
			origin_class := Void
			create side_effect.make
			create field_accesses.make
		end

feature -- Visitors

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- <Precursor>
		local
			l_type, l_target_type: CL_TYPE_A
			l_feature: FEATURE_I
			l_handler: E2B_CUSTOM_CALL_HANDLER
		do
			l_type := class_type_in_current_context (a_node.type)
			l_feature := l_type.base_class.feature_of_rout_id (a_node.call.routine_id)
			check feature_valid: l_feature /= Void end
			translation_pool.add_type (l_type)
			l_target_type := current_target_type
			current_target_type := l_type

			if helper.is_class_logical (current_target_type.base_class) then
				l_handler := translation_mapping.handler_for_call (current_target_type, l_feature)
				check l_handler /= Void end
				l_handler.handle_routine_call_in_contract (Current, l_feature, a_node.parameters)
			else
				last_expression := dummy_node (a_node.type)
			end

			current_target_type := l_target_type
		end

	process_un_old_b (a_node: UN_OLD_B)
			-- <Precursor>
		do
			process_as_old (a_node.expr)
		end

feature -- Translation

	process_attribute_call (a_feature: FEATURE_I)
			-- Process call to attribute `a_feature'.
		local
			l_content_type: IV_TYPE
			l_field: IV_ENTITY
		do
			translation_pool.add_referenced_feature (a_feature, current_target_type)

			check current_target /= Void end
			l_content_type := types.for_class_type (feature_class_type (a_feature))
			l_field := factory.entity (name_translator.boogie_procedure_for_feature (a_feature, current_target_type), types.field (l_content_type))

				-- Add a reads check
			if context_readable /= Void then
					-- Using subsumption here, since in a query call chains it can trigger for the followings checks
				add_safety_check_with_subsumption (factory.frame_access (context_readable, current_target, l_field), "access", "attribute_readable", context_line_number)
				last_safety_check.node_info.set_attribute ("cid", current_target_type.base_class.class_id.out)
				last_safety_check.node_info.set_attribute ("fid", a_feature.feature_id.out)
				check system.class_of_id (current_target_type.base_class.class_id).feature_of_feature_id (a_feature.feature_id).feature_name_id = a_feature.feature_name_id end
			end

			last_expression := factory.heap_access (entity_mapping.heap, current_target, l_field.name, l_content_type)
			field_accesses.extend ([current_target, l_field])
		end

	process_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_for_creator: BOOLEAN)
			-- Process feature call.
		local
			l_call: IV_FUNCTION_CALL
			l_name: STRING
		do
			check a_feature.has_return_value end

			translation_pool.add_referenced_feature (a_feature, current_target_type)
			l_name := name_translator.boogie_function_for_feature (a_feature, current_target_type,
				use_uninterpreted_context_function and helper.is_same_feature (a_feature, context_feature))

			if helper.is_impure (a_feature) then
					-- This is not a pure function
				helper.add_semantic_error (context_feature, messages.impure_function_in_contract (a_feature.feature_name), context_line_number)
				last_expression := dummy_node (a_feature.type)
			else
				create l_call.make (l_name, types.for_class_type (feature_class_type (a_feature)))
					-- Once functions are translated as constants; they have neither arguments nor preconditions
				if not a_feature.is_once then
					l_call.add_argument (entity_mapping.heap)
					if not helper.is_static (a_feature) then
						l_call.add_argument (current_target)
					end

					process_parameters (a_parameters)
					l_call.arguments.append (last_parameters)

						-- Add read frame check
					add_read_frame_check (a_feature)
						-- Add precondition check
					add_function_precondition_check (a_feature, l_call)
						-- Add termination check (for recursive functionals)
					add_recursion_termination_check (a_feature)
				end
				last_expression := l_call
			end
		end

	process_builtin_routine_call (a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		local
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A
			l_call: IV_FUNCTION_CALL
		do
			l_target := current_target
			l_target_type := current_target_type

			create l_call.make (a_builtin_name, types.for_class_type (feature_class_type (a_feature)))
			l_call.add_argument (entity_mapping.heap)
			if not helper.is_static (a_feature) then
				l_call.add_argument (current_target)
			end

			process_parameters (a_parameters)
			l_call.arguments.append (last_parameters)

			current_target := l_target
			current_target_type := l_target_type

			last_expression := l_call
		end

	process_special_feature_call (a_handler: E2B_CUSTOM_CALL_HANDLER; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		do
			a_handler.handle_routine_call_in_contract (Current, a_feature, a_parameters)
		end

end
