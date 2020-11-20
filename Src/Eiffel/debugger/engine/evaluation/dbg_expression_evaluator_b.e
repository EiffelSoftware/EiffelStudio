note
	description: "Objects used to evaluate a DBG_EXPRESSION ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	fixme: "FIXME jfiat [2007/05/07]: factorize code between process_array_const_b and process_tuple_const_b"
	fixme: "check all case where we do not create a tmp_result ... should we set it to Void? "

class
	DBG_EXPRESSION_EVALUATOR_B

inherit
	DBG_EXPRESSION_EVALUATOR
		redefine
			apply_context,
			reset_error
		end

	BYTE_NODE_VISITOR

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
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

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- helpers

	application_execution: APPLICATION_EXECUTION
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application
		end

	application_status: APPLICATION_STATUS
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
			if attached tmp_target as r then
				Result := r.value
			end
		end

feature {DBG_EXPRESSION_EVALUATION} -- Basic operation: Evaluation

	reset_error
			-- <Precursor>
		do
			Precursor
			error_handler.wipe_out
		end

feature {NONE} -- Evaluation

	process_evaluation (keep_assertion_checking: BOOLEAN)
			-- Compute the value of the last message of `Current'.
		local
			l_error_occurred: BOOLEAN
			prev_byte_code: detachable BYTE_CODE
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
			elseif on_object then
				init_context_on_object_with_current_callstack (context.address)
			end

			debug ("debugger_evaluator")
				display_context_information
			end

			if
				(on_context and context.feature_i = Void)
				or (on_class and context.class_c = Void)
			then
				dbg_error_handler.notify_error_expression_during_context_preparation
				l_error_occurred := True
			else
					--| Compute and get `expression_byte_node'
				get_byte_node
				l_error_occurred := error_occurred or else
						not ((attached {EXPR_B} byte_node) or (attached {INSTR_B} byte_node))
			end

				--| FIXME jfiat 2004-12-09 : check if this is a true error or not ..
				-- and if this is handle later or not
			if
				on_context and then
				(context.address = Void or else context.address.is_void)
			then
				l_error_occurred := True
			end

			if not l_error_occurred then
					--| Initializing
				clean_temp_data

					--| Record byte_context.byte_code
				prev_byte_code := byte_context.byte_code

					--| Apply byte_code related to current evaluation
				if attached context.byte_code as bc then
					byte_context.set_byte_code (bc)
				end

					--| concrete evaluation
				process_byte_node_evaluation (keep_assertion_checking)

					--| Process result
				if tmp_result /= Void then
					final_result := tmp_result
				else
					if (attached {EXPR_B} byte_node as expr) and then (attached expr.type as ta) then
						create final_result.make
						final_result.failed := True
						if attached ta.base_class as cl then
							final_result.suggest_static_class (cl)
						end
					end
					check
						error_occurred
					end
				end

					--| Revert byte_context.byte_code
				if prev_byte_code /= Void then
					byte_context.set_byte_code (prev_byte_code)
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
											(attached final_result.value as pdv) and then
												(pdv.is_type_procedure_return or pdv.is_void)
											)
										)
		end

	clean_temp_data
			-- Clean temporary data used for evaluation
		do
			tmp_result := Void
			tmp_target := Void
			clean_expression_object_test_locals
		end

	process_byte_node_evaluation (keep_assertion_checking: BOOLEAN)
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
				if attached {EXPR_B} byte_node as expr_b then
					process_expression_evaluation (expr_b)
				elseif attached {INSTR_B} byte_node as inst_b then
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

	process_instruction_evaluation (a_instr_b: INSTR_B)
		do
			if attached {INSTR_CALL_B} a_instr_b as l_instr_call_b then
				process_call_b (l_instr_call_b.call)
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instruction_eval_not_yet_available (a_instr_b))
			end
		end

feature {NONE} -- EXPR_B evaluation

	process_expression_evaluation (a_expr_b: EXPR_B)
		do
			process_expr_b (a_expr_b)
		end

	standalone_evaluation_expr_b (a_expr_b: EXPR_B): DBG_EVALUATED_VALUE
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

	process_std_byte_code (a_node: STD_BYTE_CODE)
			-- Process `a_node'.
		do
			check not_yet_implemented: False end
		end

feature {BYTE_NODE} -- Visitor

	process_access_expr_b (a_node: ACCESS_EXPR_B)
			-- Process `a_node'.
		do
			process_expr_b (a_node.expr)
		end

	process_address_b (a_node: ADDRESS_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_argument_b (a_node: ARGUMENT_B)
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

	process_array_const_b (a_node: ARRAY_CONST_B)
			-- Process `a_node'.
		local
			l_byte_list: LIST [BYTE_NODE]
			l_arg_as_lst: LINKED_LIST [DUMP_VALUE]
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
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instantiation_of_type_raised_error (l_type_i.name))
				end
				if not error_occurred then
					tmp_target := l_call_value
					if l_byte_list.count > 0 then
						from
							l_class := l_type_i.base_class
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
							if attached {EXPR_B} l_byte_list.item as l_expr_b then
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
							dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_instantiation_of_type_raised_error (l_type_i.name))
						end
					end
				end
				tmp_result := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	process_assert_b (a_node: ASSERT_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_assign_b (a_node: ASSIGN_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_attribute_b (a_node: ATTRIBUTE_B)
			-- Process `a_node'.
		local
			cl: CLASS_C
			fi: FEATURE_I
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context.class_c /= Void then
				cl := context.class_c
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
						evaluate_attribute (context.address, Void, cl, fi)
					end
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_with_retrieving_attribute (a_node.attribute_name))
				end
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
			if a_node.access /= Void then
				evaluate_boolean_nested_b (a_node.nested_b, not a_node.is_and, False)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_bin_div_b (a_node: BIN_DIV_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_eq_b (a_node: BIN_EQ_B)
			-- Process `a_node'.
		do
			process_bin_equal_b_node (a_node, False)
		end

	process_bin_free_b (a_node: BIN_FREE_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ge_b (a_node: BIN_GE_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_gt_b (a_node: BIN_GT_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_le_b (a_node: BIN_LE_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_lt_b (a_node: BIN_LT_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_mod_b (a_node: BIN_MOD_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_ne_b (a_node: BIN_NE_B)
			-- Process `a_node'.
		do
			process_bin_equal_b_node (a_node, True)
		end

	process_bin_not_tilde_b (a_node: BIN_NOT_TILDE_B)
			-- Process `a_node'.
		do
			process_bin_tilde_b (a_node)
			if
				not error_occurred and then
				attached tmp_result as tmp_res and then
				tmp_res.has_value and then
				tmp_res.value.is_type_boolean and then
				attached tmp_res.value.as_dump_value_basic as bval
			then
				create tmp_result.make_with_value (
						debugger_manager.dump_value_factory.new_boolean_value (
								not bval.value_boolean,
								tmp_result.dynamic_class
							)
					)
			end
		end

	process_bin_or_b (a_node: BIN_OR_B)
			-- Process `a_node'.
		do
			process_bin_or_else_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B)
			-- Process `a_node'.
		do
			if a_node.access /= Void then
				evaluate_boolean_nested_b (a_node.nested_b, not a_node.is_or, True)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_bin_plus_b (a_node: BIN_PLUS_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_power_b (a_node: BIN_POWER_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_slash_b (a_node: BIN_SLASH_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_star_b (a_node: BIN_STAR_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bin_tilde_b (a_node: BIN_TILDE_B)
			-- Process `a_node'.
		local
			o: like operands_for_binary_b
			b: BOOLEAN
			l, r: DBG_EVALUATED_VALUE
		do
			o := operands_for_binary_b (a_node)
			l := o.left
			r := o.right
			if not error_occurred then
				if l = Void and r = Void then
					dbg_error_handler.notify_error_exception_internal_issue
				else
					if attached application_execution as app then
						b := app.tilda_equal_evaluation (l, r, dbg_error_handler)
						if not dbg_error_handler.error_occurred then
							create tmp_result.make_with_value (debugger_manager.dump_value_factory.new_boolean_value (b, debugger_manager.compiler_data.boolean_class_c))
						end
					else
						dbg_error_handler.notify_error_exception_internal_issue
					end
				end
			end
		end

	process_bin_xor_b (a_node: BIN_XOR_B)
			-- Process `a_node'.
		do
			process_binary_b (a_node)
		end

	process_bool_const_b (a_node: BOOL_CONST_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_byte_list (a_node: BYTE_LIST [BYTE_NODE])
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_hidden_b (a_node: HIDDEN_B)
			-- Process `a_node'.
		do
			process_byte_list (a_node)
		end

	process_do_rescue_b (a_node: DO_RESCUE_B)
			-- Process `a_node'
		do
		end

	process_try_b (a_node: TRY_B)
			-- Process `a_node'
		do
		end

	process_case_b (a_node: CASE_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_case_expression_b (b: CASE_EXPRESSION_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_not_supported (b)
		end

	process_char_const_b (a_node: CHAR_CONST_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_char_val_b (a_node: CHAR_VAL_B)
			-- Process `a_node'.
		local
			c: CHARACTER_32
			dv: DUMP_VALUE
		do
			c := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_character_32_value (c, debugger_manager.compiler_data.character_32_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_check_b (a_node: CHECK_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_constant_b (a_node: CONSTANT_B)
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

	process_creation_expr_b (a_node: CREATION_EXPR_B)
			-- Process `a_node'.
		local
			retried: BOOLEAN
			l_type_to_create: CL_TYPE_A
			l_supported: BOOLEAN
			l_has_error: BOOLEAN
			ct: CLASS_TYPE
		do
--FIXME: convert this to visitor !!	
			ct := context.class_type
			if ct /= Void then
				if Byte_context.class_type = Void then
					Byte_context.init (ct)
				else
					Byte_context.change_class_type_context (ct, ct.type, ct, ct.type)
				end
			end
			l_type_to_create := a_node.info.type_to_create
			if byte_context.is_class_type_changed then
				byte_context.restore_class_type_context
			end
			if not retried then
				if l_type_to_create /= Void and then l_type_to_create.is_basic then
					if
						attached {FEATURE_B} a_node.call as l_f_b and then
						l_f_b.parameters /= Void and then
						l_f_b.parameters.count = 1 and then
						attached l_f_b.parameters.first as l_p_b and then
						attached l_p_b.expression as l_e_b and then
						attached l_e_b.evaluate as l_v_i
					then
						l_supported	:= True
						evaluate_value_i (l_v_i, Void)
					end
				else
					if l_type_to_create /= Void then
						evaluate_creation_expr_b_with_type (a_node, l_type_to_create)
						l_has_error := error_occurred
					else
						debug ("refactor_fixme")
							fixme ("2004/03/18 for now we just process basic type ..., to improve ...")
						end
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

	process_current_b (a_node: CURRENT_B)
			-- Process `a_node'.
		do
			if on_object then
					--| If the context is on object
					--| then Current represent the pointed object
				create tmp_result.make_with_value (dump_value_at_address (context.address))
			elseif attached {EIFFEL_CALL_STACK_ELEMENT} application_status.current_call_stack_element as cse then
				if attached dbg_evaluator.current_object_from_callstack (cse) as dv then
					create tmp_result.make_with_value (dv)
					if attached context.class_c as cl then
						tmp_result.suggest_static_class (cl)
					end
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.Cst_unable_to_get_current_object)
				end
			else
				check is_eiffel_call_stack_element: False end
			end
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_debug_b (a_node: DEBUG_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_elsif_b (a_node: ELSIF_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_elsif_expression_b (a_node: ELSIF_EXPRESSION_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_not_supported (a_node))
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_external_b (a_node: EXTERNAL_B)
			-- Process `a_node'.
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if a_node.is_static_call then
				cl := class_c_from_external_b (a_node)
			elseif on_class then
				cl := context.class_c
			end
			if cl = Void then
				if tmp_target_dump_value /= Void then
					cl := tmp_target_dump_value.dynamic_class
				elseif context.class_c /= Void then
					cl := context.class_c
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
									evaluate_static_routine (context.address, Void, cl, fi, params)
								end
							else
								if tmp_target_dump_value /= Void then
									evaluate_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
								elseif context.address /= Void and then not context.address.is_void then
									evaluate_routine (context.address, Void, cl, fi, params)
								else
									if debugger_manager.is_dotnet_project  then
										evaluate_static_function (fi, cl, params)
									else
										evaluate_static_routine (context.address, Void, cl, fi, params)
									end
								end
							end
						end
					elseif fi.is_attribute then
						if tmp_target_dump_value /= Void then
							evaluate_attribute (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
						else
							evaluate_attribute (context.address, tmp_target_dump_value, cl, fi)
						end
					else
						dbg_error_handler.notify_error_evaluation_during_call_evaluation (a_node, a_node.feature_name)
					end
				end
			end
		end

	process_feature_b (a_node: FEATURE_B)
			-- Process `a_node'.
		local
			fi: detachable FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context.class_c /= Void then
				cl := context.class_c
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
--					if attached {BASIC_A} cl.types.first.type as l_basic_i  and then a_node.is_feature_special (False, l_basic_i) then
--						dbg_error_handler.notify_error_expression ("Evaluation of %"built-in%" feature %""
--							+ "{" + cl.name_in_upper + "}." + a_node.feature_name
--							+ "%" is not yet available")
--					end
--				end
				if not error_occurred then
					if a_node.precursor_type /= Void and then a_node.precursor_type.is_standalone then
						if attached {CL_TYPE_A} a_node.precursor_type as l_cl_type then
							cl := l_cl_type.base_class
							fi := cl.feature_table.feature_of_rout_id (a_node.routine_id)
						else
							check l_cl_type_not_void_if_true_precursor: False end
						end
					else
						fi := feature_i_from_call_access_b_in_context (cl, a_node)
					end
					if fi /= Void then
						if fi.is_process_or_thread_relative_once then
							evaluate_once (fi)
						elseif fi.is_constant then
							evaluate_constant (fi)
						elseif fi.is_object_relative_once then
							if tmp_target_dump_value /= Void then
								evaluate_object_relative_once (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
							else
								evaluate_object_relative_once (context.address, Void, cl, fi)
							end
						elseif fi.is_routine then
								--| parameters ...
							params := parameter_values_from_parameters_b (a_node.parameters)
							if not error_occurred then
								if fi.is_class then
									evaluate_class_routine (cl, fi, params)
								else
									if tmp_target_dump_value /= Void then
										evaluate_routine (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi, params)
									else
										evaluate_routine (context.address, Void, cl, fi, params)
									end
								end
							end
						elseif fi.is_attribute then
								-- How come ? maybe with redefinition .. and so on ..
							if tmp_target_dump_value /= Void then
								evaluate_attribute (tmp_target_dump_value.value_address, tmp_target_dump_value, cl, fi)
							else
								evaluate_attribute (context.address, Void, cl, fi)
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

	process_agent_call_b (a_node: AGENT_CALL_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_guard_b (a_node: GUARD_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_hector_b (a_node: HECTOR_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_if_b (a_node: IF_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_if_expression_b (a_node: IF_EXPRESSION_B)
			-- <Precursor>
		local
			l_tmp_target_backup: like tmp_target
			l_condition_value: DBG_EVALUATED_VALUE
			l_cond: BOOLEAN
			l_result_value: detachable DBG_EVALUATED_VALUE
		do
			l_tmp_target_backup := tmp_target

			l_condition_value := standalone_evaluation_expr_b (a_node.condition)

			if not error_occurred then
				if
					l_condition_value.value.is_type_boolean and then
					attached l_condition_value.value.as_dump_value_basic as bval
				then
					l_cond := bval.value_boolean
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_condition_expression_must_have_boolean_condition)
				end
				if not error_occurred then
					if l_cond then
						l_result_value := standalone_evaluation_expr_b (a_node.then_expression)
					else
						if attached a_node.elsif_list as l_elsif_list then
							across
								l_elsif_list as c
							until
								l_result_value /= Void or error_occurred
							loop
								l_result_value := standalone_evaluation_elseif_expression_b (c.item)
							end
						end
						if
							not error_occurred and then
							l_result_value = Void and then
							attached a_node.else_expression as l_else_expression
								-- | else_expression is attached, but this does not hurt here to use object test
						then
							l_result_value := standalone_evaluation_expr_b (l_else_expression)
						end
					end
					if
						not error_occurred and then
						attached l_result_value
					then
						tmp_result := l_result_value
					end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	standalone_evaluation_elseif_expression_b (a_node: ELSIF_EXPRESSION_B): detachable DBG_EVALUATED_VALUE
		require
			a_node /= Void
		local
			l_tmp_result_value_backup: like tmp_result
			l_tmp_target_backup: like tmp_target

			l_condition_value: DBG_EVALUATED_VALUE
			l_cond: BOOLEAN
			l_result_value: DBG_EVALUATED_VALUE
		do
				-- Backup
			l_tmp_result_value_backup := tmp_result
			l_tmp_target_backup := tmp_target

				-- ELSEIF_EXPRESSION...
			l_condition_value := standalone_evaluation_expr_b (a_node.condition)
			if not error_occurred then
				if
					l_condition_value.value.is_type_boolean and then
					attached l_condition_value.value.as_dump_value_basic as bval
				then
					l_cond := bval.value_boolean
					if l_cond then
						l_result_value := standalone_evaluation_expr_b (a_node.expression)
						if not error_occurred then
							Result := l_result_value
						end
					end
				else
					dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_should_not_occur_during_evaluation (l_condition_value))
				end
			end

				-- Restore
			tmp_result := l_tmp_result_value_backup
			tmp_target := l_tmp_target_backup
		end

	process_hidden_if_b (a_node: HIDDEN_IF_B)
			-- Process `a_node'.
		do
			process_if_b (a_node)
		end

	process_inspect_b (a_node: INSPECT_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_inspect_expression_b (b: INSPECT_EXPRESSION_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (b)
		end

	process_instr_call_b (a_node: INSTR_CALL_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_instr_list_b (a_node: INSTR_LIST_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_int64_val_b (a_node: INT64_VAL_B)
			-- Process `a_node'.
		local
			v: INTEGER_64
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_integer_64_value (v, debugger_manager.compiler_data.integer_64_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_int_val_b (a_node: INT_VAL_B)
			-- Process `a_node'.
		local
			v: INTEGER_32
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_integer_32_value (v, debugger_manager.compiler_data.integer_32_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_integer_constant (a_node: INTEGER_CONSTANT)
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

	process_inv_assert_b (a_node: INV_ASSERT_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_invariant_b (a_node: INVARIANT_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_local_b (a_node: LOCAL_B)
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

	process_loop_b (a_node: LOOP_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_loop_expr_b (a_node: LOOP_EXPR_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_not_supported (a_node))
		end

	process_nat64_val_b (a_node: NAT64_VAL_B)
			-- Process `a_node'.
		local
			v: NATURAL_64
			dv: DUMP_VALUE
		do
			v := a_node.value
			dv := Debugger_manager.Dump_value_factory.new_natural_64_value (v, debugger_manager.compiler_data.natural_64_class_c)
			create tmp_result.make_with_value (dv)
		end

	process_nat_val_b (a_node: NAT_VAL_B)
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

	process_nested_b (a_node: NESTED_B)
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

	process_null_conversion_b (a_node: NULL_CONVERSION_B)
			-- Process `a_node'.
		do
			process_expr_b (a_node.expr)
		end

	process_object_test_b (a_node: OBJECT_TEST_B)
			-- Process `a_node'.
		local
			l_tmp_target_backup: like tmp_target
			l_expr_value: DBG_EVALUATED_VALUE
			l_res: BOOLEAN
			cl: CLASS_C
			ta: TYPE_A
		do
			l_tmp_target_backup := tmp_target
			l_expr_value := standalone_evaluation_expr_b (a_node.expression)

			if not error_occurred then
				l_res := l_expr_value.has_attached_value
				if l_res and not a_node.is_void_check then
					cl := l_expr_value.dynamic_class
					if attached a_node.target as l_target then
						ta := l_target.type
					else
						ta := a_node.expression.type
					end
					if ta /= Void then
						l_res := cl /= Void and then cl.actual_type.conform_to (context.class_c, ta)
					else
						--| Note: could use `a_node.info.type_to_create' ?
						dbg_error_handler.notify_error_exception_internal_issue
					end
				end
				if not error_occurred then
					create tmp_result.make_with_value (Debugger_manager.Dump_value_factory.new_boolean_value (l_res, debugger_manager.compiler_data.boolean_class_c))
					if l_res and attached a_node.target as l_ot then
						record_expression_object_test_locals (a_node.target, l_expr_value)
					end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B)
			-- Process `a_node'.
		local
			dv: ABSTRACT_DEBUG_VALUE
			t: like current_call_stack_data_for_evaluation
		do
			t := current_call_stack_data_for_evaluation
			if t /= Void then
				dv :=  t.cse.object_test_local_value (a_node.position)
				if dv /= Void then
					create tmp_result.make_with_value (dv.dump_value)
				else
					tmp_result := expression_object_test_locals_value (a_node.position)
				end
				if tmp_result = Void then
					dbg_error_handler.notify_error_exception_during_evaluation (Void)
				end
				-- FIXME jfiat [2004/02/26] : optimization : maybe compute the static type ....
			else
				check error_occurred: error_occurred end
			end
		end

	process_once_string_b (a_node: ONCE_STRING_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_operand_b (a_node: OPERAND_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_parameter_b (a_node: PARAMETER_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_paran_b (a_node: PARAN_B)
			-- Process `a_node'.
		do
			process_expr_b (a_node.expr)
		end

	process_real_const_b (a_node: REAL_CONST_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_require_b (a_node: REQUIRE_B)
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_result_b (a_node: RESULT_B)
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
					if attached cf.type as cft and then attached cft.base_class as cl then
						tmp_result.suggest_static_class (cl)
					end
				end
			else
				check error_occurred: error_occurred end
			end
		end

	process_retry_b (a_node: RETRY_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_reverse_b (a_node: REVERSE_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_separate_b (a_node: SEPARATE_INSTRUCTION_B)
			-- <Precursor>
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_string_b (a_node: STRING_B)
			-- Process `a_node'.
		local
			dv: DUMP_VALUE
		do
			if a_node.is_string_32 then
				dv := Debugger_manager.Dump_value_factory.new_manifest_string_32_value (
							a_node.value_32,
							debugger_manager.compiler_data.string_32_class_c
						)
			else
				dv := Debugger_manager.Dump_value_factory.new_manifest_string_value (
							a_node.value_8,
							debugger_manager.compiler_data.string_8_class_c
						)
			end
			if dv /= Void then
				create tmp_result.make_with_value (dv)
			end
		end

	process_strip_b (a_node: STRIP_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B)
			-- Process `a_node'.
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
			dv: DUMP_VALUE
		do
			if tmp_target_dump_value /= Void then
				cl := tmp_target_dump_value.dynamic_class
			elseif context.class_c /= Void then
				cl := context.class_c
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
					evaluate_routine (context.address, Void, cl, fi, params)
				end
			else
				dbg_error_handler.notify_error_evaluation_report_to_support (a_node)
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B)
			-- Process `a_node'.
		local
			l_byte_list: LIST [BYTE_NODE]
			l_arg_as_lst: LINKED_LIST [DUMP_VALUE]
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
							l_class := l_type_i.base_class
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
							if attached {EXPR_B} l_byte_list.item as l_expr_b then
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

	process_type_expr_b (a_node: TYPE_EXPR_B)
			-- Process `a_node'.
		local
--			l_class: CLASS_C
--			l_def_create_feat_i: FEATURE_I
			l_tmp_target_backup: like tmp_target
--			l_call_value: DBG_EVALUATED_VALUE
--			l_value: DUMP_VALUE
		do
			debug ("refactor_fixme")
				fixme ("Later when we have a way to ensure the unicity of TYPE instances, we'll need to update this part")
			end
			l_tmp_target_backup := tmp_target
			create_empty_instance_of (resolved_real_type_in_context (a_node.type))
-- FIXME: the following commented code seems to be useless, and it fixes bug#15888  (2009-06-01)
--			if not error_occurred then
--				l_call_value := tmp_result
--				tmp_target := l_call_value
--					--| Call default_create
--				l_class := debugger_manager.compiler_data.type_class_c
--				l_def_create_feat_i := l_class.default_create_feature
--				l_value := l_call_value.value
--				evaluate_routine (l_value.address, l_value, l_class, l_def_create_feat_i, Void)
--				tmp_result := l_call_value
--			end
			tmp_target := l_tmp_target_backup
		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B])
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_un_free_b (a_node: UN_FREE_B)
			-- Process `a_node'.
		do
			process_unary_b (a_node)
		end

	process_un_minus_b (a_node: UN_MINUS_B)
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_not_b (a_node: UN_NOT_B)
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_old_b (a_node: UN_OLD_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_not_supported (a_node)
		end

	process_un_plus_b (a_node: UN_PLUS_B)
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_variant_b (a_node: VARIANT_B)
			-- Process `a_node'.
		do
			dbg_error_handler.notify_error_should_not_occur_in_expression_evaluation (a_node)
		end

	process_void_b (a_node: VOID_B)
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
			elseif attached {BIN_TILDE_B} a_node as tb then
				tb.process (Current)
			else
				dbg_error_handler.notify_error_not_supported (a_node)
			end
		end

	process_bin_equal_b_node (a_node: BIN_EQUAL_B; a_is_not: BOOLEAN)
			-- Process BIN EQUAL B node `a_node'
			-- and if `a_is_not' is true, return the negation
		local
			o: like operands_for_binary_b
			b: BOOLEAN
			l,r: DBG_EVALUATED_VALUE
		do
			o := operands_for_binary_b (a_node)
			l := o.left
			r := o.right

			if
				not error_occurred and then
				l /= Void and
				r /= Void
			then
				b := equal_sign_evaluation_on_values (l, r)
				if a_is_not then
					b := not b
				end
				if not error_occurred then
					create tmp_result.make_with_value (Debugger_manager.Dump_value_factory.new_boolean_value (b, debugger_manager.compiler_data.boolean_class_c))
				end
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
			if not error_occurred then
				l_right_value := standalone_evaluation_expr_b (l_right)
			end
			Result := [l_left_value, l_right_value]
		end

	current_call_stack_data_for_evaluation: TUPLE [cse: EIFFEL_CALL_STACK_ELEMENT; feat: E_FEATURE]
			-- Return call stack element, and feature from current call stack.
			--| note: it can raise error, if those values are not available
			--| this is mainly to factory code for
			--|      LOCAL_B, OBJECT_TEST_LOCAL_B, ARGUMENT_B
		local
			cf: detachable E_FEATURE
			ecse: detachable EIFFEL_CALL_STACK_ELEMENT
		do
			if attached {EIFFEL_CALL_STACK_ELEMENT} application_status.current_call_stack_element as cse then
				ecse := cse
				cf := cse.routine
			else
				dbg_error_handler.notify_error_evaluation ("Unable to get Current call stack element")
				check
					False -- Shouldn't occur.
				end
			end
			if cf = Void then
				dbg_error_handler.notify_error_evaluation ("Unable to get Current call stack element's routine")
				check
					False -- Shouldn't occur.
				end
			else
				Result := [ecse, cf]
			end
		ensure
			result_void_if_error: Result = Void implies error_occurred
			valid_attached_result: Result /= Void implies Result.cse /= Void and Result.feat /= Void
		end

	evaluate_value_i (a_value_i: VALUE_I; cl: CLASS_C)
			-- Evaluate `a_value_i'
		require
			a_value_i_not_void: a_value_i /= Void
		local
			l_cl: CLASS_C
			d_fact: DUMP_VALUE_FACTORY
			comp_data: DEBUGGER_DATA_FROM_COMPILER
			dv: DUMP_VALUE
		do
			if a_value_i.is_integer and attached {INTEGER_CONSTANT} a_value_i as l_integer then
				process_integer_constant (l_integer)
			else
				d_fact := Debugger_manager.Dump_value_factory
				comp_data := debugger_manager.compiler_data
				l_cl := cl
				if a_value_i.is_string and attached {STRING_VALUE_I} a_value_i as l_string then
					if l_cl = Void then
						l_cl := comp_data.string_8_class_c
					end
					dv := d_fact.new_manifest_string_value (l_string.string_value, l_cl)
				elseif a_value_i.is_string_32 and attached {STRING_VALUE_I} a_value_i as l_string_32 then
					if l_cl = Void then
						l_cl := comp_data.string_32_class_c
					end
					dv := d_fact.new_manifest_string_32_value (l_string_32.string_value, l_cl)
				elseif a_value_i.is_boolean then
					if l_cl = Void then
						l_cl := comp_data.boolean_class_c
					end
					dv := d_fact.new_boolean_value (a_value_i.boolean_value, l_cl)
				elseif a_value_i.is_character and attached {CHAR_VALUE_I} a_value_i as l_char then
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
				elseif a_value_i.is_real and attached {REAL_VALUE_I} a_value_i as l_real then
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
				else
					dbg_error_handler.notify_error_not_supported (a_value_i)
				end
				if dv /= Void then
					create tmp_result.make_with_value (dv)
				end
			end
		end

	evaluate_boolean_nested_b (a_node: NESTED_B; a_is_lazy: BOOLEAN; a_lazy_value: BOOLEAN)
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
		do
			l_tmp_target_backup := tmp_target

			l_target_value := standalone_evaluation_expr_b (a_node.target)

			if not error_occurred then
				check is_boolean_value: l_target_value.value.is_type_boolean end
				if attached {DUMP_VALUE_BASIC} l_target_value.value as l_boolean_value then
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
				else
					check is_boolean_dump_value: False end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_creation_expr_b_with_type (a_node: CREATION_EXPR_B; a_type_i: CL_TYPE_A)
			-- Evaluate creation expression, given the type to create `a_type_i'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
			a_type_i_not_void: a_type_i /= Void
		local
			l_tmp_target_backup: like tmp_target
			l_call_value: DBG_EVALUATED_VALUE
			l_call: CALL_B
			l_type_i: CL_TYPE_A
			l_dv: detachable DUMP_VALUE
		do
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_type_i)
			if l_type_i.base_class.is_special then
				if
					attached {GEN_TYPE_A} l_type_i as l_gen_type_i and then
					l_gen_type_i.generics.valid_index (1) and then
					attached {CL_TYPE_A} l_gen_type_i.generics[1] as l_elt_type_i and then
					attached a_node.call as l_call_access and then
					attached l_call_access.parameters as l_params and then
					l_params.count = 1
				then
					if attached parameter_evaluation (l_params.first) as r then
						l_dv := r.value
					end
					if l_dv /= Void and then l_dv.is_type_integer_32 then
						create_special_any_instance (resolved_real_type_in_context (l_type_i), l_dv.as_dump_value_basic.value_integer_32)
					end
				end
				if error_occurred or else l_dv = Void then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instantiate_type (l_type_i.name, Debugger_names.cst_error_special_not_yet_supported))
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

	parameter_values_from_parameters_b (a_node: BYTE_LIST [EXPR_B]): ARRAYED_LIST [DUMP_VALUE]
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

	parameter_evaluation (a_node: EXPR_B): DBG_EVALUATED_VALUE
			-- Evaluate `a_node' as a parameter
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		local
			l_expr_b: EXPR_B
			l_tmp_target_backup: like tmp_target
		do
			if attached {PARAMETER_B} a_node as l_param_b then
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

	prepare_dbg_evaluation
			-- Initialization before effective evaluation
		require
			dbg_evaluator /= Void
		do
			dbg_evaluator.set_last_variables (tmp_result)
		end

	retrieve_dbg_evaluation
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

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE])
			-- Evaluate static function `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			notify_potential_side_effect
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				prepare_dbg_evaluation
				Dbg_evaluator.evaluate_static_function (f, cl, params)
				retrieve_dbg_evaluation
			end
		end

	evaluate_once (f: FEATURE_I)
			-- Evaluate once function `f'
			--| in fact, get once function data
			--| Do not force the evaluation
		require
			feature_not_void: f /= Void
			f_is_process_or_thread_relative_once: f.is_process_or_thread_relative_once
		do
			prepare_dbg_evaluation
			Dbg_evaluator.evaluate_once (f)
			retrieve_dbg_evaluation
		end

	evaluate_object_relative_once (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I)
			-- Evaluate once per object `f'
			--| in fact, get once function data
			--| Do not force the evaluation
		require
			feature_not_void: f /= Void
			f_is_object_relative_once: f.is_object_relative_once
		do
			prepare_dbg_evaluation
			Dbg_evaluator.evaluate_object_relative_once (a_addr, a_target, c, f)
			retrieve_dbg_evaluation
		end

	evaluate_constant (f: FEATURE_I)
			-- Find the value of constant feature `f'.
		require
			valid_feature: f /= Void
			is_constant: f.is_constant
		do
			if attached {CONSTANT_I} f as cv_cst_i then
				evaluate_value_i (cv_cst_i.value, cv_cst_i.type.base_class)
			else
				dbg_error_handler.notify_error_evaluation_unknown_constant_type_for (f.feature_name)
			end
		end

	evaluate_attribute (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I)
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

	evaluate_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE])
			-- Evaluate routine `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			notify_potential_side_effect
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if a_target /= Void and then a_target.is_void then
					dbg_error_handler.notify_error_evaluation_call_on_void (f.feature_name)
				elseif on_class and then not f.is_process_or_thread_relative_once then
					dbg_error_handler.notify_error_evaluation_VST1_on_class_context (cl.name_in_upper, f.feature_name)
				else
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_routine (a_addr, a_target, cl, f, params, False)
					retrieve_dbg_evaluation
				end
			end
		end

	evaluate_class_routine (cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE])
			-- Evaluate class routine `f' with parameters `params'
		require
			f /= Void
			f_is_class_routine: f.is_class
		do
			if cl = Void then
				dbg_error_handler.notify_error_evaluation ("Missing class information for non object call " + f.feature_name)
			elseif cl.is_deferred then
				dbg_error_handler.notify_error_evaluation ("Evaluation of class routine {" + cl.name + "}." + f.feature_name + " is not supported (deferred target type)!")
			else
					-- Instanciate empty object as the "target" of non object call.
				prepare_dbg_evaluation
				dbg_evaluator.create_empty_instance_of (cl.actual_type)
				retrieve_dbg_evaluation
				if
					not error_occurred and then
					attached tmp_result as res and then
					attached res.value as dv
				then
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_class_routine (dv.address, dv, cl, f, params)
					retrieve_dbg_evaluation
				end
			end
		end

	evaluate_static_routine (a_addr: DBG_ADDRESS; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE])
			-- Evaluate static routine `f' with parameters `params'
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			notify_potential_side_effect
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if a_target /= Void and then a_target.is_void then
					dbg_error_handler.notify_error_evaluation_call_on_void (f.feature_name)
				else
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_static_routine (a_addr, a_target, cl, f, params)
					retrieve_dbg_evaluation
				end
			end
		end

	evaluate_function_with_name (a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE])
			-- Evaluate function defined by `a_feature_name'
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		local
			l_addr: DBG_ADDRESS
		do
			notify_potential_side_effect
			if side_effect_forbidden then
				dbg_error_handler.notify_error_evaluation_side_effect_forbidden
			else
				if debugger_manager.is_dotnet_project then
						-- FIXME: What about static ? check ...
					if a_target /= Void then
						l_addr := tmp_target_dump_value.value_address
					else
						l_addr := context.address
					end
					prepare_dbg_evaluation
					Dbg_evaluator.evaluate_function_with_name (l_addr, a_target, a_feature_name, a_external_name, params)
					retrieve_dbg_evaluation
				end
			end
		end

	create_empty_instance_of (a_type_i: CL_TYPE_A)
			-- New empty instance of class represented by `a_type_id'.
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			not_special: not a_type_i.base_class.is_special
		local
			l_cl_type_i: CL_TYPE_A
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type (Void) then
				prepare_dbg_evaluation
				Dbg_evaluator.create_empty_instance_of (l_cl_type_i)
				retrieve_dbg_evaluation
				if error_occurred and l_cl_type_i.has_formal_generic then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instantiate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_can_not_instantiate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

	create_special_any_instance (a_type_i: CL_TYPE_A; a_count: INTEGER)
			-- Create new instance of SPECIAL represented by `a_type_id' and `a_count'
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			is_special: a_type_i.base_class.is_special
		local
			l_cl_type_i: CL_TYPE_A
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type (Void) then
				prepare_dbg_evaluation
				Dbg_evaluator.create_special_any_instance (l_cl_type_i, a_count)
				retrieve_dbg_evaluation
				if error_occurred and l_cl_type_i.has_formal_generic then
					dbg_error_handler.notify_error_not_implemented (Debugger_names.msg_error_can_not_instantiate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				dbg_error_handler.notify_error_evaluation (Debugger_names.msg_error_can_not_instantiate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

	values_with_same_type (a_left, a_right: DBG_EVALUATED_VALUE): BOOLEAN
		require
			a_left_attached: a_left /= Void
			a_right_attached: a_right /= Void
		do
			Result := a_left.dynamic_type ~ a_right.dynamic_type
		end

	is_equal_evaluation_on_values (a_left, a_right: DBG_EVALUATED_VALUE): BOOLEAN
			-- Compare using `is_equal`.
		do
			if values_with_same_type (a_left, a_right) and then attached application_execution as app then
				Result := app.is_equal_evaluation (a_left, a_right, dbg_error_handler)
			else
				dbg_error_handler.notify_error_exception_internal_issue
			end
		end

	equal_sign_evaluation_on_values (a_left, a_right: DBG_EVALUATED_VALUE): BOOLEAN
			-- Compare using ` = '
		do
			if attached application_execution as app then
				Result := app.equal_sign_evaluation (a_left, a_right, dbg_error_handler)
			else
				dbg_error_handler.notify_error_exception_internal_issue
			end
		end

feature {NONE} -- Implementation: recorded object test locals' value

	expression_object_test_locals: LINKED_LIST [TUPLE [position: INTEGER; value: like tmp_result]]
			-- Object test locals' container for the Current expression

	record_expression_object_test_locals (a_node: OBJECT_TEST_LOCAL_B; a_value: like tmp_result)
			-- Record object test's value created during expression
		require
			a_node_attached: a_node /= Void
			a_value_attached: a_value /= Void
		local
			l_recorder: like expression_object_test_locals
		do
			l_recorder := expression_object_test_locals
			if l_recorder = Void then
				create l_recorder.make
				expression_object_test_locals := l_recorder
			end
			l_recorder.force ([a_node.position, a_value])
		end

	expression_object_test_locals_value (a_position: INTEGER): detachable like tmp_result
			-- Expression's object test local value at position `a_position'
		do
			if attached expression_object_test_locals as lst then
				from
					lst.start
				until
					lst.after or Result /= Void
				loop
					if lst.item.position = a_position then
						Result := lst.item.value
					end
					lst.forth
				end
			end
		end

	clean_expression_object_test_locals
			-- Clean recorded object test locals.
		do
			if attached expression_object_test_locals as lst then
				lst.wipe_out
				expression_object_test_locals := Void
			end
		end

feature -- Context: Element change

	init_context_with_current_callstack
			-- Init context data with values from current callstack
			-- i.e: current debugging contex	
		do
			init_context_with_callstack_element (application_status.current_call_stack_element)
		end

	init_context_with_callstack_element (cse: detachable CALL_STACK_ELEMENT)
			-- Init context data with values from current callstack
			-- i.e: current debugging contex	
		local
			fi: FEATURE_I
		do
			if cse = Void then
				dbg_error_handler.notify_error_expression_during_context_preparation
			else
					--| Cse can be Void if the application raised an exception
					--| at the very beginning of the execution (for instance under dotnet)
				context.set_address (cse.object_address)
				if attached {EIFFEL_CALL_STACK_ELEMENT} cse as ecse then
					fi := ecse.routine_i
					context.set_data (fi, ecse.dynamic_class, ecse.dynamic_type, ecse.local_table, ecse.object_test_locals_info, ecse.break_index, ecse.break_nested_index)
					apply_context
				else
					--| Could occurs in case of External call stack element
					--| in case of Exception or stopped state
					dbg_error_handler.notify_error_expression_during_context_preparation
				end
			end
		end

	init_context_on_object_with_current_callstack (addr: DBG_ADDRESS)
			-- Init context on object with data from current callstack
			-- i.e: current debugging context
		local
			dobj: DEBUGGED_OBJECT
		do
			init_context_with_current_callstack

			if attached debugger_manager.object_manager as objman and then objman.is_valid_and_known_object_address (addr) then
				dobj := objman.debugged_object (addr, 0, 0)
			else
				dobj := Void
			end
			if dobj = Void or else dobj.is_erroneous then
				dbg_error_handler.notify_error_expression (Debugger_names.msg_error_during_context_preparation (Debugger_names.msg_error_unable_to_get_valid_target_for (addr.output)))
			else
				context.set_address (addr)
				context.set_data (context.feature_i, dobj.dynamic_class, dobj.class_type, context.local_table, context.object_test_locals, context.breakable_index, context.bp_nested_index)
				apply_context
			end
		end

	init_context_address_with_current_callstack
			-- Init context address with data from current callstack
			-- i.e: current debugging context
		local
			cse: CALL_STACK_ELEMENT
		do
			cse := application_status.current_call_stack_element
				--| Cse can be Void if the application raised an exception
				--| at the very beginning of the execution (for instance under dotnet)
			if cse /= Void then
				context.set_address (cse.object_address)
			end
			context.set_data (Void, context.class_c, Void, Void, Void, 0, 0)
			apply_context
		end

	apply_context
			-- Apply context's modification
		do
			if context.changed then
				reset_byte_node
			end
			Precursor
		end

	display_context_information
			-- Display context information in the output
			-- for debugging purpose only
		do
			debug ("debugger_evaluator")
				io.put_string_32 ({STRING_32} "%NExpression=" + expression.text + "%N")
				io.put_string (context.to_string)
			end
		end

feature -- Access

	byte_node_computed: BOOLEAN
			-- is byte_node computed?

	byte_node: BYTE_NODE
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

	is_boolean_expression (f: FEATURE_I): BOOLEAN
			-- Is `Current' a boolean query in the context of `f'?
		local
			ctx, bak: like context
			ct: CLASS_TYPE
			fi: FEATURE_I
			bak_byte_code: BYTE_CODE
			old_int_expression_byte_note: like internal_byte_node

			l_dbg_ast_server: DEBUGGER_AST_SERVER
			l_feat: E_FEATURE
		do
				--| Backup current context and values
			context.backup
			old_int_expression_byte_note := internal_byte_node

				--| Removed any potential error due to previous evaluation
			reset_error

				--| prepare context
				--| this may reset the `expression_byte_node' value
			ctx := context
			ctx.set_data (f, f.written_class, Void, Void, Void, 0, 0) -- FIXME: we are missing locals and object test locals here
			l_dbg_ast_server := debugger_manager.debugger_ast_server

			fi := f.written_class.feature_of_rout_id_set (f.rout_id_set)
			l_feat := fi.api_feature (fi.written_in)
			ctx.set_data (f, f.written_class, Void, l_dbg_ast_server.local_table (l_feat), l_dbg_ast_server.object_test_locals (l_feat, 0, 0), 0, 0) -- FIXME: we are missing locals and object test locals here

			apply_context

				--| Get expression_byte_node
			get_byte_node
			if not error_occurred and then (attached {EXPR_B} byte_node as expr) then
--| Since the Byte_context is used only by debugger and code generation
--| there is no need to restore previous context
--| (see below the commented line for restoring class_type_context)
				ct := ctx.class_type
				if ct /= Void then
					if Byte_context.class_type = Void then
						Byte_context.init (ct)
					else
						Byte_context.change_class_type_context (ct, ct.type, ct, ct.type)
					end
					bak_byte_code := Byte_context.byte_code
					fi := ctx.feature_i
					if fi /= Void then
						Byte_context.set_current_feature (fi)
						Byte_context.set_byte_code (fi.byte_server.item (fi.body_index))
					end
				end

				Result := expr.type.is_boolean
				if ct /= Void and Byte_context.is_class_type_changed then
					Byte_context.restore_class_type_context
				end
				if bak_byte_code /= Void then
					Byte_context.set_byte_code (bak_byte_code)
				end
			end

				--| FIXME JFIAT: check in which cases we call the is_condition
				--| to see if it is pertinent to save.restore data ...			
			bak := ctx.backup_data
			if (bak /= Void and then bak.is_valid) or old_int_expression_byte_note /= Void then
					--| Restore context and values
				if bak.class_c = Void then
						--| FIXME JFIAT: check this ... how to have a context_class .. not void
						--| and pertinent ...
					bak.set_class_c (context.class_c)
				end
				ctx.restore
				apply_context
				internal_byte_node := old_int_expression_byte_note
			else
				-- if everything was unset before, let's keep these values
				-- we may use them again soon ...
				-- so no need to recompute the EXPR_B again and again
			end
		ensure then
			error_handler_cleaned: not error_handler.has_error
		end

feature {NONE} -- Implementation

	new_integer_dump_value (i: INTEGER): DUMP_VALUE_BASIC
			-- New DUMP_VALUE representing an INTEGER value.
		local
			dbgm: like debugger_manager
		do
			dbgm := debugger_manager
			Result := dbgm.dump_value_factory.new_integer_32_value (i, dbgm.compiler_data.integer_32_class_c)
		end

	get_byte_node
			-- get byte node depending of the context
		require
			context_feature_not_void: on_context implies context.feature_i /= Void
			context_class_not_void: context.class_c /= Void
		do
			byte_node_computed := True
			error_handler.wipe_out
			if internal_byte_node = Void then
				internal_byte_node := dbg_expression_checker.expression_byte_node (expression, context, dbg_error_handler)
			end
		end

	reset_byte_node
			-- Reset `byte_node'
		do
			internal_byte_node := Void
		end

	internal_byte_node: like  byte_node
			-- Cached `byte_node'

feature {NONE} -- Compiler helpers

	resolved_real_type_in_context (a_type_i: CL_TYPE_A): CL_TYPE_A
			-- Resolved real type associated with `a_type_i'
		require
			a_type_i_not_void: a_type_i /= Void
		do
			if
				attached context.class_type as ct and then
				attached {CL_TYPE_A} byte_context.real_type_in (a_type_i, ct.type) as t
			then
				Result := t
			end
			if Result = Void then
				Result := a_type_i
			end
		ensure
			Result_not_void: Result /= Void
		end

	class_c_from_external_b (a_external_b: EXTERNAL_B): CLASS_C
			-- Class C related to `a_external_b' if exists.
		require
			a_expr_b_not_void: a_external_b /= Void
		do
			if attached a_external_b.static_class_type as ti then
				Result := class_c_from_type_i (ti)
			elseif a_external_b.extension /= Void then
				 	-- try to find out the class thanks to extension
				Result := Dbg_evaluator.class_c_from_external_b_with_extension (a_external_b)
			end
		end

feature {NONE} -- Implementation

	dbg_expression_checker: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR
			-- Ast expression checker dedicated for debugger
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
