indexing
	description : "Objects used to evaluate a DBG_EXPRESSION ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"
	fixme: "FIXME jfiat [2007/05/07] : factorize code between process_array_const_b and process_tuple_const_b"
	fixme: "check all case where we do not create a tmp_result .. should we set it to Void? "

class
	DBG_EXPRESSION_EVALUATOR_B

inherit
	DBG_EXPRESSION_EVALUATOR
		redefine
			reset_error
		end

	BYTE_NODE_VISITOR

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		rename
			Context as Ast_context
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER --| To access:  ERROR_HANDLER.wipe_out
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- helpers

	application_status: APPLICATION_STATUS is
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application_status
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Evaluation data

	tmp_target: DBG_EVALUATED_VALUE
			-- Temporary evaluation target value

	tmp_result: DBG_EVALUATED_VALUE
			-- Temporary evaluation value

	tmp_target_dump_value: DUMP_VALUE
			-- Temporary target value
		do
			if {r: like tmp_target} tmp_target then
				Result := r.value
			end
		end

feature -- Context

	context_feature: FEATURE_I
			-- Feature associated to the context

	Default_context_feature: FEATURE_I is
			-- Default context feature for `context_feature'
		once
			Result := System.Any_class.compiled_class.feature_named ("default_create")
		end

feature {DBG_EXPRESSION_EVALUATION} -- Basic operation: Evaluation

	reset_error is
			-- <Precursor>
		do
			Precursor
			error_handler.wipe_out
		end

feature {NONE} -- Evaluation

	process_evaluation (keep_assertion_checking: BOOLEAN) is
			-- Compute the value of the last message of `Current'.
		local
			l_error_occurred: BOOLEAN
			dobj: DEBUGGED_OBJECT
		do
				--| Clean tmp evaluation.
			clean_temp_data

				--| prepare context
				--| this may trigger the reset of `expression_byte_node' value
			if on_context then
					--| .. Init current context using current call_stack
				init_context_with_current_callstack
			elseif on_class then
				init_context_address_with_current_callstack
				set_context_data (Void, context_class, Void)
			elseif on_object then
				dobj := debugger_manager.object_manager.debugged_object (context_address, 0, 0)
				if dobj.is_erroneous then
					dbg_error_handler.notify_error_expression (Debugger_names.msg_error_during_context_preparation (Debugger_names.msg_error_unable_to_get_valid_target_for (context_address.output)))
				else
					set_context_data (Void, dobj.dynamic_class, dobj.class_type)
				end
				dobj := Void
			end

			debug ("debugger_evaluator")
				display_context_information
			end

			if
				(on_context and context_feature = Void)
				or (on_class and context_class = Void)
			then
				dbg_error_handler.notify_error_expression_during_context_preparation
				l_error_occurred := True
			else
					--| Compute and get `expression_byte_node'
				get_byte_node
				l_error_occurred := error_occurred or else
						not (({expr_b: EXPR_B} byte_node) or ({inst_b: INSTR_B} byte_node))
			end

				--| FIXME jfiat 2004-12-09 : check if this is a true error or not ..
				-- and if this is handle later or not
			if on_context then
				if context_address = Void or else context_address.is_void then
					l_error_occurred := True
				end
			end

			if not l_error_occurred then
					--| Initializing
				clean_temp_data

					--| concrete evaluation
				process_byte_node_evaluation (keep_assertion_checking)

					--| Process result
				if tmp_result /= Void then
					final_result := tmp_result
				else
					if {expr: EXPR_B} byte_node and then {ta: TYPE_A} expr.type then
						create final_result.make
						final_result.failed := True
						final_result.suggest_static_class (ta.associated_class)
					end
					check
						error_occurred
					end
				end
					--| Clean temporary data
				clean_temp_data
			else
				final_result := Void
			end
		ensure then
			error_occurred_if_no_result: (final_result = Void or else final_result.dynamic_class = Void)
									implies (
										error_occurred
										or (final_result /= Void and then final_result.failed)
										or (final_result /= Void and then
											{pdv: DUMP_VALUE} final_result.value and then
												(pdv.is_type_procedure_return or pdv.is_void)
											)
										)
		end

	clean_temp_data is
			-- Clean temporary data used for evaluation
		do
			tmp_result := Void
			tmp_target := Void
		end

	process_byte_node_evaluation (keep_assertion_checking: BOOLEAN) is
			-- Process byte node evaluation
			-- if `keep_assertion_checking' is False, discard all assertion during evaluation
		require
			byte_node_not_void: byte_node /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if not keep_assertion_checking then
					debugger_manager.application.disable_assertion_check
				end
				if {expr_b: EXPR_B} byte_node then
					process_expression_evaluation (expr_b)
				elseif {inst_b: INSTR_B} byte_node then
					process_instruction_evaluation (inst_b)
				else
					--| Error: no expression or instruction!!
				end
			else
				dbg_error_handler.notify_error_exception_internal_issue
			end
			if not keep_assertion_checking then
				debugger_manager.application.restore_assertion_check
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- INSTR_B evaluation

	process_instruction_evaluation (a_instr_b: INSTR_B) is
		local
			l_instr_call_b: INSTR_CALL_B
		do
			l_instr_call_b ?= a_instr_b
			if l_instr_call_b /= Void then
				process_call_b (l_instr_call_b.call)
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instruction_eval_not_yet_available (a_instr_b))
			end
		end

feature {NONE} -- EXPR_B evaluation

	process_expression_evaluation (a_expr_b: EXPR_B) is
		do
			process_expr_b (a_expr_b)
		end

	standalone_evaluation_expr_b (a_expr_b: EXPR_B): DBG_EVALUATED_VALUE is
		require
			a_expr_b /= Void
		local
			l_tmp_result_value_backup: like tmp_result
			l_tmp_target_backup: like tmp_target
		do
				-- Backup
			l_tmp_result_value_backup := tmp_result
			l_tmp_target_backup := tmp_target

			process_expr_b (a_expr_b)
			Result := tmp_result

				-- Restore
			tmp_result := l_tmp_result_value_backup
			tmp_target := l_tmp_target_backup
		end


feature {BYTE_NODE} -- Routine visitors

	process_std_byte_code (a_node: STD_BYTE_CODE) is
			-- Process `a_node'.
		do
			check not_yet_implemented: False end
		end

feature {BYTE_NODE} -- Visitor

	process_access_expr_b (a_node: ACCESS_EXPR_B) is
			-- Process `a_node'.
		do
			process_expr_b (a_node.expr)
		end

	process_address_b (a_node: ADDRESS_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			t: like current_call_stack_data_for_evaluation
		do
			t := current_call_stack_data_for_evaluation
			if t /= Void then
				dv :=  t.cse.argument (a_node.position)
				if dv /= Void then
					create tmp_result.make_with_value (dv.dump_value)
					-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
				else
					dbg_error_handler.notify_error_evaluation ("Argument not found at position #" + a_node.position.out)
				end
			else
				check error_occurred: error_occurred end
			end
		end

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		local
			l_byte_list: LIST [BYTE_NODE]
			l_arg_as_lst: LINKED_LIST [DUMP_VALUE]
			l_expr_b: EXPR_B
			i: INTEGER
			dv: DUMP_VALUE
			index_dv: DUMP_VALUE_BASIC
			l_class, l_int_class: CLASS_C
			l_create_feat_i,
			l_put_feat_i: FEATURE_I
			l_tmp_target_backup: like tmp_target
			l_call_value: DBG_EVALUATED_VALUE
			l_type_i: CL_TYPE_A
			dbg: like debugger_manager
			r: DBG_EVALUATED_VALUE
		do
			--FIXME: optimize with visitor ...
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_node.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				dbg := debugger_manager
				l_call_value := tmp_result
				tmp_target := l_call_value

				l_byte_list := a_node.expressions

					--| Call default_create
				l_class := dbg.compiler_data.array_class_c
				if l_class /= Void then
					l_create_feat_i := l_class.feature_named ("make")
					create l_arg_as_lst.make
					l_int_class := dbg.compiler_data.integer_32_class_c
					l_arg_as_lst.extend (dbg.dump_value_factory.new_integer_32_value (0, l_int_class))
					l_arg_as_lst.extend (dbg.dump_value_factory.new_integer_32_value (l_byte_list.count - 1, l_int_class))
					evaluate_routine (tmp_target_dump_value.address, tmp_target_dump_value, l_class, l_create_feat_i, l_arg_as_lst)
					l_arg_as_lst := Void
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (l_type_i.name))
				end
				if not error_occurred then
					tmp_target := l_call_value
					if l_byte_list.count > 0 then
						from
							l_class := l_type_i.associated_class
							l_put_feat_i := l_class.feature_named ("put")
							check l_put_feat_i /= Void end
							create l_arg_as_lst.make
							l_arg_as_lst.extend (Void)
							l_arg_as_lst.extend (Void)
							l_byte_list.start
							i := 0
						until
							l_byte_list.after or error_occurred
						loop
							l_expr_b ?= l_byte_list.item
							if l_expr_b /= Void then
								r := parameter_evaluation (l_expr_b)
								if r = Void then
									dv := Void
								else
									dv := r.value
								end
								check l_arg_as_lst.count = 2 end
								if not error_occurred then
									l_arg_as_lst.start
									l_arg_as_lst.replace (dv)
									l_arg_as_lst.forth
									if index_dv = Void then
										index_dv := new_integer_dump_value (i)
									else
										index_dv.replace_integer_32_value (i)
									end
									l_arg_as_lst.replace (index_dv)

									tmp_target := l_call_value
									evaluate_routine (tmp_target_dump_value.address, tmp_target_dump_value, l_class, l_put_feat_i, l_arg_as_lst)
								end
							end
							i := i + 1
							l_byte_list.forth
						end
						if error_occurred then
							dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (l_type_i.name))
						end
					end
				end
				tmp_result := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	process_assert_b (a_node: ASSERT_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			cl: CLASS_C
			fi: FEATURE_I
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_node.written_in)
			end

			if cl = Void then
				dbg_error_handler.notify_error_evaluation_call_on_void (a_node.attribute_name)
			else
				fi := feature_i_from_call_access_b_in_context (cl, a_node)
				if fi /= Void then
					if tmp_target_dump_value /= Void then
						evaluate_attribute (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
					else
						evaluate_attribute (context_address, Void, cl, fi)
					end
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_with_retrieving_attribute (a_node.attribute_name))
				end
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
			if a_node.access /= Void then
				evaluate_boolean_nested_b (a_node.nested_b, not a_node.is_and, False)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_bin_div_b (a_node: BIN_DIV_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_eq_b (a_node: BIN_EQ_B) is
			-- Process `a_node'.
		local
			o: like operands_for_binary_b
			b: BOOLEAN
			l,r: DBG_EVALUATED_VALUE
		do
			o := operands_for_binary_b (a_node)
			l := o.left
			r := o.right

			if
				(l /= Void and then l.has_value) and
				(r /= Void and then r.has_value)
			then
				b := l.same_as (r)
			end
			if not error_occurred then
				create tmp_result.make_with_value (Debugger_manager.Dump_value_factory.new_boolean_value (b, debugger_manager.compiler_data.boolean_class_c))
			end
		end

	process_bin_free_b (a_node: BIN_FREE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ge_b (a_node: BIN_GE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_gt_b (a_node: BIN_GT_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_le_b (a_node: BIN_LE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_lt_b (a_node: BIN_LT_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_mod_b (a_node: BIN_MOD_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ne_b (a_node: BIN_NE_B) is
			-- Process `a_node'.
		local
			o: like operands_for_binary_b
			b: BOOLEAN
			l,r: DBG_EVALUATED_VALUE
		do
			o := operands_for_binary_b (a_node)
			l := o.left
			r := o.right

			if
				(l /= Void and then l.has_value) and
				(r /= Void and then r.has_value)
			then
				b := not l.same_as (r)
			end
			if not error_occurred then
				create tmp_result.make_with_value (Debugger_manager.Dump_value_factory.new_boolean_value (b, debugger_manager.compiler_data.boolean_class_c))
			end
		end

	process_bin_not_tilde_b (a_node: BIN_NOT_TILDE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_or_b (a_node: BIN_OR_B) is
			-- Process `a_node'.
		do
			process_bin_or_else_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B) is
			-- Process `a_node'.
		do
			if a_node.access /= Void then
				evaluate_boolean_nested_b (a_node.nested_b, not a_node.is_or, True)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_bin_plus_b (a_node: BIN_PLUS_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_power_b (a_node: BIN_POWER_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_star_b (a_node: BIN_STAR_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_xor_b (a_node: BIN_XOR_B) is
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bit_const_b (a_node: BIT_CONST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE]) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_case_b (a_node: CASE_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_char_val_b (a_node: CHAR_VAL_B) is
			-- Process `a_node'.
		local
			c: CHARACTER_32
			dv: DUMP_VALUE
		do
			c := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_character_32_value (c, debugger_manager.compiler_data.character_32_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_check_b (a_node: CHECK_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		local
			l_value_i: VALUE_I
		do
			dbg_error_handler.notify_error_not_supported (a_node)
			l_value_i := a_node.evaluate
			if l_value_i.is_no_value then
				dbg_error_handler.notify_error_not_supported (a_node)
			else
				evaluate_value_i (l_value_i, Void)
			end
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B) is
			-- Process `a_node'.
		local
			retried: BOOLEAN

			l_type_to_create: CL_TYPE_A
			l_f_b: FEATURE_B
			l_p_b: PARAMETER_B
			l_e_b: EXPR_B
			l_v_i: VALUE_I
			l_supported: BOOLEAN
			l_has_error: BOOLEAN
		do
--FIXME: convert this to visitor !!			
			if context_class_type /= Void then
				if Byte_context.class_type = Void then
					Byte_context.init (context_class_type)
				else
					Byte_context.change_class_type_context (context_class_type, context_class_type.type, context_class_type, context_class_type.type)
				end
			end
			l_type_to_create := a_node.info.type_to_create
			if byte_context.is_class_type_changed then
				byte_context.restore_class_type_context
			end
			if not retried then
				if l_type_to_create /= Void and then l_type_to_create.is_basic then
					l_f_b ?= a_node.call
					if l_f_b /= Void and then l_f_b.parameters /= Void then
						if l_f_b.parameters.count = 1 then
							l_p_b ?= l_f_b.parameters.first
							if l_p_b /= Void then
								l_e_b ?= l_p_b.expression
								if l_e_b /= Void then
									l_v_i := l_e_b.evaluate
									if l_v_i /= Void then
										l_supported	:= True
										evaluate_value_i (l_v_i, Void)
									end
								end
							end
						end
					end
				else
					if l_type_to_create /= Void then
						evaluate_creation_expr_b_with_type (a_node, l_type_to_create)
						l_has_error := error_occurred
					else
						fixme ("2004/03/18 for now we just process basic type ..., to improve ...")
						l_has_error := True
					end
				end
			else
				l_has_error := True
			end
			if l_has_error and not l_supported then
				l_type_to_create := a_node.info.type_to_create
				if l_type_to_create = Void then
					dbg_error_handler.notify_error_evaluation_creation_expression_not_implemented (Void)
				else
					dbg_error_handler.notify_error_evaluation_creation_expression_not_implemented (l_type_to_create.name)
				end
			end
		rescue
			retried := True
			retry
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			dv: DUMP_VALUE
		do
			if on_object then
					--| If the context is on object
					--| then Current represent the pointed object
				create tmp_result.make_with_value (dump_value_at_address (context_address))
			else
				cse ?= application_status.current_call_stack_element
				check cse /= Void end
				dv := dbg_evaluator.current_object_from_callstack (cse)
				if dv = Void then
					dbg_error_handler.notify_error_evaluation (Debugger_names.Cst_unable_to_get_current_object)
				else
					create tmp_result.make_with_value (dv)
					tmp_result.suggest_static_class (context_class)
				end
			end
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_debug_b (a_node: DEBUG_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_elsif_b (a_node: ELSIF_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if a_node.is_static_call then
				cl := class_c_from_external_b (a_node)
			elseif on_class then
				cl := context_class
			end
			if cl = Void then
				if tmp_target_dump_value /= Void then
					cl := tmp_target_dump_value.dynamic_class
				elseif context_class /= Void then
					cl := context_class
				else
					cl := system.class_of_id (a_node.written_in)
				end
			end

			if cl = Void then
				dbg_error_handler.notify_error_evaluation_call_on_void (a_node.feature_name)
			else
				fi := feature_i_from_call_access_b_in_context (cl, a_node)
				if fi = Void then
					params := parameter_values_from_parameters_b (a_node.parameters)
					if not error_occurred then
						evaluate_function_with_name (tmp_target_dump_value, a_node.feature_name, a_node.external_name, params)

						if tmp_result = Void or else (not tmp_result.has_value or tmp_result.failed) then
								-- FIXME: What about static ? check ...
							dbg_error_handler.notify_error_evaluation_during_call_evaluation (a_node, a_node.feature_name)
						end
					end
				else
					if fi.is_external then
							--| parameters ...
						params := parameter_values_from_parameters_b (a_node.parameters)
						if not error_occurred then
							if on_class or a_node.is_static_call then
								if tmp_target_dump_value /= Void then
									evaluate_static_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
								else
									evaluate_static_routine (context_address, Void, cl, fi, params)
								end
							else
								if tmp_target_dump_value /= Void then
									evaluate_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
								elseif context_address /= Void and then not context_address.is_void then
									evaluate_routine (context_address, Void, cl, fi, params)
								else
									if debugger_manager.is_dotnet_project  then
										evaluate_static_function (fi, cl, params)
									else
										evaluate_static_routine (context_address, Void, cl, fi, params)
									end
								end
							end
						end
					elseif fi.is_attribute then
						if tmp_target_dump_value /= Void then
							evaluate_attribute (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
						else
							evaluate_attribute (context_address, tmp_target_dump_value, cl, fi)
						end
					else
						dbg_error_handler.notify_error_evaluation_during_call_evaluation (a_node, a_node.feature_name)
					end
				end
			end
		end

	process_feature_b (a_node: FEATURE_B) is
			-- Process `a_node'.
		local
			fi: FEATURE_I
			cl: CLASS_C
			l_cl_type: CL_TYPE_A
--			l_basic_i: BASIC_A
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_node.written_in)
			end

			if cl = Void then
				dbg_error_handler.notify_error_evaluation_call_on_void (a_node.feature_name)
			else
--| Not yet ready, and useless since we do a metamorph on basic type to their ref value
--| thus no built-in evaluation			
--					--| Check if a_node is not built-in
--				if cl.is_basic then
--					check cl.types /= Void and then cl.types.first /= Void end
--					l_basic_i ?= cl.types.first.type
--					if l_basic_i /= Void and then a_node.is_feature_special (False, l_basic_i) then
--						dbg_error_handler.notify_error_expression ("Evaluation of %"built-in%" feature %""
--							+ "{" + cl.name_in_upper + "}." + a_node.feature_name
--							+ "%" is not yet available")
--					end
--				end
				if not error_occurred then
					if a_node.precursor_type /= Void and then a_node.precursor_type.is_standalone then
						l_cl_type ?= a_node.precursor_type
						check l_cl_type_not_void_if_true_precursor: l_cl_type /= Void end
						cl := l_cl_type.associated_class
						fi := cl.feature_table.feature_of_rout_id (a_node.routine_id)
					else
						fi := feature_i_from_call_access_b_in_context (cl, a_node)
					end
					if fi /= Void then
						if fi.is_once then
							evaluate_once (fi)
						elseif fi.is_constant then
							evaluate_constant (fi)
						elseif fi.is_routine then
								--| parameters ...
							params := parameter_values_from_parameters_b (a_node.parameters)
							if not error_occurred then
								if tmp_target_dump_value /= Void then
									evaluate_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
								else
									evaluate_routine (context_address, Void, cl, fi, params)
								end
							end
						elseif fi.is_attribute then
								-- How come ? maybe with redefinition .. and so on ..
							if tmp_target_dump_value /= Void then
								evaluate_attribute (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
							else
								evaluate_attribute (context_address, Void, cl, fi)
							end
						else
							dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_other_than_func_cst_once_not_available (a_node))
						end
					else
						dbg_error_handler.notify_error_evaluation_report_to_support (a_node)
					end
				end
			end
		end

	process_agent_call_b (a_node: AGENT_CALL_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_hector_b (a_node: HECTOR_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_inspect_b (a_node: INSPECT_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_int64_val_b (a_node: INT64_VAL_B) is
			-- Process `a_node'.
		local
			v: INTEGER_64
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_integer_64_value (v, debugger_manager.compiler_data.integer_64_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_int_val_b (a_node: INT_VAL_B) is
			-- Process `a_node'.
		local
			v: INTEGER_32
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_integer_32_value (v, debugger_manager.compiler_data.integer_32_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		local
			l_type: TYPE_A
			l_cl: CLASS_C
			l_cli: CLASS_I
			d_fact: DUMP_VALUE_FACTORY
			dv: DUMP_VALUE
		do
			l_type := a_node.type
			if l_type /= Void then
				l_cl := class_c_from_type_i (l_type)
			end
			d_fact := Debugger_manager.Dump_value_factory
			if l_cl /= Void then
				l_cli := l_cl.original_class
				if l_type.is_natural then
					if l_cli = System.natural_32_class then
						dv := d_fact.new_natural_32_value (a_node.natural_32_value, l_cl)
					elseif l_cli = System.natural_64_class then
						dv := d_fact.new_natural_64_value (a_node.natural_64_value, l_cl)
					elseif l_cli = System.natural_16_class then
						dv := d_fact.new_natural_16_value (a_node.natural_16_value, l_cl)
					elseif l_cli = System.natural_8_class then
						dv := d_fact.new_natural_8_value (a_node.natural_8_value, l_cl)
					else
						check should_not_occur: False end
						dv := d_fact.new_natural_32_value (a_node.natural_32_value, l_cl)
					end
				else
					if l_cli = System.integer_32_class then
						dv := d_fact.new_integer_32_value (a_node.integer_32_value, l_cl)
					elseif l_cli = System.integer_64_class then
						dv := d_fact.new_integer_64_value (a_node.integer_64_value, l_cl)
					elseif l_cli = System.integer_16_class then
						dv := d_fact.new_integer_16_value (a_node.integer_16_value, l_cl)
					elseif l_cli = System.integer_8_class then
						dv := d_fact.new_integer_8_value (a_node.integer_8_value, l_cl)
					else
						check should_not_occur: False end
						dv := d_fact.new_integer_32_value (a_node.integer_32_value, l_cl)
					end
				end
			else
					--| This should not occur, but in case it does
					--| let's display it as INTEGER_64
				l_cl := debugger_manager.compiler_data.integer_64_class_c
				dv := d_fact.new_integer_64_value (a_node.integer_64_value, l_cl)
			end
			if dv /= Void then
				create tmp_result.make_with_value (dv)
			else
				check shoud_not_occur: False end
			end
		end

	process_inv_assert_b (a_node: INV_ASSERT_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_invariant_b (a_node: INVARIANT_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			t: like current_call_stack_data_for_evaluation
		do
--FIXME: check with process_object_test_local_b
			t := current_call_stack_data_for_evaluation
			if t /= Void then
				dv :=  t.cse.local_value (a_node.position)
				create tmp_result.make_with_value (dv.dump_value)
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			else
				check error_occurred: error_occurred end
			end
		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_nat64_val_b (a_node: NAT64_VAL_B) is
			-- Process `a_node'.
		local
			v: NATURAL_64
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_natural_64_value (v, debugger_manager.compiler_data.natural_64_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_nat_val_b (a_node: NAT_VAL_B) is
			-- Process `a_node'.
		local
			v: NATURAL_32
			dv: DUMP_VALUE
		do
			--FIXME: NATURAL is NATURAL_32 for debugger?
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_natural_32_value (v, debugger_manager.compiler_data.natural_32_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_nested_b (a_node: NESTED_B) is
			-- Process `a_node'.
		local
			l_tmp_target_backup: like tmp_target
			l_target_value: DBG_EVALUATED_VALUE
			l_message_value: DBG_EVALUATED_VALUE
		do
			l_tmp_target_backup := tmp_target

			l_target_value := standalone_evaluation_expr_b (a_node.target)

			if not error_occurred then
				tmp_target := l_target_value
				l_message_value := standalone_evaluation_expr_b (a_node.message)

				if not error_occurred then
					tmp_result := l_message_value
				end
			end
			tmp_target := l_tmp_target_backup
		end

	process_object_test_b (a_node: OBJECT_TEST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B) is
			-- Process `a_node'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			t: like current_call_stack_data_for_evaluation
		do
			t := current_call_stack_data_for_evaluation
			if t /= Void then
				dv :=  t.cse.object_test_local_value (a_node.position)
				create tmp_result.make_with_value (dv.dump_value)
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			else
				check error_occurred: error_occurred end
			end
		end

	process_once_string_b (a_node: ONCE_STRING_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_operand_b (a_node: OPERAND_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_parameter_b (a_node: PARAMETER_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
			process_expr_b (a_node.expr)
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_require_b (a_node: REQUIRE_B) is
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
			t: like current_call_stack_data_for_evaluation
		do
			t := current_call_stack_data_for_evaluation
			if t /= Void then
				dv := t.cse.result_value
				if dv /= Void then
					create tmp_result.make_with_value (dv.dump_value)
					cf := t.feat
					if cf.type /= Void then
						tmp_result.suggest_static_class (cf.type.associated_class)
					end
				end
			else
				check error_occurred: error_occurred end
			end
		end

	process_retry_b (a_node: RETRY_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_reverse_b (a_node: REVERSE_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		local
			dv: DUMP_VALUE
		do
			dv := Debugger_manager.Dump_value_factory.new_manifest_string_value (
						a_node.value,
						debugger_manager.compiler_data.string_8_class_c
					)
			if dv /= Void then
				create tmp_result.make_with_value (dv)
			end
		end

	process_strip_b (a_node: STRIP_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B) is
			-- Process `a_node'.
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
			dv: DUMP_VALUE
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := debugger_manager.compiler_data.tuple_class_c
			end
			fi := cl.feature_named ("item")
			create params.make (1)
			dv := debugger_manager.dump_value_factory.new_integer_32_value (a_node.position, system.integer_32_class.compiled_class)
			params.extend (dv)
			if not error_occurred then
				if tmp_target_dump_value /= Void then
					evaluate_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
				else
					evaluate_routine (context_address, Void, cl, fi, params)
				end
			else
				dbg_error_handler.notify_error_evaluation_report_to_support (a_node)
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B) is
			-- Process `a_node'.
		local
			l_byte_list: LIST [BYTE_NODE]
			l_arg_as_lst: LINKED_LIST [DUMP_VALUE]
			l_expr_b: EXPR_B
			i: INTEGER
			dv: DUMP_VALUE
			index_dv: DUMP_VALUE_BASIC
			l_class: CLASS_C
			l_def_create_feat_i,
			l_put_feat_i: FEATURE_I
			l_tmp_target_backup: like tmp_target
			l_call_value: DBG_EVALUATED_VALUE
			l_type_i: CL_TYPE_A
			r: like parameter_evaluation
		do
			--FIXME: optimize with visitors
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_node.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				l_call_value := tmp_result
				tmp_target := l_call_value
					--| Call default_create
				l_class := debugger_manager.compiler_data.tuple_class_c
				l_def_create_feat_i := l_class.default_create_feature
				evaluate_routine (tmp_target_dump_value.address, tmp_target_dump_value, l_class, l_def_create_feat_i, Void)
				tmp_target := l_call_value
				if not error_occurred then
					l_byte_list := a_node.expressions
					if l_byte_list.count > 0 then
						from
							l_class := l_type_i.associated_class
							l_put_feat_i := l_class.feature_named ("put")
							check l_put_feat_i /= Void end
							create l_arg_as_lst.make
							l_arg_as_lst.extend (Void)
							l_arg_as_lst.extend (Void)
							l_byte_list.start
							i := 1
						until
							l_byte_list.after or error_occurred
						loop
							l_expr_b ?= l_byte_list.item
							if l_expr_b /= Void then
								r := parameter_evaluation (l_expr_b)
								if r = Void then
									dv := Void
								else
									dv := r.value
								end
								check l_arg_as_lst.count = 2 end
								if not error_occurred then
									l_arg_as_lst.start
									l_arg_as_lst.replace (dv)
									l_arg_as_lst.forth
									if index_dv = Void then
										index_dv := new_integer_dump_value (i)
									else
										index_dv.replace_integer_32_value (i)
									end
									l_arg_as_lst.replace (index_dv)

									tmp_target := l_call_value
									evaluate_routine (tmp_target_dump_value.address, tmp_target_dump_value, l_class, l_put_feat_i, l_arg_as_lst)
								end
							end
							i := i + 1
							l_byte_list.forth
						end
						if error_occurred then
							dbg_error_handler.notify_error_evaluation_instanciation_of_type_failed (l_type_i.name)
						end
					end
				end
				tmp_result := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		local
			l_class: CLASS_C
			l_def_create_feat_i: FEATURE_I
			l_tmp_target_backup: like tmp_target
			l_call_value: DBG_EVALUATED_VALUE
			l_type_i: CL_TYPE_A
		do
			fixme ("Later when we have a way to ensure the unicity of TYPE instances, we'll need to update this part")
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_node.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				l_call_value := tmp_result
				tmp_target := l_call_value
					--| Call default_create
				l_class := debugger_manager.compiler_data.type_class_c
				l_def_create_feat_i := l_class.default_create_feature
				evaluate_routine (tmp_target_dump_value.address, tmp_target_dump_value, l_class, l_def_create_feat_i, Void)
				tmp_result := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B]) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_un_free_b (a_node: UN_FREE_B) is
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_minus_b (a_node: UN_MINUS_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_not_b (a_node: UN_NOT_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_old_b (a_node: UN_OLD_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_un_plus_b (a_node: UN_PLUS_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_variant_b (a_node: VARIANT_B) is
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		do
			create tmp_result.make_with_value (Debugger_manager.Dump_value_factory.new_void_value (Void))
		end

feature {NONE} -- Visitor: implementation

	process_expr_b (a_node: EXPR_B)
			-- Process `a_node'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		local
			l_value_i: VALUE_I
		do
			l_value_i := a_node.evaluate
			if l_value_i.is_no_value then
				a_node.process (Current)
			else
				evaluate_value_i (l_value_i, Void)
			end
		end

	process_call_b (a_node: CALL_B)
			-- Process `a_node'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			a_node.process (Current)
		end

	process_unary_b (a_node: UNARY_B)
			-- Process `a_node'
			-- for unimplemented case
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			if a_node.access /= Void then
				a_node.nested_b.process (Current)
			elseif a_node.expr /= Void then
				process_expr_b (a_node.expr)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_binary_b (a_node: BINARY_B)
			-- Process `a_node'
			-- for unimplemented case
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			if a_node.access /= Void then
				a_node.nested_b.process (Current)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	operands_for_binary_b (a_node: BINARY_B): TUPLE [left: DBG_EVALUATED_VALUE; right: DBG_EVALUATED_VALUE]
			-- Operands for `a_node' evaluation
		local
			l_right, l_left: EXPR_B
			l_right_value, l_left_value: like standalone_evaluation_expr_b
		do
			l_left := a_node.left
			l_right := a_node.right

			l_left_value := standalone_evaluation_expr_b (l_left)
			l_right_value := standalone_evaluation_expr_b (l_right)
			Result := [l_left_value, l_right_value]
		end

	current_call_stack_data_for_evaluation: TUPLE [cse: EIFFEL_CALL_STACK_ELEMENT; feat: E_FEATURE]
			-- Return call stack element, and feature from current call stack.
			--| note: it can raise error, if those values are not available
			--| this is mainly to factory code for
			--|      LOCAL_B, OBJECT_TEST_LOCAL_B, ARGUMENT_B
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			cf: E_FEATURE
		do
			cse ?= application_status.current_call_stack_element
			if cse = Void then
				dbg_error_handler.notify_error_evaluation ("Unable to get Current call stack element")
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				dbg_error_handler.notify_error_evaluation ("Unable to get Current call stack element's routine")
				check
					False -- Shouldn't occur.
				end
			else
				Result := [cse, cf]
			end
		ensure
			result_void_if_error: Result = Void implies error_occurred
			valid_attached_result: Result /= Void implies Result.cse /= Void and Result.feat /= Void
		end

	evaluate_value_i (a_value_i: VALUE_I; cl: CLASS_C) is
			-- Evaluate `a_value_i'
		require
			a_value_i_not_void: a_value_i /= Void
		local
			l_integer: INTEGER_CONSTANT
			l_bit: BIT_VALUE_I
			l_char: CHAR_VALUE_I
			l_real: REAL_VALUE_I
			l_string: STRING_VALUE_I
			l_cl: CLASS_C
			d_fact: DUMP_VALUE_FACTORY
			comp_data: DEBUGGER_DATA_FROM_COMPILER
			dv: DUMP_VALUE
		do
			if a_value_i.is_integer then
				l_integer ?= a_value_i
				check is_integer: l_integer /= Void end
				process_integer_constant (l_integer)
			else
				d_fact := Debugger_manager.Dump_value_factory
				comp_data := debugger_manager.compiler_data
				l_cl := cl
				if a_value_i.is_string then
					l_string ?= a_value_i
					if l_cl = Void then
						l_cl := comp_data.string_8_class_c
					end
					dv := d_fact.new_manifest_string_value (l_string.string_value, l_cl)
				elseif a_value_i.is_boolean then
					if l_cl = Void then
						l_cl := comp_data.boolean_class_c
					end
					dv := d_fact.new_boolean_value (a_value_i.boolean_value, l_cl)
				elseif a_value_i.is_character then
					l_char ?= a_value_i
					if l_char.is_character_32 then
						if l_cl = Void then
							l_cl := comp_data.character_32_class_c
						end
						dv := d_fact.new_character_32_value (l_char.character_value, l_cl)
					else
						if l_cl = Void then
							l_cl := comp_data.character_8_class_c
						end
						dv := d_fact.new_character_value (l_char.character_value.to_character_8, l_cl)
					end
				elseif a_value_i.is_real then
					l_real ?= a_value_i
					if l_real.is_real_32 then
						if l_cl = Void then
							l_cl := comp_data.real_32_class_c
						end
						dv := d_fact.new_real_32_value (l_real.real_32_value, l_cl)
					else
						check realis_64: l_real.is_real_64 end
						if l_cl = Void then
							l_cl := comp_data.real_64_class_c
						end
						dv := d_fact.new_real_64_value (l_real.real_64_value, l_cl)
					end
				elseif a_value_i.is_bit then
					l_bit ?= a_value_i
					if l_cl = Void then
						l_cl := comp_data.bit_class_c
					end
					dv := d_fact.new_bits_value (l_bit.bit_value, l_cl.class_signature, l_cl);
				else
					dbg_error_handler.notify_error_not_supported (a_value_i)
				end
				if dv /= Void then
					create tmp_result.make_with_value (dv)
				end
			end
		end

	evaluate_boolean_nested_b (a_node: NESTED_B; a_is_lazy: BOOLEAN; a_lazy_value: BOOLEAN) is
			-- Evaluate nested expression with boolean expression
			-- if `a_is_lazy' is True, only evaluate first part
			-- if first value is `a_lazy_value'
			--| i.e: for `and then' , is_lazy=True, and lazy_value=False
			--       for `or else', is_lazy=true, and lazy_value=True
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		local
			l_tmp_target_backup: like tmp_target
			l_target_value: DBG_EVALUATED_VALUE
			l_message_value: DBG_EVALUATED_VALUE
			l_boolean_value: DUMP_VALUE_BASIC
		do
			l_tmp_target_backup := tmp_target

			l_target_value := standalone_evaluation_expr_b (a_node.target)

			if not error_occurred then
				check is_boolean_value: l_target_value.value.is_type_boolean end
				l_boolean_value ?= l_target_value.value
				check is_boolean_dump_value: l_boolean_value /= Void end
				if
					a_is_lazy and then l_boolean_value.value_boolean = a_lazy_value
				then
					tmp_result := l_target_value
				else
					tmp_target := l_target_value
					l_message_value := standalone_evaluation_expr_b (a_node.message)

					if not error_occurred then
						tmp_result := l_message_value
					end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_creation_expr_b_with_type (a_node: CREATION_EXPR_B; a_type_i: CL_TYPE_A) is
			-- Evaluate creation expression, given the type to create `a_type_i'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
			a_type_i_not_void: a_type_i /= Void
		local
			l_tmp_target_backup: like tmp_target
			l_call_value: DBG_EVALUATED_VALUE
			l_call_access: CALL_ACCESS_B
			l_call: CALL_B
			l_type_i: CL_TYPE_A
			l_gen_type_i: GEN_TYPE_A
			l_elt_type_i: CL_TYPE_A
			l_params: BYTE_LIST [PARAMETER_B]
			l_dv: DUMP_VALUE
			r: DBG_EVALUATED_VALUE
		do
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_type_i)
			if l_type_i.associated_class.is_special then
				l_gen_type_i ?= l_type_i
				if l_gen_type_i /= Void then
					if l_gen_type_i.generics.valid_index (1) then
						l_elt_type_i ?= l_gen_type_i.generics[1]
						if l_elt_type_i /= Void then
							l_call_access := a_node.call
							if l_call_access /= Void then
								l_params := l_call_access.parameters
								if l_params /= Void and then l_params.count = 1 then
									r := parameter_evaluation (l_params.first)
									if r /= Void then
										l_dv := r.value
									end
									if l_dv /= Void and then l_dv.is_type_integer_32 then
										create_special_any_instance (resolved_real_type_in_context (l_type_i), l_dv.as_dump_value_basic.value_integer_32)
									end
								end
							end
						end
					end
				end
				if error_occurred or else l_dv = Void then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instanciate_type (l_type_i.name, Debugger_names.cst_error_special_not_yet_supported))
				end
			else
				create_empty_instance_of (l_type_i)
				if not error_occurred then
					tmp_target := tmp_result
					l_call_value := tmp_target
					l_call := a_node.call
					if l_call /= Void then
						process_call_b (l_call)
					end
					if not error_occurred then
						tmp_result := l_call_value
					end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	parameter_values_from_parameters_b (a_node: BYTE_LIST [EXPR_B]): ARRAYED_LIST [DUMP_VALUE] is
			-- Parameters values for `a_params'
			-- `a_params' can be Void
		require
			is_valid: is_valid
			a_node_valid: a_node /= Void implies is_node_valid (a_node)
		local
			l_parameters_b: LIST [EXPR_B]
			r: DBG_EVALUATED_VALUE
		do
			l_parameters_b := a_node
			if l_parameters_b /= Void then
				from
					create Result.make (l_parameters_b.count)
					l_parameters_b.start
				until
					l_parameters_b.after or error_occurred
				loop
					r := parameter_evaluation (l_parameters_b.item)
					if not error_occurred then
						Result.extend (r.value)
					end
					l_parameters_b.forth
				end
			end
		ensure
			a_node_attached_implies_result: a_node /= Void implies Result /= Void
		end

	parameter_evaluation (a_node: EXPR_B): DBG_EVALUATED_VALUE is
			-- Evaluate `a_node' as a parameter
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		local
			l_expr_b: EXPR_B
			l_tmp_target_backup: like tmp_target
		do
			if {l_param_b: PARAMETER_B} a_node then
				l_expr_b := l_param_b.expression
			else
				l_expr_b := a_node
			end

			l_tmp_target_backup := tmp_target
			tmp_target := Void
				--| in case of parameter, there is not target except the top one
			Result := standalone_evaluation_expr_b (l_expr_b)
			tmp_target := l_tmp_target_backup

			if Result = Void then
				dbg_error_handler.notify_error_evaluation_parameter (a_node)
			end
		ensure
			Result_attached_unless_error_occurred: Result = Void implies error_occurred
		end

feature {NONE} -- Evaluation: implementation

	prepare_dbg_evaluation is
			-- Initialization before effective evaluation
		require
			dbg_evaluator /= Void
		do
			dbg_evaluator.set_last_variables (tmp_result)
		end

	retrieve_dbg_evaluation is
			-- Get the effective evaluation's result and info
		local
			r: like tmp_result
		do
			r := dbg_evaluator.last_result
			if r /= Void then
				create tmp_result.make_clone (r)
--			else
--| Note: at some point we should always create a result, and set it as failed				
--				create tmp_result.make
			end
			dbg_error_handler.append (dbg_evaluator.dbg_error_handler)
		ensure
			tmp_result_void_implies_error: tmp_result = Void implies error_occurred
		end

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]) is
			-- Evaluate static function `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				prepare_dbg_evaluation
				Dbg_evaluator.evaluate_static_function (f, cl, params)
				retrieve_dbg_evaluation
			end
		end

	evaluate_once (f: FEATURE_I) is
			-- Evaluate once function `f'
			--| in fact, get once function data
			--| Do not force the evaluation
		require
			feature_not_void: f /= Void
		do
			prepare_dbg_evaluation
			Dbg_evaluator.evaluate_once (f)
			retrieve_dbg_evaluation
		end

	evaluate_constant (f: FEATURE_I) is
			-- Find the value of constant feature `f'.
		require
			valid_feature: f /= Void
			is_constant: f.is_constant
		local
			cv_cst_i: CONSTANT_I
		do
			cv_cst_i ?= f
			if cv_cst_i /= Void then
				evaluate_value_i (cv_cst_i.value, cv_cst_i.type.associated_class)
			else
				dbg_error_handler.notify_error_evaluation_unknown_constant_type_for (f.feature_name)
			end
		end

	evaluate_attribute (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I) is
			-- Evaluate attribute feature
		do
			if a_target /= Void and then a_target.is_void then
				dbg_error_handler.notify_error_evaluation_call_on_void (f.feature_name)
			else
				prepare_dbg_evaluation
				Dbg_evaluator.evaluate_attribute (a_addr, a_target, c, f)
				retrieve_dbg_evaluation
			end
		end

	evaluate_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
			-- Evaluate routine `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if a_target /= Void and then a_target.is_void then
					dbg_error_handler.notify_error_evaluation_call_on_void (f.feature_name)
				elseif on_class and then not f.is_once then
					dbg_error_handler.notify_error_evaluation_VST1_on_class_context (cl.name_in_upper, f.feature_name)
				else
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_routine (a_addr, a_target, cl, f, params, False)
					retrieve_dbg_evaluation
				end
			end
		end

	evaluate_static_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
			-- Evaluate static routine `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if a_target /= Void and then a_target.is_void then
					dbg_error_handler.notify_error_evaluation_call_on_void (f.feature_name)
				else
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_routine (a_addr, a_target, cl, f, params, True)
					retrieve_dbg_evaluation
				end
			end
		end

	evaluate_function_with_name (a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
			-- Evaluate function defined by `a_feature_name'
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		local
			l_addr: DBG_ADDRESS
		do
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if debugger_manager.is_dotnet_project then
						-- FIXME: What about static ? check ...
					if a_target /= Void then
						l_addr := tmp_target_dump_value.value_address
					else
						l_addr := context_address
					end
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_function_with_name (l_addr, a_target, a_feature_name, a_external_name, params)
					retrieve_dbg_evaluation
				end
			end
		end

	create_empty_instance_of (a_type_i: CL_TYPE_A) is
			-- New empty instance of class represented by `a_type_id'.
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			not_special: not a_type_i.associated_class.is_special
		local
			l_cl_type_i: CL_TYPE_A
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type (Void) then
				prepare_dbg_evaluation
				Dbg_evaluator.create_empty_instance_of (l_cl_type_i)
				retrieve_dbg_evaluation
				if error_occurred and l_cl_type_i.has_formal_generic then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

	create_special_any_instance (a_type_i: CL_TYPE_A; a_count: INTEGER) is
			-- Create new instance of SPECIAL represented by `a_type_id' and `a_count'
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			is_special: a_type_i.associated_class.is_special
		local
			l_cl_type_i: CL_TYPE_A
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type (Void) then
				prepare_dbg_evaluation
				Dbg_evaluator.create_special_any_instance (l_cl_type_i, a_count)
				retrieve_dbg_evaluation
				if error_occurred and l_cl_type_i.has_formal_generic then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

feature -- Context: Element change

	init_context_with_current_callstack is
			-- Init context data with values from current callstack
			-- i.e: current debugging contex	
		local
			cse: CALL_STACK_ELEMENT
			ecse: EIFFEL_CALL_STACK_ELEMENT
			fi: FEATURE_I
		do
			cse := application_status.current_call_stack_element
			if cse = Void then
				dbg_error_handler.notify_error_expression_during_context_preparation
			else
					--| Cse can be Void if the application raised an exception
					--| at the very beginning of the execution (for instance under dotnet)
				context_address := cse.object_address
				ecse ?= cse
				if ecse = Void then
					--| Could occurs in case of External call stack element
					--| in case of Exception or stopped state
					dbg_error_handler.notify_error_expression_during_context_preparation
				else
					fi := ecse.routine_i
					set_context_data (fi, ecse.dynamic_class, ecse.dynamic_type)
				end
			end
		end

	init_context_address_with_current_callstack is
			-- Init context address with data from current callstack
			-- i.e: current debugging context
		local
			cse: CALL_STACK_ELEMENT
		do
			cse := application_status.current_call_stack_element
				--| Cse can be Void if the application raised an exception
				--| at the very beginning of the execution (for instance under dotnet)
			if cse /= Void then
				context_address := cse.object_address
			end
		end

	set_context_data (f: like context_feature; c: like context_class; ct: like context_class_type) is
			-- Set context data related to `f', `c', `ct'
		local
			l_reset_byte_node: BOOLEAN
			c_c_t: CLASS_TYPE
			c_t_i: CL_TYPE_A
		do
			if c /= Void then
				if
					f /= context_feature
				then
					context_feature := f
					l_reset_byte_node := True
				end
				if not equal (context_class, c) then
					context_class := c
					l_reset_byte_node := True
				end
				if ct /= Void then
					c_c_t := ct
				elseif context_class /= Void then
					c_t_i := context_class.actual_type
					if c_t_i.has_associated_class_type (Void) then
						c_c_t := c_t_i.associated_class_type (Void)
					end
				end
				if not equal (context_class_type, c_c_t) then
					context_class_type := c_c_t
					l_reset_byte_node := True
				end
				if context_class = Void and context_class_type /= Void then
					context_class_type := Void
					l_reset_byte_node := True
				end

				if context_feature = Void then
					if not on_object then
						l_reset_byte_node := True
						context_feature := Default_context_feature
					end
				end
				if l_reset_byte_node then
						--| this means we will recompute the EXPR_B value according to the new context				
					reset_byte_node
				end
			end
		end

	display_context_information	is
			-- Display context information in the output
			-- for debugging purpose only
		local
			ca: like context_address
			cc: like context_class
			cct: like context_class_type
			cf: like context_feature
			r: BOOLEAN
		do
			if not r then
				ca := context_address
				cc := context_class
				cct := context_class_type
				cf := context_feature

				io.put_string ("%NExpression=" + expression.text + "%N")
				io.put_string (" address=")
				if ca /= Void then
					io.put_string (ca.output)
				else
					io.put_string ("")
				end
				io.put_new_line

				io.put_string (" class=")
				if cc /= Void then
					io.put_string (cc.name_in_upper)
				else
					io.put_string ("")
				end
				io.put_new_line


				io.put_string (" type=")
				if cct /= Void then
					io.put_string (cct.associated_class.name_in_upper)
				else
					io.put_string ("")
				end
				io.put_new_line

				io.put_string (" feature==")
				if cf /= Void then
					io.put_string (cf.feature_name)
				else
					io.put_string ("")
				end
				io.put_new_line
			end
		rescue
			r := True
			retry
		end

feature -- Access

	byte_node_computed: BOOLEAN
			-- is byte_node computed?

	byte_node: BYTE_NODE is
			-- Byte node related to `expression'
		do
			Result := internal_byte_node
			if not byte_node_computed then
				check internal_byte_node = Void end
				get_byte_node
				check byte_node_computed end
				Result := internal_byte_node
			end
		end

	is_boolean_expression (f: FEATURE_I): BOOLEAN is
			-- Is `Current' a boolean query in the context of `f'?
		local
			old_context_feature: like context_feature
			old_context_class: like context_class
			old_context_class_type: like context_class_type
			old_int_expression_byte_note: like internal_byte_node
			bak_byte_code: BYTE_CODE
		do
				--| Backup current context and values
			old_context_feature := context_feature
			old_context_class := context_class
			old_context_class_type := context_class_type
			old_int_expression_byte_note := internal_byte_node

				--| Removed any potential error due to previous evaluation
			error_handler.wipe_out

				--| prepare context
				--| this may reset the `expression_byte_node' value
			set_context_data (f, f.written_class, Void)

				--| Get expression_byte_node
			get_byte_node
			if not error_occurred and then {expr: EXPR_B} byte_node then
--| Since the Byte_context is used only by debugger and code generation
--| there is no need to restore previous context
--| (see below the commented line for restoring class_type_context)
				if context_class_type /= Void then
					if Byte_context.class_type = Void then
						Byte_context.init (context_class_type)
					else
						Byte_context.change_class_type_context (context_class_type, context_class_type.type, context_class_type, context_class_type.type)
					end
					bak_byte_code := Byte_context.byte_code
					if context_feature /= Void then
						Byte_context.set_current_feature (context_feature)
						Byte_context.set_byte_code (context_feature.byte_server.item (context_feature.body_index))
					end
				end

				Result := expr.type.is_boolean
				if context_class_type /= Void and Byte_context.is_class_type_changed then
					Byte_context.restore_class_type_context
				end
				if bak_byte_code /= Void then
					Byte_context.set_byte_code (bak_byte_code)
				end
			end

				--| FIXME JFIAT: check in which cases we call the is_condition
				--| to see if it is pertinent to save.restore data ...			
			if
				old_context_class = Void
				and old_context_class_type = Void
				and old_context_feature = Void
				and old_int_expression_byte_note = Void
			then
				-- if everything was unset before, let's keep these values
				-- we may use them again soon ...
				-- so no need to recompute the EXPR_B again and again
			else
					--| Restore context and values
				if old_context_class = Void then
						--| FIXME JFIAT: check this ... how to have a context_class .. not void
						--| and pertinent ...
					old_context_class := context_class
				end
				set_context_data (old_context_feature, old_context_class, old_context_class_type)
				internal_byte_node := old_int_expression_byte_note
			end
		end

feature {NONE} -- Implementation

	new_integer_dump_value (i: INTEGER): DUMP_VALUE_BASIC is
			-- New DUMP_VALUE representing an INTEGER value.
		local
			dbgm: like debugger_manager
		do
			dbgm := debugger_manager
			Result := dbgm.dump_value_factory.new_integer_32_value (i, dbgm.compiler_data.integer_32_class_c)
		end

	prepare_contexts (cl: CLASS_C; ct: CLASS_TYPE) is
			-- Prepare AST shared context  with `cl' and `ct'
		require
			cl_not_void: cl /= Void
			ct_associated_to_cl: ct /= Void implies ct.associated_class.is_equal (cl)
		local
			l_ta: CL_TYPE_A
		do
			if ct /= Void then
				l_ta := ct.type
			else
				l_ta := cl.actual_type
			end
			Ast_context.initialize (cl, l_ta, cl.feature_table)
			if ct /= Void then
				byte_context.init (ct)
			end
			Inst_context.set_group (cl.group)
		end

	get_byte_node is
			-- get byte node depending of the context
		require
			context_feature_not_void: on_context implies context_feature /= Void
			context_class_not_void: context_class /= Void
		local
			retried: BOOLEAN

			l_ct_locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			f_as: BODY_AS
			l_byte_code: BYTE_CODE
			bak_byte_code: BYTE_CODE
			bak_cc, l_cl: CLASS_C
		do
			byte_node_computed := True
			if not retried then
				if internal_byte_node = Void then
					error_handler.wipe_out

					debug ("debugger_trace_eval_data")
						print (generator + ".get_expression_byte_node from [" + expression.text + "]%N")
						print ("%T%T on_context: " + on_context.out +"%N")
						print ("%T%T on_class  : " + on_class.out +"%N")
						print ("%T%T on_object : " + on_object.out +"%N")
						if context_class /= Void then
							print ("%T%T context_class : " + context_class.name_in_upper +"%N")
						end
						if context_address /= Void then
							print ("%T%T context_address : " + context_address.output +"%N")
						end
						if context_feature /= Void then
							print ("%T%T context_feature : " + context_feature.feature_name +"%N")
						end
					end
						--| If we want to recompute the `byte_node',
						--| we need to call `reset_byte_node'

					if context_class /= Void then
						ast_context.clear_all
							--| Prepare Compiler context
						prepare_contexts (context_class, context_class_type)

						bak_cc := System.current_class
						System.set_current_class (context_class)

						bak_byte_code := Byte_context.byte_code

						if on_context and then context_feature /= Void then
							if not context_class.conform_to (context_feature.written_class) then
								debug ("debugger_trace_eval_data")
									print ("Context class {"+ context_class.name_in_upper
											+"} does not has context feature %""+context_feature.feature_name+"%"%N")
								end
								--| This issue occurs for instance in {TEST}.twin
								--| where {ISE_RUNTIME}check_assert (boolean) is called
								--| at this point the context class is TEST,
								--| and the context feature is `check_assert (BOOLEAN)'
								--| but TEST doesn't conform to ISE_RUNTIME.
								l_cl := context_feature.written_class
								prepare_contexts (l_cl, Void)
								System.set_current_class (l_cl)
							else
								l_cl := context_class
							end
							Ast_context.set_current_feature (context_feature)
							if context_feature.written_class /= context_class then
								Ast_context.set_written_class (context_feature.written_class)
							end

							fixme ("jfiat [2004/10/16] : Seems pretty heavy computing ..")
							l_byte_code := context_feature.byte_server.item (context_feature.body_index)
							Byte_context.set_byte_code (l_byte_code)

								--| Locals
							f_as := context_feature.real_body
							if f_as /= Void or True then
								l_ct_locals := locals_builder.local_table (l_cl, context_feature, f_as)
								if l_ct_locals /= Void then
										--| if it failed .. let's continue anyway for now

										--| Last local return a new object
										--| so there is no need to "twin" it
									Ast_context.set_locals (l_ct_locals)
								end
								add_object_test_locals_info_to_ast_context (context_feature.e_feature)
							end
						elseif on_object and then context_class /= Void then
							l_cl := context_class
							prepare_contexts (l_cl, Void)
							System.set_current_class (l_cl)
							ast_context.set_written_class (l_cl)
						end
							--| Compute and get `expression_byte_node'
						internal_byte_node := byte_node_from_ast (expression.ast)
							--| Reset Compiler context
						if bak_cc /= Void then
							System.set_current_class (bak_cc)
						end
						if bak_byte_code /= Void then
							Byte_context.set_byte_code (bak_byte_code)
						end
						Ast_context.clear_all
					else
						dbg_error_handler.notify_error_exception_context_corrupted_or_not_found
						Ast_context.clear_all
					end
				end
			else
				dbg_error_handler.notify_error_expression_during_analyse
				error_handler.wipe_out
			end
		ensure
			expression_byte_node_computed: byte_node_computed
		rescue
			retried := True
			retry
		end

	byte_node_from_ast (exp: EXPR_AS): like byte_node is
			-- compute expression_byte_node from EXPR_AS `exp'
		require
			context_feature_not_void: on_context implies context_feature /= Void
		local
			retried: BOOLEAN
			type_check_succeed: BOOLEAN
		do
			if exp = Void then
					--| How come it is Void ?
					--| for instance, expression: create {STRING}.make_empty
				reset_error
				dbg_error_handler.notify_error_expression_during_analyse
			elseif not retried then
				reset_error
				error_handler.wipe_out
				Ast_context.set_is_ignoring_export (True)

				dbg_expression_checker.init (ast_context)
				debug ("debugger_trace_eval_data")
					print (generator + ".expression_byte_node_from_ast (..) %N")
					print ("   Ast_context -> {"
							+ ast_context.current_class.name_in_upper
							+ "}")
					if ast_context.current_feature /= Void then
						print ("." + ast_context.current_feature.feature_name)
					end
					print ("%N")
				end
				dbg_expression_checker.expression_type_check_and_code (context_feature, exp)
				Ast_context.set_is_ignoring_export (False)

				if error_handler.has_error then
					type_check_succeed := True
					dbg_error_handler.notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
					Result := Void
				else
					Result := dbg_expression_checker.last_byte_node
				end
			else
				ast_context.set_is_ignoring_export (False)
				if not type_check_succeed then
					dbg_error_handler.notify_error_expression_type_checking_failed
				end
				if error_handler.has_error then
					dbg_error_handler.notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
				else
					if not error_occurred then
						dbg_error_handler.notify_error_expression (Void)
					end
				end
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	reset_byte_node is
			-- Reset `byte_node'
		do
			internal_byte_node := Void
		end

	internal_byte_node: like  byte_node
			-- Cached `byte_node'

feature {NONE} -- OT locals

	add_object_test_locals_info_to_ast_context (f: E_FEATURE) is
			-- Add object test locals to the context
		require
			f_not_void: f /= Void
		local
			lst: LIST [TUPLE [id_as: ID_AS; type_as: TYPE_AS]]
			ta: TYPE_A
			tu: TUPLE [id_as: ID_AS; type_as: TYPE_AS]
			li: LOCAL_INFO
			ast_v: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR
			l_name_id: INTEGER
		do
			lst := f.object_test_locals
			if lst /= Void and then not lst.is_empty then
				create ast_v
				ast_v.init (Ast_context)
				from
					lst.start
				until
					lst.after
				loop
					tu := lst.item_for_iteration
					l_name_id := tu.id_as.name_id
					create li
					li.set_position (Ast_context.next_object_test_local_position)
					ta := ast_v.type_a_from_type_as (tu.type_as)
					li.set_type (ta)
					li.set_is_used (True)

					Ast_context.add_object_test_local (li, l_name_id)
					Ast_context.add_object_test_expression_scope (l_name_id)
					lst.forth
				end
			end
		end

feature {NONE} -- Compiler helpers

	resolved_real_type_in_context (a_type_i: CL_TYPE_A): CL_TYPE_A is
			-- Resolved real type associated with `a_type_i'
		require
			a_type_i_not_void: a_type_i /= Void
		do
			if context_class_type /= Void then
				Result ?= byte_context.real_type_in (a_type_i, context_class_type.type)
			end
			if Result = Void then
				Result := a_type_i
			end
		ensure
			Result_not_void: Result /= Void
		end

	class_c_from_external_b (a_external_b: EXTERNAL_B): CLASS_C is
			-- Class C related to `a_external_b' if exists.
		require
			a_expr_b_not_void: a_external_b /= Void
		local
			ti: TYPE_A
		do
			ti := a_external_b.static_class_type
			if ti /= Void then
				Result := class_c_from_type_i (ti)
			elseif a_external_b.extension /= Void then
				 -- try to find out the class thanks to extension
				Result := Dbg_evaluator.class_c_from_external_b_with_extension (a_external_b)
			end
		end

feature {NONE} -- Implementation

	dbg_expression_checker: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR is
			-- Ast expression checker dedicated for debugger
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class DBG_EXPRESSION_EVALUATOR_B
