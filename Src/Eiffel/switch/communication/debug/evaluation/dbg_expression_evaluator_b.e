indexing
	description : "Objects used to evaluate a DBG_EXPRESSION ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"
	fixme: "FIXME jfiat [2007/05/07] : factorize code between evaluate_array_const_b and evaluate_tuple_const_b"

class
	DBG_EXPRESSION_EVALUATOR_B

inherit
	DBG_EXPRESSION_EVALUATOR
		redefine
			dbg_expression, reset_error,
			evaluate
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

	COMPILER_EXPORTER --| To access:  ERROR_HANDLER.wipe_out
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make_with_expression,
	make_as_object

feature -- helpers

	application_status: APPLICATION_STATUS is
		require
			application_is_executing: debugger_manager.application_is_executing
		do
			Result := debugger_manager.application_status
		end

feature {DBG_EXPRESSION} -- Evaluation

	evaluate (keep_assertion_checking: BOOLEAN) is
			-- Compute the value of the last message of `Current'.
		local
			l_error_occurred: BOOLEAN
			dobj: DEBUGGED_OBJECT
		do
			Precursor {DBG_EXPRESSION_EVALUATOR} (keep_assertion_checking)

				--| Clean tmp evaluation.			
			clean_temp_data

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
				elseif on_class then
					init_context_address_with_current_callstack
					set_context_data (Void, context_class, Void)
				elseif on_object then
					dobj := debugger_manager.object_manager.debugged_object (context_address, 0, 0)
					if dobj.is_erroneous then
						notify_error_expression (Debugger_names.msg_error_during_context_preparation (Debugger_names.msg_error_unable_to_get_valid_target_for (context_address)))
					else
						set_context_data (Void, dobj.dtype, dobj.class_type)
					end
					dobj := Void
				end

				if
					(on_context and context_feature = Void)
					or (on_class and context_class = Void)
				then
					notify_error_expression (Debugger_names.Cst_error_during_context_preparation)
					l_error_occurred := True
				else
						--| Compute and get `expression_byte_node'
					get_byte_node
					l_error_occurred := error_occurred
							or else (expression_byte_node = Void and instruction_byte_node = Void)
				end

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
					process_byte_node_evaluation (keep_assertion_checking)

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
		ensure then
			error_occurred_if_no_result: (final_result_value = Void
										and	final_result_static_type = Void
										and final_result_type = Void)
									implies (error_occurred)
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

feature {NONE} -- Evaluation

	process_byte_node_evaluation (keep_assertion_checking: BOOLEAN) is
		require
			byte_node_not_void: byte_node /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				if not keep_assertion_checking then
					debugger_manager.application.disable_assertion_check
				end
				if expression_byte_node /= Void then
					process_expression_evaluation (expression_byte_node)
				else
					process_instruction_evaluation (instruction_byte_node)
				end
			else
				notify_error_exception (Debugger_names.cst_error_evaluation_failed_with_internal_exception)
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
				evaluate_call_b (l_instr_call_b.call)
			else
				notify_error_evaluation (Debugger_names.msg_error_instruction_eval_not_yet_available (a_instr_b))
			end
		end

	evaluate_call_b (a_call_b: CALL_B) is
		require
			a_call_b /= Void
		local
			l_access_b: ACCESS_B
			l_nested_b: NESTED_B
		do
			l_access_b ?= a_call_b
			if l_access_b /= Void then
				evaluate_access_b (l_access_b)
			else
				l_nested_b ?= a_call_b
				if l_nested_b /= Void then
					evaluate_nested_b (l_nested_b)
				else
					notify_error_evaluation (Debugger_names.msg_error_expression_not_yet_available (a_call_b))
				end
			end
		end

--| Keep this commented code for later use.		
--	standalone_evaluation_expr_b (a_expr_b: EXPR_B): DUMP_VALUE
--			-- (export status {NONE})
--		require
--			a_expr_b /= Void
--		local
--			l_tmp_result_value_backup: like tmp_result_value
--			l_tmp_target_backup: like tmp_target
--			l_tmp_result_static_type_backup: like tmp_result_static_type
--		do
--			l_tmp_result_value_backup := tmp_result_value
--			l_tmp_target_backup := tmp_target
--			l_tmp_result_static_type_backup := tmp_result_static_type
--			evaluate_expr_b (a_expr_b)
--			Result := tmp_result_value
--			tmp_result_value := l_tmp_result_value_backup
--			tmp_target := l_tmp_target_backup
--			tmp_result_static_type := l_tmp_result_static_type_backup
--		end		

feature {NONE} -- EXPR_B evaluation

	process_expression_evaluation (a_expr_b: EXPR_B) is
		do
			evaluate_expr_b (a_expr_b)
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
			l_type_expr_b: TYPE_EXPR_B
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
										l_type_expr_b ?= a_expr_b
										if l_type_expr_b /= Void then
											evaluate_type_expr_b (l_type_expr_b)
										else
											evaluate_manifest_value (a_expr_b)
										end
									end
								end
							end
						end
					end
				end
			else
				evaluate_value_i (l_value_i, Void)
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
		do
			tmp_result_value := Void
			tmp_result_value := Void
			tmp_result_value := Debugger_manager.Dump_value_factory.new_void_value (Void)
		end

	evaluate_manifest_value (a_expr_b: EXPR_B) is
			-- Manifest value, that is to say STRING manisfest value,
			-- since the INTEGER and so on value are handled by the parser
		local
			l_string_b: STRING_B
			l_tuple_const_b: TUPLE_CONST_B
			l_array_const_b: ARRAY_CONST_B
		do
			l_string_b ?= a_expr_b
			if l_string_b /= Void then
				tmp_result_value := Debugger_manager.Dump_value_factory.new_manifest_string_value (
						l_string_b.value,
						debugger_manager.compiler_data.string_8_class_c
					)
			else
				l_tuple_const_b ?= a_expr_b
				if l_tuple_const_b /= Void then
					evaluate_tuple_const_b (l_tuple_const_b)
				else
					l_array_const_b ?= a_expr_b
					if l_array_const_b /= Void then
						evaluate_array_const_b (l_array_const_b)
					else
						notify_error_not_implemented_and_ready (a_expr_b, Void, Void)
					end
				end
			end
		end

	evaluate_tuple_const_b (a_tuple_const_b: TUPLE_CONST_B) is
			-- Manifest Tuple
		require
			a_tuple_const_b_not_void: a_tuple_const_b /= Void
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
			l_call_value: DUMP_VALUE
			l_type_i: CL_TYPE_I
		do
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_tuple_const_b.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				l_call_value := tmp_result_value
				tmp_target := l_call_value
					--| Call default_create
				l_class := debugger_manager.compiler_data.tuple_class_c
				l_def_create_feat_i := l_class.default_create_feature
				evaluate_routine (tmp_target.address, tmp_target, l_class, l_def_create_feat_i, Void)
				tmp_target := l_call_value
				if not error_occurred then
					l_byte_list := a_tuple_const_b.expressions
					if l_byte_list.count > 0 then
						from
							l_class := l_type_i.associated_class_type.associated_class
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
								dv := parameter_evaluation (l_expr_b)
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
									evaluate_routine (tmp_target.address, tmp_target, l_class, l_put_feat_i, l_arg_as_lst)
								end
							end
							i := i + 1
							l_byte_list.forth
						end
						if error_occurred then
							notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (l_type_i.name))
						end
					end
				end
				tmp_result_value := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_array_const_b (a_array_const_b: ARRAY_CONST_B) is
		require
			a_array_const_b_not_void: a_array_const_b /= Void
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
			l_call_value: DUMP_VALUE
			l_type_i: CL_TYPE_I
			dbg: like debugger_manager
		do
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_array_const_b.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				dbg := debugger_manager
				l_call_value := tmp_result_value
				tmp_target := l_call_value

				l_byte_list := a_array_const_b.expressions

					--| Call default_create
				l_class := dbg.compiler_data.array_class_c
				if l_class /= Void then
					l_create_feat_i := l_class.feature_named ("make")
					create l_arg_as_lst.make
					l_int_class := dbg.compiler_data.integer_32_class_c
					l_arg_as_lst.extend (dbg.dump_value_factory.new_integer_32_value (0, l_int_class))
					l_arg_as_lst.extend (dbg.dump_value_factory.new_integer_32_value (l_byte_list.count - 1, l_int_class))
					evaluate_routine (tmp_target.address, tmp_target, l_class, l_create_feat_i, l_arg_as_lst)
					l_arg_as_lst := Void
				else
					notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (l_type_i.name))
				end
				if not error_occurred then
					tmp_target := l_call_value
					if l_byte_list.count > 0 then
						from
							l_class := l_type_i.associated_class_type.associated_class
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
								dv := parameter_evaluation (l_expr_b)
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
									evaluate_routine (tmp_target.address, tmp_target, l_class, l_put_feat_i, l_arg_as_lst)
								end
							end
							i := i + 1
							l_byte_list.forth
						end
						if error_occurred then
							notify_error_evaluation (Debugger_names.msg_error_instanciation_of_type_raised_error (l_type_i.name))
						end
					end
				end
				tmp_result_value := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_value_i (a_value_i: VALUE_I; cl: CLASS_C) is
		require
			a_value_i_not_void: a_value_i /= Void
		local
			l_integer: INTEGER_CONSTANT
			l_bit: BIT_VALUE_I
			l_char: CHAR_VALUE_I
			l_real: REAL_VALUE_I
			l_string: STRING_VALUE_I
			l_type: TYPE_I
			l_cl: CLASS_C
			l_cli: CLASS_I
			-- ...
			d_fact: DUMP_VALUE_FACTORY
			comp_data: DEBUGGER_DATA_FROM_COMPILER
		do
			d_fact := Debugger_manager.Dump_value_factory
			comp_data := debugger_manager.compiler_data
			l_cl := cl
			if a_value_i.is_integer then
				l_integer ?= a_value_i
				l_type := l_integer.type
				if
					l_cl = Void
					and then l_type /= Void
				then
					l_cl := class_c_from_type_i (l_type)
				end
				if l_cl /= Void then
					if l_type.is_natural then
						l_cli := l_cl.original_class
						if l_cli = system.natural_32_class then
							tmp_result_value := d_fact.new_natural_32_value (l_integer.natural_32_value, l_cl)
						elseif l_cli = system.natural_64_class then
							tmp_result_value := d_fact.new_natural_64_value (l_integer.natural_64_value, l_cl)
						elseif l_cli = system.natural_16_class then
							tmp_result_value := d_fact.new_natural_16_value (l_integer.natural_16_value, l_cl)
						elseif l_cli = system.natural_8_class then
							tmp_result_value := d_fact.new_natural_8_value (l_integer.natural_8_value, l_cl)
						else
							check should_not_occur: False end
							tmp_result_value := d_fact.new_natural_32_value (l_integer.natural_32_value, l_cl)
						end
					else
						l_cli := l_cl.original_class
						if l_cli = system.integer_32_class then
							tmp_result_value := d_fact.new_integer_32_value (l_integer.integer_32_value, l_cl)
						elseif l_cli = system.integer_64_class then
							tmp_result_value := d_fact.new_integer_64_value (l_integer.integer_64_value, l_cl)
						elseif l_cli = system.integer_16_class then
							tmp_result_value := d_fact.new_integer_16_value (l_integer.integer_16_value, l_cl)
						elseif l_cli = system.integer_8_class then
							tmp_result_value := d_fact.new_integer_8_value (l_integer.integer_8_value, l_cl)
						else
							check should_not_occur: False end
							tmp_result_value := d_fact.new_integer_32_value (l_integer.integer_32_value, l_cl)
						end
					end
				else
						--| This should not occur, but in case it does
						--| let's display it as INTEGER_64
					l_cl := comp_data.integer_64_class_c
					tmp_result_value := d_fact.new_integer_64_value (l_integer.integer_64_value, l_cl)
				end
			elseif a_value_i.is_string then
				l_string ?= a_value_i
				if l_cl = Void then
					l_cl := comp_data.string_8_class_c
				end
				tmp_result_value := d_fact.new_manifest_string_value (l_string.string_value, l_cl)
			elseif a_value_i.is_boolean then
				if l_cl = Void then
					l_cl := comp_data.boolean_class_c
				end
				tmp_result_value := d_fact.new_boolean_value (a_value_i.boolean_value, l_cl)
			elseif a_value_i.is_character then
				l_char ?= a_value_i
				if l_char.is_character_32 then
					if l_cl = Void then
						l_cl := comp_data.character_32_class_c
					end
					tmp_result_value := d_fact.new_character_32_value (l_char.character_value, l_cl)
				else
					if l_cl = Void then
						l_cl := comp_data.character_8_class_c
					end
					tmp_result_value := d_fact.new_character_value (l_char.character_value.to_character_8, l_cl)
				end
			elseif a_value_i.is_real_32 then
				l_real ?= a_value_i
				if l_cl = Void then
					l_cl := comp_data.real_32_class_c
				end
				tmp_result_value := d_fact.new_real_32_value (l_real.real_32_value, l_cl)
			elseif a_value_i.is_real_64 then
				l_real ?= a_value_i
				if l_cl = Void then
					l_cl := comp_data.real_64_class_c
				end
				tmp_result_value := d_fact.new_real_64_value (l_real.real_64_value, l_cl)
			elseif a_value_i.is_bit then
				l_bit ?= a_value_i
				if l_cl = Void then
					l_cl := comp_data.bit_class_c
				end
				tmp_result_value := d_fact.new_bits_value (l_bit.bit_value, l_cl.class_signature, l_cl);
			else
				notify_error_not_implemented_and_ready (a_value_i, Void, Void)
			end
		end

	evaluate_binary_b (a_binary_b: BINARY_B) is
		local
			l_bin_equal_b: BIN_EQUAL_B
			l_nested_b: NESTED_B
			l_bool_binary_b: BOOL_BINARY_B
		do
			l_bin_equal_b ?= a_binary_b
			if l_bin_equal_b /= Void then
				evaluate_bin_equal_b (l_bin_equal_b)
			else
				l_bool_binary_b ?= a_binary_b
				if l_bool_binary_b /= Void then
					evaluate_bool_binary_b (l_bool_binary_b)
				elseif a_binary_b.access /= Void then
					l_nested_b := a_binary_b.nested_b
					evaluate_nested_b (l_nested_b)
				else
					notify_error_not_implemented_and_ready (a_binary_b, "/BINARY_B", Void)
				end
			end
		end

	evaluate_bool_binary_b (a_bool_binary_b: BOOL_BINARY_B) is
		local
			l_nested_b: NESTED_B
			l_b_and_then_b: B_AND_THEN_B
			l_b_or_else_b: B_OR_ELSE_B
			l_lazy_eval: BOOLEAN
			l_lazy_value: BOOLEAN
		do
			if a_bool_binary_b.access /= Void then
				l_b_and_then_b ?= a_bool_binary_b
				if l_b_and_then_b /= Void then
					l_lazy_eval := not l_b_and_then_b.is_and
					l_lazy_value := False
				else
					l_b_or_else_b ?= a_bool_binary_b
					if l_b_or_else_b /= Void then
						l_lazy_eval := not l_b_or_else_b.is_or
						l_lazy_value := True
					end
				end
				l_nested_b := a_bool_binary_b.nested_b
				evaluate_boolean_nested_b (l_nested_b, l_lazy_eval, l_lazy_value)
			else
				notify_error_not_implemented_and_ready (a_bool_binary_b, "/BOOL_BINARY_B", Void)
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
					tmp_result_static_type := debugger_manager.compiler_data.boolean_class_c
					tmp_result_value := Debugger_manager.Dump_value_factory.new_boolean_value (res, tmp_result_static_type)
				end
			end
			if not error_occurred and tmp_result_value = Void then
				notify_error_not_implemented_and_ready (a_bin_equal_b, "/BINARY_B", Void)
			end
		end

	evaluate_unary_b (a_unary_b: UNARY_B) is
			-- Evaluate unary_b expression
		local
			l_un_minus_b: UN_MINUS_B
			l_un_plus_b: UN_PLUS_B
			l_un_not_b: UN_NOT_B
			l_un_old_b: UN_OLD_B
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
						l_un_old_b ?= a_unary_b
						if l_un_old_b /= Void then
							evaluate_un_old_b (l_un_old_b)
						else
							notify_error_not_implemented_and_ready (a_unary_b, "/UNARY_B", Void)
						end
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
			l_tuple_access_b: TUPLE_ACCESS_B
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
										l_tuple_access_b ?= a_access_b
										if l_tuple_access_b /= Void then
											evaluate_tuple_access_b (l_tuple_access_b)
										else
											notify_error_not_implemented_and_ready (a_access_b, "/ACCESS_B", Void)
										end
									end
								end
							end
						end
					end
				end
			end
		end

	evaluate_boolean_nested_b (a_nested_b: NESTED_B; a_is_lazy: BOOLEAN; a_lazy_value: BOOLEAN) is
			-- Evaluate nested expression with boolean expression
			-- if `a_is_lazy' is True, only evaluate first part
			-- if first value is `a_lazy_value'
			--| i.e: for and then , is_lazy=True, and lazy_value=False
			--       for or else, is_lazy=true, and lazy_value=True
		local
			l_tmp_target_backup: like tmp_target
			l_target: ACCESS_B
			l_target_value: DUMP_VALUE
			l_boolean_value: DUMP_VALUE_BASIC
			l_message_value: DUMP_VALUE
			l_message: CALL_B
		do
			l_tmp_target_backup := tmp_target

			l_target := a_nested_b.target
			l_target_value := standalone_evaluation_expr_b (l_target)

			if not error_occurred then
				check is_boolean_value: l_target_value.is_type_boolean end
				l_boolean_value ?= l_target_value
				check is_boolean_dump_value: l_boolean_value /= Void end
				if
					a_is_lazy and then l_boolean_value.value_boolean = a_lazy_value
				then
					tmp_result_value := l_target_value
				else
					tmp_target := l_target_value
					l_message := a_nested_b.message
					l_message_value := standalone_evaluation_expr_b (l_message)

					if not error_occurred then
						tmp_result_value := l_message_value
					end
				end
			end
			tmp_target := l_tmp_target_backup
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

	evaluate_type_expr_b (a_type_expr_b: TYPE_EXPR_B) is
			-- TYPE [..] creation
		require
			a_type_expr_b_not_void: a_type_expr_b /= Void
		local
			l_class: CLASS_C
			l_def_create_feat_i: FEATURE_I
			l_tmp_target_backup: like tmp_target
			l_call_value: DUMP_VALUE
			l_type_i: CL_TYPE_I
		do
			fixme ("Later when we have a way to ensure the unicity of TYPE instances, we'll need to update this part")
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_type_expr_b.type)
			create_empty_instance_of (l_type_i)
			if not error_occurred then
				l_call_value := tmp_result_value
				tmp_target := l_call_value
					--| Call default_create
				l_class := debugger_manager.compiler_data.type_class_c
				l_def_create_feat_i := l_class.default_create_feature
				evaluate_routine (tmp_target.address, tmp_target, l_class, l_def_create_feat_i, Void)
				tmp_result_value := l_call_value
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_routine_creation_b (a_routine_creation_b: ROUTINE_CREATION_B) is
		do
			notify_error_not_implemented_and_ready (a_routine_creation_b, "/ROUTINE_CREATION_B", Void)
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
			if context_class_type /= Void then
				if Byte_context.class_type = Void then
					Byte_context.init (context_class_type)
				else
					Byte_context.change_class_type_context (context_class_type, context_class_type)
				end
			end
			l_type_to_create := a_creation_expr_b.info.type_to_create
			if byte_context.is_class_type_changed then
				byte_context.restore_class_type_context
			end
			if not retried then
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
										evaluate_value_i (l_v_i, Void)
									end
								end
							end
						end
					end
				else
					if l_type_to_create /= Void then
						evaluate_creation_expr_b_with_type (a_creation_expr_b, l_type_to_create)
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
				l_type_to_create := a_creation_expr_b.info.type_to_create
				if l_type_to_create = Void then
					notify_error_not_implemented_and_ready (a_creation_expr_b, "/CREATION_EXPR_B", Void)
				else
					notify_error_not_implemented_and_ready (a_creation_expr_b, "/CREATION_EXPR_B", l_type_to_create.name)
				end
			end
		rescue
			retried := True
			retry
		end

	evaluate_creation_expr_b_with_type (a_creation_expr_b: CREATION_EXPR_B; a_type_i: CL_TYPE_I) is
		require
			a_type_i_not_void: a_type_i /= Void
		local
			l_tmp_target_backup: like tmp_target
			l_call_value: DUMP_VALUE
			l_call_access: CALL_ACCESS_B
			l_call: CALL_B
			l_type_i: CL_TYPE_I
			l_gen_type_i: GEN_TYPE_I
			l_elt_type_i: CL_TYPE_I
			l_params: BYTE_LIST [PARAMETER_B]
			l_dv: DUMP_VALUE
		do
			l_tmp_target_backup := tmp_target
			l_type_i := resolved_real_type_in_context (a_type_i)
			if l_type_i.base_class.is_special then
				l_gen_type_i ?= l_type_i
				if l_gen_type_i /= Void then
					if l_gen_type_i.true_generics.valid_index (1) then
						l_elt_type_i ?= l_gen_type_i.true_generics[1]
						if l_elt_type_i /= Void then
							l_call_access := a_creation_expr_b.call
							if l_call_access /= Void then
								l_params := l_call_access.parameters
								if l_params /= Void and then l_params.count = 1 then
									l_dv := parameter_evaluation (l_params.first)
									if l_dv.is_type_integer_32 then
										create_special_any_instance (resolved_real_type_in_context (l_type_i), l_dv.as_dump_value_basic.value_integer_32)
									end
								end
							end
						end
					end
				end
				if error_occurred or else l_dv = Void then
					notify_error_evaluation (Debugger_names.msg_error_can_not_instanciate_type (l_type_i.name, Debugger_names.cst_error_special_not_yet_supported))
				end
			else
				create_empty_instance_of (l_type_i)
				if not error_occurred then
					tmp_target := tmp_result_value
					l_call_value := tmp_target
					l_call := a_creation_expr_b.call
					if l_call /= Void then
						evaluate_call_b (l_call)
					end
					if not error_occurred then
						tmp_result_value := l_call_value
					end
				end
			end
			tmp_target := l_tmp_target_backup
		end

	evaluate_tuple_access_b (a_tuple_access_b: TUPLE_ACCESS_B) is
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
			dv: DUMP_VALUE
		do
			if tmp_target /= Void then
				cl := tmp_target.dynamic_class
			elseif context_class /= Void then
				cl := context_class
			else
				cl := debugger_manager.compiler_data.tuple_class_c
			end
			fi := cl.feature_named ("item")
			create params.make (1)
			dv := debugger_manager.dump_value_factory.new_integer_32_value (a_tuple_access_b.position, system.integer_32_class.compiled_class)
			params.extend (dv)
			if not error_occurred then
				if tmp_target /= Void then
					evaluate_routine (tmp_target.value_address, tmp_target, cl, fi, params)
				else
					evaluate_routine (context_address, Void, cl, fi, params)
				end
			else
				notify_error_evaluation_report_to_support (a_tuple_access_b)
			end
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
				notify_error_not_implemented_and_ready (a_call_access_b, "/CALL_ACCESS_B", Void)
			end
		end

	evaluate_feature_b (a_feature_b: FEATURE_B) is
		local
			fi: FEATURE_I
			cl: CLASS_C
			l_cl_type: CL_TYPE_I
--			l_basic_i: BASIC_I
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
				notify_error_evaluation_call_on_void (a_feature_b.feature_name)
			else
--| Not yet ready, and useless since we do a metamorph on basic type to their ref value
--| thus no built-in evaluation			
--					--| Check if a_feature_b is not built-in
--				if cl.is_basic then
--					check cl.types /= Void and then cl.types.first /= Void end
--					l_basic_i ?= cl.types.first.type
--					if l_basic_i /= Void and then a_feature_b.is_feature_special (False, l_basic_i) then
--						notify_error_expression ("Evaluation of %"built-in%" feature %""
--							+ "{" + cl.name_in_upper + "}." + a_feature_b.feature_name
--							+ "%" is not yet available")
--					end
--				end
				if not error_occurred then
					if a_feature_b.precursor_type /= Void and then a_feature_b.precursor_type.is_standalone then
						l_cl_type ?= a_feature_b.precursor_type
						check l_cl_type_not_void_if_true_precursor: l_cl_type /= Void end
						cl := l_cl_type.base_class
						fi := cl.feature_table.feature_of_rout_id (a_feature_b.routine_id)
					else
						fi := feature_i_from_call_access_b_in_context (cl, a_feature_b)
					end
					if fi /= Void then
						if fi.is_once then
							evaluate_once (fi)
						elseif fi.is_constant then
							evaluate_constant (fi)
						elseif fi.is_routine then
								--| parameters ...
							params := parameter_values_from_parameters_b (a_feature_b.parameters)
							if not error_occurred then
								if tmp_target /= Void then
									evaluate_routine (tmp_target.value_address, tmp_target, cl, fi, params)
								else
									evaluate_routine (context_address, Void, cl, fi, params)
								end
							end
						elseif fi.is_attribute then
								-- How come ? maybe with redefinition .. and so on ..
							if tmp_target /= Void then
								evaluate_attribute (tmp_target.value_address, tmp_target, cl, fi)
							else
								evaluate_attribute (context_address, Void, cl, fi)
							end
						else
							notify_error_not_implemented (Debugger_names.msg_error_other_than_func_cst_once_not_available (a_feature_b))
						end
					else
						notify_error_evaluation_report_to_support (a_feature_b)
					end
				end
			end
		end

	evaluate_external_b	(a_external_b: EXTERNAL_B) is
		local
			fi: FEATURE_I
			cl: CLASS_C
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			if a_external_b.is_static_call then
				cl := class_c_from_external_b (a_external_b)
			elseif on_class then
				cl := context_class
			end
			if cl = Void then
				if tmp_target /= Void then
					cl := tmp_target.dynamic_class
				elseif context_class /= Void then
					cl := context_class
				else
					cl := system.class_of_id (a_external_b.written_in)
				end
			end

			if cl = Void then
				notify_error_evaluation_call_on_void (a_external_b.feature_name)
			else
				fi := feature_i_from_call_access_b_in_context (cl, a_external_b)
				if fi = Void then
					params := parameter_values_from_parameters_b (a_external_b.parameters)
					if not error_occurred then
						prepare_evaluation
						evaluate_function_with_name (tmp_target, a_external_b.feature_name, a_external_b.external_name, params)
						retrieve_evaluation

						if tmp_result_value = Void then
								-- FIXME: What about static ? check ...
							notify_error_evaluation_during_call_evaluation (a_external_b, a_external_b.feature_name)
						end
					end
				else
					if fi.is_external then
							--| parameters ...
						params := parameter_values_from_parameters_b (a_external_b.parameters)
						if not error_occurred then
							if on_class or a_external_b.is_static_call then
								if tmp_target /= Void then
									evaluate_static_routine (tmp_target.value_address, tmp_target, cl, fi, params)
								else
									evaluate_static_routine (context_address, Void, cl, fi, params)
								end
							else
								if tmp_target /= Void then
									evaluate_routine (tmp_target.value_address, tmp_target, cl, fi, params)
								elseif context_address /= Void then
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
						if tmp_target /= Void then
							evaluate_attribute (tmp_target.value_address, tmp_target, cl, fi)
						else
							evaluate_attribute (context_address, tmp_target, cl, fi)
						end
					else
						notify_error_evaluation_during_call_evaluation (a_external_b, a_external_b.feature_name)
					end
				end
			end
		end

	parameter_values_from_parameters_b (a_params: BYTE_LIST [EXPR_B]): ARRAYED_LIST [DUMP_VALUE] is
		local
			l_dmp: DUMP_VALUE
			l_parameters_b: LIST [EXPR_B]
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
				notify_error_evaluation_call_on_void (a_attribute_b.attribute_name)
			else
				fi := feature_i_from_call_access_b_in_context (cl, a_attribute_b)
				if fi /= Void then
					if tmp_target /= Void then
						evaluate_attribute (tmp_target.value_address, tmp_target, cl, fi)
					else
						evaluate_attribute (context_address, Void, cl, fi)
					end
				else
					notify_error_evaluation (Debugger_names.msg_error_with_retrieving_attribute (a_attribute_b.attribute_name))
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
				notify_error_evaluation (Debugger_names.msg_error_evaluating_parameter (a_expr_b))
			end
		end

	evaluate_local_b (l_local_b: LOCAL_B) is
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
			dv: ABSTRACT_DEBUG_VALUE
			cf: E_FEATURE
		do
			cse ?= application_status.current_call_stack_element
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
			cse ?= application_status.current_call_stack_element
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
			cse ?= application_status.current_call_stack_element
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
				cse ?= application_status.current_call_stack_element
				check cse /= Void end
				tmp_result_value := dbg_evaluator.current_object_from_callstack (cse)
				if tmp_result_value = Void then
					notify_error_evaluation (Debugger_names.Cst_unable_to_get_current_object)
				end
				tmp_result_static_type := context_class
			end
		end

	evaluate_un_old_b (a_un_old_b: UN_OLD_B) is
		do
			notify_error_not_implemented_and_ready (a_un_old_b, "/UN_OLD_B", Void)
		end

feature {NONE} -- Concrete evaluation

	prepare_evaluation is
			-- Initialization before effective evaluation
		require
			dbg_evaluator /= Void
		do
			dbg_evaluator.set_last_variables (tmp_result_value, tmp_result_static_type)
		end

	retrieve_evaluation is
			-- Get the effective evaluation's result and info
		do
			tmp_result_value       := dbg_evaluator.last_result_value
			tmp_result_static_type := dbg_evaluator.last_result_static_type
			if tmp_result_static_type = Void and tmp_result_value /= Void then
				tmp_result_static_type := tmp_result_value.dynamic_class
			end

			if dbg_evaluator.exception_occurred then
				notify_error_exception (dbg_evaluator.error_exception_message)
			end

			if dbg_evaluator.error_but_exception_occurred then
				notify_error_evaluation (dbg_evaluator.error_but_exception_message)
			end
		end

	evaluate_static_function (f: FEATURE_I; cl: CLASS_C; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if as_auto_expression then
				notify_error_evaluation_limited_for_auto_expression
			else
				prepare_evaluation
				Dbg_evaluator.evaluate_static_function (f, cl, params)
				retrieve_evaluation
			end
		end

	evaluate_once (f: FEATURE_I) is
		require
			feature_not_void: f /= Void
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
				evaluate_value_i (cv_cst_i.value, cv_cst_i.type.associated_class)
			else
				notify_error_evaluation (Debugger_names.msg_error_unknown_constant_type_for (f.feature_name))
			end
		end

	evaluate_attribute (a_addr: STRING; a_target: DUMP_VALUE; c: CLASS_C; f: FEATURE_I) is
			-- Evaluate attribute feature
		do
			if a_target /= Void and then a_target.is_void then
				notify_error_evaluation_call_on_void (f.feature_name)
			else
				prepare_evaluation
				Dbg_evaluator.evaluate_attribute (a_addr, a_target, c, f)
				retrieve_evaluation
			end
		end

	evaluate_routine (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if as_auto_expression then
				notify_error_evaluation_limited_for_auto_expression
			else
				if a_target /= Void and then a_target.is_void then
					notify_error_evaluation_call_on_void (f.feature_name)
				elseif on_class and then not f.is_once then
					notify_error_evaluation (Debugger_names.msg_error_vst1_on_class_context (cl.name_in_upper, f.feature_name))
				else
					prepare_evaluation
					Dbg_evaluator.evaluate_routine (a_addr, a_target, cl, f, params, False)
					retrieve_evaluation
				end
			end
		end

	evaluate_static_routine (a_addr: STRING; a_target: DUMP_VALUE; cl: CLASS_C; f: FEATURE_I; params: LIST [DUMP_VALUE]) is
		require
			f /= Void
			f_is_not_attribute: not f.is_attribute
		do
			if as_auto_expression then
				notify_error_evaluation_limited_for_auto_expression
			else
				if a_target /= Void and then a_target.is_void then
					notify_error_evaluation_call_on_void (f.feature_name)
				else
					prepare_evaluation
					Dbg_evaluator.evaluate_routine (a_addr, a_target, cl, f, params, True)
					retrieve_evaluation
				end
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
			if as_auto_expression then
				notify_error_evaluation_limited_for_auto_expression
			else
				if debugger_manager.is_dotnet_project then
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
		end

	create_empty_instance_of (a_type_i: CL_TYPE_I) is
			-- New empty instance of class represented by `a_type_id'.
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			not_special: not a_type_i.base_class.is_special
		local
			l_cl_type_i: CL_TYPE_I
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type then
				prepare_evaluation
				Dbg_evaluator.create_empty_instance_of (l_cl_type_i)
				retrieve_evaluation
				if error_occurred and l_cl_type_i.has_true_formal then
					notify_error_not_implemented (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				notify_error_evaluation (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

	create_special_any_instance (a_type_i: CL_TYPE_I; a_count: INTEGER) is
			-- Create new instance of SPECIAL represented by `a_type_id' and `a_count'
		require
			a_type_i_not_void: a_type_i /= Void
			already_resolved: a_type_i = resolved_real_type_in_context (a_type_i)
			is_special: a_type_i.base_class.is_special
		local
			l_cl_type_i: CL_TYPE_I
		do
			l_cl_type_i := a_type_i
			if l_cl_type_i.has_associated_class_type then
				prepare_evaluation
				Dbg_evaluator.create_special_any_instance (l_cl_type_i, a_count)
				retrieve_evaluation
				if error_occurred and l_cl_type_i.has_true_formal then
					notify_error_not_implemented (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_formal_type_not_yet_supported))
				end
			else
				notify_error_evaluation (Debugger_names.msg_error_can_not_instanciate_type (l_cl_type_i.name, Debugger_names.cst_error_not_compiled))
			end
		end

feature {DBG_EXPRESSION_EVALUATOR} -- Evaluation data

	tmp_target: DUMP_VALUE

	tmp_result_value: DUMP_VALUE

	tmp_result_static_type: CLASS_C

feature -- Context

	dbg_expression: DBG_EXPRESSION

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
			cse := application_status.current_call_stack_element
			if cse = Void then
				notify_error_expression (Debugger_names.Cst_error_during_context_preparation)
			else
					--| Cse can be Void if the application raised an exception
					--| at the very beginning of the execution (for instance under dotnet)
				context_address := cse.object_address
				ecse ?= cse
				if ecse = Void then
					--| Could occurs in case of External call stack element
					--| in case of Exception or stopped state
					notify_error_expression (Debugger_names.Cst_error_during_context_preparation)
				else
					fi := ecse.routine_i
					set_context_data (fi, ecse.dynamic_class, ecse.dynamic_type)
				end
			end
		end

	init_context_address_with_current_callstack is
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

feature -- Access

	byte_node_computed: BOOLEAN

	byte_node: BYTE_NODE is
		do
			Result := internal_byte_node
			if not byte_node_computed then
				check internal_byte_node = Void end
				get_byte_node
				check byte_node_computed end
				Result := internal_byte_node
			end
		end

	expression_byte_node: EXPR_B is
		do
			Result ?= byte_node
		end

	instruction_byte_node: INSTR_B is
		do
			Result ?= byte_node
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
			if not error_occurred and then expression_byte_node /= Void then
--| Since the Byte_context is used only by debugger and code generation
--| there is no need to restore previous context
--| (see below the commented line for restoring class_type_context)
				if context_class_type /= Void then
					if Byte_context.class_type = Void then
						Byte_context.init (context_class_type)
					else
						Byte_context.change_class_type_context (context_class_type, context_class_type)
					end
					bak_byte_code := Byte_context.byte_code
					if context_feature /= Void then
						Byte_context.set_current_feature (context_feature)
						Byte_context.set_byte_code (context_feature.byte_server.item (context_feature.body_index))
					end
				end

				Result := expression_byte_node.type.is_boolean
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

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		require
			addr /= Void
		do
			Result := dbg_evaluator.dump_value_at_address (addr)
		end

	new_integer_dump_value (i: INTEGER): DUMP_VALUE_BASIC is
		local
			dbgm: like debugger_manager
		do
			dbgm := debugger_manager
			Result := dbgm.dump_value_factory.new_integer_32_value (i, dbgm.compiler_data.integer_32_class_c)
		end

	prepare_contexts (cl: CLASS_C; ct: CLASS_TYPE) is
		require
			cl_not_void: cl /= Void
			ct_associated_to_cl: ct /= Void implies ct.associated_class.is_equal (cl)
		local
			l_ta: CL_TYPE_A
		do
			if ct /= Void then
				l_ta := ct.type.type_a
			else
				l_ta := cl.actual_type
			end
			Ast_context.initialize (cl, l_ta, cl.feature_table)
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
						print (generator + ".get_expression_byte_node from [" + dbg_expression.expression + "]%N")
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
							end
						elseif on_object and then context_class /= Void then
							l_cl := context_class
							prepare_contexts (l_cl, Void)
							System.set_current_class (l_cl)
							ast_context.set_written_class (l_cl)
						end
							--| Compute and get `expression_byte_node'
						internal_byte_node := byte_node_from_ast (dbg_expression.expression_ast)
							--| Reset Compiler context
						if bak_cc /= Void then
							System.set_current_class (bak_cc)
						end
						if bak_byte_code /= Void then
							Byte_context.set_byte_code (bak_byte_code)
						end
						Ast_context.clear_all
					else
						notify_error_expression_and_tag (Debugger_names.Cst_error_context_corrupted_or_not_found, Void)
						Ast_context.clear_all
					end
				end
			else
				notify_error_expression (Debugger_names.Cst_error_during_expression_analyse)
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
				notify_error_expression (Debugger_names.cst_error_during_expression_analyse)
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
					notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
					Result := Void
				else
					Result := dbg_expression_checker.last_byte_node
				end
			else
				ast_context.set_is_ignoring_export (False)
				if not type_check_succeed then
					notify_error_expression (Debugger_names.Cst_error_type_checking_failed)
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

	reset_byte_node is
		do
			internal_byte_node := Void
		end

	internal_byte_node: like  byte_node

	dbg_expression_checker: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR is
		once
			create Result
		end

feature {NONE} -- Compiler helpers

	resolved_real_type_in_context (a_type_i: CL_TYPE_I): CL_TYPE_I is
		require
			a_type_i_not_void: a_type_i /= Void
		do
			if context_class_type /= Void then
				Result ?= byte_context.real_type_in (a_type_i, context_class_type)
			end
			if Result = Void then
				Result := a_type_i
			end
		ensure
			Result_not_void: Result /= Void
		end

	feature_i_from_call_access_b_in_context (cl: CLASS_C; a_call_access_b: CALL_ACCESS_B): FEATURE_I is
			-- Return FEATURE_I corresponding to `a_call_access_b' in class `cl'
			-- (this handles the feature renaming cases)
		require
			cl_not_void: cl /= Void
			a_call_access_b_not_void: a_call_access_b /= Void
		local
			wcl: CLASS_C
			l_cl: CLASS_C
		do
			if cl.is_basic then
				l_cl := dbg_evaluator.associated_reference_basic_class_type (cl).associated_class
				Result := l_cl.feature_of_rout_id (a_call_access_b.routine_id)
			else
				if cl.class_id = a_call_access_b.written_in then
						--| if same class, this is straight forward
					Result := cl.feature_of_feature_id (a_call_access_b.feature_id)
				else
						--| let's search from written_class
					wcl := system.class_of_id (a_call_access_b.written_in)
					check wcl_not_void: wcl /= Void end
					Result := wcl.feature_of_rout_id (a_call_access_b.routine_id)
					if Result /= Void and then wcl /= cl then
						Result := fi_version_of_class (Result, cl)
					end
					if Result = Void then
							--| from _B target static type ...
						if a_call_access_b.parent /= Void and then a_call_access_b.parent.target /= Void then
							l_cl := class_c_from_expr_b (a_call_access_b.parent.target)
							if l_cl /= Void then
								Result := l_cl.feature_of_rout_id (a_call_access_b.routine_id)
								if Result /= Void and then l_cl /= cl then
									Result := fi_version_of_class (Result, cl)
								end
							end
						end

						--| else giveup, no need to find an erroneous feature whic lead to debuggee crash
					end
				end
			end
		end

	class_c_from_external_b (a_external_b: EXTERNAL_B): CLASS_C is
			-- Class C related to `a_external_b' if exists.
		require
			a_expr_b_not_void: a_external_b /= Void
		local
			ti: TYPE_I
		do
			ti := a_external_b.static_class_type
			if ti /= Void then
				Result := class_c_from_type_i (ti)
			elseif a_external_b.extension /= Void then
				 -- try to find out the class thanks to extension
				Result := Dbg_evaluator.class_c_from_external_b_with_extension (a_external_b)
			end
		end

	class_c_from_expr_b (a_expr_b: EXPR_B): CLASS_C is
			-- Class C related to `a_expr_b' if exists.
		require
			a_expr_b_not_void: a_expr_b /= Void
		local
			l_type_i: TYPE_I
		do
			l_type_i := a_expr_b.type
			if l_type_i /= Void then
				Result := class_c_from_type_i (l_type_i)
			end
		end

	class_c_from_type_i (a_type_i: TYPE_I): CLASS_C is
			-- Class C related to `a_type_i' if exists.
		require
			a_type_i_not_void: a_type_i /= Void
		local
			l_type_a: TYPE_A
		do
			if a_type_i /= Void then
				l_type_a := a_type_i.type_a
				if l_type_a.has_associated_class then
					Result := l_type_a.associated_class
				end
			end
		end

	class_type_from_expr_b (a_expr_b: EXPR_B): CLASS_TYPE is
			-- Class type related to `a_expr_b' if exists.
			--| NOT USED FOR NOW.
		require
			a_expr_b_not_void: a_expr_b /= Void
		local
			l_cl_type_i: CL_TYPE_I
		do
			l_cl_type_i ?= a_expr_b.type
			if l_cl_type_i /= Void then
				l_cl_type_i := resolved_real_type_in_context (l_cl_type_i)
				if l_cl_type_i.has_associated_class_type then
					Result := l_cl_type_i.associated_class_type
				end
			else
				--| might be :
				--| FORMAL_I
				--| LIKE_CURRENT_I
				--| MULTI_FORMAL_I
				--| NONE_I
				--| REFERENCE_I																
				--| VOID_I
			end
		end

	fi_version_of_class (fi: FEATURE_I; a_class: CLASS_C): FEATURE_I is
			-- Feature in `a_class' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			fi_not_void: fi /= Void
			a_class_not_void: a_class /= Void
		local
			rids: ROUT_ID_SET
		do
			if a_class.is_valid and then a_class.has_feature_table then
				rids := fi.rout_id_set
				Result := a_class.feature_table.feature_of_rout_id_set (fi.rout_id_set)
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

end -- class DBG_EXPRESSION_EVALUATOR_B
