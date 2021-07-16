note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_AGENT_CALL_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER
	E2B_CUSTOM_NESTED_HANDLER
	SHARED_WORKBENCH
	SHARED_NAMES_HEAP

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result := attached {CL_TYPE_A} a_target_type as c and then {E2B_HELPER}.is_agent_type (c)
		end

	is_handling_nested (a_nested: NESTED_B): BOOLEAN
			-- <Precursor>
		do
			if attached {ACCESS_EXPR_B} a_nested.target as l_access and then attached {ROUTINE_CREATION_B} l_access.expr then
				Result := True
			end
		end

feature -- Basic operations

	handle_routine_call_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_new_args: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
		do
			boogie_universe.add_dependency (agents_theory_filename)
			if a_parameters.count = 1 and attached {TUPLE_CONST_B} a_parameters.first.expression as l_tuple then
				create l_new_args.make (l_tuple.expressions.count)
				across l_tuple.expressions as i loop
					create l_param
					l_param.set_expression (i.item)
					l_new_args.extend (l_param)
				end
			else
				l_new_args := a_parameters
			end
			if a_feature.feature_name ~ "call" then
				a_translator.process_builtin_routine_call (a_feature, l_new_args, "routine.call_" + l_new_args.count.out)
			elseif a_feature.feature_name ~ "item" then
				a_translator.process_builtin_routine_call (a_feature, l_new_args, "routine.item_" + l_new_args.count.out)
			else
				a_translator.set_last_expression (factory.function_call ("unsupported", << >>, types.ref))
			end
		end

	handle_routine_call_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_new_args: BYTE_LIST [PARAMETER_B]
			l_param: PARAMETER_B
			l_is_function: BOOLEAN
		do
			boogie_universe.add_dependency (agents_theory_filename)
			if a_parameters.count = 1 and attached {TUPLE_CONST_B} a_parameters.first.expression as l_tuple then
				create l_new_args.make (l_tuple.expressions.count)
				across l_tuple.expressions as i loop
					create l_param
					l_param.set_expression (i.item)
					l_new_args.extend (l_param)
				end
			else
				l_new_args := a_parameters
			end
			l_is_function := a_translator.current_target_type.base_class.name_in_upper.same_string ("FUNCTION")
			if a_feature.feature_name.same_string ("precondition") then
				a_translator.process_builtin_routine_call (a_feature, l_new_args, "routine.precondition_" + l_new_args.count.out)
			elseif a_feature.feature_name.same_string ("postcondition") then
				if l_is_function then
					process_postcondition_call (a_translator, a_feature, l_new_args, "function.postcondition_" + l_new_args.count.out)
				else
					process_postcondition_call (a_translator, a_feature, l_new_args, "routine.postcondition_" + l_new_args.count.out)
				end
			end
		end

	handle_agent_creation (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_node: ROUTINE_CREATION_B)
			-- Handle `a_node'.
		require
			not_inline_agent: not a_node.is_inline_agent
		local
			l_agent_class: CLASS_C
			l_agent_feature: FEATURE_I
			l_agent_type: CL_TYPE_A

			i, j, k: INTEGER
			l_open_argument_count, l_closed_argument_count: INTEGER
			l_arg_str: STRING

			l_agent_local, l_arg_local: IV_ENTITY
			l_expr: IV_EXPRESSION
			l_proc_call: IV_PROCEDURE_CALL
			l_pre_forall, l_post_forall, l_mod_forall: IV_FORALL
			l_pre_acall, l_pre_fcall, l_post_acall, l_post_fcall, l_mod_acall, l_mod_fcall: IV_FUNCTION_CALL
			l_assume: IV_ASSERT
		do
			boogie_universe.add_dependency (agents_theory_filename)

			l_agent_class := system.class_of_id (a_node.origin_class_id)
			l_agent_feature := l_agent_class.feature_of_feature_id (a_node.feature_id)
				-- TODO: take actual type of open/closed target of agent creation
			l_agent_type := l_agent_feature.written_class.actual_type
			translation_pool.add_referenced_feature (l_agent_feature, l_agent_type)	-- generates frame function
			translation_pool.add_function_precondition_predicate (l_agent_feature, l_agent_type) -- generates precondition function
			translation_pool.add_postcondition_predicate (l_agent_feature, l_agent_type) -- generates postcondition function

			a_translator.create_local (system.any_type)
			l_agent_local := a_translator.last_local

				-- Set up functions and axioms
			if a_node.omap /= Void then
				l_arg_str := a_node.omap.count.out
			else
				l_arg_str := "0"
			end
			create l_pre_acall.make ("routine.precondition_" + l_arg_str, types.bool)
			l_pre_acall.add_argument (factory.heap_entity ("h"))
			l_pre_acall.add_argument (l_agent_local)
			create l_pre_fcall.make (name_translator.boogie_function_precondition (name_translator.boogie_function_for_feature (l_agent_feature, l_agent_type, False)), types.bool)
			l_pre_fcall.add_argument (factory.heap_entity ("h"))
			create l_pre_forall.make (factory.equal (l_pre_acall, l_pre_fcall))
			l_pre_forall.add_bound_variable (factory.heap_entity ("h"))

			create l_mod_acall.make ("routine.modify_" + l_arg_str, types.frame)
			l_mod_acall.add_argument (factory.heap_entity ("h"))
			l_mod_acall.add_argument (l_agent_local)
			create l_mod_fcall.make (name_translator.boogie_function_for_write_frame (l_agent_feature, l_agent_type), types.frame)
			l_mod_fcall.add_argument (factory.heap_entity ("h"))
			create l_mod_forall.make (factory.equal (l_mod_acall, l_mod_fcall))
			l_mod_forall.add_bound_variable (factory.heap_entity ("h"))

			if l_agent_feature.has_return_value then
				create l_post_acall.make ("funciton.postcondition_" + l_arg_str, types.bool)
			else
				create l_post_acall.make ("routine.postcondition_" + l_arg_str, types.bool)
			end
			l_post_acall.add_argument (factory.heap_entity ("h"))
			l_post_acall.add_argument (factory.heap_entity ("old_h"))
			l_post_acall.add_argument (l_agent_local)
			create l_post_fcall.make (name_translator.postcondition_predicate_name (l_agent_feature, l_agent_type), types.bool)
			l_post_fcall.add_argument (factory.heap_entity ("h"))
			l_post_fcall.add_argument (factory.heap_entity ("old_h"))
			create l_post_forall.make (factory.equal (l_post_acall, l_post_fcall))
			l_post_forall.add_bound_variable (factory.heap_entity ("h"))
			l_post_forall.add_bound_variable (factory.heap_entity ("old_h"))

				-- Process agent arguments
			if a_node.omap /= Void then
				l_open_argument_count := a_node.omap.count
			end
			l_closed_argument_count := a_node.arguments.expressions.count
			check l_agent_feature.argument_count + 1 = l_open_argument_count + l_closed_argument_count end

			from
				i := 1 -- Argument position
				j := 1 -- Open Argument index
				k := 1 -- Closed Argument index
			until
				i > l_agent_feature.argument_count + 1
			loop
				if j <= l_open_argument_count and then a_node.omap.i_th (j) = i then
						-- Next is an open argument
					check j <= a_node.omap.count end

						-- TODO: get argument type at position i
					create l_arg_local.make ("oarg_" + j.out, types.ref)
					l_pre_forall.add_bound_variable (l_arg_local)
					l_pre_acall.add_argument (l_arg_local)
					l_pre_fcall.add_argument (l_arg_local)

					l_mod_forall.add_bound_variable (l_arg_local)
					l_mod_acall.add_argument (l_arg_local)
					l_mod_fcall.add_argument (l_arg_local)

					l_post_forall.add_bound_variable (l_arg_local)
					l_post_acall.add_argument (l_arg_local)
					l_post_fcall.add_argument (l_arg_local)

					j := j + 1
				else
						-- Next is a closed argument
					check k <= a_node.arguments.expressions.count end

					l_expr := a_translator.process_argument_expression (a_node.arguments.expressions.i_th (k))
					l_pre_fcall.add_argument (l_expr)
					l_mod_fcall.add_argument (l_expr)
					l_post_fcall.add_argument (l_expr)

					k := k + 1
				end
				i := i + 1
			end

				-- Allocate agent ref
			create l_proc_call.make ("allocate")
			if l_agent_feature.has_return_value then
				l_proc_call.add_argument (factory.type_value (system.function_class.compiled_class.actual_type))
			else
				l_proc_call.add_argument (factory.type_value (system.procedure_class.compiled_class.actual_type))
			end
			l_proc_call.set_target (l_agent_local)
			a_translator.side_effect.extend (a_translator.if_safety_expression (l_proc_call))

			create l_proc_call.make ("create.routine")
			l_proc_call.add_argument (l_agent_local)
			a_translator.side_effect.extend (a_translator.if_safety_expression (l_proc_call))

				-- Add assumptions
			create l_assume.make_assume (l_pre_forall)
			a_translator.side_effect.extend (l_assume)
			create l_assume.make_assume (l_post_forall)
			a_translator.side_effect.extend (l_assume)
			create l_assume.make_assume (l_mod_forall)
			a_translator.side_effect.extend (l_assume)

			a_translator.set_last_expression (l_agent_local)
		end

	handle_nested_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- <Precursor>
		do
			handle_nested (a_translator, a_nested)
		end

	handle_nested_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- <Precursor>
		do
			handle_nested (a_translator, a_nested)
		end

	handle_nested (a_translator: E2B_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- Handle nested in either contract or body.
		local
			l_name: STRING
			l_expr: EXPR_B
			l_agent_class: CLASS_C
			l_agent_feature: FEATURE_I
			l_agent_type: CL_TYPE_A
			l_fcall: IV_FUNCTION_CALL
		do
			if attached {FEATURE_B} a_nested.message as l_call then
				l_name := names_heap.item (l_call.feature_name_id)
				if
					l_name ~ "postcondition" and then
					attached {ACCESS_EXPR_B} a_nested.target as l_access and then
					attached {ROUTINE_CREATION_B} l_access.expr as l_agent
				then
					l_agent_class := system.class_of_id (l_agent.origin_class_id)
					l_agent_feature := l_agent_class.feature_of_feature_id (l_agent.feature_id)
						-- TODO: take actual type of open/closed target of agent creation
					l_agent_type := l_agent_feature.written_class.actual_type

					translation_pool.add_referenced_feature (l_agent_feature, l_agent_type)
					translation_pool.add_postcondition_predicate (l_agent_feature, l_agent_type)
					create l_fcall.make (name_translator.postcondition_predicate_name (l_agent_feature, l_agent_type), types.bool)
					l_fcall.add_argument (a_translator.entity_mapping.heap)
					l_fcall.add_argument (a_translator.entity_mapping.old_heap)

						-- TODO: go though expressions
					l_expr := l_agent.arguments.expressions.first
					l_fcall.add_argument (a_translator.process_argument_expression (l_expr))

					a_translator.set_last_expression (l_fcall)
				end
			end
		end

feature -- Implementation

	process_postcondition_call (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B]; a_builtin_name: STRING)
			-- Process feature call.
		local
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A
			l_call: IV_FUNCTION_CALL
		do
			l_target := a_translator.current_target
			l_target_type := a_translator.current_target_type

			create l_call.make (a_builtin_name, types.for_class_type (a_translator.feature_class_type (a_feature)))
			l_call.add_argument (a_translator.entity_mapping.heap)
			l_call.add_argument (factory.old_ (a_translator.entity_mapping.heap))
			l_call.add_argument (a_translator.current_target)

			a_translator.process_parameters (a_parameters)
			l_call.arguments.append (a_translator.last_parameters)

			a_translator.set_current_target (l_target)
			a_translator.set_current_target_type (l_target_type)

			a_translator.set_last_expression (l_call)
		end

	agents_theory_filename: PATH
			-- File name of agents theory.
		once
			Result := {E2B_BOOGIE_GENERATOR}.theory_directory.extended ("agents.bpl")
		end

end
