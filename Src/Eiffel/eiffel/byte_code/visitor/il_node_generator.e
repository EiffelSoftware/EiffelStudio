indexing
	description: "Visitor for BYTE_NODE objects which generates the MSIL code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_NODE_GENERATOR

inherit
	BYTE_NODE_VISITOR
		redefine
			is_valid
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	IL_CONST
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_BN_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_IL_CONSTANTS
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	IL_PREDEFINED_STRINGS
		export
			{NONE} all
		end

	PREDEFINED_NAMES
		export
			{NONE} all
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is Current valid for visiting?
		do
			Result := il_generator /= Void
		end

feature -- Generation

	generate_il (a_code_generator: like il_generator; a_body: BYTE_CODE) is
			-- Generate IL byte code `a_body'.
		local
			r_type: TYPE_A
			cl_type_i: CL_TYPE_A
			local_list: LINKED_LIST [TYPE_A]
			inh_assert: INHERITED_ASSERTION
			feat: FEATURE_I
			class_c: CLASS_C
			end_of_assertion: IL_LABEL
			end_of_routine: IL_LABEL
			l_saved_in_assertion, l_saved_supplier_precondition, l_saved_in_precondition: INTEGER
			l_nb_precond: INTEGER
			l_old_expr_count: INTEGER
			keep: BOOLEAN
		do
			il_generator := a_code_generator
			keep := context.workbench_mode or else system.keep_assertions

				-- Put a breakable point on feature name.
			il_generator.put_line_info (a_body.start_line_number)
			il_generator.flush_sequence_points (context.class_type)
			if a_body.once_manifest_string_count > 0 then
				il_generator.generate_once_string_allocation (a_body.once_manifest_string_count)
			end

			class_c := context.class_type.associated_class
			local_list := context.local_list
			local_list.wipe_out
			feat := Context.current_feature
			inh_assert := Context.inherited_assertion
			inh_assert.init
			Context.set_origin_has_precondition (True)
			if not Context.associated_class.is_basic and then
				feat.assert_id_set /= Void
			then
					--! Do not get inherited pre & post for basic types
				a_body.formulate_inherited_assertions (feat.assert_id_set)
			end

				-- Set up the local variables
			a_body.setup_local_variables (True)

				-- Initialize use of local variables to IL side
			r_type := context.real_type (a_body.result_type)
			if not r_type.is_void then
				il_generator.put_result_info (r_type)
			end

				-- Set number of meaningful local variables. i.e. we
				-- do not include local variables that are temporarly
				-- generated for metamorphose and other operations.
			il_generator.set_local_count (local_list.count)

			if not local_list.is_empty then
				generate_il_local_info (local_list)
			end

			if keep then
					-- Generate local variable to save assertions level.
				context.add_local (boolean_type)
				l_saved_supplier_precondition := context.local_list.count
				context.set_saved_supplier_precondition (l_saved_supplier_precondition)
				il_generator.put_dummy_local_info (boolean_type, l_saved_supplier_precondition)
				il_generator.generate_save_supplier_precondition
				il_generator.generate_local_assignment (l_saved_supplier_precondition)
			end

			if a_body.rescue_clause /= Void then
					-- Generate local variable to save assertions level.
				context.add_local (boolean_type)
				l_saved_in_assertion := context.local_list.count
				il_generator.put_dummy_local_info (boolean_type, l_saved_in_assertion)
				il_generator.generate_in_assertion_status
				il_generator.generate_local_assignment (l_saved_in_assertion)

					-- Generate local variable to save in precondition status.
				context.add_local (boolean_type)
				l_saved_in_precondition := context.local_list.count
				il_generator.put_dummy_local_info (boolean_type, l_saved_in_precondition)
				il_generator.generate_in_precondition_status
				il_generator.generate_local_assignment (l_saved_in_precondition)

					-- Generate local variable to save `last_exception' object.
				context.add_local (system_exception_type)
				saved_last_exception := context.local_list.count
				il_generator.put_dummy_local_info (system_exception_type, saved_last_exception)
				il_generator.generate_last_exception
				il_generator.generate_local_assignment (saved_last_exception)

					-- Create retry label.
				retry_label := il_generator.create_label
				il_generator.mark_label (cil_node_generator.retry_label)
			end

				-- Make IL code for preconditions
			if
				context.origin_has_precondition and
				(a_body.precondition /= Void or inh_assert.has_precondition)
			then
				if keep then
					generate_il_precondition (a_body)
				elseif System.is_precompile_finalized then
					l_nb_precond := 0
					if a_body.precondition /= Void then
						l_nb_precond := l_nb_precond + a_body.precondition.count
					end
					if inh_assert.has_precondition then
						l_nb_precond := l_nb_precond + inh_assert.precondition_list_count
					end
					generate_ghost_debug_infos (a_body, l_nb_precond)
				end
			end

				-- Generate prologue for once routine
			if a_body.is_once then
				il_generator.generate_once_prologue
			end

			if a_body.rescue_clause /= Void then
					-- Start "try" block that will catch exceptions
					-- and invoke rescue clause
				il_generator.generate_start_exception_block
				end_of_routine := il_generator.create_label
			end

			if
				keep and then (a_body.old_expressions /= Void or inh_assert.has_postcondition)
			then
				end_of_assertion := il_generator.create_label
				il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_ensure)
				il_generator.branch_on_false (end_of_assertion)
				il_generator.put_boolean_constant (True)
				il_generator.generate_set_assertion_status

					-- Calculate how many try/catch blocks are needed for old expression evaluation.
				if a_body.old_expressions /= Void then
					l_old_expr_count := a_body.old_expressions.count
				end
				if inh_assert.has_postcondition	then
					l_old_expr_count := l_old_expr_count + inh_assert.old_expression_count
				end
				il_generator.prepare_old_expresssion_blocks (l_old_expr_count)

				if a_body.old_expressions /= Void then
					from
						a_body.old_expressions.start
					until
						a_body.old_expressions.after
					loop
						generate_il_old_init (a_body.old_expressions.item)
						a_body.old_expressions.forth
					end
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_il_old_exp_init (Current)
				end
				il_generator.put_boolean_constant (False)
				il_generator.generate_set_assertion_status
				il_generator.mark_label (end_of_assertion)
			end

				-- Initialize local variables (if required)
			if r_type.is_true_expanded and then not r_type.is_external then
				cl_type_i ?= r_type
				if cl_type_i /= Void then
					il_generator.create_expanded_object (cl_type_i)
				end
				il_generator.generate_result_assignment
			end
			if not local_list.is_empty then
				initialize_locals (local_list)
			end

			if a_body.compound /= Void then
				if a_body.body_index = context.copy_body_index then
					generate_copy
				else
					a_body.compound.process (Current)
				end
				il_generator.flush_sequence_points (context.class_type)
			end

				-- Make IL code for postcondition
			if
				keep and then
				(a_body.postcondition /= Void or inh_assert.has_postcondition)
			then
				end_of_assertion := il_generator.create_label
				il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_ensure)
				il_generator.branch_on_false (end_of_assertion)
				il_generator.put_boolean_constant (True)
				il_generator.generate_set_assertion_status
				context.set_assertion_type ({ASSERT_TYPE}.in_postcondition)
				if a_body.postcondition /= Void then
					a_body.postcondition.process (Current)
					Il_generator.flush_sequence_points (context.class_type)
				end
				if inh_assert.has_postcondition then
					inh_assert.generate_il_postcondition (Current)
				end
				il_generator.put_boolean_constant (False)
				il_generator.generate_set_assertion_status
				il_generator.mark_label (end_of_assertion)
			end

			if keep then
				il_generator.generate_local (l_saved_supplier_precondition)
				il_generator.generate_restore_supplier_precondition
			end

			if a_body.rescue_clause /= Void then
					-- Restore last exception at the end of normal exit of the routine.
				il_generator.generate_local (saved_last_exception)
				il_generator.generate_restore_last_exception

				il_generator.generate_start_rescue
					-- Restore precondition status.
				il_generator.generate_local (l_saved_in_precondition)
				il_generator.generate_set_precondition_status

					-- Restore assertion level.
				il_generator.generate_local (l_saved_in_assertion)
				il_generator.generate_set_assertion_status

					-- Generate code of rescue.
				a_body.rescue_clause.process (Current)
				il_generator.generate_end_exception_block
				il_generator.mark_label (end_of_routine)
			end
			inh_assert.wipe_out

			il_generator.put_debug_info (a_body.end_location)
			il_generator.flush_sequence_points (context.class_type)
			generate_il_return (a_body)

			il_generator := Void
			retry_label := Void
		end

	generate_il_node (a_code_generator: IL_CODE_GENERATOR; a_node: BYTE_NODE) is
			-- Generate `a_node' using `il_generator'.
		require
			a_node_not_void: a_node /= Void
			a_code_generator_not_void: a_code_generator /= Void
			a_code_generator_valid: il_generator = Void or else il_generator = a_code_generator
		do
			if il_generator = Void then
				il_generator := a_code_generator
				a_node.process (Current)
				il_generator := Void
			else
				a_node.process (Current)
			end
		end

	frozen generate_il_assignment (a_node: ACCESS_B; source_type: TYPE_A) is
			-- Generate source assignment IL code.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			is_writable: not a_node.read_only
			source_type_not_void: source_type /= Void
		local
			target_type: TYPE_A
		do
			target_type := context.real_type (a_node.type)
			generate_il_simple_assignment (a_node, target_type, source_type)
		end

	generate_reattachment (source: EXPR_B; source_type, target_type: TYPE_A) is
			-- Generate code that ensures semantics of reattachment
			-- of expression of `source_type' to entity of `target_type'
			-- assuming the expression value is on the stack.
		require
			source_type_not_void: source_type /= Void
			target_type_not_void: target_type /= Void
		local
			label: IL_LABEL
			label_done: IL_LABEL
		do
			if source_type.is_expanded then
				if not source_type.is_basic and then not source_type.is_external then
						-- Generate code to copy object at compile time
					if target_type.is_expanded then
							-- Box object before calling run-time feature
						il_generator.generate_metamorphose (target_type)
					end
					generate_twin_routine ({PREDEFINED_NAMES}.twin_name_id, target_type)
				end
			elseif target_type.is_basic then
				il_generator.generate_check_cast (source_type, target_type)
				il_generator.generate_load_address (target_type)
				il_generator.generate_load_from_address_as_basic (target_type)
			elseif
				source.is_dynamic_clone_required (source_type) and then
				(source_type.is_external and then
				target_type.is_external and then
				source_type.associated_class.is_interface and then
				target_type.associated_class.is_interface or else
				not source_type.is_external and then
				not source_type.is_generated_as_single_type and then
				not source_type.is_optimized_as_frozen)
			then
					-- Generate code to copy object at run-time
					-- depending on its dynamic type
				il_generator.duplicate_top
				il_generator.generate_is_true_instance_of (system.system_value_type_class.compiled_class.types.first.type)
				label := il_generator.create_label
				il_generator.branch_on_false (label)
				generate_twin_routine ({PREDEFINED_NAMES}.twin_name_id, target_type)
				if target_type.is_expanded then
						-- Ensure a value of an expanded type is on the stack instead of a reference.
					label_done := il_generator.create_label
					il_generator.branch_to (label_done)
					il_generator.mark_label (label)
					il_generator.generate_unmetamorphose (target_type)
					il_generator.mark_label (label_done)
				else
					il_generator.mark_label (label)
				end
			elseif target_type.is_expanded then
				il_generator.generate_unmetamorphose (target_type)
			end
		end

	generate_il_load_value (a_node: INSPECT_B) is
			-- Load value of expression
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
			if a_node.switch.is_fast_as_local then
				a_node.switch.process (Current)
			else
				il_generator.duplicate_top
			end
		end

	generate_il_old_init (a_node: UN_OLD_B) is
			-- Generate old initialization of `a_node'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
			il_generator.generate_start_old_try_block (a_node.exception_position)
			a_node.expr.process (Current)
			il_generator.generate_local_assignment (a_node.position)
			il_generator.generate_catch_old_exception_block (a_node.exception_position)
		end

	generate_il_precondition_node (a_node: ASSERT_B; a_failure_block: IL_LABEL) is
			-- Generate `a_node' as precondition
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_failure_block_not_void: a_failure_block /= Void
		do
			generate_il_line_info (a_node, True)
			a_node.expr.process (Current)
			il_generator.generate_precondition_check (a_node.tag, a_failure_block)
		end

	generate_il_when_part (a_node: INSPECT_B; case_index: INTEGER; labels: ARRAY [IL_LABEL]) is
			-- Generate code for When_part idetified by `case_index' and
			-- adjust `labels' if required.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			case_list_not_void: a_node.case_list /= Void
			valid_case_index: 1 <= case_index and case_index <= a_node.case_list.count
			labels_not_void: labels /= Void
			valid_labels: labels.lower = -1 and labels.upper = a_node.case_list.count
		local
			case_label: IL_LABEL
			case_b: CASE_B
			compound: BYTE_LIST [BYTE_NODE]
		do
			case_label := labels.item (case_index)
			if case_label = Void then
				case_label := il_generator.create_label
				labels.put (case_label, case_index)
			end
			il_generator.mark_label (case_label)
			case_b ?= a_node.case_list.i_th (case_index)
			compound := case_b.compound
			if compound /= Void then
				compound.process (Current)
			end
			il_generator.branch_to (labels.item (-1))
		ensure
			label_not_void: labels.item (case_index) /= Void
		end

feature {NONE} -- Implementation

	generate_il_return (a_body: BYTE_CODE) is
			-- Generate IL final return statement
		require
			is_valid: is_valid
			a_body_not_voyd: a_body /= Void
		local
			has_return_value: BOOLEAN
		do
			if a_body.is_once then
				il_generator.generate_once_epilogue
			else
				if not context.real_type (a_body.result_type).is_void then
					il_generator.generate_result
					has_return_value := True
				end
				il_generator.generate_return (has_return_value)
			end
		end

	generate_il_precondition (a_body: BYTE_CODE) is
			-- Generate IL precondition checking blocks.
		require
			is_valid: is_valid
			a_body_not_voyd: a_body /= Void
		local
			inh_assert: INHERITED_ASSERTION
			end_of_assertion, success_block, failure_block: IL_LABEL
			l_prec: BYTE_LIST [BYTE_NODE]
			assert_b: ASSERT_B
			need_end_label: BOOLEAN
		do
			context.set_assertion_type ({ASSERT_TYPE}.in_precondition)

			l_prec := a_body.precondition
			inh_assert := Context.inherited_assertion

			end_of_assertion := il_generator.create_label
			il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_require)
			il_generator.branch_on_false (end_of_assertion)
			il_generator.put_boolean_constant (True)
			il_generator.generate_set_assertion_status
			il_generator.put_boolean_constant (True)
			il_generator.generate_set_precondition_status
			if l_prec /= Void then
				from
					need_end_label := True
					success_block := il_generator.create_label
					failure_block := il_generator.create_label
					l_prec.start
				until
					l_prec.after
				loop
					assert_b ?= l_prec.item
					check
						assert_b_not_void: assert_b /= Void
					end
					generate_il_precondition_node (assert_b, failure_block)
					l_prec.forth
				end
				il_generator.branch_to (success_block)
				il_generator.mark_label (failure_block)
				Il_generator.flush_sequence_points (context.class_type)
			end

			if inh_assert.has_precondition then
				inh_assert.generate_il_precondition (Current)
				if need_end_label then
					il_generator.mark_label (success_block)
				end
			else
				if need_end_label then
					il_generator.generate_precondition_violation
					il_generator.mark_label (success_block)
				end
			end
			il_generator.put_boolean_constant (False)
			il_generator.generate_set_precondition_status
			il_generator.put_boolean_constant (False)
			il_generator.generate_set_assertion_status
			il_generator.mark_label (end_of_assertion)
		end

	generate_il_local_info (local_list: LINKED_LIST [TYPE_A]) is
			-- Generate IL info for local variables in `local_list'.
		require
			is_valid: is_valid
			local_list_not_void: local_list /= Void
			local_list_not_empty: not local_list.is_empty
		local
			routine_as: ROUTINE_AS
			id_list: IDENTIFIER_LIST
			rout_locals: EIFFEL_LIST [TYPE_DEC_AS]
			debug_generation: BOOLEAN
			i: INTEGER
			l_body: BODY_AS
		do
				-- Do we generate debug information for local variables.
			debug_generation := System.line_generation or context.workbench_mode

			if debug_generation then
				l_body := context.current_feature.real_body
				if l_body /= Void then
					routine_as ?= l_body.content
					if routine_as /= Void and then routine_as.locals /= Void then
							-- `local_list' is in the same order as `routine_as.locals'
							-- so this is easy to find for each element of `local_list'
							-- its name in `routine_as.locals'.
						from
							rout_locals := routine_as.locals
							rout_locals.start
							local_list.start
						until
							local_list.after
						loop
							if not rout_locals.after then
								from
									id_list := rout_locals.item.id_list
									id_list.start
								until
									id_list.after
								loop
									il_generator.put_local_info (local_list.item, id_list.item)
									local_list.forth
									id_list.forth
								end
								rout_locals.forth
							else
								il_generator.put_dummy_local_info (local_list.item, i)
								i := i + 1
								local_list.forth
							end
						end
					else
							-- No local variables were found in routine text, therefore
							-- we have only temporary local variables that are generated
							-- using no debug information.
						debug_generation := False
					end
				else
						-- No local variables were found in routine text, therefore
						-- we have only temporary local variables that are generated
						-- using no debug information.
					debug_generation := False
				end
			end

			if not debug_generation then
					-- Generation of local variable without debug information
				from
					local_list.start
				until
					local_list.after
				loop
					il_generator.put_nameless_local_info (local_list.item, i)
					i := i + 1
					local_list.forth
				end
			end
		end

	initialize_locals (local_list: LINKED_LIST [TYPE_A]) is
			-- Generate code to initialize local variables of the current routine
			-- taking their types from `local_list'.
		require
			is_valid: is_valid
			local_list_not_void: local_list /= Void
			local_list_not_empty: not local_list.is_empty
		local
			routine_as: ROUTINE_AS
			id_list: IDENTIFIER_LIST
			rout_locals: EIFFEL_LIST [TYPE_DEC_AS]
			local_type: CL_TYPE_A
			i: INTEGER
			l_body: BODY_AS
		do
			l_body := context.current_feature.real_body
			if l_body /= Void then
				routine_as ?= l_body.content
				if routine_as /= Void and then routine_as.locals /= Void then
						-- `local_list' is in the same order as `routine_as.locals'
						-- so this is easy to find for each element of `local_list'
						-- its name in `routine_as.locals'.
					rout_locals := routine_as.locals
					from
						rout_locals.start
						local_list.start
						i := 1
					until
						rout_locals.after
					loop
						from
							id_list := rout_locals.item.id_list
							id_list.start
						until
							id_list.after
						loop
							local_type ?= context.real_type (local_list.item)
							if local_type /= Void and then local_type.is_true_expanded and then not local_type.is_external then
								il_generator.create_expanded_object (local_type)
								il_generator.generate_local_assignment (i)
							end
							i := i + 1
							local_list.forth
							id_list.forth
						end
						rout_locals.forth
					end
				end
			end
		end

	generate_copy is
			-- Generate body of feature `copy' from ANY.
		local
			class_type, l_old_class_type: CLASS_TYPE
			cl_type_i: CL_TYPE_A
			skeleton: SKELETON
			feature_id: INTEGER
		do
			class_type := context.original_class_type
			if class_type.is_expanded then
				cl_type_i := class_type.type
				skeleton := class_type.skeleton
				if skeleton /= Void then
					l_old_class_type := context.class_type
					context.set_class_type (class_type)
					from
						skeleton.start
					until
						skeleton.after
					loop
						feature_id := skeleton.item.feature_id
						il_generator.generate_current
						il_generator.generate_argument (1)
						if not cl_type_i.is_basic then
							il_generator.generate_metamorphose (cl_type_i)
							il_generator.generate_load_address (cl_type_i)
							il_generator.generate_attribute (True, cl_type_i, feature_id)
						end
						il_generator.generate_attribute_assignment (True, cl_type_i, feature_id)
						skeleton.forth
					end
					context.set_class_type (l_old_class_type)
				end
			else
				il_generator.generate_current
				il_generator.generate_argument (1)
				il_generator.generate_call_to_standard_copy
			end
		end

feature -- Access

	il_generator: IL_CODE_GENERATOR
			-- Actual IL code generator.

	is_in_creation_call: BOOLEAN
			-- Is current call a creation instruction

	is_in_external_creation_call: BOOLEAN
			-- Is current call a creation instruction on an external type?

	is_nested_call: BOOLEAN
			-- Is current call from a NESTED_B node?

	is_object_load_required: BOOLEAN
			-- If we manipulate an expanded and try to access the object, we need
			-- to load the object from its address.

	is_this_argument_current: BOOLEAN
			-- Is current argument loaded to the stack a Current?

	is_last_argument_current: BOOLEAN
			-- Is last argument loaded to the stack a Current?

	retry_label: IL_LABEL
			-- Label used for `retry' clause.

feature {NONE} -- Access

	saved_last_exception: INTEGER
			-- Number of local to store `last_exception'

feature {NONE} -- Routine visitor

	process_std_byte_code (a_node: STD_BYTE_CODE) is
			-- Process current element.
		do
		end

feature {NONE} -- Visitors

	process_access_expr_b (a_node: ACCESS_EXPR_B) is
			-- Process `a_node'.
		local
			l_is_nested_call: like is_nested_call
			l_type_i: TYPE_A
		do
			l_is_nested_call := is_nested_call
			is_nested_call := False
			a_node.expr.process (Current)
			if l_is_nested_call then
				l_type_i := context.real_type (a_node.type)
				if l_type_i.is_true_expanded and then not l_type_i.associated_class.is_enum then
					generate_il_metamorphose (l_type_i, l_type_i, True)
				end
			end
		end

	process_address_b (a_node: ADDRESS_B) is
			-- Process `a_node'.
		local
			l_target_type: CL_TYPE_A
			l_target_feature_id: INTEGER
		do
			l_target_type := context.context_class_type.type
			if l_target_type.is_expanded then
				l_target_feature_id := l_target_type.associated_class.feature_of_rout_id (
					system.class_of_id (a_node.class_id).feature_of_feature_id (a_node.feature_id).rout_id_set.first
				).feature_id
			else
				l_target_type := l_target_type.implemented_type (a_node.class_id)
				l_target_feature_id := a_node.feature_id
			end
			il_generator.generate_routine_address (l_target_type, l_target_feature_id, is_last_argument_current)
		end

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
			if need_access_address (a_node, is_nested_call) then
				il_generator.generate_argument_address (a_node.position)
			else
				il_generator.generate_argument (a_node.position)
			end
			is_nested_call := False
		end

	process_array_const_b (a_node: ARRAY_CONST_B) is
			-- Process `a_node'.
		local
			l_real_ty: GEN_TYPE_A
			l_decl_type: CL_TYPE_A
			l_target_type: TYPE_A
			l_expr: EXPR_B
			l_base_class: CLASS_C
			i: INTEGER
			l_feat_tbl: FEATURE_TABLE
			l_make_feat, l_put_feat: FEATURE_I
		do
			l_real_ty ?= context.real_type (a_node.type)
			l_target_type := l_real_ty.generics.item (1)
			l_base_class := l_real_ty.associated_class
			l_feat_tbl := l_base_class.feature_table
			l_make_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.make_name_id)
			l_decl_type := l_real_ty.implemented_type (l_make_feat.origin_class_id)

				-- Creation of Array
			a_node.info.generate_il

				-- Call creation procedure of ARRAY
			il_generator.duplicate_top
			il_generator.put_integer_32_constant (1)
 			il_generator.put_integer_32_constant (a_node.expressions.count)
 			il_generator.generate_feature_access (l_decl_type, l_make_feat.origin_feature_id,
				l_make_feat.argument_count, l_make_feat.has_return_value, True)

				-- Find `put' from ARRAY
			l_put_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.put_name_id)
			l_decl_type := l_real_ty.implemented_type (l_put_feat.origin_class_id)

 			from
 				a_node.expressions.start
 				i := 1
 			until
 				a_node.expressions.after
 			loop
 				l_expr ?= a_node.expressions.item

 					-- Prepare call to `put'.
				il_generator.duplicate_top

 					-- Generate expression
 				generate_expression_il_for_type (l_expr, l_target_type)

 				il_generator.put_integer_32_constant (i)

 				il_generator.generate_feature_access (l_decl_type, l_put_feat.origin_feature_id,
					l_put_feat.argument_count, l_put_feat.has_return_value, True)
 				i := i + 1
 				a_node.expressions.forth
 			end
		end

	process_assert_b (a_node: ASSERT_B) is
			-- Process `a_node'.
		do
			check
				expr_exists: a_node.expr /= Void
				not_in_precondition: context.assertion_type /= {ASSERT_TYPE}.in_precondition
			end
			generate_il_line_info (a_node, True)
			a_node.expr.process (Current)
			il_generator.generate_assertion_check (context.assertion_type, a_node.tag)
		end

	process_assign_b (a_node: ASSIGN_B) is
			-- Process `a_node'.
		local
			source_type: TYPE_A
			target_type: TYPE_A
		do
			generate_il_line_info (a_node, True)
			process_pragma (a_node)

				-- Code that needs to be generated when performing
				-- assignment to an attribute.
			generate_il_start_assignment (a_node.target)

			source_type := context.real_type (a_node.source.type)
			target_type := context.real_type (a_node.target.type)

				-- Generate expression byte code.
			generate_expression_il_for_type (a_node.source, target_type)

				-- Check if the assignment instruction is used to model
				-- creation instruction.
			if not a_node.is_creation_instruction then
					-- Generate code for reattachment.
				generate_reattachment (a_node.source, source_type, target_type)
			end

				-- Generate assignment.
			generate_il_assignment (a_node.target, source_type)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_r_type: TYPE_A
			l_cl_type: CL_TYPE_A
			l_attribute_cl_type: CL_TYPE_A
			l_target_type: TYPE_A
			l_target_attribute_id: INTEGER
			l_feature_call: FEATURE_B
			l_cancel_attribute_generation: BOOLEAN
			l_is_nested_call: like is_nested_call
			l_need_address: BOOLEAN
		do
			l_is_nested_call := is_nested_call
			is_nested_call := False

			if l_is_nested_call then
				l_need_address := need_access_address (a_node, l_is_nested_call)
			end

				-- Type of attribute in current context
			l_r_type := context.real_type (a_node.type)

			if l_r_type.is_none then
					-- Accessing Void attribute from ANY
				il_generator.put_default_value (l_r_type)
			else
					-- Type of class which defines current attribute.
				l_cl_type ?= a_node.context_type
				if l_cl_type.is_expanded and then not l_cl_type.is_true_external then
						-- Access attribute directly.
					if l_cl_type.associated_class.is_typed_pointer then
							-- Use non-generic class POINTER because TYPED_POINTER is not generated.
						l_cl_type := system.pointer_class.compiled_class.actual_type
					end
					l_target_type := l_cl_type
					l_target_attribute_id := l_cl_type.associated_class.feature_of_rout_id (a_node.routine_id).feature_id
				else
					l_target_type := l_cl_type.implemented_type (a_node.written_in)
					l_target_attribute_id := a_node.attribute_id
				end

				check
					valid_type: l_cl_type /= Void
				end

					-- Let's try to prepare call to `XXX.attribute.copy' in
					-- case of `attribute' is a basic type.
				if a_node.parent /= Void and l_r_type.is_basic then
					l_feature_call ?= a_node.parent.message
					l_attribute_cl_type ?= l_r_type
					if
						l_feature_call /= Void and then
						il_special_routines.has (l_feature_call, l_attribute_cl_type) and then
						il_special_routines.function_type =
							{IL_SPECIAL_FEATURES}.set_item_type
					then
							-- Since we do not need to load attribute value onto the stack,
							-- we cancel the attribute generation.
							-- IL_SPECIAL_FEATURES.generate_set_item will know that Object
							-- where Current belongs is on top of the stack.
						l_cancel_attribute_generation := True
					end
				end

				if not l_cancel_attribute_generation then
					if a_node.is_first and a_node.need_target then
							-- Accessing attribute written in current analyzed class.
						if l_need_address and not context.context_class_type.is_generated_as_single_type then
								-- We need current target which will be used later on in
								-- NESTED_B.generate_il to assign back the new value of the attribute.
							il_generator.generate_current
						end
						il_generator.generate_current
					elseif l_cl_type.is_basic then
							-- A metamorphose is required to perform call.
						generate_il_metamorphose (l_cl_type, l_target_type, need_real_metamorphose (a_node, l_cl_type))
					end
						-- We push code to access Current attribute.
					if l_need_address then
						il_generator.generate_attribute_address (l_target_type, l_r_type, l_target_attribute_id)
					else
						if l_target_type.is_generated_as_single_type then
							il_generator.generate_attribute (a_node.need_target, l_target_type, l_target_attribute_id)
						else
							il_generator.generate_feature_access (l_target_type,
								l_target_attribute_id, 0, True, True)
						end

							-- Generate cast if we have to generate verifiable code
							-- since attribute might have been redefined and in this
							-- case its type for IL generation is the one from the
							-- parent not the redefined one. Doing the cast enable
							-- the verifier to find out that what we are doing is
							-- correct.
						if
							system.il_verifiable and then not l_r_type.is_expanded
							and then not l_r_type.is_none
						then
							il_generator.generate_check_cast (Void, l_r_type)
						end
					end
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
		local
			l_and_then_label, l_final_label: IL_LABEL
		do
			if a_node.is_built_in then
				l_and_then_label := il_generator.create_label
				l_final_label := il_generator.create_label
				a_node.left.process (Current)
				il_generator.branch_on_false (l_and_then_label)
				a_node.right.process (Current)
				il_generator.branch_to (l_final_label)
				il_generator.mark_label (l_and_then_label)
				il_generator.put_boolean_constant (False)
				il_generator.mark_label (l_final_label)
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_div_b (a_node: BIN_DIV_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_div)
		end

	process_bin_eq_b (a_node: BIN_EQ_B) is
			-- Process `a_node'.
		do
			generate_bin_equal_b (a_node, il_eq)
		end

	process_bin_free_b (a_node: BIN_FREE_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_bin_ge_b (a_node: BIN_GE_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_ge)
		end

	process_bin_gt_b (a_node: BIN_GT_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_gt)
		end

	process_bin_implies_b (a_node: B_IMPLIES_B) is
			-- Process `a_node'.
		local
			l_final_label: IL_LABEL
		do
			if a_node.is_built_in then
				l_final_label := il_generator.create_label
				a_node.left.process (Current)
				il_generator.generate_unary_operator (il_not)
				il_generator.duplicate_top
				il_generator.branch_on_true (l_final_label)
				il_generator.pop
				a_node.right.process (Current)
				il_generator.mark_label (l_final_label)
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_le_b (a_node: BIN_LE_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_le)
		end

	process_bin_lt_b (a_node: BIN_LT_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_lt)
		end

	process_bin_minus_b (a_node: BIN_MINUS_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_minus)
		end

	process_bin_mod_b (a_node: BIN_MOD_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_mod)
		end

	process_bin_ne_b (a_node: BIN_NE_B) is
			-- Process `a_node'.
		do
			generate_bin_equal_b (a_node, il_ne)
		end

	process_bin_or_b (a_node: BIN_OR_B) is
			-- Process `a_node'.
		do
			process_bin_or_else_b (a_node)
		end

	process_bin_or_else_b (a_node: B_OR_ELSE_B) is
			-- Process `a_node'.
		local
			l_final_label: IL_LABEL
		do
			if a_node.is_built_in then
				l_final_label := il_generator.create_label
				a_node.left.process (Current)
				il_generator.duplicate_top
				il_generator.branch_on_true (l_final_label)
				il_generator.pop
				a_node.right.process (Current)
				il_generator.mark_label (l_final_label)
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_plus_b (a_node: BIN_PLUS_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_plus)
		end

	process_bin_power_b (a_node: BIN_POWER_B) is
			-- Process `a_node'.
		local
			l_power_nb: REAL_CONST_B
			l_power_value: DOUBLE
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				il_generator.convert_to_real_64
				l_power_nb ?= a_node.right
				if l_power_nb /= Void then
					l_power_value := l_power_nb.value.to_double
					if l_power_value = 0.0 then
						il_generator.pop
						il_generator.put_real_64_constant (1.0)
					elseif l_power_value = 1.0 then
					elseif l_power_value = 2.0 then
						il_generator.duplicate_top
						il_generator.generate_binary_operator (il_star, False)
					elseif l_power_value = 3.0 then
						il_generator.duplicate_top
						il_generator.duplicate_top
						il_generator.generate_binary_operator (il_star, False)
						il_generator.generate_binary_operator (il_star, False)
					else
						a_node.right.process (Current)
						il_generator.convert_to_real_64
						il_generator.generate_binary_operator (il_power, False)
					end
				else
					a_node.right.process (Current)
					il_generator.convert_to_real_64
					il_generator.generate_binary_operator (il_power, False)
				end
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_slash_b (a_node: BIN_SLASH_B) is
			-- Process `a_node'.
		do
			if a_node.is_built_in then
				a_node.left.process (Current)
				il_generator.convert_to_real_64
				a_node.right.process (Current)
				il_generator.convert_to_real_64
				il_generator.generate_binary_operator (il_slash, False)
			else
				a_node.nested_b.process (Current)
			end
		end

	process_bin_star_b (a_node: BIN_STAR_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_star)
		end

	process_bin_xor_b (a_node: BIN_XOR_B) is
			-- Process `a_node'.
		do
			generate_converted_binary_b (a_node, il_xor)
		end

	process_bit_const_b (a_node: BIT_CONST_B) is
			-- Process `a_node'.
		local
			l_bit_type: BITS_A
			l_bit_class: CLASS_C
			l_make_feat, l_put_feat: FEATURE_I
			l_decl_type: CL_TYPE_A
			l_values: STRING
			i, nb: INTEGER
		do
			l_bit_type ?= context.real_type (a_node.type)
			l_bit_class := l_bit_type.associated_class
			l_make_feat := l_bit_class.feature_table.item_id ({PREDEFINED_NAMES}.make_name_id)
			l_decl_type := l_bit_type.implemented_type (l_make_feat.origin_class_id)

				-- Creation of BIT object
			l_bit_type.create_info.generate_il

 				-- Call creation procedure of BIT_REF
			il_generator.duplicate_top
			il_generator.put_integer_32_constant (l_bit_type.bit_count)
 			il_generator.generate_feature_access (l_decl_type, l_make_feat.origin_feature_id,
				l_make_feat.argument_count, l_make_feat.has_return_value, True)

				-- Find `put' and call `put' for the sequence.
			l_put_feat := l_bit_class.feature_table.item_id ({PREDEFINED_NAMES}.put_name_id)
			l_decl_type := l_bit_type.implemented_type (l_put_feat.origin_class_id)

			from
				l_values := a_node.value
 				i := 1
 				nb := l_values.count
 			until
 				i = nb
 			loop
 					-- Duplicate top
				il_generator.duplicate_top

 					-- Generate expression
 				il_generator.put_boolean_constant (l_values.item (i) /= '0')
 				il_generator.put_integer_32_constant (i)
 				il_generator.generate_feature_access (l_decl_type, l_put_feat.origin_feature_id,
					l_put_feat.argument_count, l_put_feat.has_return_value, True)
 				i := i + 1
 			end
		end

	process_bool_const_b (a_node: BOOL_CONST_B) is
			-- Process `a_node'.
		do
			il_generator.put_boolean_constant (a_node.value)
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
		do
			-- Nothing to be done, as it is handled in INSPECT_B
		end

	process_char_const_b (a_node: CHAR_CONST_B) is
			-- Process `a_node'.
		do
			if a_node.is_character_32 then
				il_generator.put_natural_32_constant (a_node.value.natural_32_code)
			else
				il_generator.put_character_constant (a_node.value.to_character_8)
			end
		end

	process_char_val_b (a_node: CHAR_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_check_b (a_node: CHECK_B) is
			-- Process `a_node'.
		local
			l_label: IL_LABEL
		do
			process_pragma (a_node)
			if
				a_node.check_list /= Void and then
				(context.workbench_mode or else
					context.class_type.associated_class.assertion_level.is_check)
			then
				l_label := il_generator.create_label
				il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_check)
				il_generator.branch_on_false (l_label)
				il_generator.put_boolean_constant (True)
				il_generator.generate_set_assertion_status
				context.set_assertion_type ({ASSERT_TYPE}.in_check)
				Il_generator.put_silent_line_info (a_node.line_number)
				a_node.check_list.process (Current)
				il_generator.put_boolean_constant (False)
				il_generator.generate_set_assertion_status
				Il_generator.mark_label (l_label)
				check
					end_location_not_void: a_node.end_location /= Void
				end
				il_generator.put_silent_debug_info (a_node.end_location)
			end
		end

	process_constant_b (a_node: CONSTANT_B) is
			-- Process `a_node'.
		do
			is_nested_call := False
			a_node.value.generate_il
		end

	process_creation_expr_b (a_node: CREATION_EXPR_B) is
			-- Process `a_node'.
		local
			l_ext_call: EXTERNAL_B
			l_creation_type: TYPE_A
			l_nested: NESTED_B
			l_is_il_external: BOOLEAN
		do
			is_nested_call := False
			l_creation_type := context.real_type (a_node.type)
			if l_creation_type.is_basic then
				il_generator.put_default_value (l_creation_type)
			elseif l_creation_type.is_external then --or else a_node.call.is_external then
					-- Creation call on external class.
				if a_node.call /= Void then
					create l_nested
					l_nested.set_target (a_node)
					l_nested.set_message (a_node.call)
					a_node.call.set_parent (l_nested)
					is_in_creation_call := True
					a_node.call.process (Current)
					is_in_creation_call := False
					a_node.call.set_parent (Void)
				else
						-- We called `default_create' on an external class.
					a_node.info.generate_il
				end
			else
				l_ext_call ?= a_node.call
				if l_ext_call /= Void then
					l_is_il_external := l_ext_call.extension.is_il
				end
				if not l_is_il_external then
						-- Standard creation call on non-il external.
					a_node.info.generate_il
				end
				if a_node.call /= Void then
					if l_creation_type.is_expanded then
							-- Take an address of a boxed object.
						il_generator.generate_metamorphose (l_creation_type)
						il_generator.generate_load_address (l_creation_type)
					end
					if not l_is_il_external then
						il_generator.duplicate_top
					end

					create l_nested
					l_nested.set_target (a_node)
					l_nested.set_message (a_node.call)
					a_node.call.set_parent (l_nested)
					is_in_creation_call := True
					is_in_external_creation_call := l_is_il_external
					a_node.call.process (Current)
					is_in_external_creation_call := False
					is_in_creation_call := False
					a_node.call.set_parent (Void)
					if l_creation_type.is_expanded then
							-- Load expanded object.
						il_generator.generate_load_from_address (l_creation_type)
					end
				end
			end
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		local
			l_type_i: TYPE_A
			l_is_object_load_required: like is_object_load_required
		do
			if is_nested_call then
				l_is_object_load_required := is_object_load_required
				is_nested_call := False
			else
				l_is_object_load_required := True
			end

			is_this_argument_current := True
			l_type_i := context.real_type (a_node.type)
			if l_is_object_load_required and then l_type_i.is_basic then
				il_generator.generate_current_as_basic
			else
				il_generator.generate_current
				if l_is_object_load_required then
					is_object_load_required := False
					if l_type_i.is_expanded then
						is_this_argument_current := False
						il_generator.generate_load_from_address (l_type_i)
					end
				end
			end
		end

	process_custom_attribute_b (a_node: CUSTOM_ATTRIBUTE_B) is
			-- Process `a_node'.
		do
			-- Generated by CUSTOM_ATTRIBUTE_GENERATOR.
		end

	process_debug_b (a_node: DEBUG_B) is
			-- Process `a_node'.
		do
			process_pragma (a_node)
			if a_node.compound /= Void then
				if a_node.is_debug_clause_enabled then
					generate_il_line_info (a_node, True)
					a_node.compound.process (Current)
					check
						end_location_not_void: a_node.end_location /= Void
					end
					il_generator.put_silent_debug_info (a_node.end_location)
				else
					il_generator.put_ghost_debug_infos (a_node.line_number, a_node.compound.count)
				end
			end
		end

	process_elsif_b (a_node: ELSIF_B) is
			-- Process `a_node'.
		do
			-- Generation done in IF_B
		end

	process_expr_address_b (a_node: EXPR_ADDRESS_B) is
			-- Process `a_node'.
		do
			fixme ("Not supported in .NET")
		end

	process_external_b (a_node: EXTERNAL_B) is
			-- Process `a_node'.
		local
			l_cl_type: CL_TYPE_A
			l_il_ext: IL_EXTENSION_I
			l_return_type: TYPE_A
			l_count: INTEGER
			l_real_metamorphose: BOOLEAN
			l_real_target: ACCESS_B
			l_is_in_creation: like is_in_creation_call
			l_is_nested_call: like is_nested_call
			l_is_in_external_creation_call: like is_in_external_creation_call
		do
			l_is_in_creation := is_in_creation_call
			l_is_nested_call := is_nested_call
			l_is_in_external_creation_call := is_in_external_creation_call
			is_in_creation_call := False
			is_nested_call := False
			is_in_external_creation_call := False
			is_this_argument_current := False

			if not a_node.extension.is_il then
					-- Generate call to C external.
				generate_il_c_call (a_node, not l_is_in_creation)
			else
				l_il_ext ?= a_node.extension
					-- Type of object on which we are performing call to Current.
				l_cl_type ?= a_node.context_type

				check
					il_ext_not_void: l_il_ext /= Void
					cl_type_not_void: l_cl_type /= Void
				end

				if l_cl_type.is_expanded then
					if l_cl_type.associated_class.is_typed_pointer then
							-- Use non-generic class POINTER because TYPED_POINTER is not generated.
						l_cl_type := system.pointer_class.compiled_class.actual_type
					end
						-- Current type is expanded. We need to find out if
						-- we need to generate a box operation, meaning that
						-- the feature is inherited from a non-expanded class.
					l_real_metamorphose := need_real_metamorphose (a_node, l_cl_type)
				end

				if a_node.is_first then
					if need_current (l_il_ext.type) then
							-- First call in dot expression, we need to generate Current
							-- only when we do not call a static feature.
						il_generator.generate_current
					end
				elseif l_cl_type.is_expanded then
					if l_il_ext.type = operator_type then
							-- Operators are static functions, so a value has to be passed rather than an address.
						il_generator.generate_load_from_address (l_cl_type)
					elseif l_il_ext.type /= creator_type and a_node.parent /= Void then
							-- No need to do anything special in case of a call to
							-- a constructor. The generation of `a_node.target' of current call already
							-- did any special transformation to perfom call.
						if a_node.is_message or else a_node.parent.parent = Void then
							l_real_target := a_node.parent.target
						else
							l_real_target := a_node.parent.parent.target
						end
						if l_real_target.is_predefined or l_real_target.is_attribute then
								-- For same reason we don't do anything for a call to
								-- a constructor, when `l_real_target' is predefined or is
								-- an attribute any special transformation have already been done.
							if l_real_metamorphose then
									-- Feature is written in an inherited class of current
									-- expanded class. We need to box.
								il_generator.generate_metamorphose (l_cl_type)
							end
						elseif a_node.written_in /= l_cl_type.class_id then
								-- A call to parent routine.
							generate_il_metamorphose (l_cl_type, Void, l_real_metamorphose)
						end
					end
				end

				if a_node.parameters /= Void then
						-- Generate parameters if any.
					l_count := a_node.parameters.count
					a_node.parameters.process (Current)
				end

				if l_is_in_creation or else l_il_ext.type /= creator_type then
						-- We are not performing a creation call, neither a call
						-- to a constructor.
					if a_node.is_static_call or else a_node.precursor_type /= Void then
							-- A call to precursor or a static call is never polymorphic.
						l_il_ext.generate_call (False)
					elseif l_is_in_external_creation_call then
						l_il_ext.generate_external_creation_call (l_cl_type)
					elseif l_cl_type.is_expanded and then not l_cl_type.is_true_external and then not l_is_in_creation then
							-- The feature is generated in the current class.
						il_generator.generate_feature_access
							(l_cl_type, l_cl_type.associated_class.feature_of_rout_id (a_node.routine_id).feature_id,
							l_count, not context.real_type (a_node.type).is_void, False)
					else
							-- Standard call to an external feature.
						if not l_cl_type.is_enum or else l_il_ext.type /= field_type then
								-- Call will be polymorphic if it target of call is a reference
								-- or if target has been boxed, or if type of external
								-- forces a static binding (eg static features).
							l_il_ext.generate_call (l_cl_type.is_reference or else l_real_metamorphose)
						end
					end
				else
						-- Current external is a creation, we perform a slightly different
						-- call to constructor, but basically it is very close to `generate_call'
						-- but doing a static binding.
					l_il_ext.generate_creation_call
				end
			end
			if l_is_nested_call then
				l_return_type := context.real_type (a_node.type)
				if l_return_type.is_true_expanded and then not l_return_type.associated_class.is_enum then
					generate_il_metamorphose (l_return_type, l_return_type, True)
				end
			end
		end

	process_feature_b (a_node: FEATURE_B) is
			-- Process `a_node'.
		local
			l_cl_type: CL_TYPE_A
			l_orig_return_type, l_return_type: TYPE_A
			l_native_array_class_type: NATIVE_ARRAY_CLASS_TYPE
			l_special_array_class_type: SPECIAL_CLASS_TYPE
			l_is_special_handled: BOOLEAN
			l_invariant_checked: BOOLEAN
			l_class_c: CLASS_C
			l_real_metamorphose: BOOLEAN
			l_need_generation: BOOLEAN
			l_target_type, l_precursor_type: CL_TYPE_A
			l_count: INTEGER
			l_arg_type: CL_TYPE_A
			l_is_call_on_any: BOOLEAN
			l_is_nested_call: like is_nested_call
			l_is_in_creation: like is_in_creation_call
		do
			l_is_in_creation := is_in_creation_call
			l_is_nested_call := is_nested_call
			is_in_creation_call := False
			is_nested_call := False
			is_this_argument_current := False

				-- Get type on which call will be performed.
			l_cl_type ?= a_node.context_type
			check
				valid_type: l_cl_type /= Void
			end

				-- Get the real type of `Precursor'.
			if a_node.precursor_type /= Void then
				l_precursor_type ?= context.real_type (a_node.precursor_type)
			end

				-- Let's find out if we are performing a call on a basic type
				-- or on an enum type. This happens only when we are calling
				-- magically added feature on basic types.
			if il_special_routines.has (a_node, l_cl_type) then
				if a_node.is_first then
						-- Because the code is generated for a basic type,
						-- the value has to be loaded.
					il_generator.generate_current_as_basic
				end
				il_special_routines.generate_il (Current, a_node, l_cl_type, a_node.parameters)
			else
				l_is_call_on_any := a_node.is_any_feature and l_precursor_type = Void
					-- Find location of feature.
				if not l_is_call_on_any and l_cl_type.is_expanded and not l_cl_type.is_true_external then
					if l_cl_type.associated_class.is_typed_pointer then
							-- Use non-generic class POINTER because TYPED_POINTER is not generated.
						l_cl_type := system.pointer_class.compiled_class.actual_type
					end
					l_target_type := l_cl_type
				else
					l_target_type := l_cl_type.implemented_type (a_node.written_in)
				end
				check
					target_type_not_void: l_target_type /= Void
				end

				l_class_c := l_cl_type.associated_class

				if l_class_c.is_native_array then
					check
						not_expanded: not l_cl_type.is_expanded
					end
					l_native_array_class_type ?= l_cl_type.associated_class_type (context.context_class_type.type)
					check
						native_array_class_type_not_void: l_native_array_class_type /= Void
					end
				end

				l_invariant_checked := (context.workbench_mode or
					l_class_c.assertion_level.is_invariant) and then not a_node.is_first
					and then (l_native_array_class_type = Void)

				if l_cl_type.is_expanded then
						-- Current type is expanded. We need to find out if
						-- we need to generate a box operation, meaning that
						-- the feature is inherited from a non-expanded class.
					l_real_metamorphose := need_real_metamorphose (a_node, l_cl_type)
				end

				if a_node.is_first then
						-- First call in dot expression, we need to generate Current
						-- only when we do not call a static feature.
					il_generator.generate_current
				elseif l_cl_type.is_basic then
						-- A metamorphose is required to perform call.
					generate_il_metamorphose (l_cl_type, l_target_type, True)
				end

				if l_invariant_checked then
					generate_il_call_invariant_leading (l_cl_type, not l_is_in_creation)
				end

					-- Box value type if the call is made to the predefined feature from ANY
					-- This has to be done before calculating feature arguments
				if l_is_call_on_any then
					if l_cl_type.is_true_expanded then
						if not l_cl_type.is_enum then
							il_generator.generate_load_from_address (l_cl_type)
						end
						il_generator.generate_metamorphose (l_cl_type)
					elseif l_cl_type.is_basic and then a_node.is_first then
						il_generator.generate_load_from_address_as_object (l_cl_type)
						il_generator.generate_metamorphose (l_cl_type)
					end
				elseif not a_node.is_first and then l_cl_type.is_basic then
						-- Address of a value is required.
						il_generator.generate_load_address (l_cl_type)
				elseif a_node.is_first and then l_precursor_type /= Void and then context.context_class_type.is_expanded then
					check
						precursor_not_expanded: not l_precursor_type.is_expanded
					end
					il_generator.generate_load_from_address (context.context_class_type.type)
					il_generator.generate_metamorphose (context.context_class_type.type)
					il_generator.generate_check_cast (context.context_class_type.type, l_precursor_type)
				end

				if l_class_c.is_special then
					check
						not_expanded: not l_cl_type.is_expanded
					end
					l_special_array_class_type ?= l_cl_type.associated_class_type (context.context_class_type.type)
					check
						special_array_class_type_not_void: l_special_array_class_type /= Void
					end
					inspect
						a_node.feature_name_id
					when
						{PREDEFINED_NAMES}.Item_name_id,
						{PREDEFINED_NAMES}.Infix_at_name_id,
						{PREDEFINED_NAMES}.Put_name_id
					then
						l_special_array_class_type.prepare_generate_il (a_node.feature_name_id, l_cl_type)
						l_is_special_handled := True
					else
					end
				end

				if a_node.parameters /= Void then
						-- Generate parameters if any.
					if
						l_native_array_class_type /= Void and then
						a_node.feature_name_id = {PREDEFINED_NAMES}.put_name_id
					then
						check
							parameters_count_is_two: a_node.parameters.count = 2
						end
						a_node.parameters.i_th (1).process (Current)
						if context.real_type (a_node.parameters.i_th (2).type).is_true_expanded then
							l_native_array_class_type.generate_il_put_preparation (l_cl_type, context.context_class_type.type)
						end
						a_node.parameters.i_th (2).process (Current)
					elseif l_is_call_on_any then
							-- Run-time features work on arguments of reference type only
						from
							a_node.parameters.start
						until
							a_node.parameters.after
						loop
							l_arg_type ?= context.real_type (a_node.parameters.item.attachment_type)
							if l_arg_type /= Void and then l_arg_type.is_expanded then
								generate_expression_il_for_type (a_node.parameters.item,
									l_arg_type.reference_type)
							else
								a_node.parameters.item.process (Current)
							end
							a_node.parameters.forth
						end
					else
						a_node.parameters.process (Current)
					end
					l_count := a_node.parameters.count
				end

				l_return_type := context.real_type (a_node.type)
					-- Special handling when precursor has a different expanded status
					-- than current type. We need to find out the return type of the Precursor.
				if l_precursor_type /= Void and then context.context_class_type.is_expanded then
					context.change_class_type_context (
						l_precursor_type.associated_class_type (context.context_class_type.type),
						l_precursor_type.instantiated_in (context.context_class_type.type),
						l_precursor_type.associated_class_type (context.context_class_type.type),
						l_precursor_type.instantiated_in (context.context_class_type.type))
					l_orig_return_type := context.real_type (a_node.type)
					context.restore_class_type_context
				else
					l_orig_return_type := l_return_type
				end

				l_need_generation := True

				if l_native_array_class_type /= Void then
					l_need_generation := False
					l_native_array_class_type.generate_il (a_node.feature_name_id, l_cl_type, context.context_class_type.type)
					if System.il_verifiable then
						if
							not l_return_type.is_expanded and then
							not l_return_type.is_none and then
							not l_return_type.is_void
						then
							il_generator.generate_check_cast (Void, l_return_type)
						end
					end
				elseif l_is_special_handled then
					l_special_array_class_type.generate_il (a_node.feature_name_id, l_cl_type, context.context_class_type.type)
					l_need_generation := False
					if System.il_verifiable then
						if
							not l_return_type.is_expanded and then
							not l_return_type.is_none and then
							not l_return_type.is_void
						then
							il_generator.generate_check_cast (Void, l_return_type)
						end
					end
				end

				if l_need_generation then
						-- Perform call to feature
					if l_is_call_on_any then
						generate_il_any_call (a_node, l_target_type, l_cl_type,
							l_cl_type.is_reference or else l_real_metamorphose)
					else
						if l_cl_type.is_true_expanded then
							generate_il_normal_call (a_node, l_cl_type, False)
						else
							generate_il_normal_call (a_node, l_target_type,
								l_cl_type.is_reference or else l_real_metamorphose)
						end
					end
				end
				if l_invariant_checked then
					generate_il_call_invariant_trailing (l_cl_type, l_return_type)
				end

				if
					l_precursor_type /= Void and then l_orig_return_type /= l_return_type and then
					not l_orig_return_type.is_expanded and then l_return_type.is_expanded
				then
						-- Return type of precursor is not expanded, we need to make
						-- an expanded out of it. Because the way it works, the value
						-- we get from the Precursor call must be a boxed value.
					il_generator.generate_check_cast (l_orig_return_type, l_return_type)
					il_generator.generate_load_address (l_return_type)
					il_generator.generate_load_from_address (l_return_type)
				elseif l_is_nested_call then
					l_return_type := context.real_type (a_node.type)
					if l_return_type.is_true_expanded and then not l_return_type.associated_class.is_enum then
							-- Pointer to value type is required.
							generate_il_metamorphose (l_return_type, l_return_type, True)
					end
				end
			end
		end

	process_agent_call_b (a_node: AGENT_CALL_B) is
		do
			process_feature_b (a_node)
		end

	process_formal_conversion_b (a_node: FORMAL_CONVERSION_B) is
			-- Process `a_node'.
		local
			l_type: TYPE_A
			l_expr_type: TYPE_A
		do
				-- Generate expression
			a_node.expr.process (Current)

				-- Check if conversion expanded -> reference is needed in
				-- case we assign an expression whose type is a formal generic
				-- parameter of the current class to a reference type whose
				-- formal's constraint conforms to.
			l_type := context.real_type (a_node.type)
			l_expr_type := context.real_type (a_node.expr.type)

			if a_node.is_conversion_needed (l_expr_type, l_type) then
				if a_node.is_boxing or else not l_expr_type.is_basic then
					il_generator.generate_metamorphose (l_expr_type)
				else
					generate_il_eiffel_metamorphose (l_expr_type)
				end
			end
		end

	process_hector_b (a_node: HECTOR_B) is
			-- Process `a_node'.
		do
			cil_access_address_generator.generate_il_address (il_generator, a_node.expr)
		end

	process_if_b (a_node: IF_B) is
			-- Process `a_node'.
		local
			l_elsif_clause: ELSIF_B
			l_cmp: BYTE_LIST [BYTE_NODE]
			l_else_label, l_end_label, l_elsif_label: IL_LABEL
			l_has_elses: BOOLEAN
		do
			l_has_elses := a_node.else_part /= Void or a_node.elsif_list /= Void

			generate_il_line_info (a_node, True)
			process_pragma (a_node)

				-- Generated byte code for condition
			a_node.condition.process (Current)

				-- Generated a test
			l_else_label := il_generator.create_label
			il_generator.branch_on_false (l_else_label)

			if a_node.compound /= Void then
					-- Generated IL code for first compound (if any).
				a_node.compound.process (Current)
			end

			if l_has_elses then
				l_end_label := il_generator.create_label
				il_generator.branch_to (l_end_label)
			end

				-- Else label
			il_generator.mark_label (l_else_label)

			if a_node.elsif_list /= Void then
					-- Generates IL code for alternatives
				from
					a_node.elsif_list.start
				until
					a_node.elsif_list.after
				loop
					l_elsif_clause ?= a_node.elsif_list.item
						-- Generate byte code for expression
					generate_il_line_info (l_elsif_clause, True)
					l_elsif_clause.expr.process (Current)

						-- Test if False
					l_elsif_label := il_generator.create_label
					il_generator.branch_on_false (l_elsif_label)

					l_cmp := l_elsif_clause.compound
					if l_cmp /= Void then
							-- Generate alternative compound byte code
						l_cmp.process (Current)
					end

					il_generator.branch_to (l_end_label)

					il_generator.mark_label (l_elsif_label)
					a_node.elsif_list.forth
				end
			end

			if a_node.else_part /= Void then
					-- Generates byte code for default compound.
				a_node.else_part.process (Current)
			end

			if l_has_elses then
					-- End of `if' statement.
				il_generator.mark_label (l_end_label)
			end

			check
				end_location_not_void: a_node.end_location /= Void
			end

			il_generator.put_silent_debug_info (a_node.end_location)
		end

	process_inspect_b (a_node: INSPECT_B) is
			-- Process `a_node'.
		local
			l_else_label: IL_LABEL
			l_end_label: IL_LABEL
			l_intervals: SORTED_TWO_WAY_LIST [INTERVAL_B]
			l_spans: ARRAYED_LIST [INTERVAL_SPAN]
			inspect_type: TYPE_A
			l_cl_type_i: CL_TYPE_A
			min_value: INTERVAL_VAL_B
			max_value: INTERVAL_VAL_B
			labels: ARRAY [IL_LABEL]
		do
			l_else_label := il_generator.create_label
			l_end_label := il_generator.create_label
			generate_il_line_info (a_node, True)
			process_pragma (a_node)

			if not a_node.switch.is_fast_as_local then
					-- Generate switch expression byte code
				a_node.switch.process (Current)
			end

			if a_node.case_list /= Void then
					-- Sort and merge intervals
				l_intervals := create_sorted_interval_list (a_node)
				merge_intervals (a_node, l_intervals)
				if l_intervals.count > 0 then
						-- Calculate minimum and maximum values
					inspect_type := a_node.switch.type
					l_cl_type_i ?= inspect_type
					if l_cl_type_i /= Void and then l_cl_type_i.is_enum then
						create {INT_VAL_B} min_value.make ({INTEGER_32}.min_value)
						create {INT_VAL_B} max_value.make ({INTEGER_32}.max_value)
					else
						min_value := inspect_type.minimum_interval_value
						max_value := inspect_type.maximum_interval_value
					end

						-- Make sure there are no different objects for the same boundary
					if l_intervals.first.lower.is_equal (min_value) then
						min_value := l_intervals.first.lower
					end
					if l_intervals.last.upper.is_equal (max_value) then
						max_value := l_intervals.last.upper
					end
						-- Group intervals
					l_spans := build_spans (a_node, l_intervals, min_value, max_value)
						-- Create array of labels for all cases and put `l_else_label' to position 0
					create labels.make (-1, a_node.case_list.count)
					labels.put (l_end_label, -1)
					labels.put (l_else_label, 0)
					generate_spans (a_node, l_spans, 1, l_spans.count, min_value, max_value, True, True, labels)
				end
			end

			il_generator.mark_label (l_else_label)
			if a_node.else_part /= Void then
				a_node.else_part.process (Current)
			else
				il_generator.generate_raise_exception ({EXCEP_CONST}.incorrect_inspect_value, Void)
					-- Throw an exception
			end

			il_generator.mark_label (l_end_label)

			if not a_node.switch.is_fast_as_local then
					-- Either there was nothing in the inspect and therefore we need to
					-- pop the value on which we were inspecting as it is not used. Or if
					-- there was some `when' parts we need to remove the duplication made
					-- for case comparison.
				il_generator.pop
			end

			check
				end_location_not_void: a_node.end_location /= Void
			end

			il_generator.put_silent_debug_info (a_node.end_location)
		end

	process_instr_call_b (a_node: INSTR_CALL_B) is
			-- Process `a_node'.
		do
			generate_il_line_info (a_node, True)
			process_pragma (a_node)
			a_node.call.process (Current)
		end

	process_instr_list_b (a_node: INSTR_LIST_B) is
			-- Process `a_node'.
		do
			process_pragma (a_node)
			a_node.compound.process (Current)
		end

	process_int64_val_b (a_node: INT64_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_int_val_b (a_node: INT_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_integer_constant (a_node: INTEGER_CONSTANT) is
			-- Process `a_node'.
		do
			a_node.generate_il
		end

	process_inv_assert_b (a_node: INV_ASSERT_B) is
			-- Process `a_node'.
		do
			process_assert_b (a_node)
		end

	process_invariant_b (a_node: INVARIANT_B) is
			-- Process `a_node'.
		do
			context.local_list.wipe_out
			context.set_assertion_type ({ASSERT_TYPE}.in_invariant)

			context.set_original_body_index (a_node.associated_class.invariant_feature.body_index)

				-- Allocate memory for once manifest strings if required
			if a_node.once_manifest_string_count > 0 then
				il_generator.generate_once_string_allocation (a_node.once_manifest_string_count)
			end

			il_generator.generate_invariant_body (a_node.byte_list)
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			if need_access_address (a_node, is_nested_call) then
				il_generator.generate_local_address (a_node.position)
			else
				il_generator.generate_local (a_node.position)
			end
			is_nested_call := False
		end

	process_loop_b (a_node: LOOP_B) is
			-- Process `a_node'.
		local
			l_test_label, l_end_label, l_label: IL_LABEL
			l_local_list: LINKED_LIST [TYPE_A]
			l_variant_local_number: INTEGER
			l_check_assertion: BOOLEAN
		do
			l_check_assertion := context.workbench_mode or
				Context.class_type.associated_class.assertion_level.is_loop

			if a_node.from_part /= Void then
					-- Generate IL code for the from part
				a_node.from_part.process (Current)
			end

			if l_check_assertion and then a_node.variant_part /= Void then
					-- Initialization of the variant control variable
				l_local_list := context.local_list
				context.add_local (integer_32_type)
				l_variant_local_number := l_local_list.count
				il_generator.put_dummy_local_info (a_node.variant_part.type, l_variant_local_number)
			end

			if l_check_assertion and then (a_node.invariant_part /= Void or else a_node.variant_part /= Void) then
				l_label := il_generator.create_label
				il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_loop)
				il_generator.branch_on_false (l_label)
				il_generator.put_boolean_constant (True)
				il_generator.generate_set_assertion_status
				if a_node.invariant_part /= Void then
					context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					a_node.invariant_part.process (Current)
				end
					-- Variant loop byte code
				if a_node.variant_part /= Void then
					context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					generate_il_variant_init (a_node.variant_part, l_variant_local_number)
				end
				il_generator.put_boolean_constant (False)
				il_generator.generate_set_assertion_status
				il_generator.mark_label (l_label)
			end

				-- Loop labels
			l_test_label := il_generator.create_label
			l_end_label := il_generator.create_label

			generate_il_line_info (a_node, True)
			process_pragma (a_node)

				-- Generate byte code for exit expression
			il_generator.mark_label (l_test_label)

			a_node.stop.process (Current)

				-- Generate a test
			il_generator.branch_on_true (l_end_label)

			if a_node.compound /= Void then
				a_node.compound.process (Current)
			end

			if l_check_assertion and then (a_node.invariant_part /= Void or else a_node.variant_part /= Void) then
				l_label := il_generator.create_label
				il_generator.generate_is_assertion_checked ({ASSERTION_I}.Ck_loop)
				il_generator.branch_on_false (l_label)
				il_generator.put_boolean_constant (True)
				il_generator.generate_set_assertion_status

					-- Invariant loop byte code
				if a_node.invariant_part /= Void then
					context.set_assertion_type ({ASSERT_TYPE}.in_loop_invariant)
					a_node.invariant_part.process (Current)
				end

					-- Variant loop byte code
				if a_node.variant_part /= Void then
					context.set_assertion_type ({ASSERT_TYPE}.in_loop_variant)
					generate_il_variant_check (a_node.variant_part, l_variant_local_number)
				end
				il_generator.put_boolean_constant (False)
				il_generator.generate_set_assertion_status
				il_generator.mark_label (l_label)
			end

			il_generator.branch_to (l_test_label)

			il_generator.mark_label (l_end_label)
			check
				end_location_not_void: a_node.end_location /= Void
			end

			il_generator.put_silent_debug_info (a_node.end_location)

		end

	process_nat64_val_b (a_node: NAT64_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_nat_val_b (a_node: NAT_VAL_B) is
			-- Process `a_node'.
		do
		end

	process_nested_b (a_node: NESTED_B) is
			-- Process `a_node'.
		local
			l_can_discard_target: BOOLEAN
			l_is_target_generated: BOOLEAN
			l_call_access: CALL_ACCESS_B
			l_attr: ATTRIBUTE_B
			l_cl_type: CL_TYPE_A
			l_local_number: INTEGER
			l_type: TYPE_A
			l_need_attribute_to_be_assigned_back: BOOLEAN
			l_external: EXTERNAL_B
		do
			is_object_load_required := False
			l_can_discard_target := not a_node.message.need_target

			if l_can_discard_target then
					-- If we have a constant or a static external call,
					-- we can forget about the generation of `a_node.target' only
					-- if it is not a routine call. If the generation
					-- of `a_node.target' occurred, we need to pop from
					-- execution stack the value returned by `a_node.target'
					-- because it is not needed to perform the call to `a_node.message'.
				l_is_target_generated := (not a_node.target.is_predefined and
					(a_node.parent /= Void or not a_node.target.is_attribute))
			else
				l_is_target_generated := True
			end

			if l_is_target_generated then
					-- We pass `True' to force a special treatment on
					-- generation of `a_node.target' if it is an expanded object.
					-- Namely if `a_node.target' is predefined we will load
					-- the address of `a_node.target' instead of `a_node.target' itself.
					-- `a_node.message' will manage the boxing operation if needed.
				is_nested_call := True
				a_node.target.process (Current)
				is_nested_call := False
					-- In case of attributes which requires their address to be loaded
					-- to perform the call, we check wether or not the value needs to be
					-- assigned back to the attribute or not, that is to say if they
					-- are first in the call chain.
					-- If it does then its address was loaded in previous call to `a_node.target', so
					-- we need to duplicate it.
				l_attr ?= a_node.target
				if l_attr /= Void then
					l_need_attribute_to_be_assigned_back := need_access_address (l_attr, True) and then
						l_attr.is_first and then not context.context_class_type.is_generated_as_single_type
					if l_need_attribute_to_be_assigned_back then
						il_generator.duplicate_top
					end
				end
			end

			l_call_access ?= a_node.message

			if l_can_discard_target and l_is_target_generated then
				il_generator.pop
				l_external ?= l_call_access
				if l_external /= Void then
						-- Modify call so that we do it as if it was a static call.
						-- This is ok because eventhough the code looks like:
						-- f.static_external (args) where f is of type A
						-- it should have been written as:
						-- {A}.static_external (args)
					l_external.enable_static_call
					l_external.set_parent (Void)
				end
			end

				-- Generate call
			if l_call_access /= Void then
				l_call_access.process (Current)
			else
				a_node.message.process (Current)
			end
			if l_need_attribute_to_be_assigned_back then
				l_type := context.real_type (a_node.message.type)
				if not l_type.is_void then
					context.add_local (l_type)
					l_local_number := context.local_list.count
					il_generator.put_dummy_local_info (l_type, l_local_number)
					il_generator.generate_local_assignment (l_local_number)
				end
				l_cl_type ?= l_attr.context_type
				il_generator.generate_expanded_attribute_assignment (
					l_cl_type.implemented_type (l_attr.written_in),
					context.real_type (l_attr.type),
					l_attr.attribute_id)
				if not l_type.is_void then
					il_generator.generate_local (l_local_number)
				end
			end
		end

	process_object_test_b (a_node: OBJECT_TEST_B) is
			-- Process `a_node'.
		local
			l_target_type, l_source_type: TYPE_A
			l_source_class_type: CL_TYPE_A
			l_target_class_type: CL_TYPE_A
			success_label, failure_label: IL_LABEL
			basic_failure_label: IL_LABEL
		do
				-- Get types
			l_target_type := a_node.target.type
			if l_target_type.is_formal then
				l_target_type := context.creation_type (l_target_type)
			end
			l_source_type := context.real_type (a_node.expression.type)
			check
				target_type_not_void: l_target_type /= Void
				source_type_not_void: l_source_type /= Void
			end

				-- FIXME: At the moment we don't know how to
				-- find out the real type of the generic
				-- parameter, so we cheat.
			l_target_type := context.real_type (l_target_type)

				-- Generate expression byte code
			is_object_load_required := True
			a_node.expression.process (Current)
			is_object_load_required := False

			l_target_class_type ?= l_target_type
			if
				l_target_class_type /= Void and then
				l_target_class_type.associated_class.is_typed_pointer and then not
				l_source_type.same_as (l_target_type)
			then
					-- Objcet test for TYPED_POINTER fails
					-- if the source is not of the same type as the target.
					-- Remove expression value because it is not used.
				il_generator.pop
					-- Types do not conform.
				il_generator.put_boolean_constant (False)
			elseif l_source_type.is_expanded and then l_target_type.is_expanded then
					-- NOOP if classes are different or normal assignment otherwise.
				l_source_class_type ?= l_source_type
				if
					l_target_class_type /= Void and then l_source_class_type /= Void and then
					l_target_class_type.class_id = l_source_class_type.class_id
				then
						-- Do normal assignment.
					generate_reattachment (a_node.expression, l_source_type, l_target_type)
						-- Generate assignment header depending of the type
						-- of the target (local, attribute or result).
					generate_il_assignment (a_node.target, l_source_type)
						-- Types conform.
					il_generator.put_boolean_constant (True)
				else
						-- Remove expression value because it is not used.
					il_generator.pop
						-- Types do not conform.
					il_generator.put_boolean_constant (False)
				end
			else
				if l_source_type.is_expanded then
					l_source_class_type ?= l_source_type
					if l_source_class_type /= Void and then l_source_class_type.associated_class.is_typed_pointer then
							-- Use non-generic class POINTER because TYPED_POINTER is not generated.
						l_source_type := system.pointer_class.compiled_class.actual_type
					end
					generate_il_metamorphose (l_source_type, l_target_type, True)
				end

					-- Generate Test on type
				il_generator.generate_is_instance_of (l_target_type)
				il_generator.duplicate_top

				failure_label := il_generator.create_label
				success_label := il_generator.create_label
				il_generator.branch_on_true (success_label)

					-- Assignment attempt failed.

				l_target_class_type ?= l_target_type
				if l_target_class_type /= Void and then l_target_class_type.is_basic and then l_target_class_type.generics = Void then
						-- Check native .NET type.
						-- Generate Test on type
					il_generator.generate_is_instance_of_external (l_target_class_type)
					il_generator.duplicate_top
					basic_failure_label := il_generator.create_label
					il_generator.branch_on_false (basic_failure_label)
						-- Generate reattachment.
					il_generator.generate_external_unmetamorphose (l_target_class_type)
						-- Generate assignment header depending of the type
						-- of the target (local, attribute or result).
					generate_il_assignment (a_node.target, l_source_type)
						-- Types conform.
					il_generator.put_boolean_constant (True)
						-- Terminate reattachment.
					il_generator.branch_to (failure_label)
					il_generator.mark_label (basic_failure_label)
				end

					-- Types do not conform.
				il_generator.pop
				il_generator.put_boolean_constant (False)
				il_generator.branch_to (failure_label)

				il_generator.mark_label (success_label)

				generate_reattachment (a_node.expression, l_source_type, l_target_type)

					-- Generate assignment header depending of the type
					-- of the target (local, attribute or result).
				generate_il_assignment (a_node.target, l_source_type)

					-- Types conform.
				il_generator.put_boolean_constant (True)

				il_generator.mark_label (failure_label)
			end
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B) is
		do
			if need_access_address (a_node, is_nested_call) then
				il_generator.generate_local_address (context.object_test_local_position (a_node))
			else
				il_generator.generate_local (context.object_test_local_position (a_node))
			end
			is_nested_call := False
		end

	process_once_string_b (a_node: ONCE_STRING_B) is
			-- Process `a_node'.
		do
			il_generator.generate_once_string (a_node.number - 1, a_node.value, a_node.is_dotnet_string)
		end

	process_operand_b (a_node: OPERAND_B) is
			-- Process `a_node'.
		do
			is_nested_call := False
		end

	process_parameter_b (a_node: PARAMETER_B) is
			-- Process `a_node'.
		local
			target_type: TYPE_A
		do
			is_last_argument_current := is_this_argument_current
			is_this_argument_current := False
			target_type := context.real_type (a_node.attachment_type)
			generate_expression_il_for_type (a_node.expression, target_type)
			generate_reattachment (a_node.expression, context.real_type (a_node.type), target_type)
		end

	process_paran_b (a_node: PARAN_B) is
			-- Process `a_node'.
		do
			a_node.expr.process (Current)
			is_object_load_required := False
		end

	process_real_const_b (a_node: REAL_CONST_B) is
			-- Process `a_node'.
		do
			if a_node.real_size = 64 then
				il_generator.put_real_64_constant (a_node.value.to_double)
			else
				il_generator.put_real_32_constant (a_node.value.to_real)
			end
		end

	process_require_b (a_node: REQUIRE_B) is
		do
			process_assert_b (a_node)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			if need_access_address (a_node, is_nested_call) then
				il_generator.generate_result_address
			else
				il_generator.generate_result
			end
			is_nested_call := False
		end

	process_retry_b (a_node: RETRY_B) is
			-- Process `a_node'.
		do
			generate_il_line_info (a_node, True)
			process_pragma (a_node)
			il_generator.generate_leave_to (retry_label)
		end

	process_reverse_b (a_node: REVERSE_B) is
			-- Process `a_node'.
		local
			l_target_type, l_source_type: TYPE_A
			l_source_class_type: CL_TYPE_A
			l_target_class_type: CL_TYPE_A
			success_label, failure_label: IL_LABEL
			basic_failure_label: IL_LABEL
		do
			generate_il_line_info (a_node, True)
			process_pragma (a_node)

				-- Code that needs to be generated when performing
				-- assignment to an attribute.
			generate_il_start_assignment (a_node.target)

				-- Get types
			l_target_type := a_node.target.type
			if l_target_type.is_formal then
				l_target_type := context.creation_type (l_target_type)
			end
			l_source_type := context.real_type (a_node.source.type)
			check
				target_type_not_void: l_target_type /= Void
				source_type_not_void: l_source_type /= Void
			end

				-- FIXME: At the moment we don't know how to
				-- find out the real type of the generic
				-- parameter, so we cheat.
			l_target_type := context.real_type (l_target_type)

				-- Generate expression byte code
			is_object_load_required := True
			a_node.source.process (Current)
			is_object_load_required := False

			l_target_class_type ?= l_target_type
			if
				l_target_class_type /= Void and then
				l_target_class_type.associated_class.is_typed_pointer and then not
				l_source_type.same_as (l_target_type)
			then
					-- Reverse reattachment to TYPED_POINTER is NOOP
					-- if the source is not of the same type as the target.
					-- Remove expression value because it is not used.
				il_generator.pop
					-- Avoid reattachment altogether.
				generate_il_cancel_assignment (a_node.target)
			elseif l_source_type.is_expanded and then l_target_type.is_expanded then
					-- NOOP if classes are different or normal assignment otherwise.
				l_source_class_type ?= l_source_type
				if
					l_target_class_type /= Void and then l_source_class_type /= Void and then
					l_target_class_type.class_id = l_source_class_type.class_id
				then
						-- Do normal assignment.
					generate_reattachment (a_node.source, l_source_type, l_target_type)
						-- Generate assignment header depending of the type
						-- of the target (local, attribute or result).
					generate_il_assignment (a_node.target, l_source_type)
				else
						-- Remove expression value because it is not used.
					il_generator.pop
						-- Avoid reattachment altogether.
					generate_il_cancel_assignment (a_node.target)
				end
			else
				if l_source_type.is_expanded then
					l_source_class_type ?= l_source_type
					if l_source_class_type /= Void and then l_source_class_type.associated_class.is_typed_pointer then
							-- Use non-generic class POINTER because TYPED_POINTER is not generated.
						l_source_type := system.pointer_class.compiled_class.actual_type
					end
					generate_il_metamorphose (l_source_type, l_target_type, True)
				end

				if l_target_type.is_expanded then
						-- Conditional branch is used to avoid reattachment
						-- if the types do not conform.
					il_generator.duplicate_top
				end

					-- Generate Test on type
				il_generator.generate_is_instance_of (l_target_type)

				if l_target_type.is_expanded then

					failure_label := il_generator.create_label
					success_label := il_generator.create_label
					il_generator.branch_on_true (success_label)

						-- Assignment attempt failed.

					l_target_class_type ?= l_target_type
					if l_target_class_type /= Void and then l_target_class_type.is_basic and then l_target_class_type.generics = Void then
							-- Check native .NET type.
							-- Generate Test on type
						il_generator.generate_is_instance_of_external (l_target_class_type)
						il_generator.duplicate_top
						basic_failure_label := il_generator.create_label
						il_generator.branch_on_false (basic_failure_label)
							-- Generate reattachment.
						il_generator.generate_external_unmetamorphose (l_target_class_type)
							-- Generate assignment header depending of the type
							-- of the target (local, attribute or result).
						generate_il_assignment (a_node.target, l_source_type)
							-- Terminate reattachment.
						il_generator.branch_to (failure_label)
						il_generator.mark_label (basic_failure_label)
					end

						-- Remove duplicate obtained from call to `isinst'.
					il_generator.pop
						-- Avoid reattachment altogether.
					generate_il_cancel_assignment (a_node.target)

					il_generator.branch_to (failure_label)

					il_generator.mark_label (success_label)
				end

				generate_reattachment (a_node.source, l_source_type, l_target_type)

					-- Generate assignment header depending of the type
					-- of the target (local, attribute or result).
				generate_il_assignment (a_node.target, l_source_type)

				if failure_label /= Void then
					il_generator.mark_label (failure_label)
				end
			end
		end

	process_routine_creation_b (a_node: ROUTINE_CREATION_B) is
			-- Process `a_node'.
		local
			l_set_rout_disp_feat: FEATURE_I
			l_real_ty: GEN_TYPE_A
			l_decl_type, l_cl_type: CL_TYPE_A
		do
			l_real_ty ?= context.real_type (a_node.type)
			(create {CREATE_TYPE}.make (l_real_ty)).generate_il
			il_generator.duplicate_top

			l_set_rout_disp_feat := l_real_ty.associated_class.feature_table.
				item_id ({PREDEFINED_NAMES}.set_rout_disp_name_id)
			l_decl_type := l_real_ty.implemented_type (l_set_rout_disp_feat.origin_class_id)

			l_cl_type ?= context.real_type (a_node.class_type)
			if a_node.is_inline_agent then
				il_generator.put_impl_method_token (l_cl_type.implemented_type (a_node.origin_class_id),
					a_node.feature_id)
			else
				il_generator.put_method_token (l_cl_type.implemented_type (a_node.origin_class_id),
					a_node.feature_id)
			end
				-- Arguments
			if a_node.arguments /= Void then
				a_node.arguments.process (Current)
			else
				il_generator.put_void
			end

				-- Open map
			if a_node.open_positions /= Void then
				a_node.open_positions.process (Current)
			else
				il_generator.put_void
			end

			il_generator.put_boolean_constant (a_node.is_inline_agent)

			il_generator.generate_feature_access (l_decl_type, l_set_rout_disp_feat.origin_feature_id,
				l_set_rout_disp_feat.argument_count, l_set_rout_disp_feat.has_return_value, True)
		end

	process_string_b (a_node: STRING_B) is
			-- Process `a_node'.
		do
			if a_node.is_dotnet_string then
				il_generator.put_system_string (a_node.value)
			else
				il_generator.put_manifest_string (a_node.value)
			end
		end

	process_strip_b (a_node: STRIP_B) is
			-- Process `a_node'.
		do
			check
				not_implemented: False
			end
		end

	process_tuple_access_b (a_node: TUPLE_ACCESS_B) is
			-- Process `a_node'.
		local
			l_feat_tbl: FEATURE_TABLE
			l_decl_type: CL_TYPE_A
			l_actual_type: CL_TYPE_A
			l_real_ty: TUPLE_TYPE_A
			l_tuple_element_type: TYPE_A
			l_item_feat, l_put_feat: FEATURE_I
		do
			l_real_ty ?= context.real_type (a_node.tuple_type)
			l_feat_tbl := l_real_ty.associated_class.feature_table
			if a_node.source /= Void then
				generate_il_line_info (a_node, True)
				a_node.source.process (Current)
				l_actual_type ?= context.real_type (a_node.source.type)

				if l_actual_type /= Void and then l_actual_type.is_expanded then
					il_generator.generate_external_metamorphose (l_actual_type)
				end

				il_generator.put_integer_32_constant (a_node.position)

					-- Find `put' from TUPLE
				l_put_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.put_name_id)
				l_decl_type := l_real_ty.implemented_type (l_put_feat.origin_class_id)
					-- Call `put' from TUPLE
				il_generator.generate_feature_access (l_decl_type, l_put_feat.origin_feature_id, l_put_feat.argument_count, l_put_feat.has_return_value, True)
			else
				il_generator.put_integer_32_constant (a_node.position)

					-- Find `fast_item' from TUPLE
				l_item_feat := l_feat_tbl.item_id (fast_item_name_id)
				l_decl_type := l_real_ty.implemented_type (l_item_feat.origin_class_id)
					-- Call `fast_item' from TUPLE
				il_generator.generate_feature_access (l_decl_type, l_item_feat.origin_feature_id, l_item_feat.argument_count, l_item_feat.has_return_value, True)

				l_tuple_element_type := a_node.tuple_element_type
				if l_tuple_element_type.is_expanded then
					l_actual_type ?= l_tuple_element_type
					if l_actual_type /= Void then
						il_generator.generate_external_unmetamorphose (l_actual_type)
					else
						il_generator.generate_unmetamorphose (l_tuple_element_type)
					end
				elseif System.il_verifiable and then not l_tuple_element_type.is_none then
					il_generator.generate_check_cast (Void, l_tuple_element_type)
				end
			end
		end

	process_tuple_const_b (a_node: TUPLE_CONST_B) is
			-- Process `a_node'.
		local
			l_real_ty: GEN_TYPE_A
			l_decl_type: CL_TYPE_A
			l_actual_type: CL_TYPE_A
			l_expr: EXPR_B
			i: INTEGER
			l_feat_tbl: FEATURE_TABLE
			l_make_feat, l_put_feat: FEATURE_I
		do
			l_real_ty ?= context.real_type (a_node.type)
			l_feat_tbl := l_real_ty.associated_class.feature_table
			l_make_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.default_create_name_id)
			l_decl_type := l_real_ty.implemented_type (l_make_feat.origin_class_id)

				-- Creation of Array
			(create {CREATE_TYPE}.make (l_real_ty)).generate_il

				-- Call creation procedure of TUPLE
			il_generator.duplicate_top
 			il_generator.generate_feature_access (l_decl_type, l_make_feat.origin_feature_id,
 				l_make_feat.argument_count, l_make_feat.has_return_value, True)

				-- Find `put' from TUPLE
			l_put_feat := l_feat_tbl.item_id ({PREDEFINED_NAMES}.put_name_id)
			l_decl_type := l_real_ty.implemented_type (l_put_feat.origin_class_id)

 			from
 				a_node.expressions.start
 				i := 1
 			until
 				a_node.expressions.after
 			loop
 				l_expr ?= a_node.expressions.item
 				l_actual_type ?= context.real_type (l_expr.type)

 					-- Prepare call to `put'.
				il_generator.duplicate_top

 					-- Generate expression
 				l_expr.process (Current)
 				if l_actual_type /= Void and then l_actual_type.is_expanded then
 						-- We generate a metamorphosed version of type.
 					il_generator.generate_external_metamorphose (l_actual_type)
 				end

 				il_generator.put_integer_32_constant (i)

 				il_generator.generate_feature_access (l_decl_type, l_put_feat.origin_feature_id,
 					l_put_feat.argument_count, l_put_feat.has_return_value, True)
 				i := i + 1
 				a_node.expressions.forth
 			end
		end

	process_type_expr_b (a_node: TYPE_EXPR_B) is
			-- Process `a_node'.
		local
			l_type_creator: CREATE_TYPE
		do
			if a_node.is_dotnet_type then
				il_generator.put_type_instance (
					context.real_type (a_node.type_data.generics.item (1)))
			else
				fixme ("Instance should be unique.")
				create l_type_creator.make (context.real_type (a_node.type_data))
				l_type_creator.generate_il
			end

		end

	process_typed_interval_b (a_node: TYPED_INTERVAL_B [INTERVAL_VAL_B]) is
			-- Process `a_node'.
		do
		end

	process_un_free_b (a_node: UN_FREE_B) is
			-- Process `a_node'.
		do
			a_node.nested_b.process (Current)
		end

	process_un_minus_b (a_node: UN_MINUS_B) is
			-- Process `a_node'.
		do
			generate_unary_b (a_node, il_uminus)
		end

	process_un_not_b (a_node: UN_NOT_B) is
			-- Process `a_node'.
		do
			generate_unary_b (a_node, il_not)
		end

	process_un_old_b (a_node: UN_OLD_B) is
			-- Process `a_node'.
		do
			il_generator.generate_raising_old_exception (a_node.exception_position)
			il_generator.generate_local (a_node.position)
		end

	process_un_plus_b (a_node: UN_PLUS_B) is
			-- Process `a_node'.
		do
			generate_unary_b (a_node, il_uplus)
		end

	process_variant_b (a_node: VARIANT_B) is
			-- Process `a_node'.
		do
			process_assert_b (a_node)
		end

	process_void_b (a_node: VOID_B) is
			-- Process `a_node'.
		do
			il_generator.put_void
		end

feature {NONE} -- Implementation

	need_access_address (a_node: ACCESS_B; a_is_target_of_call: BOOLEAN): BOOLEAN is
			-- Does `a_node' access need its address loaded in memory?
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		local
			l_cl_type: CL_TYPE_A
			l_call_access: CALL_ACCESS_B
			l_nested: NESTED_B
			l_constant: CONSTANT_B
			l_ext: EXTERNAL_B
			l_il_ext: IL_EXTENSION_I
			l_feature_b: FEATURE_B
		do
			if a_is_target_of_call then
				l_cl_type ?= context.real_type (a_node.type)
				Result := l_cl_type /= Void and then l_cl_type.is_true_expanded and then not l_cl_type.is_enum

				if Result then
					l_call_access ?= a_node.parent.message

					if l_call_access = Void then
							-- Find out if it is a nested call.
						l_nested ?= a_node.parent.message

						if l_nested = Void then
							l_constant ?= a_node.parent.message
							check
									-- It has to be a constant access, as otherwise
									-- it means the original code was not Eiffel code.
								l_constant_not_void: l_constant /= Void
							end
							l_call_access ?= l_constant.access
						else
							l_call_access ?= l_nested.target
						end
					end

						-- We do not load the address if it is an optimized call of the compiler.
					l_feature_b ?= l_call_access
					Result := l_feature_b = Void or else not il_special_routines.has (l_feature_b, l_cl_type)
					if Result then
						l_ext ?= l_call_access
						if l_ext /= Void then
							l_il_ext ?= l_ext.extension
							Result := l_il_ext = Void or else l_il_ext.type /=
								{SHARED_IL_CONSTANTS}.Operator_type
						end
					end
				end
			end
		end

	generate_expression_il_for_type (a_node: EXPR_B; a_target_type: TYPE_A) is
			-- Generate IL code for `expression' that is attached
			-- or compared to the target of type `a_target_type'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			target_type_not_void: a_target_type /= Void
		local
			l_expression_type: TYPE_A
			l_cl_type: CL_TYPE_A
		do
			is_object_load_required := True
			a_node.process (Current)
			is_object_load_required := False
			l_expression_type := context.real_type (a_node.type)
			if a_target_type.is_reference and then l_expression_type.is_expanded then
				l_cl_type ?= l_expression_type
				if not l_expression_type.is_basic then
						-- Simply box the object.
					il_generator.generate_metamorphose (l_expression_type)
				else
					if l_cl_type.associated_class.is_typed_pointer then
							-- Use POINTER instead of TYPED_POINTER.
						l_cl_type := system.pointer_class.compiled_class.actual_type
						l_expression_type := l_cl_type
					end
					if not a_target_type.is_external or else l_cl_type.generics /= Void then
							-- Basic type is attached to Eiffel reference type,
							-- so basic type has to be represented by Eiffel type
							-- rather than by built-in IL type.
						generate_il_eiffel_metamorphose (l_expression_type)
					else
						il_generator.generate_external_metamorphose (l_expression_type)
					end
				end
			end
		end

	generate_il_eiffel_metamorphose (a_type: TYPE_A) is
			-- Generate a metamorphose of `a_type' into a _REF type.
		require
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_is_basic: a_type.is_basic
		do
			il_generator.generate_eiffel_metamorphose (a_type)
		end

	generate_il_metamorphose (a_type, a_target_type: TYPE_A; a_real_metamorphose: BOOLEAN) is
			-- Generate a metamorphose of target object.
			-- If `a_real_metamorphose' is set to True, target is an
			-- expanded type and feature is defined in a non-expanded class.
			-- If False, feature is defined in an expanded
			-- class we simply need to load address of target.
		require
			is_valid: is_valid
		local
			l_local_number: INTEGER
		do
			if a_target_type /= Void and then a_type.is_basic and then not a_target_type.is_true_external then
					-- Box object.
				generate_il_eiffel_metamorphose (a_type)
				if not a_real_metamorphose then
						-- Get address of an object.
					il_generator.generate_load_address (a_type)
				end
			elseif
				a_target_type = Void and then not a_real_metamorphose or else
				a_target_type /= Void and then a_type.is_expanded and a_type.same_as (a_target_type)
			then
					-- Take object address.
				context.add_local (a_type)
				l_local_number := context.local_list.count
				il_generator.put_dummy_local_info (a_type, l_local_number)
				il_generator.generate_local_assignment (l_local_number)
				il_generator.generate_local_address (l_local_number)
			else
					-- Box object.
				il_generator.generate_metamorphose (a_type)
			end
		end

	generate_il_line_info (a_node: BYTE_NODE; is_breakable_for_studio_dbg: BOOLEAN) is
			-- Generate source line information in IL code.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		local
			l_number: INTEGER
		do
			if system.line_generation or context.workbench_mode then
				l_number := a_node.line_number
				if l_number > 0 then
					if is_breakable_for_studio_dbg then
						il_generator.put_line_info (l_number)
					else
						il_generator.put_silent_line_info (l_number)
					end
				end
			end
		end

	generate_ghost_debug_infos (a_node: BYTE_NODE; n: INTEGER) is
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal, for instance, with the not generated debug clauses
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
			if (System.line_generation or context.workbench_mode) then
				if system.is_precompile_finalized then
					il_generator.put_ghost_debug_infos (a_node.line_number, n)
				end
			end
		end

	process_pragma (a_node: INSTR_B) is
			-- Process pragma `a_pragma'.
		local
			l_parser: LINE_PRAGMA_PARSER
			l_pragma: BREAK_AS
		do
			l_pragma := a_node.line_pragma
			if (l_pragma /= Void) and then (system.line_generation or context.workbench_mode) then
				create l_parser
				l_parser.parse (l_pragma.literal_text (Void))
				if l_parser.is_pragma then
					if l_parser.is_default then
						il_generator.set_pragma_offset (0)
						il_generator.set_default_document
						il_generator.set_stop_breakpoints_generation (False)
					elseif l_parser.is_hidden then
						il_generator.set_pragma_offset (0)
						il_generator.set_default_document
						il_generator.set_stop_breakpoints_generation (True)
					else
						il_generator.set_pragma_offset (l_parser.line_number - l_pragma.start_location.line)
						il_generator.set_document (l_parser.document)
						il_generator.set_stop_breakpoints_generation (False)
					end
					il_generator.put_silent_line_info (a_node.line_number)
				end
			end
		end

feature {NONE} -- Implementation: binary operators

	generate_converted_binary_b (a_node: BINARY_B; an_opcode: INTEGER) is
			-- Generate binary node `a_node' which cast either left hand side
			-- or right hand side to heaviest type before performing binary operation.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		local
			l_left_type, l_right_type: TYPE_A
			l_type: TYPE_A
			l_same_type: BOOLEAN
		do
			if a_node.is_built_in then
				l_left_type := context.real_type (a_node.left.type)
				l_right_type := context.real_type (a_node.right.type)
				l_same_type := l_left_type.same_as (l_right_type)
				if not l_same_type then
					l_type := l_left_type.heaviest (l_right_type)
				end

				a_node.left.process (Current)
				if not l_same_type and then l_type = l_right_type then
						-- FIXME: Manu 1/29/2002: When evaluating inherited assertions where
						-- type is formal, type is not properly computed and therefore we do
						-- not get a basic type, but a formal one instead.
						-- When this bug will be fixed, we can remove the if statement for
						-- a basic type and replace it by a check statement.
					if l_type.is_basic then
						il_generator.convert_to (l_type)
					end
				end
				a_node.right.process (Current)
				if not l_same_type and then l_type = l_left_type then
						-- FIXME: See above fixme.
					if l_type.is_basic then
						il_generator.convert_to (l_type)
					end
				end

				if l_same_type then
					il_generator.generate_binary_operator (an_opcode, l_left_type.is_natural)
				else
					il_generator.generate_binary_operator (an_opcode, l_type.is_natural)
				end
			else
				a_node.nested_b.process (Current)
			end
		end

	generate_bin_equal_b (a_node: BIN_EQUAL_B; an_opcode: INTEGER) is
			-- Generate byte code for equality test
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			an_opcode_valie: an_opcode = il_ne or an_opcode = il_eq
		local
			l_left_type: TYPE_A
			l_right_type: TYPE_A
			l_comparison_type: TYPE_A
			l_continue_label: IL_LABEL
			l_end_label: IL_LABEL
			l_right_value: INTEGER
		do
			l_left_type := context.real_type (a_node.left.type)
			l_right_type := context.real_type (a_node.right.type)

			if
				(l_left_type.is_none and l_right_type.is_expanded) or
				(l_left_type.is_expanded and l_right_type.is_none)
			then
					-- Simple type can never be Void, so we simply evaluate
					-- expressions and then remove them from the stack to insert
					-- the expected value
				a_node.left.process (Current)
				a_node.right.process (Current)
				il_generator.pop
				il_generator.pop
				il_generator.put_boolean_constant (an_opcode = il_ne)
			else
				if
					(l_left_type.is_expanded or else l_right_type.is_expanded) and then
					not (l_left_type.is_basic and then l_right_type.is_basic)
				then
						-- Object (value) equality.

						-- Select reference type to which expanded types will be converted
						-- for comparison that expects arguments of type System.Object.
					if l_left_type.is_expanded then
						l_comparison_type := l_right_type
						if l_comparison_type.is_expanded then
								-- Both type are expanded. If either of them is external
								-- but not basic, the comparison type is System.Object.
								-- Otherwise it is ANY.
							if
								l_left_type.is_external and then not l_left_type.is_basic or else
								l_right_type.is_external and then not l_right_type.is_basic
							then
								create {CL_TYPE_A} l_comparison_type.make (system.system_object_id)
							else
								create {CL_TYPE_A} l_comparison_type.make (system.any_id)
							end
						end
					else
						l_comparison_type := l_left_type
					end

						-- Generate left operand.
					generate_expression_il_for_type (a_node.left, l_comparison_type)
					if l_left_type.is_reference then
							-- Check for voidness.
						l_continue_label := il_generator.create_label
						l_end_label := il_generator.create_label
						il_generator.duplicate_top
						il_generator.branch_on_true (l_continue_label)
						il_generator.pop
						il_generator.put_boolean_constant (False)
						il_generator.branch_to (l_end_label)
						il_generator.mark_label (l_continue_label)
					end

						-- Generate right operand.
					generate_expression_il_for_type (a_node.right, l_comparison_type)
					if l_right_type.is_reference then
							-- Check for voidness.
						l_continue_label := il_generator.create_label
						l_end_label := il_generator.create_label
						il_generator.duplicate_top
						il_generator.branch_on_true (l_continue_label)
							-- Remove left operand as well.
						il_generator.pop
						il_generator.pop
						il_generator.put_boolean_constant (False)
						il_generator.branch_to (l_end_label)
						il_generator.mark_label (l_continue_label)
					end

						-- Call "is_equal".
					il_generator.generate_object_equality_test
						-- Negate result if required.
					if an_opcode = il_ne then
						il_generator.generate_unary_operator (il_not)
					end

						-- Mark end of equality expression (if required).
					if l_end_label /= Void then
						il_generator.mark_label (l_end_label)
					end
				elseif
					l_left_type.is_basic or else
					l_right_type.is_basic or else
					not a_node.left.is_dynamic_clone_required (l_left_type) or else
					not a_node.right.is_dynamic_clone_required (l_right_type)
				then
						-- Basic type equality or pure reference type equality.
					generate_converted_binary_b (a_node, an_opcode)
				else
						-- Reference type equality.
						-- Check if one of the operands is of expanded type
						-- and use object comparison. Use reference comparison
						-- otherwise.

						-- Store result of a right expression in a local.
					a_node.right.process (Current)
					context.add_local (l_right_type)
					l_right_value := context.local_list.count
					il_generator.put_dummy_local_info (l_right_type, l_right_value)
					il_generator.generate_local_assignment (l_right_value)

						-- Check expandedness of a left expression object.
					a_node.left.process (Current)
					il_generator.duplicate_top
					il_generator.generate_is_true_instance_of (system.system_value_type_class.compiled_class.types.first.type)
					l_end_label := il_generator.create_label
					l_continue_label := il_generator.create_label
					il_generator.branch_on_true (l_continue_label)
						-- Compare references.
					il_generator.generate_local (l_right_value)
					il_generator.generate_binary_operator (an_opcode, False)
					il_generator.branch_to (l_end_label)
					il_generator.mark_label (l_continue_label)
						-- Compare objects.
					il_generator.duplicate_top
					il_generator.generate_local (l_right_value)
					generate_equal_routine ({PREDEFINED_NAMES}.equal_name_id)
						-- Negate result if required for comparing objects.
					if an_opcode = il_ne then
						il_generator.generate_unary_operator (il_not)
					end
					il_generator.mark_label (l_end_label)
				end
			end
		end

feature {NONE} -- Implementation: Inspect

	create_sorted_interval_list (a_node: INSPECT_B): SORTED_TWO_WAY_LIST [INTERVAL_B] is
			-- Create sorted list of all intervals in inspect instruction
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			case_list_not_void: not a_node.case_list.is_empty
		local
			l_case: BYTE_LIST [BYTE_NODE]
			case_index: INTEGER
			case_b: CASE_B
			case_intervals: BYTE_LIST [INTERVAL_B]
			case_compound: BYTE_LIST [BYTE_NODE]
			interval_b: INTERVAL_B
			has_empty_else_part: BOOLEAN
		do
			has_empty_else_part := a_node.else_part /= Void and then a_node.else_part.is_empty
			l_case := a_node.case_list
			create Result.make
			from
				l_case.start
			until
				l_case.after
			loop
				case_index := l_case.index
				case_b ?= l_case.item
					-- Add all intervals associated with current When_part unless they do the same as Else_part does
				case_intervals := case_b.interval
				case_compound := case_b.compound
				if case_intervals /= Void and then (not has_empty_else_part or else case_compound /= Void and then not case_compound.is_empty) then
					from
						case_intervals.start
					until
						case_intervals.after
					loop
						interval_b := case_intervals.item
						interval_b.set_case_index (case_index)
						Result.extend (interval_b)
						case_intervals.forth
					end
				end
				l_case.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	merge_intervals (a_node: INSPECT_B; intervals: like create_sorted_interval_list) is
			-- Merge adjacent intervals with the same code
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			intervals_not_void: intervals /= Void
		local
			interval_b: INTERVAL_B
			case_index: INTEGER
			next_interval_b: INTERVAL_B
			next_case_index: INTEGER
		do
			from
				intervals.start
			until
				intervals.after
			loop
				next_interval_b := intervals.item
				next_case_index := next_interval_b.case_index
				if case_index = next_case_index and then interval_b.upper.is_next (next_interval_b.lower) then
					interval_b.set_upper (next_interval_b.upper)
					intervals.remove
				else
					interval_b := next_interval_b
					case_index := next_case_index
					intervals.forth
				end
			end
		end

	minimum_group_size: INTEGER is 7
			-- Minimum number of items in group for which switch IL instruction is generated
			-- Switch instruction adds too much overhead when group consists of less than 7 items

	build_spans (a_node: INSPECT_B; intervals: like create_sorted_interval_list; min_value, max_value: INTERVAL_VAL_B): ARRAYED_LIST [INTERVAL_SPAN] is
			-- New sorted list of spans built from given `intervals' bounded with `min_value' and `max_value'
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			intervals_not_void: intervals /= Void
			min_value_not_void: min_value /= Void
			max_value_not_void: max_value /= Void
		local
			groups: TWO_WAY_LIST [INTERVAL_GROUP]
			interval_element: BI_LINKABLE [INTERVAL_B]
			group: INTERVAL_GROUP
		do
			create groups.make
				-- Merge intervals in groups by walking intervals backward
			from
				interval_element := intervals.last_element
			until
				interval_element = Void
			loop
				create group.make (interval_element)
				groups.put_front (group)
				from
					interval_element := interval_element.left
				until
					interval_element = Void or else not group.is_extended
				loop
					group.extend_with_interval (interval_element)
					if group.is_extended then
						interval_element := interval_element.left
					end
				end
			end
				-- Merge heading and trailing gaps
			group := groups.first
			if group /= Void and then group.lower /= min_value then
				group.extend_with_lower_gap (min_value, True)
			end
			group := groups.last
			if group /= Void and then group.upper /= max_value then
				group.extend_with_upper_gap (max_value, True)
			end
				-- Merge groups by walking them forward
			from
				create Result.make (groups.count)
				groups.start
			until
				groups.after
			loop
				group := groups.item
				group.set_is_extended (True)
				from
					groups.forth
				until
					groups.after or else not group.is_extended
				loop
					group.extend_with_group (groups.item)
					if group.is_extended then
						groups.remove
					end
				end
				if group.count >= minimum_group_size then
						-- This is a dense group with enough elements
					Result.extend (group)
				else
						-- Group has too little elements, replace it by elements themselves
					from
						interval_element := group.lower_interval
					until
						interval_element = group.upper_interval
					loop
						Result.extend (interval_element.item)
						interval_element := interval_element.right
					end
					Result.extend (interval_element.item)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	generate_spans (a_node: INSPECT_B; spans: like build_spans; lower, upper: INTEGER; min, max: INTERVAL_VAL_B; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]) is
			-- Generate selectors for `spans' with indexes `lower'..`upper' within interval `min'..`max'
			-- where these bounds are included according to `is_min_inclued' and `is_max_included'. Use
			-- `else_label' to branch to Else_part.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		local
			middle: INTEGER
			span: INTERVAL_SPAN
			next_label: IL_LABEL
		do
			if lower = upper then
					-- There is only one group
				span := spans.i_th (lower)
				generate_il_line_info (a_node, False)
				span.generate_il (Current, min, max, is_min_included, is_max_included, labels, a_node)
			else
					-- Divide groups in two parts and recurse
				middle := (lower + upper) // 2
				span := spans.i_th (middle)
				next_label := il_generator.create_label
				generate_il_line_info (a_node, False)
				generate_il_branch_on_greater (span.upper, span.is_upper_included, next_label, a_node)
				generate_spans (a_node, spans, lower, middle, min, span.upper, is_min_included, span.is_upper_included, labels)
				il_generator.mark_label (next_label)
				generate_spans (a_node, spans, middle + 1, upper, span.upper, max, not span.is_upper_included, is_max_included, labels)
			end
		end

	generate_il_branch_on_greater (an_interval: INTERVAL_VAL_B; is_included: BOOLEAN; label: IL_LABEL; instruction: INSPECT_B) is
			-- Generate branch to `label' if value on IL stack it greater than this value.
			-- Assume that current value is included in lower interval if `is_included' is true.
		require
			is_valid: is_valid
			an_interval_not_void: an_interval /= Void
			label_not_void: label /= Void
			instruction_not_void: instruction /= Void
		do
			generate_il_load_value (instruction)
			an_interval.il_load_value
			if an_interval.is_signed then
				if is_included then
					il_generator.branch_on_condition ({MD_OPCODES}.bgt, label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.bge, label)
				end
			else
				if is_included then
					il_generator.branch_on_condition ({MD_OPCODES}.bgt_un, label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.bge_un, label)
				end
			end
		end

feature {NONE} -- Implementation: loop

	generate_il_variant_init (a_node: VARIANT_B; a_local: INTEGER) is
			-- Initialize variant computation.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_local_not_negative: a_local > 0
		do
			check
				expr_exists: a_node.expr /= Void
				not_in_precondition: context.assertion_type /= {ASSERT_TYPE}.in_precondition
			end

			generate_il_line_info (a_node, True)

				-- Generate expression, duplicate top to perform checking,
				-- and store it in `a_local'.
			a_node.expr.process (Current)
			il_generator.duplicate_top
			il_generator.generate_local_assignment (a_local)
			il_generator.put_integer_32_constant (0)
			il_generator.generate_binary_operator ({IL_CONST}.il_ge, False)

			il_generator.generate_assertion_check (context.assertion_type, a_node.tag)
		end

	generate_il_variant_check (a_node: VARIANT_B; a_local: INTEGER) is
			-- Compute new variant and raise an assertion violation if not satisfied.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_local_not_negative: a_local > 0
		do
			check
				expr_exists: a_node.expr /= Void
				not_in_precondition: context.assertion_type /= {ASSERT_TYPE}.in_precondition
			end

			generate_il_line_info (a_node, True)

			a_node.expr.process (Current)

				-- We need 3 times the new value on top:
				-- 1 - to compare it with old value stored in `a_local' and
				--     make sure it is decreasing.
				-- 2 - for storing new value of variant in `a_local'.
				-- 3 - to make sure it is a positive value.
			il_generator.duplicate_top
			il_generator.duplicate_top

			il_generator.generate_local (a_local)
			il_generator.generate_binary_operator ({IL_CONST}.Il_lt, False)

			il_generator.generate_assertion_check (context.assertion_type, a_node.tag)

			il_generator.generate_local_assignment (a_local)
			il_generator.put_integer_32_constant (0)
			il_generator.generate_binary_operator ({IL_CONST}.il_ge, False)

			il_generator.generate_assertion_check (context.assertion_type, a_node.tag)
		end

feature {NONE} -- Implementation: unary operators

	generate_unary_b (a_node: UNARY_B; an_opcode: INTEGER) is
			-- Generate code for `a_node'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
			if a_node.is_built_in then
				a_node.expr.process (Current)
				il_generator.generate_unary_operator (an_opcode)
			else
				a_node.nested_b.process (Current)
			end
		end

feature {NONE} -- Implementation: assignments

	generate_il_start_assignment (a_node: ACCESS_B) is
			-- Generate location of assignment if needed.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
				-- Nothing to do in the current implementation.
		end

	generate_il_cancel_assignment (a_node: ACCESS_B) is
			-- Remove any data from the stack put by `generate_il_start_assignment'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		do
				-- Nothing to do in the current implementation.
		end

	frozen generate_il_simple_assignment (a_node: ACCESS_B; target_type, source_type: TYPE_A) is
			-- Generate simple source assignment
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			is_writable: not a_node.read_only
			target_type_not_void: target_type /= Void
			source_type_not_void: source_type /= Void
		local
			attr: ATTRIBUTE_B
			loc: LOCAL_B
			res: RESULT_B
			cl_type: CL_TYPE_A
			local_index: INTEGER
		do
					-- Generate cast if we have to generate verifiable code
					-- since access might have been redefined and in this
					-- case its type for IL generation is the one from the
					-- parent not the redefined one. Doing the cast enable
					-- the verifier to find out that what we are doing is
					-- correct. Cast is not needed for expanded type since
					-- they cannot be redefined.
			if
				System.il_verifiable and then not target_type.is_expanded
				and then not target_type.is_none
			then
				il_generator.generate_check_cast (source_type, target_type)
			end

			if a_node.is_attribute then
				attr ?= a_node
					-- Check the type in which we are generating the current attribute
					-- assignment. We could take `attr.context_type' but this would not
					-- work when we regenerate the assignment in a descendant class (case
					-- where routine is regenerated in an expanded type).
				cl_type := context.original_class_type.type
					-- Save expression value in a local, put Current on the stack,
					-- load saved expression value and perform the assignment.
				context.add_local (target_type)
				local_index := context.local_list.count
				il_generator.put_dummy_local_info (target_type, local_index)
				il_generator.generate_local_assignment (local_index)
				il_generator.generate_current
				il_generator.generate_local (local_index)
				if cl_type.is_expanded then
						-- Generate direct assignment.
					il_generator.generate_attribute_assignment (attr.need_target,
						cl_type, cl_type.associated_class.feature_of_rout_id (attr.routine_id).feature_id)
				else
						-- Generate assignment to the potentially inherited attribute.
					il_generator.generate_attribute_assignment (attr.need_target,
						cl_type.implemented_type (attr.written_in), attr.attribute_id)
				end
			elseif a_node.is_local then
				if {o: OBJECT_TEST_LOCAL_B} a_node then
					il_generator.generate_local_assignment (context.object_test_local_position (o))
				else
					loc ?= a_node
					il_generator.generate_local_assignment (loc.position)
				end
			elseif a_node.is_result then
				res ?= a_node
				il_generator.generate_result_assignment
			end
		end

feature {NONE} -- Implementation: Feature calls

	need_real_metamorphose (a_node: CALL_ACCESS_B; a_type: CL_TYPE_A): BOOLEAN is
			-- Does call `a_node' originate from a reference type?
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			a_type_not_void: a_type /= Void
			a_type_has_associated_class: a_type.associated_class /= Void
		do
			Result := system.class_of_id (a_node.written_in).is_external and then
				a_node.written_in /= a_type.associated_class.class_id
		end

	generate_il_c_call (a_node: EXTERNAL_B; inv_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `inv_checked' generates invariant check before call.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
		local
			l_cl_type: CL_TYPE_A
			l_return_type: TYPE_A
			l_invariant_checked: BOOLEAN
			l_real_metamorphose: BOOLEAN
			l_basic_type: BASIC_A
			l_count: INTEGER
		do
				-- Get type on which call will be performed.
			l_cl_type ?= a_node.context_type
			check
				valid_type: l_cl_type /= Void
			end

			if l_cl_type.is_expanded then
				if l_cl_type.associated_class.is_typed_pointer then
						-- Use POINTER instead of TYPED_POINTER.
					l_cl_type := system.pointer_class.compiled_class.actual_type
				end
					-- Current type is expanded. We need to find out if
					-- we need to generate a box operation, meaning that
					-- the feature is inherited from a non-expanded class.
				l_real_metamorphose := need_real_metamorphose (a_node, l_cl_type)
			end

				-- Let's find out if we are performing a call on a basic type
				-- or on an enum type. This happens only when we are calling
				-- magically added feature on basic types.
			l_basic_type ?= l_cl_type
			l_invariant_checked := (context.workbench_mode or
				l_cl_type.associated_class.assertion_level.is_invariant) and then
				not a_node.is_first

			if a_node.is_first then
					-- First call in dot expression, we need to generate Current
					-- only when we do not call a static feature.
				if l_cl_type.is_reference then
						-- Normal call, we simply push current object.
					if a_node.is_static_call then
							-- Bug fix until we generate direct static access
							-- to C external.
						(create {CREATE_TYPE}.make (a_node.static_class_type)).generate_il
					else
						il_generator.generate_current
					end
				else
					il_generator.generate_current
					if l_real_metamorphose then
							-- Feature is written in an inherited class of current
							-- expanded class. We need to box.
						il_generator.generate_metamorphose (l_cl_type)
					end
				end
			elseif l_cl_type.is_expanded then
					-- A metamorphose is required to perform call.
				generate_il_metamorphose (l_cl_type, Void, l_real_metamorphose)
			end

			if l_invariant_checked then
				generate_il_call_invariant_leading (l_cl_type, inv_checked)
			end

			if a_node.parameters /= Void then
					-- Generate parameters if any.
				a_node.parameters.process (Current)
				l_count := a_node.parameters.count
			end

			l_return_type := context.real_type (a_node.type)

				-- Perform call to feature
				-- FIXME: performance problem here since we are retrieving the
				-- FEATURE_TABLE. This could be avoided if at creation of FEATURE_B
				-- node we add the feature_id in the parent class.
			if a_node.is_static_call or else a_node.precursor_type /= Void then
					-- In IL, if you can call Precursor, it means that parent is
					-- not expanded and therefore we can safely generate a static
					-- call to Precursor feature.
				il_generator.generate_feature_access (
					a_node.static_class_type, a_node.feature_id, l_count, not l_return_type.is_void, False)
			elseif l_cl_type.is_expanded then
				il_generator.generate_feature_access (l_cl_type,
					l_cl_type.associated_class.feature_of_rout_id (a_node.routine_id).feature_id,
					l_count, not l_return_type.is_void, False)
			else
				il_generator.generate_feature_access (
					l_cl_type.implemented_type (a_node.written_in),
					a_node.feature_id, l_count, not l_return_type.is_void,
					l_cl_type.is_reference or else l_real_metamorphose)
			end
			if System.il_verifiable then
				if
					not l_return_type.is_expanded and then
					not l_return_type.is_none and then
					not l_return_type.is_void
				then
					il_generator.generate_check_cast (Void, l_return_type)
				end
			end
			if l_invariant_checked then
				generate_il_call_invariant_trailing (l_cl_type, l_return_type)
			end
		end

	generate_il_call_invariant (cl_type: CL_TYPE_A; entry: BOOLEAN) is
			-- Generate IL code for calling invariant feature on class type `cl_type'.
			-- Is the invariant checking `entry'?
		require
			is_valid: is_valid
			cl_type_not_void: cl_type /= Void
		do
			if cl_type.is_true_expanded then
					-- Box object before checking its class invariant
				if not cl_type.is_enum then
					il_generator.generate_load_from_address (cl_type)
				end
				il_generator.generate_metamorphose (cl_type)
			end
			il_generator.generate_invariant_checking (cl_type, entry)
		end

	generate_il_call_invariant_leading (cl_type: CL_TYPE_A; is_checked_before_call: BOOLEAN) is
			-- Generate IL code for calling invariant feature on class type `cl_type'
			-- before associated feature call if `is_checked_before_call' is true.
			-- Object on which a class invariant has
			-- to be checked has to be on the evaluation stack.
			-- It is preserved for the subsequent invariant check after feature call.
		require
			is_valid: is_valid
			cl_type_not_void: cl_type /= Void
		do
				-- Need two copies of current object in stack
				-- to perform invariant check before and after
				-- feature call.
			il_generator.duplicate_top
			if is_checked_before_call then
				il_generator.duplicate_top
				generate_il_call_invariant (cl_type, True)
			end
		end

	generate_il_call_invariant_trailing (cl_type: CL_TYPE_A; a_return_type: TYPE_A) is
			-- Generate IL code for calling invariant feature on class type `cl_type'
			-- after associated feature call with result type `a_return_type'.
			-- It is assumed that `generate_il_call_invariant_leading' is called
			-- before feature call to make necessary bookkeeping.
		require
			is_valid: is_valid
			cl_type_not_void: cl_type /= Void
			return_type_not_void: a_return_type /= Void
		local
			local_number: INTEGER
		do
			if a_return_type.is_void then
				generate_il_call_invariant (cl_type, False)
			else
					-- It is a function and we need to save the result onto
					-- a local variable.
				context.add_local (a_return_type)
				local_number := context.local_list.count
				il_generator.put_dummy_local_info (a_return_type, local_number)
				il_generator.generate_local_assignment (local_number)
				generate_il_call_invariant (cl_type, False)
				il_generator.generate_local (local_number)
			end
		end

	il_special_routines: IL_SPECIAL_FEATURES is
			-- Array containing special routines.
		once
			create Result
		ensure
			il_special_routines_not_void: Result /= Void
		end

	generate_il_normal_call (a_node: FEATURE_B; target_type: CL_TYPE_A; is_virtual: BOOLEAN) is
			-- Normal feature call.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			target_type_not_void: target_type /= Void
		local
			l_count: INTEGER
			l_return_type: TYPE_A
			target_feature_id: INTEGER
		do
			if a_node.parameters /= Void then
				l_count := a_node.parameters.count
			end

			l_return_type := context.real_type (a_node.type)

			if target_type.is_expanded then
					-- Generate direct call.
				target_feature_id := target_type.associated_class.feature_of_rout_id (a_node.routine_id).feature_id
			else
				target_feature_id := a_node.feature_id
			end

			if a_node.precursor_type /= Void then
					-- In IL, if you can call Precursor, it means that parent is
					-- not expanded and therefore we can safely generate a static
					-- call to Precursor feature.
				il_generator.generate_precursor_feature_access (
					target_type, target_feature_id, l_count, not l_return_type.is_void)
			else
				il_generator.generate_feature_access (
					target_type, target_feature_id, l_count, not l_return_type.is_void,
					is_virtual)
			end
			if System.il_verifiable then
				if
					not l_return_type.is_expanded and then
					not l_return_type.is_none and then
					not l_return_type.is_void
				then
					il_generator.generate_check_cast (Void, l_return_type)
				end
			end
		end

	generate_il_any_call (a_node: FEATURE_B; written_type, target_type: CL_TYPE_A; is_virtual: BOOLEAN) is
			-- Generate call to routine of ANY that works for both ANY and SYSTEM_OBJECT.
			-- Arguments and target of the call are already pushed on the stack.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			il_generation: System.il_generation
			is_any_feature: a_node.is_any_feature
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
			not_precursor_call: a_node.precursor_type = Void
		local
			l_count: INTEGER
			l_return_type: TYPE_A
		do
			if a_node.parameters /= Void then
				l_count := a_node.parameters.count
			end

			l_return_type := context.real_type (a_node.type)

				-- It is safe to use the name and not the routine ID to identify the routine
				-- because we are in ANY and therefore no renaming took place.
			inspect
				a_node.feature_name_id
			when
				{PREDEFINED_NAMES}.conforms_to_name_id,
				{PREDEFINED_NAMES}.deep_equal_name_id,
				{PREDEFINED_NAMES}.is_deep_equal_name_id,
				{PREDEFINED_NAMES}.same_type_name_id,
				{PREDEFINED_NAMES}.standard_equal_name_id,
				{PREDEFINED_NAMES}.standard_is_equal_name_id
			then
				generate_frozen_boolean_routine (a_node.feature_name_id)

			when {PREDEFINED_NAMES}.default_name_id then
				generate_default (target_type, l_return_type)

			when {PREDEFINED_NAMES}.default_pointer_name_id then
				generate_default_pointer (target_type)

			when {PREDEFINED_NAMES}.do_nothing_name_id then
				generate_do_nothing (target_type)

			when {PREDEFINED_NAMES}.io_name_id then
				generate_io (a_node, written_type, target_type)

			when {PREDEFINED_NAMES}.operating_environment_name_id then
				generate_operating_environment (a_node, written_type, target_type)

			when
				{PREDEFINED_NAMES}.generating_type_name_id,
				{PREDEFINED_NAMES}.generator_name_id,
				{PREDEFINED_NAMES}.out_name_id,
				{PREDEFINED_NAMES}.tagged_out_name_id
			then
				generate_string_routine (a_node, written_type)

			when
				{PREDEFINED_NAMES}.clone_name_id,
				{PREDEFINED_NAMES}.deep_clone_name_id,
				{PREDEFINED_NAMES}.standard_clone_name_id
			then
			generate_clone_routine (a_node.feature_name_id, l_return_type)

			when
				{PREDEFINED_NAMES}.copy_name_id,
				{PREDEFINED_NAMES}.deep_copy_name_id,
				{PREDEFINED_NAMES}.standard_copy_name_id
			then
				generate_copy_routine (a_node.feature_name_id)

			when
				{PREDEFINED_NAMES}.deep_twin_name_id,
				{PREDEFINED_NAMES}.standard_twin_name_id,
				{PREDEFINED_NAMES}.twin_name_id
			then
				generate_twin_routine (a_node.feature_name_id, l_return_type)

			when
				{PREDEFINED_NAMES}.equal_name_id,
				{PREDEFINED_NAMES}.is_equal_name_id
			then
				generate_equal_routine (a_node.feature_name_id)

			when
				{PREDEFINED_NAMES}.default_create_name_id,
				{PREDEFINED_NAMES}.default_rescue_name_id
			then
				generate_default_routine (a_node, written_type, target_type)
			when
				{PREDEFINED_NAMES}.to_dotnet_name_id
			then
					-- Nothing to be done, we like what we have on top of the stack
					-- since it is already a .NET object.
			else
					-- We come here if a routine has been added by user in ANY, or
					-- if we handle `print' and `internal_correct_mismatch'.
				if not target_type.is_external then
						-- Normal call to Eiffel routine.
					generate_il_normal_call (a_node, written_type, is_virtual)
				else
						-- New routine of ANY, or `print' or `internal_correct_mismatch' applied
						-- to a .NET object, we raise an exception as they should not be called
						-- on .NET object.

						-- Remove arguments and target from stack.
					from
					until
						l_count < 0
					loop
						il_generator.pop
						l_count := l_count - 1
					end
					il_generator.generate_raise_exception ({EXCEP_CONST}.precondition,
						"Feature of ANY not implemented for .NET class")
				end
			end
		end

	generate_frozen_boolean_routine (a_feature_name_id: INTEGER) is
			-- Generate inlined call to routine of ANY that are completely frozen (that is to
			-- say their definition is frozen and they don't call non-frozen routine in their
			-- definition if ANY) and that returns a boolean value.
		require
			is_valid: is_valid
			valid_feature_name:
				a_feature_name_id = {PREDEFINED_NAMES}.conforms_to_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.deep_equal_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.is_deep_equal_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.same_type_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.standard_equal_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.standard_is_equal_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_boolean_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

			l_id := {PREDEFINED_NAMES}.system_object_name_id
			inspect
				a_feature_name_id
			when
				{PREDEFINED_NAMES}.conforms_to_name_id,
				{PREDEFINED_NAMES}.same_type_name_id,
				{PREDEFINED_NAMES}.standard_is_equal_name_id,
				{PREDEFINED_NAMES}.is_deep_equal_name_id
			then
				l_extension.set_argument_types (<<l_id, l_id>>)
			when
				{PREDEFINED_NAMES}.deep_equal_name_id,
				{PREDEFINED_NAMES}.standard_equal_name_id
			then
				l_extension.set_argument_types (<<l_id, l_id, l_id>>)
			end

				-- Call routine
			l_extension.generate_call (False)
		end

	generate_clone_routine (a_feature_name_id: INTEGER; a_result_type: TYPE_A) is
			-- Generate inlined call to xx_clone' routines of ANY.
		require
			is_valid: is_valid
			a_result_type_not_void: a_result_type /= Void
			valid_feature_name:
				a_feature_name_id = {PREDEFINED_NAMES}.clone_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.deep_clone_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.standard_clone_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_object_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id, l_id>>)

				-- Call routine
			l_extension.generate_call (False)

				-- Unbox result if required
			if context.real_type (a_result_type).is_expanded then
				il_generator.generate_unmetamorphose (context.real_type (a_result_type))
			end

				-- Cast result back to proper type
			il_generator.generate_check_cast (Void, a_result_type)
		end

	generate_copy_routine (a_feature_name_id: INTEGER) is
			-- Generate inlined call to xx_copy' routines of ANY.
		require
			is_valid: is_valid
			valid_feature_name:
				a_feature_name_id = {PREDEFINED_NAMES}.copy_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.deep_copy_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.standard_copy_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_feature_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id, l_id>>)

				-- Call routine
			l_extension.generate_call (False)
		end

	generate_default (target_type, return_type: TYPE_A) is
			-- Generate inlined call to `default'.
		require
			is_valid: is_valid
			target_type_not_void: target_type /= Void
		local
			cl_type_i: CL_TYPE_A
		do
				-- Check validity of target
			generate_call_on_void_target (target_type, False)

			if target_type.is_expanded then
				if target_type.is_basic then
						-- Put default value for basic type
					il_generator.put_default_value (target_type)
				elseif target_type.is_external then
						-- Create new instance of external expanded type.
					(create {CREATE_TYPE}.make (target_type)).generate_il
				else
						-- Create new instance of internal expanded type.
					cl_type_i ?= target_type
					check
						cl_type_i_attached: cl_type_i /= Void
					end
					il_generator.create_expanded_object (cl_type_i)
				end
				if return_type.is_reference then
						-- Box value type
					il_generator.generate_metamorphose (target_type)
				end
			else
					-- Reference case, we simply return Void
				il_generator.put_void
			end
		end

	generate_default_routine (a_node: FEATURE_B; written_type, target_type: CL_TYPE_A) is
			-- Generate inlined call to `default_create' and `default_rescue'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
				a_node.feature_name_id = {PREDEFINED_NAMES}.default_create_name_id or
				a_node.feature_name_id = {PREDEFINED_NAMES}.default_rescue_name_id
		local
			l_dotnet_label, l_end_label: IL_LABEL
		do
				-- Since `default_create' and `default_rescue' are virtual in ANY,
				-- we need to perform a dynamic dispatch when we handle an Eiffel class.
			l_dotnet_label := il_generator.create_label
			l_end_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_false (l_dotnet_label)
			generate_il_normal_call (a_node, written_type, True)
			il_generator.branch_to (l_end_label)
			il_generator.mark_label (l_dotnet_label)

				-- Check validity of target for .NET case
			generate_call_on_void_target (target_type, False)

				-- Nothing to be done for .NET since their content is empty.

			il_generator.mark_label (l_end_label)
		end

	generate_default_pointer (target_type: TYPE_A) is
			-- Generate inlined call to `default_pointer'.
		require
			is_valid: is_valid
			target_type_not_void: target_type /= Void
		do
				-- Check validity of target
			generate_call_on_void_target (target_type, False)

				-- We simply return null pointer
			il_generator.put_integer_32_constant (0)
			il_generator.convert_to_native_int
		end

	generate_do_nothing (target_type: TYPE_A) is
			-- Generate inlined call to `do_nothing'.
		require
			is_valid: is_valid
			target_type_not_void: target_type /= Void
		do
				-- Check validity of target
			generate_call_on_void_target (target_type, False)
		end

	generate_equal_routine (a_feature_name_id: INTEGER) is
			-- Generate inlined call to `equal' and `is_equal' routines of ANY.
		require
			is_valid: is_valid
			valid_feature_name:
				a_feature_name_id = {PREDEFINED_NAMES}.equal_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.is_equal_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_boolean_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

			l_id := {PREDEFINED_NAMES}.system_object_name_id
			if a_feature_name_id = {PREDEFINED_NAMES}.is_equal_name_id then
				l_extension.set_argument_types (<<l_id, l_id>>)
			else
				l_extension.set_argument_types (<<l_id, l_id, l_id>>)
			end

				-- Call routine
			l_extension.generate_call (False)
		end

	generate_io (a_node: FEATURE_B; written_type, target_type: CL_TYPE_A) is
			-- Generate inlined call to `io'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
		local
			l_io_label: IL_LABEL
		do
				-- Check validity of target.
			generate_call_on_void_target (target_type, True)
				-- Call feature on this object if its type inherits ANY.
			l_io_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_true (l_io_label)
			il_generator.pop;
				-- Call feature from ANY because type of object does not inherit it.
			(create {CREATE_TYPE}.make (any_type)).generate_il
			il_generator.mark_label (l_io_label)
			generate_il_normal_call (a_node, written_type, True)
		end

	generate_operating_environment (a_node: FEATURE_B; written_type, target_type: CL_TYPE_A) is
			-- Generate inlined call to `operating_environment'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
		local
			l_oe_label: IL_LABEL
		do
				-- Check validity of target
			generate_call_on_void_target (target_type, True)

			l_oe_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_true (l_oe_label)
			il_generator.pop;
			(create {CREATE_TYPE}.make (any_type)).generate_il
			il_generator.mark_label (l_oe_label)
			generate_il_normal_call (a_node, written_type, True)
		end

	generate_string_routine (a_node: FEATURE_B; written_type: CL_TYPE_A) is
			-- Generate inlined call to routines of ANY returning a STRING object:
			-- `generator', `generating_type', `out' and `tagged_out'.
		require
			is_valid: is_valid
			a_node_not_void: a_node /= Void
			written_type_not_void: written_type /= Void
			valid_feature_name:
				a_node.feature_name_id = {PREDEFINED_NAMES}.generating_type_name_id or
				a_node.feature_name_id = {PREDEFINED_NAMES}.generator_name_id or
				a_node.feature_name_id = {PREDEFINED_NAMES}.out_name_id or
				a_node.feature_name_id = {PREDEFINED_NAMES}.tagged_out_name_id
		local
			l_extension: IL_EXTENSION_I
			l_local: INTEGER
			l_out_label, l_end_label: IL_LABEL
		do
			if
				a_node.feature_name_id = {PREDEFINED_NAMES}.out_name_id or else
				a_node.feature_name_id = {PREDEFINED_NAMES}.tagged_out_name_id
			then
					-- Since `out' is virtual in ANY, we need to perform
					-- a dynamic dispatch when we handle an Eiffel class.
				l_out_label := il_generator.create_label
				l_end_label := il_generator.create_label
				il_generator.duplicate_top
				il_generator.generate_is_true_instance_of (any_type)
				il_generator.branch_on_false (l_out_label)
				il_generator.generate_is_true_instance_of (any_type)
				generate_il_normal_call (a_node, written_type, True)
				il_generator.branch_to (l_end_label)
				il_generator.mark_label (l_out_label)
			end

				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_node.feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_string_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_argument_types (<<{PREDEFINED_NAMES}.system_object_name_id>>)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

				-- Call routine
			l_extension.generate_call (False)

				-- Store result in temporary variable
			context.add_local (system_string_type)
			l_local := context.local_list.count
			il_generator.put_dummy_local_info (system_string_type, l_local)
			il_generator.generate_local_assignment (l_local)

				-- Generate Eiffel STRING object from SYSTEM_STRING object
			il_generator.put_manifest_string_from_system_string_local (l_local)

			if l_end_label /= Void then
				il_generator.mark_label (l_end_label)
			end
		end

	generate_twin_routine (a_feature_name_id: INTEGER; a_result_type: TYPE_A) is
			-- Generate inlined call to xx_twin' routines of ANY.
		require
			is_valid: is_valid
			a_result_type_not_void: a_result_type /= Void
			valid_feature_name:
				a_feature_name_id = {PREDEFINED_NAMES}.twin_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.deep_twin_name_id or
				a_feature_name_id = {PREDEFINED_NAMES}.standard_twin_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (a_feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_object_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)

			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id>>)

				-- Call routine
			l_extension.generate_call (False)

				-- Unbox result if required
			if a_result_type.is_basic then
				il_generator.generate_load_address (a_result_type)
				il_generator.generate_load_from_address_as_basic (a_result_type)
			elseif a_result_type.is_expanded then
				il_generator.generate_unmetamorphose (a_result_type)
			end

				-- Cast result back to proper type
			il_generator.generate_check_cast (Void, a_result_type)
		end

feature {NONE} -- Convenience

	generate_call_on_void_target (target_type: TYPE_A; need_top_duplication: bOOLEAN) is
			-- Generate check that current object is not Void.
		require
			is_valid: is_valid
			target_type_not_void: target_type /= Void
		local
			l_not_void_label: IL_LABEL
		do
			if need_top_duplication then
				il_generator.duplicate_top
			end

			if target_type.is_reference then
				l_not_void_label := il_generator.create_label

					-- Check that target is not Void.			
				il_generator.branch_on_true (l_not_void_label)

					-- If target of call is Void, throw an exception.
				il_generator.generate_call_on_void_target_exception

					-- Else we procede normally
				il_generator.mark_label (l_not_void_label)
			else
					-- Top element is not required so we can get rid of it.
				il_generator.pop
			end
		end

	any_type: CL_TYPE_A is
			-- Actual type of ANY
		require
			has_any: system.any_class /= Void
			has_any_compiled: system.any_class.is_compiled
		once
			Result := system.any_class.compiled_class.actual_type
		ensure
			any_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_A is
			-- Actual type of SYSTEM_STRING
		require
			has_system_string: system.system_string_class /= Void
			has_system_string_compiled: system.system_string_class.is_compiled
		once
			Result := system.system_string_class.compiled_class.actual_type
		ensure
			system_string_type_not_void: Result /= Void
		end

	system_exception_type: CL_TYPE_A is
			-- Actual type of SYSTEM_EXCEPTION
		require
			has_system_string: system.system_exception_type_class /= Void
			has_system_string_compiled: system.system_exception_type_class.is_compiled
		once
			Result := system.system_exception_type_class.compiled_class.actual_type
		ensure
			system_exception_type_not_void: Result /= Void
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

end
