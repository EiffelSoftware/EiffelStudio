indexing
	description : "Objects used to evaluate a DBG_EXPRESSION_B ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DBG_EXPRESSION_EVALUATOR_B

inherit
	DBG_EXPRESSION_EVALUATOR
		redefine
			dbg_expression, reset_error
		end

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

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

	COMPILER_EXPORTER --| To access:  ERROR_HANDLER.wipe_out
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make_with_expression,
	make_as_object

feature -- Evaluation

	evaluate is
			-- Compute the value of the last message of `Current'.
		local
			l_error_occurred: BOOLEAN
		do
			reset_error

			if as_object then
				final_result_value := dump_value_at_address (context_address)
				if final_result_value /= Void then
					final_result_type := final_result_value.dynamic_class
					final_result_static_type := final_result_type
				end
				clean_temp_data
			else
					--| prepare context
					--| this may trigger the reset of `expression_byte_node' value
				if on_context then
						--| .. Init current context using current call_stack
					init_context_with_current_callstack
				elseif on_object then
					set_context_data (
							Void,
							Debugged_object_manager.class_c_at_address (context_address),
							Debugged_object_manager.class_type_at_address (context_address)
						)

				elseif on_class then
					set_context_data (Void, context_class, Void)
				end

				if
					(on_context and context_feature = Void)
					or (on_class and context_class = Void)
				then
					notify_error_expression (Cst_error_during_context_preparation)
				else
						--| Compute and get `expression_byte_node'
					get_expression_byte_node
				end

				l_error_occurred := error_occurred or expression_byte_node = Void
					--| FIXME jfiat 2004-12-09 : check if this is a true error or not ..
					-- and if this is handle later or not
				if on_context then
					if context_address = Void then
						l_error_occurred := True
					end
				end

				if not l_error_occurred then
						--| Initializing
					clean_temp_data

						--| concrete evaluation
					process_expression_evaluation (expression_byte_node)

						--| Process result
					if tmp_result_value /= Void then
						final_result_value := tmp_result_value
						final_result_type := tmp_result_value.dynamic_class
						final_result_static_type := final_result_type
					else
						final_result_value := Void
						final_result_type := Void
						final_result_static_type := Void
						check
							error_occurred
						end
					end
						--| Clean temporary data
					clean_temp_data
				else
					final_result_value := Void
					final_result_type := Void
					final_result_static_type := Void
				end
			end
		end

	reset_error is
		do
			Precursor
			error_handler.wipe_out
		end

	clean_temp_data is
			-- Clean temporary data used for evaluation
		do
			tmp_result_static_type := Void
			tmp_result_value := Void
			tmp_target := Void
		end

feature {NONE} -- EXPR_B evaluation

	process_expression_evaluation (a_expr_b: EXPR_B) is
		local
			retried: BOOLEAN
		do
			if not retried then
				evaluate_expr_b (a_expr_b)
			else
				notify_error_exception (Cst_error_evaluation_failed_with_exception)
			end
		rescue
			retried := True
			retry
		end

	evaluate_expr_b (a_expr_b: EXPR_B) is
		local
			l_paran_b: PARAN_B
			l_call_b: CALL_B
			l_access_b: ACCESS_B
			l_nested_b: NESTED_B

			l_binary_b: BINARY_B
			l_unary_b: UNARY_B

			l_void_b: VOID_B

			l_value_i: VALUE_I
			l_routine_creation_b: ROUTINE_CREATION_B
		do
			debug ("debugger_evaluator")
				print (generator + ".evaluate_expr_b (" + a_expr_b.generator + ")%N")
			end
			l_value_i := a_expr_b.evaluate
			if l_value_i.is_no_value then
				l_paran_b ?= a_expr_b
				if l_paran_b /= Void then
						--| PARAN_B |--					
					evaluate_expr_b (l_paran_b.expr)
				else
						--| CALL_B |--
					l_call_b ?= a_expr_b
					if l_call_b /= Void then
							--| ACCESS_B |--
						l_access_b ?= l_call_b
						if l_access_b /= Void then
							evaluate_access_b (l_access_b)
						else
								--| NESTED_B |--
							l_nested_b ?= l_call_b
							evaluate_nested_b (l_nested_b)
						end
					else
							--| BINARY_B |--
						l_binary_b ?= a_expr_b
						if l_binary_b /= Void then
							evaluate_binary_b (l_binary_b)
						else
								--| UNARY_B |--
							l_unary_b ?= a_expr_b
							if l_unary_b /= Void then
								evaluate_unary_b (l_unary_b)
							else
									--| VOID_B |--
								l_void_b ?= a_expr_b
								if l_void_b /= Void then
									evaluate_void_b (l_void_b)
								else
									l_routine_creation_b ?= a_expr_b
									if l_routine_creation_b /= Void then
										evaluate_routine_creation_b (l_routine_creation_b)
									else
										evaluate_manifest_value (a_expr_b)
									end
								end
							end
						end
					end
				end
			else
				evaluate_value_i (l_value_i)
			end
		end

	standalone_evaluation_expr_b (a_expr_b: EXPR_B): DUMP_VALUE is
		require
			a_expr_b /= Void
		local
			l_tmp_result_value_backup: like tmp_result_value
			l_tmp_target_backup: like tmp_target
			l_tmp_result_static_type_backup: like tmp_result_static_type
		do
				-- Backup
			l_tmp_result_value_backup := tmp_result_value
			l_tmp_target_backup := tmp_target
			l_tmp_result_static_type_backup	:= tmp_result_static_type

			evaluate_expr_b (a_expr_b)
			Result := tmp_result_value

				-- Restore
			tmp_result_value := l_tmp_result_value_backup
			tmp_target := l_tmp_target_backup
			tmp_result_static_type := l_tmp_result_static_type_backup
		end

	evaluate_void_b	(a_void_b: VOID_B) is
			-- Evaluate Void keyword value
		local
			t: TYPE_I
		do
			t := a_void_b.type
			tmp_result_value := Void
			tmp_result_value := Void
			create tmp_result_value.make_void (Void)
		end

	evaluate_manifest_value (a_expr_b: EXPR_B) is
			-- Manifest value, that is to say STRING manisfest value,
			-- since the INTEGER and so on value are handled by the parser
		local
			l_string_b: STRING_B
		do
			l_string_b ?= a_expr_b
			if l_string_b /= Void then
				tmp_result_value := string_to_dump_value (l_string_b.value)
			else
					--| NotYetReady |--
				notify_error_not_implemented (a_expr_b.generator + Cst_error_not_yet_ready)
			end
		end

	evaluate_value_i (a_value_i: VALUE_I) is
		local
			l_integer: INTEGER_CONSTANT
			l_char: CHAR_VALUE_I
			l_real: REAL_VALUE_I
			l_string: STRING_VALUE_I
			-- ...
		do
			if     a_value_i.is_integer		then
				l_integer ?= a_value_i
				if l_integer.has_integer (32) then
					tmp_result_value := integer_32_to_dump_value (l_integer.integer_32_value)
				else
					tmp_result_value := integer_64_to_dump_value (l_integer.integer_64_value)
				end
			elseif a_value_i.is_string		then
				l_string ?= a_value_i
				tmp_result_value := string_to_dump_value (l_string.string_value)
			elseif a_value_i.is_boolean		then
				tmp_result_value := boolean_to_dump_value (a_value_i.boolean_value)
			elseif a_value_i.is_character	then
				l_char ?= a_value_i
				tmp_result_value := character_to_dump_value (l_char.character_value)
			elseif a_value_i.is_real_32		then
				l_real ?= a_value_i
				tmp_result_value := real_to_dump_value (l_real.real_32_value)
			elseif a_value_i.is_real_64		then
				l_real ?= a_value_i
				tmp_result_value := double_to_dump_value (l_real.real_64_value)
--			elseif a_value_i.is_bit			then
			else
				notify_error_not_implemented (a_value_i.generator + Cst_error_not_yet_ready)
			end
		end

	evaluate_binary_b (a_binary_b: BINARY_B) is
		local
			l_bin_equal_b: BIN_EQUAL_B
			l_nested_b: NESTED_B
		do
			l_bin_equal_b ?= a_binary_b
			if l_bin_equal_b /= Void then
				evaluate_bin_equal_b (l_bin_equal_b)
			elseif a_binary_b.access /= Void then
				l_nested_b := a_binary_b.nested_b
				evaluate_nested_b (l_nested_b)
			else
				notify_error_not_implemented (a_binary_b.generator + "/BINARY_B" + Cst_error_not_yet_ready)
			end
		end

	evaluate_bin_equal_b (a_bin_equal_b: BIN_EQUAL_B) is
		local
			l_bin_eq_b: BIN_EQ_B
			l_bin_ne_b: BIN_NE_B
			l_right, l_left: EXPR_B
			l_right_value, l_left_value: DUMP_VALUE
			res: BOOLEAN
		do
			l_left := a_bin_equal_b.left
			l_right := a_bin_equal_b.right

			l_left_value := standalone_evaluation_expr_b (l_left)
			l_right_value := standalone_evaluation_expr_b (l_right)

			if l_left_value /= Void and l_right_value /= Void then
				l_bin_eq_b ?= a_bin_equal_b
				if l_bin_eq_b /= Void then
					res := l_left_value.same_as (l_right_value)
				else
					l_bin_ne_b ?= a_bin_equal_b
					if l_bin_ne_b /= Void then
						res := not l_left_value.same_as (l_right_value)
					end
				end
				if not error_occurred then
					tmp_result_static_type := System.boolean_class.compiled_class
					create tmp_result_value.make_boolean (res, tmp_result_static_type)
				end
			end
			if not error_occurred and tmp_result_value = Void then
				notify_error_not_implemented (a_bin_equal_b.generator + "/BINARY_B" + Cst_error_not_yet_ready)
			end
		end

	evaluate_unary_b (a_unary_b: UNARY_B) is
			-- Evaluate unary_b expression
		local
			l_un_minus_b: UN_MINUS_B
			l_un_plus_b: UN_PLUS_B
			l_un_not_b: UN_NOT_B
		do
			l_un_not_b ?= a_unary_b
			if l_un_not_b /= Void then
				evaluate_nested_b (l_un_not_b.nested_b)
			else
				l_un_minus_b ?= a_unary_b
				if l_un_minus_b /= Void then
					evaluate_nested_b (l_un_minus_b.nested_b)
				else
					l_un_plus_b ?= a_unary_b
					if l_un_plus_b /= Void then
						evaluate_nested_b (l_un_plus_b.nested_b)
					else
						notify_error_not_implemented (a_unary_b.generator + " = UNARY_B" + Cst_error_not_yet_ready)
					end
				end
			end
		end

	evaluate_access_b (a_access_b: ACCESS_B) is
		local
			l_call_access_b: CALL_ACCESS_B
			l_access_expr_b: ACCESS_EXPR_B
--			l_constant_b: CONSTANT_B
			l_local_b: LOCAL_B
			l_result_b: RESULT_B
			l_argument_b: ARGUMENT_B
			l_current_b: CURRENT_B
			l_creation_expr_b: CREATION_EXPR_B
			-- ...
		do
			l_call_access_b ?= a_access_b
			if l_call_access_b /= Void then
				evaluate_call_access_b (l_call_access_b)
			else
				l_access_expr_b ?= a_access_b
				if l_access_expr_b /= Void then
					evaluate_expr_b (l_access_expr_b.expr)
				else
					l_local_b ?= a_access_b
					if l_local_b /= Void then
						evaluate_local_b (l_local_b)
					else
						l_argument_b ?= a_access_b
						if l_argument_b /= Void then
							evaluate_argument_b (l_argument_b)
						else
							l_result_b ?= a_access_b
							if l_result_b /= Void then
								evaluate_result_b (l_result_b)
							else
								l_current_b ?= a_access_b
								if l_current_b /= Void then
									evaluate_current_b (l_current_b)
								else
									l_creation_expr_b ?= a_access_b
									if l_creation_expr_b /= Void then
										evaluate_creation_expr_b (l_creation_expr_b)
									else

	-- Constants value should be already caught by the value_i in evaluate_expr_b									
	--									l_constant_b ?= a_access_b
	--									if l_constant_b /= Void then
	--					--					l_constant_b.evaluate
	--									else
											notify_error_not_implemented (a_access_b.generator + " = ACCESS_B" + Cst_error_not_yet_ready)
	--									end	
									end
								end
							end
						end
					end
				end
			end
		end

	evaluate_nested_b (a_nested_b: NESTED_B) is
		local
			l_tmp_target_backup: like tmp_target
			l_target: ACCESS_B
			l_target_value: DUMP_VALUE
			l_message_value: DUMP_VALUE
			l_message: CALL_B
		do
			l_tmp_target_backup := tmp_target

			l_target := a_nested_b.target
			l_target_value := standalone_evaluation_expr_b (l_target)

			if not error_occurred then
				tmp_target := l_target_value
				l_message := a_nested_b.message
				l_message_value := standalone_evaluation_expr_b (l_message)

				if not error_occurred then
					tmp_result_value := l_message_value
				end
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_routine_creation_b (a_routine_creation_b: ROUTINE_CREATION_B) is
		local
		do
			notify_error_not_implemented (a_routine_creation_b.generator + " = agent creation " + Cst_error_not_yet_ready)
		end

	evaluate_creation_expr_b (a_creation_expr_b: CREATION_EXPR_B) is
		local
			retried: BOOLEAN

			l_type_to_create: CL_TYPE_I
			l_f_b: FEATURE_B
			l_p_b: PARAMETER_B
			l_e_b: EXPR_B
			l_v_i: VALUE_I
			l_supported: BOOLEAN
			l_has_error: BOOLEAN
		do
			l_type_to_create := a_creation_expr_b.info.type_to_create
			if not retried then
				fixme ("2004/03/18 for now we just process basic type ..., to improve ...")
				if l_type_to_create /= Void and then l_type_to_create.is_basic then
					l_f_b ?= a_creation_expr_b.call
					if l_f_b /= Void and then l_f_b.parameters /= Void then
						if l_f_b.parameters.count = 1 then
							l_p_b ?= l_f_b.parameters.first
							if l_p_b /= Void then
								l_e_b ?= l_p_b.expression
								if l_e_b /= Void then
									l_v_i := l_e_b.evaluate
									if l_v_i /= Void then
										l_supported	:= True
										evaluate_value_i (l_v_i)
									end
								end
							end
						end
					end
				else
					l_has_error := True
				end
			else
				l_has_error := True
			end
			if l_has_error and not l_supported then
				l_type_to_create := a_creation_expr_b.info.type_to_create
				if l_type_to_create = Void then
					notify_error_not_implemented (a_creation_expr_b.generator + " = CREATION_EXPR_B" + Cst_error_not_yet_ready)
				else
					notify_error_not_implemented (a_creation_expr_b.generator + " = CREATION_EXPR_B" + Cst_error_not_yet_ready
						+ " for " + l_type_to_create.name )
				end
			end
		rescue
			retried := True
			retry
		end

	evaluate_call_access_b (a_call_access_b: CALL_ACCESS_B) is
		local
			l_feature_b: FEATURE_B
			l_attribue_b: ATTRIBUTE_B
			l_external_b: EXTERNAL_B
		do
			if a_call_access_b.is_feature then
				l_feature_b ?= a_call_access_b
				evaluate_feature_b (l_feature_b)
			elseif a_call_access_b.is_attribute then
				l_attribue_b ?= a_call_access_b
				evaluate_attribute_b (l_attribue_b)
			elseif a_call_access_b.is_external then
				l_external_b ?= a_call_access_b
				evaluate_external_b (l_external_b)
			else
				notify_error_not_implemented (a_call_access_b.generator + " = CALL_ACCESS_B"+ Cst_error_not_yet_ready)
			end
		end

	evaluate_feature_b (a_feature_b: FEATURE_B) is
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_feature_b.written_in)
			end

			if cl = Void then
				notify_error_evaluation (Cst_error_call_on_void_target +
						Cst_feature_name_left_limit + a_feature_b.feature_name + Cst_feature_name_right_limit
					)
			else
				if a_feature_b.precursor_type /= Void then
					cl := a_feature_b.precursor_type.base_class
					fi := cl.feature_table.feature_of_rout_id (a_feature_b.routine_id)
				else
					fi := cl.feature_table.item (a_feature_b.feature_name)
				end
				if fi /= Void then
					if fi.is_once then
						evaluate_once (fi)
					elseif fi.is_constant then
						evaluate_constant (fi)
					elseif fi.is_function then
							--| parameters ...
						params := parameter_values_from_parameters_b (a_feature_b.parameters)
						if tmp_target /= Void then
							evaluate_function (tmp_target.value_address, tmp_target, cl, fi, params)
						else
							evaluate_function (context_address, Void, cl, fi, params)
						end
					elseif fi.is_attribute then
							-- How come ? maybe with redefinition .. and so on ..
						if tmp_target /= Void then
							evaluate_attribute (tmp_target.value_address, tmp_target, fi)
						else
							evaluate_attribute (context_address, Void, fi)
						end
					else
						notify_error_not_implemented (a_feature_b.generator +  Cst_error_other_than_func_cst_once_not_available)
					end
				else
					notify_error_evaluation (a_feature_b.generator + Cst_error_report_to_support)
				end
			end
		end

	evaluate_external_b	(a_external_b: EXTERNAL_B) is
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_external_b.written_in)
			end

			if cl = Void then
				notify_error_evaluation (Cst_error_call_on_void_target +
						Cst_feature_name_left_limit + a_external_b.feature_name + Cst_feature_name_right_limit
					)
			else
				fi := cl.feature_table.item (a_external_b.feature_name)
				if fi = Void then
					params := parameter_values_from_parameters_b (a_external_b.parameters)
					prepare_evaluation
					evaluate_function_with_name (tmp_target, a_external_b.feature_name, a_external_b.external_name, params)
					retrieve_evaluation

					if tmp_result_value = Void then
							-- FIXME: What about static ? check ...
						notify_error_expression (a_external_b.generator + Cst_error_during_evaluation_of_external_call + a_external_b.feature_name)
					end
				else
					if fi.is_external then
							--| parameters ...
						params := parameter_values_from_parameters_b (a_external_b.parameters)
						if tmp_target /= Void then
							evaluate_function (tmp_target.value_address, tmp_target, Void, fi, params)
						elseif context_address /= Void then
							evaluate_function (context_address, Void, Void, fi, params)
						else
							evaluate_static_function (fi, cl, params)
						end
					elseif fi.is_attribute then
						if tmp_target /= Void then
							evaluate_attribute (tmp_target.value_address, tmp_target, fi)
						else
							evaluate_attribute (context_address, tmp_target, fi)
						end
					else
						notify_error_expression (a_external_b.generator + Cst_error_during_evaluation_of_external_call + a_external_b.feature_name)
					end
				end
			end
		end

	parameter_values_from_parameters_b (a_params: BYTE_LIST [EXPR_B]): ARRAYED_LIST [DUMP_VALUE] is
		local
			l_dmp: DUMP_VALUE
			l_parameters_b: BYTE_LIST [EXPR_B]
		do
			l_parameters_b := a_params
			if l_parameters_b /= Void then
				from
					create Result.make (l_parameters_b.count)
					l_parameters_b.start
				until
					l_parameters_b.after or error_occurred
				loop
					l_dmp := parameter_evaluation (l_parameters_b.item)
					if not error_occurred then
						Result.extend (l_dmp)
					end
					l_parameters_b.forth
				end
			end
		end

	evaluate_attribute_b (a_attribute_b: ATTRIBUTE_B) is
		local
			cl: CLASS_C
			fi: FEATURE_I
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := system.class_of_id (a_attribute_b.written_in)
			end

			if cl = Void then
				notify_error_evaluation (Cst_error_call_on_void_target)
			else
				fi := cl.feature_table.item (a_attribute_b.attribute_name)
				if tmp_target /= Void then
					evaluate_attribute (tmp_target.value_address, tmp_target, fi)
				else
					evaluate_attribute (context_address, Void, fi)
				end
			end
		end

	parameter_evaluation (a_expr_b: EXPR_B): DUMP_VALUE is
		require
			a_expr_b /= Void
		local
			l_param_b: PARAMETER_B
			l_expr_b: EXPR_B
			l_tmp_target_backup: like tmp_target
		do

			l_param_b ?= a_expr_b
			if l_param_b /= Void then
				l_expr_b := l_param_b.expression
			else
				l_expr_b := a_expr_b
			end

			l_tmp_target_backup := tmp_target
			tmp_target := Void
				--| in case of parameter, there is not target except the top one
			Result := standalone_evaluation_expr_b (l_expr_b)
			tmp_target := l_tmp_target_backup

			if Result = Void then
				notify_error_evaluation (a_expr_b.generator + Cst_error_evaluating_parameter)
			end
		end

	evaluate_local_b (l_local_b: LOCAL_B) is
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse ?= Application.status.current_call_stack_element
			if cse = Void then
				notify_error_evaluation ("Unable to get Current call stack element")
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				notify_error_evaluation ("Unable to get Current call stack element's routine")
			else
				dv :=  cse.locals.i_th (l_local_b.position)
				tmp_result_value := dv.dump_value
				tmp_result_static_type := tmp_result_value.dynamic_class
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			end
		end

	evaluate_argument_b (l_argument_b: ARGUMENT_B) is
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse ?= Application.status.current_call_stack_element
			if cse = Void then
				notify_error_evaluation ("Unable to get Current call stack element")
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				notify_error_evaluation ("Unable to get Current call stack element's routine")
				check
					False -- Shouldn't occur.
				end
			else
				dv :=  cse.arguments.i_th (l_argument_b.position)
				tmp_result_value := dv.dump_value
				tmp_result_static_type := tmp_result_value.dynamic_class
				-- FIXME jfiat [2004/02/26] : optimisation : maybe compute the static type ....
			end
		end

	evaluate_result_b (l_result_b: RESULT_B) is
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse ?= Application.status.current_call_stack_element
			if cse = Void then
				notify_error_evaluation ("Unable to get Current call stack element")
				check
					False -- Shouldn't occur.
				end
			else
				cf := cse.routine
			end
			if cf = Void then
				notify_error_evaluation ("Unable to get Current call stack element's routine")
				check
					False -- Shouldn't occur.
				end
			else
				dv := cse.result_value
				if dv /= Void then
					tmp_result_value := dv.dump_value
					if cf.type /= Void then
						tmp_result_static_type := cf.type.associated_class
					end
				end
			end
		end

	evaluate_current_b (l_current_b: CURRENT_B) is
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
		do
			if on_object then
					--| If the context is on object
					--| then Current represent the pointed object
				tmp_result_value := dump_value_at_address (context_address)
				if tmp_result_value /= Void then
					tmp_result_static_type := tmp_result_value.dynamic_class
				end
			else
				cse ?= Application.status.current_call_stack_element
				check cse /= Void end
				tmp_result_value := dbg_evaluator.current_object_from_callstack (cse)
				if tmp_result_value = Void then
					notify_error_evaluation ("Unable to get Current object")
				end
				tmp_result_static_type := context_class
			end
		end

feature {NONE} -- Concrete evaluation

	prepare_evaluation is
			-- Initialization before effective evaluation
		do
			Dbg_evaluator.set_last_variables (tmp_result_value, tmp_result_static_type)
		end

	retrieve_evaluation is
			-- Get the effective evaluation's result and info
		do
			tmp_result_value       := Dbg_evaluator.last_result_value
			tmp_result_static_type := Dbg_evaluator.last_result_static_type
			if Dbg_evaluator.error_evaluation_message /= Void then
				notify_error_evaluation (Dbg_evaluator.error_evaluation_message)
			end
			if Dbg_evaluator.error_exception_message /= Void then
				notify_error_evaluation (Dbg_evaluator.error_exception_message)
			end
		end

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			prepare_evaluation
			Dbg_evaluator.evaluate_static_function (f, cl, params)
			retrieve_evaluation
		end

	evaluate_once (f: FEATURE_I) is
			--
		require
			feature_not_void: f /= Void
--			f_is_once: f.is_once
--			f_is_once: f.is_once
		do
			prepare_evaluation
			Dbg_evaluator.evaluate_once (f)
			retrieve_evaluation
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
				evaluate_value_i (cv_cst_i.value)
			else
				prepare_evaluation
				Dbg_evaluator.evaluate_constant (f)
				retrieve_evaluation
			end
		end

	evaluate_attribute (a_addr: STRING; a_target: DUMP_VALUE; f: FEATURE_I) is
			-- Evaluate attribute feature
		do
			if a_target /= Void and then a_target.is_void then
				notify_error_evaluation (Cst_error_call_on_void_target +
						Cst_feature_name_left_limit + f.feature_name + Cst_feature_name_right_limit
					)
			else
				prepare_evaluation
				Dbg_evaluator.evaluate_attribute (a_addr, a_target, f)
				retrieve_evaluation
			end
		end

	evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if a_target /= Void and then a_target.is_void then
				notify_error_evaluation (Cst_error_call_on_void_target +
						Cst_feature_name_left_limit + f.feature_name + Cst_feature_name_right_limit
					)
			else
				prepare_evaluation
				Dbg_evaluator.evaluate_function (a_addr, a_target, cl, f, params)
				retrieve_evaluation
			end
		end

	evaluate_function_with_name (a_target: DUMP_VALUE;
				a_feature_name, a_external_name: STRING;
				params: LIST [DUMP_VALUE]) is
		require
			a_feature_name_not_void: a_feature_name /= Void
			a_external_name_not_void: a_external_name /= Void
		local
			l_addr: STRING
		do
			if application.is_dotnet then
					-- FIXME: What about static ? check ...
				if a_target /= Void then
					l_addr := tmp_target.value_address
				else
					l_addr := context_address
				end
				prepare_evaluation
				Dbg_evaluator.evaluate_function_with_name (l_addr, a_target, a_feature_name, a_external_name, params)
				retrieve_evaluation
			end
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Evaluation data

	tmp_target: DUMP_VALUE

	tmp_result_value: DUMP_VALUE

	tmp_result_static_type: CLASS_C

feature -- Context

	dbg_expression: DBG_EXPRESSION_B

	context_feature: FEATURE_I

	Default_context_feature: FEATURE_I is
		once
			Result := System.Any_class.compiled_class.feature_named ("default_create")
		end

feature -- Change Context

	init_context_with_current_callstack is
		local
			cse: CALL_STACK_ELEMENT
			ecse: EIFFEL_CALL_STACK_ELEMENT
			fi: FEATURE_I
		do
			cse := Application.status.current_call_stack_element
			if cse = Void then
				notify_error_expression (Cst_error_during_context_preparation)
			else
					--| Cse can be Void if the application raised an exception
					--| at the very beginning of the execution (for instance under dotnet)
				context_address := cse.object_address
				ecse ?= cse
				if ecse = Void then
					--| Could occurs in case of External call stack element
					--| in case of Exception or stopped state
					notify_error_expression (Cst_error_during_context_preparation)
				else
					fi := ecse.routine_i
					set_context_data (fi, ecse.dynamic_class, ecse.dynamic_type)
				end
			end
		end

	set_context_data (f: like context_feature; c: like context_class; ct: like context_class_type) is
		require
--			f_not_void: f /= Void
--			c_not_void: c /= Void
		local
			l_reset_byte_node: BOOLEAN
			c_c_t: CLASS_TYPE
			c_t_i: CL_TYPE_I
		do
			if c /= Void then
				if
					f /= context_feature
				then
					context_feature := f
					l_reset_byte_node := True
				end
				if context_feature = Void then
					context_feature := Default_context_feature
				end

				if not equal (context_class, c) then
					context_class := c
					l_reset_byte_node := True
				end
				if ct /= Void then
					c_c_t := ct
				elseif context_class /= Void then
					c_t_i := context_class.actual_type.type_i
					if c_t_i.has_associated_class_type then
						c_c_t := c_t_i.associated_class_type
					end
				end
				if not equal (context_class_type, c_c_t) then
					context_class_type := c_c_t
					l_reset_byte_node := True
				end
				if l_reset_byte_node then
						--| this means we will recompute the EXPR_B value according to the new context				
					reset_expression_byte_node
				end
			end
		end

feature -- Access

	expression_byte_node: EXPR_B is
		do
			Result := internal_expression_byte_node
			if Result = Void then
				get_expression_byte_node
				Result := internal_expression_byte_node
			end
		end

	is_condition (f: FEATURE_I): BOOLEAN is
			-- Is `Current' a condition (boolean query) in the context of `f'?
		local
			old_context_feature: like context_feature
			old_context_class: like context_class
			old_context_class_type: like context_class_type
			old_int_expression_byte_note: like internal_expression_byte_node
		do
				--| Backup current context and values
			old_context_feature := context_feature
			old_context_class := context_class
			old_context_class_type := context_class_type
			old_int_expression_byte_note := internal_expression_byte_node

				--| Removed any potential error due to previous evaluation
			error_handler.wipe_out

				--| prepare context
				--| this may reset the `expression_byte_node' value
			set_context_data (f, f.written_class, Void)

				--| Get expression_byte_node
			get_expression_byte_node
			if expression_byte_node /= Void then
--| Since the Byte_context is used only by debugger and code generation
--| there is no need to restore previous context
--| (see below the commented line for restoring class_type_context)
				if context_class_type /= Void then
					if Byte_context.class_type = Void then
						Byte_context.init (context_class_type)
					else
						Byte_context.change_class_type_context (context_class_type, context_class_type)
					end
				end

				Result := expression_byte_node.type.is_boolean
				if context_class_type /= Void and Byte_context.is_class_type_changed then
					Byte_context.restore_class_type_context
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
				internal_expression_byte_node := old_int_expression_byte_note
			end
		end

feature {NONE} -- Implementation

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		require
			addr /= Void
		do
			Result := dbg_evaluator.dump_value_at_address (addr)
		end

	local_table_for (a_feat_i: FEATURE_I; a_feat_as: FEATURE_AS): HASH_TABLE [LOCAL_INFO, STRING] is
		require
			--| make sure all the context had been set
			a_feat_i /= Void
			a_feat_as /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := locals_builder.local_table (a_feat_i, a_feat_as)
			else
					--| Should not occur ... but
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	get_expression_byte_node is
			-- get expression byte node depending of the context
		require
			context_feature_not_void: on_context implies context_feature /= Void
			context_class_not_void: context_class /= Void
		local
			retried: BOOLEAN

			l_ct_locals: HASH_TABLE [LOCAL_INFO, STRING]
			f_as: FEATURE_AS
			l_byte_code: BYTE_CODE
			l_ta: CL_TYPE_A
			bak_byte_code: BYTE_CODE
			bak_cc: CLASS_C
		do
			if not retried then
				if internal_expression_byte_node = Void then
					error_handler.wipe_out

					debug ("debugger_trace_eval_data")
						print (generator + ".get_expression_byte_node from ["+dbg_expression.expression+"]%N")
						print ("%T%T on_context: " + on_context.out +"%N")
						print ("%T%T on_class  : " + on_class.out +"%N")
						print ("%T%T on_object : " + on_object.out +"%N")
						if context_class /= Void then
							print ("%T%T context_class : " + context_class.name_in_upper +"%N")
						end
						if context_address /= Void then
							print ("%T%T context_address : " + context_address.out +"%N")
						end
						if context_feature /= Void then
							print ("%T%T context_feature : " + context_feature.feature_name +"%N")
						end
					end
						--| If we want to recompute the `expression_byte_node',
						--| we need to call `reset_expression_byte_nod'

					if context_class /= Void then
						ast_context.clear_all
							--| Prepare Compiler context
						if context_class_type /= Void then
							l_ta := context_class_type.type.type_a
						else
							l_ta := context_class.actual_type
						end
						ast_context.initialize (context_class, l_ta, context_class.feature_table)
						Inst_context.set_cluster (context_class.cluster)

						bak_cc := System.current_class
						System.set_current_class (context_class)

						bak_byte_code := Byte_context.byte_code

						if on_context and then context_feature /= Void then
								--| Locals
							f_as := context_feature.body

							Ast_context.set_current_feature (context_feature)

							fixme ("jfiat [2004/10/16] : Seems pretty heavy computing ..")
							l_byte_code := context_feature.byte_server.item (context_feature.body_index)
							Byte_context.set_byte_code (l_byte_code)

							l_ct_locals := locals_builder.local_table (context_feature, f_as)
							if l_ct_locals /= Void then
									--| if it failed .. let's continue anyway for now
								Ast_context.set_locals (l_ct_locals)
							end
						end
							--| Compute and get `expression_byte_node'
						internal_expression_byte_node := expression_byte_node_from_ast (dbg_expression.expression_ast)
							--| Reset Compiler context
						if bak_cc /= Void then
							System.set_current_class (bak_cc)
						end
						if bak_byte_code /= Void then
							Byte_context.set_byte_code (bak_byte_code)
						end
						Ast_context.clear_all
					else
						notify_error_expression_and_tag (Cst_error_context_corrupted_or_not_found, Void)
						Ast_context.clear_all
					end
				end
			else
				notify_error_expression (Cst_error_during_expression_analyse)
				error_handler.wipe_out
			end
		rescue
			retried := True
			retry
		end

	expression_byte_node_from_ast (exp: EXPR_AS): like expression_byte_node is
			-- compute expression_byte_node from EXPR_AS `exp'
		require
			exp_not_void: exp /= Void
			context_feature_not_void: context_feature /= Void
		local
			retried: BOOLEAN
			type_check_succeed: BOOLEAN
		do
			if not retried then
				reset_error
				error_handler.wipe_out
				Ast_context.set_is_ignoring_export (True)
				feature_checker.init (ast_context)
				feature_checker.expression_type_check_and_code (context_feature, exp)
				Ast_context.set_is_ignoring_export (False)

				if error_handler.has_error then
					type_check_succeed := True
					notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
					Result := Void
				else
					Result ?= feature_checker.last_byte_node
				end
			else
				ast_context.set_is_ignoring_export (False)
				if not type_check_succeed then
					notify_error_expression (Cst_error_type_checking_failed)
				end
				if error_handler.has_error then
					notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
				else
					if not error_occurred then
						notify_error_expression ("Error!")
					end
				end
				Result := Void
			end
		rescue
			retried := True
			retry
		end

	reset_expression_byte_node is
		do
			internal_expression_byte_node := Void
		end

	internal_expression_byte_node: like expression_byte_node

feature {NONE} -- Dump value helpers

	string_to_dump_value (v: STRING): DUMP_VALUE is
			-- Convert a string value `v' to the corresponding DUMP_VALUE
		do
			create Result.make_manifest_string (v, system.string_class.compiled_class)
		end

	integer_32_to_dump_value (v: INTEGER): DUMP_VALUE is
			-- Convert a INTEGER value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_integer_32 (v, system.integer_32_class.compiled_class)
		end

	integer_64_to_dump_value (v: INTEGER_64): DUMP_VALUE is
			-- Convert a INTEGER_64 value `v' to the corresponding DUMP_VALUE		
		do
			create Result.make_integer_64 (v, system.integer_64_class.compiled_class)
		end

	boolean_to_dump_value (v: BOOLEAN): DUMP_VALUE is
			-- Convert a BOOLEAN value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_boolean (v, system.boolean_class.compiled_class)
		end

	character_to_dump_value (v: CHARACTER): DUMP_VALUE is
			-- Convert a CHARACTER value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_character (v, system.character_class.compiled_class)
		end

	real_to_dump_value (v: REAL): DUMP_VALUE is
			-- Convert a REAL value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_real (v, system.real_32_class.compiled_class)
		end

	double_to_dump_value (v: DOUBLE): DUMP_VALUE is
			-- Convert a DOUBLE value `v' to the corresponding DUMP_VALUE	
		do
			create Result.make_double (v, system.real_64_class.compiled_class)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
