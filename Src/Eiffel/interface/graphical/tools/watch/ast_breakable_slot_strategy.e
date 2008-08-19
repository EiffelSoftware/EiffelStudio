indexing
	description: "Process ast to compute the bp index from source code line index."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_BREAKABLE_SLOT_STRATEGY

inherit
	AST_NULL_VISITOR
		redefine
			process_inline_agent_creation_as,
			process_custom_attribute_as,
			process_integer_as,
			process_static_access_as,
			process_feature_clause_as,
			process_tuple_as,
			process_real_as,
			process_bool_as,
			process_bit_const_as,
			process_array_as,
			process_char_as,
			process_string_as,
			process_verbatim_string_as,
			process_body_as,
			process_built_in_as,
			process_result_as,
			process_current_as,
			process_access_feat_as,
			process_access_inv_as,
			process_access_id_as,
			process_access_assert_as,
			process_precursor_as,
			process_nested_expr_as,
			process_nested_as,
			process_creation_expr_as,
			process_type_expr_as,
			process_routine_as,
			process_constant_as,
			process_eiffel_list,
			process_indexing_clause_as,
			process_operand_as,
			process_variant_as,
			process_un_strip_as,
			process_paran_as,
			process_expr_call_as,
			process_expr_address_as,
			process_address_result_as,
			process_address_current_as,
			process_address_as,
			process_routine_creation_as,
			process_un_free_as,
			process_un_minus_as,
			process_un_not_as,
			process_un_old_as,
			process_un_plus_as,
			process_bin_and_then_as,
			process_bin_free_as,
			process_bin_implies_as,
			process_bin_or_as,
			process_bin_or_else_as,
			process_bin_xor_as,
			process_bin_ge_as,
			process_bin_gt_as,
			process_bin_le_as,
			process_bin_lt_as,
			process_bin_div_as,
			process_bin_minus_as,
			process_bin_mod_as,
			process_bin_plus_as,
			process_bin_power_as,
			process_bin_slash_as,
			process_bin_star_as,
			process_bin_and_as,
			process_bin_eq_as,
			process_bin_ne_as,
			process_bin_tilde_as,
			process_bin_not_tilde_as,
			process_bracket_as,
			process_object_test_as,
			process_external_lang_as,
			process_feature_as,
			process_feature_list_as,
			process_assign_as,
			process_assigner_call_as,
			process_reverse_as,
			process_check_as,
			process_creation_as,
			process_debug_as,
			process_if_as,
			process_inspect_as,
			process_instr_call_as,
			process_loop_as,
			process_retry_as,
			process_external_as,
			process_attribute_as,
			process_do_as,
			process_once_as,
			process_type_dec_as,
			process_class_as,
			process_parent_as,
			process_like_id_as,
			process_like_cur_as,
			process_formal_as,
			process_formal_dec_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			process_none_type_as,
			process_bits_as,
			process_bits_symbol_as,
			process_rename_as,
			process_invariant_as,
			process_interval_as,
			process_index_as,
			process_export_item_as,
			process_elseif_as,
			process_create_as,
			process_client_as,
			process_case_as,
			process_ensure_as,
			process_ensure_then_as,
			process_require_as,
			process_require_else_as,
			process_convert_feat_as,
			process_void_as,
			process_type_list_as,
			process_type_dec_list_as,
			process_convert_feat_list_as,
			process_class_list_as,
			process_parent_list_as,
			process_local_dec_list_as,
			process_formal_argu_dec_list_as,
			process_debug_key_list_as,
			process_delayed_actual_list_as,
			process_parameter_list_as,
			process_rename_clause_as,
			process_export_clause_as,
			process_undefine_clause_as,
			process_redefine_clause_as,
			process_select_clause_as,
			process_formal_generic_list_as
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

create
	make, make_for_inline_agent

feature {NONE} -- Initialization

	make is
		do
			reset
		end

	make_for_inline_agent (parent_strategy: like Current; a_as: INLINE_AGENT_CREATION_AS) is
		do
			make
			source_class := parent_strategy.source_class
			current_class := parent_strategy.current_class

			source_feature := source_class.eiffel_class_c.inline_agent_of_rout_id (a_as.inl_rout_id)
			current_feature := source_feature
		end

feature -- reset

	reset is
		do
			if breakable_lines /= Void then
				breakable_lines.wipe_out
			else
				create {DS_LINKED_LIST [INTEGER]} breakable_lines.make
			end
			if locals_for_current_feature	/= Void then
				locals_for_current_feature.wipe_out
			else
				create locals_for_current_feature.make (10)
			end
			if error_message /= Void then
				error_message.wipe_out
			else
				create error_message.make (5)
			end
		end

feature -- Access

	sorted_breakable_lines: DS_LIST [INTEGER] is
		do
			Result := breakable_lines
			if not integer_sorter.sorted (Result) then
				integer_sorter.sort (Result)
			end
		end

	integer_sorter: DS_QUICK_SORTER [INTEGER] is
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [INTEGER]}.make)
		end

	breakable_lines: like sorted_breakable_lines

feature -- Element change

	set_source_feature (a_feature: like source_feature) is
		do
			source_feature := a_feature
		ensure
			source_feature_set: source_feature = a_feature
		end

	set_current_feature (a_feature: like current_feature) is
		do
			current_feature := a_feature
		end

	set_source_class (a_class: like source_class) is
		do
			source_class := a_class
		end

	set_current_class (a_class: like current_class) is
		do
			current_class := a_class
		end

	reset_last_class_and_type is
		do
			last_type := Void
			last_class := Void
		end

	wipe_out_error is
			-- Wipe out errors.
		do
			has_error_internal := False
			error_message.wipe_out
		ensure
			not_has_error: not has_error_internal
			error_message_is_empty: error_message.is_empty
		end

feature -- Access

	current_class: CLASS_C
			-- The class user viewing.

	source_class: CLASS_C
			-- Written class of current feature.
			-- or other part of `current_class' we are processing.

	source_feature, current_feature: FEATURE_I
			-- The feature being processed. `source_feature' is the feature from `source_class',
			-- whereas `current_feature' is the feature from `current_class'.

	last_parent: CLASS_C
			-- For rename clause, save the written class for old name.

	last_class: CLASS_C
			-- Class from `last_type'.

	last_type: TYPE_A
			-- Last type we explained.

	error_message: ARRAYED_LIST [STRING]
			-- Error message.

	has_error: BOOLEAN is
			-- Did an error happen?
		do
			Result := not error_message.is_empty
		end

feature {AST_BREAKABLE_SLOT_STRATEGY} -- Access

	last_actual_local_type: TYPE_A

	locals_for_current_feature: HASH_TABLE [TYPE_A, STRING]

	processing_locals: BOOLEAN;

	processing_creation_target: BOOLEAN

	processing_parents: BOOLEAN
			-- rename, redefine clause etc.

	processing_none_feature_part: BOOLEAN

	has_error_internal: BOOLEAN
			-- If error when processing.
			-- For the case we only have old AST,
			-- `last_type' cannot be evaluated correctly.
			-- If `has_error', we give up type evaluating and send
			-- simple text to output.

feature {AST_BREAKABLE_SLOT_STRATEGY} -- Error handling

	set_error_message (a_str: STRING) is
			-- Setup `error_message'.
		require
			a_str_not_void: a_str /= Void
		do
			error_message.extend (a_str)
		ensure
			error_message_extended: error_message.has (a_str)
		end

feature -- Roundtrip

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS) is
		local
			l_strategy: like Current
			l_feat: FEATURE_I
			l_leaf_list: LEAF_AS_LIST
		do
			if not expr_type_visiting then
				if l_as.inl_rout_id > 0 then
					create l_strategy.make_for_inline_agent (Current, l_as)
					l_feat := l_strategy.current_feature
					l_as.body.process (l_strategy)
					if l_as.operands /= Void then
						reset_last_class_and_type
						l_as.operands.process (Current)
					end
					last_type := expr_type (l_as)
				else
					has_error_internal := True
					l_leaf_list	:= match_list_server.item (current_class.class_id)
				end
			else
				if not has_error_internal then
					last_type := agent_type (l_as)
				end
			end
		end

feature {NONE} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS) is
		do
			l_as.creation_expr.process (Current)
		end

	process_integer_as (l_as: INTEGER_CONSTANT) is
		do
			if l_as.constant_type /= Void then
				l_as.constant_type.process (Current)
			end
			last_type := l_as.manifest_type
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		local
			l_feat: E_FEATURE
			l_rout_ids: ID_SET
			l_type: TYPE_A
			l_static_type: TYPE_A
			l_actual_argument_typs: like expr_types
		do
			l_as.class_type.process (Current)
			l_static_type := last_type
			l_rout_ids := l_as.routine_ids
			check
				l_rout_ids_not_void: l_rout_ids /= Void
				l_class_id_not_zero: l_as.class_id /= 0
			end
			if not has_error_internal then
				l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_rout_ids)
			end
			if l_as.parameter_count > 0 then
				l_as.parameters.process (Current)
			end
			if not has_error_internal then
				if l_feat.is_procedure then
					reset_last_class_and_type
				else
					l_type := l_feat.type
							-- If it has an like argument type, we solve the type from the arguments.
					if l_type.has_like_argument then
						check
							parameters_not_void: l_as.parameters /= Void
						end
						l_actual_argument_typs := expr_types (l_as.parameters)
						if l_actual_argument_typs /= Void then
							l_type := l_type.actual_argument_type (l_actual_argument_typs)
						end
						if l_type = Void then
							l_type := l_feat.type
						end
					end
					l_type := l_type.actual_type
					if l_type.is_loose then
						last_type := l_type.instantiation_in (l_static_type, last_class.class_id)
					else
						last_type := l_type
					end
				end
			end

		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
		local
			i, l_count: INTEGER
			f: EIFFEL_LIST [FEATURE_AS]
			next_feat, feat: FEATURE_AS
		do
			if l_as.clients /= Void then
				l_as.clients.process (Current)
			end
			f := l_as.features
			from
				i := 1
				l_count := f.count
				if l_count > 0 then
					feat := f.i_th (1)
				end
			until
				i > l_count
			loop
				i := i + 1
				feat.process (Current)
				feat := next_feat
			end
		end

	process_tuple_as (l_as: TUPLE_AS) is
		local
			l_tuple_type: TUPLE_TYPE_A
		do
			l_as.expressions.process (Current)
			if not has_error_internal then
				create l_tuple_type.make (system.tuple_id, expr_types (l_as.expressions))
				last_type := l_tuple_type
			end
		end

	process_real_as (l_as: REAL_AS) is
		do
			if not expr_type_visiting then
				if l_as.constant_type /= Void then
					l_as.constant_type.process (Current)
				end
			end

			if l_as.constant_type = Void then
				last_type := Real_64_type
			elseif expr_type_visiting then
				l_as.constant_type.process (Current)
			else
			end
		end

	process_bool_as (l_as: BOOL_AS) is
		do
			last_type := Boolean_type
		end

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			create {BITS_A} last_type.make (l_as.value.name.count)
		end

	process_array_as (l_as: COMPILER_ARRAY_AS) is
		do
			reset_last_class_and_type
			if not l_as.expressions.is_empty then
				l_as.expressions.process (Current)
			end
			last_type := l_as.array_type
		end

	process_char_as (l_as: CHAR_AS) is
		do
			last_type := character_type
		end

	process_string_as (l_as: STRING_AS) is
		do
			last_type := string_type
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS) is
		do
			if not expr_type_visiting then
			end
			last_type := string_type
		end

	process_body_as (l_as: BODY_AS) is
		local
			l_feat: E_FEATURE
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.arguments /= Void and then not l_as.arguments.is_empty then
				l_as.arguments.process (Current)
			end
			if l_as.type /= Void then
				l_as.type.process (Current)
			end
			if l_as.assigner /= Void then
				if not has_error_internal then
					l_feat := current_assigner_feature
				end
			end
			safe_process (l_as.content)
		end

	process_built_in_as (l_as: BUILT_IN_AS) is
			-- Process `l_as'.
		do
			process_external_as (l_as)
		end

	process_result_as (l_as: RESULT_AS) is
		local
			l_feat: E_FEATURE
		do
			if not has_error_internal then
				l_feat := feature_in_class (current_class, current_feature.rout_id_set)
				if not has_error_internal then
					if not processing_creation_target or else last_type = Void then
						last_type := l_feat.type
					end
					check
						last_type_not_void: last_type /= Void
					end
				end
			end
		end

	process_current_as (l_as: CURRENT_AS) is
		do
			last_type := current_class.actual_type
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		local
			l_feat: E_FEATURE
			l_feat_result: like feature_from_type_set
			l_rout_id_set: ID_SET
			l_last_class: like last_class
			l_last_type: like last_type
			l_formal: FORMAL_A
			l_last_type_set: TYPE_SET_A
			l_named_tuple_type: NAMED_TUPLE_TYPE_A
			l_type: TYPE_A
			l_pos: INTEGER
			l_actual_argument_typs: like expr_types
			l_is_multi_constrained: BOOLEAN
		do
			if l_as.is_argument then
			elseif l_as.is_local then
			elseif l_as.is_tuple_access then
			else
				if not has_error_internal then
					if last_type /= Void then
						last_type := last_type.actual_type
						if last_type.is_formal then
							l_formal ?= last_type
							if l_formal.is_multi_constrained (current_class) then
								l_is_multi_constrained := True
								l_last_type_set := last_type.to_type_set.constraining_types (current_class)
								check multi_constrained_implies_existence_of_type_set: l_is_multi_constrained implies l_last_type_set /= Void end
							else
								last_type := l_formal.constrained_type (current_class)
							end
						end
						if not last_type.is_none then
							last_class := last_type.associated_class
						else
							last_class := Void
						end
					end
					l_rout_id_set := l_as.routine_ids
					if l_rout_id_set /= Void then
						if processing_creation_target then
								-- We are processing something like: create l.make
							if l_is_multi_constrained then
								l_feat_result := feature_from_type_set (l_last_type_set, l_rout_id_set)
								if l_feat_result.count >= 1 then
									l_feat := l_feat_result.first.feature_item
									last_class := l_feat_result.first.class_type.associated_class
								else
									l_feat := Void
									last_class := Void
								end
							else
								l_feat := feature_in_class (current_class, l_rout_id_set)
								if last_type /= Void then
									last_class := last_type.associated_class
								else
									last_class := current_class
								end
							end
						else
							if last_type /= Void then
									-- We are already in a nested call like: a.f.*
									-- So `last_type', last_class are the ones from a and
									-- `l_rout_id_set' is the one of f
								if last_type.is_none then
									last_class := system.class_of_id (l_as.class_id)
								end
								if last_class /= Void then
									l_feat := feature_in_class (last_class, l_rout_id_set)
								end
							else
									-- We are at the beginning of a nested call: a.f.*
									-- `l_rout_id_set' is the one of a
								if l_is_multi_constrained then
									l_feat_result := feature_from_type_set (l_last_type_set, l_rout_id_set)
									if l_feat_result.count >= 1 then
											-- We just pick the first one.
										l_feat := l_feat_result.first.feature_item
									end
								else
									l_feat := feature_in_class (current_class, l_rout_id_set)
								end

								last_type := current_class.actual_type
								last_class := current_class
							end
						end
						check last_class_not_void: last_class /= Void end
					end
				end
			end
			if l_as.parameters /= Void and not expr_type_visiting then
				l_last_type := last_type
				l_last_class := last_class
				reset_last_class_and_type
				l_as.parameters.process (Current)
				last_type := l_last_type
				last_class := l_last_class
			end
			if l_as.is_argument then
				last_type := current_feature.arguments.i_th (l_as.argument_position)
			elseif l_as.is_local then
				if last_type = Void then
					if locals_for_current_feature.has_key (l_as.access_name) then
						last_type := locals_for_current_feature.found_item
					end
				end
			elseif l_as.is_tuple_access then
				if not has_error_internal then
					l_named_tuple_type ?= last_type.actual_type
					check
						l_named_tuple_type /= Void
					end
					l_pos := l_named_tuple_type.label_position (l_as.access_name)
					if l_pos > 0 then
						last_type := l_named_tuple_type.generics.item (l_pos)
					else
						last_type := Void
					end
				else
					last_type := Void
				end
			else
				if l_feat /= Void then
					if l_feat.is_procedure then
						reset_last_class_and_type
					else
						if processing_creation_target then
							if last_type = Void then
								l_type := l_feat.type.actual_type
								last_type := current_class.actual_type
							else
									-- A static type in creation as.
								l_type := last_type
							end
						else
							l_type := l_feat.type
									-- If it has an like argument type, we solve the type from the arguments.
							if l_type.has_like_argument then
								check
									parameters_not_void: l_as.parameters /= Void
								end
								l_actual_argument_typs := expr_types (l_as.parameters)
								if l_actual_argument_typs /= Void then
									l_type := l_type.actual_argument_type (l_actual_argument_typs)
								end
								if l_type = Void then
									l_type := l_feat.type
								end
							end
							l_type := l_type.actual_type
						end
						if l_type.is_loose then
							last_type := l_type.instantiation_in (last_type, last_class.class_id)
						else
							last_type := l_type
						end
					end
				else
					last_type := Void
				end
			end
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		do
			process_access_feat_as (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
		local
			real_feature: E_FEATURE
			l_parent_class: CLASS_C
			l_parent_class_i: CLASS_I
			l_current_feature: E_FEATURE
			l_type: TYPE_A
			l_actual_argument_typs: like expr_types
		do
			check
				current_feature.rout_id_set /= Void
			end
			l_current_feature := feature_in_class (current_class, current_feature.rout_id_set)
			if not has_error_internal then
				if l_as.parent_base_class /= Void then
					l_parent_class_i := universe.safe_class_named (l_as.parent_base_class.class_name.name, current_class.group)
					if l_parent_class_i /= Void then
						l_parent_class := l_parent_class_i.compiled_class
					else
						if not has_error_internal then
							has_error_internal := True
							set_error_message ("Precursor class locating failed.")
						end
					end
				elseif l_current_feature.precursors /= Void then
					l_parent_class := l_current_feature.precursors.last
				end
				if l_parent_class /= Void then
					real_feature := l_current_feature.ancestor_version (l_parent_class)
				end
			end
			if not expr_type_visiting then
				if l_as.parameter_count > 0 then
					l_as.parameters.process (Current)
				end
			end
			if real_feature /= Void then
				l_type := real_feature.type
			else
					-- Could not find an ancestor version, most likely code where Precursor appears
					-- has been replicated. We simply use the `current_feature' type as best approximation.
					-- This should not happen when replication is properly implemented in compiler.
				l_type := current_feature.type
			end
			if l_type /= Void then
						-- If it has an like argument type, we solve the type from the arguments.
				if l_type.has_like_argument then
					check
						parameters_not_void: l_as.parameters /= Void
					end
					l_actual_argument_typs := expr_types (l_as.parameters)
					if l_actual_argument_typs /= Void then
						l_type := l_type.actual_argument_type (l_actual_argument_typs)
					end
				end
				if l_type /= Void then
					last_type := l_type.actual_type
				else
					last_type := Void
				end
			else
				last_type := Void
			end
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
		do
			l_as.target.process (Current)
			l_as.message.process (Current)
		end

	process_nested_as (l_as: NESTED_AS) is
		do
			l_as.target.process (Current)
			l_as.message.process (Current)
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
		local
			l_type: TYPE_A
		do
			l_as.type.process (Current)
			l_type := last_type
			if l_as.call /= Void then
				l_as.call.process (Current)
			end
			last_type := l_type
		end

	process_type_expr_as (l_as: TYPE_EXPR_AS) is
		do
			if not expr_type_visiting then
				l_as.type.process (Current)
			else
				l_as.type.process (Current)
				create {GEN_TYPE_A} last_type.make (
					system.type_class.compiled_class.class_id, << last_type >>)
			end
		end

	process_routine_as (l_as: ROUTINE_AS) is
		local
			is_inline_agent: BOOLEAN
			inline_agent_assertion: ROUTINE_ASSERTIONS
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end

			is_inline_agent := current_feature.is_inline_agent

			locals_for_current_feature.wipe_out
				if l_as.obsolete_message /= Void then
					l_as.obsolete_message.process (Current)
				end

			if is_inline_agent then
				create inline_agent_assertion.make_for_inline_agent (current_feature, l_as)
			else

				if l_as.precondition /= Void then
					l_as.precondition.process (Current)
				end
			end
				if l_as.locals /= Void then
					if l_as.locals.count > 0 then
						processing_locals := True
						l_as.locals.process (Current)
						processing_locals := False
					end
				end
				safe_process (l_as.routine_body)
			if is_inline_agent then
			else
				if l_as.postcondition /= Void then
					l_as.postcondition.process (Current)
				end
			end
				if l_as.rescue_clause /= Void then
					if not l_as.rescue_clause.is_empty then
						format_compound (l_as.rescue_clause)
					end
				end
				if not l_as.is_deferred and not l_as.is_external then
					put_breakable (l_as)
				end
		end

	process_constant_as (l_as: CONSTANT_AS) is
		do
			l_as.value.process (Current)
		end

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL]) is
		local
			i, l_count: INTEGER
			failure: BOOLEAN
			not_first: BOOLEAN
		do
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count or failure
			loop
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_operand_as (l_as: OPERAND_AS) is
		do
			if l_as.class_type /= Void then
				l_as.class_type.process (Current)
			else
				if l_as.expression /= Void then
					l_as.expression.process (Current)
				else
					if l_as.target /= Void then
						reset_last_class_and_type
						l_as.target.process (Current)
					else
						if not expr_type_visiting then
						else
							create {OPEN_TYPE_A} last_type
						end
					end
				end
			end
		end

	process_variant_as (l_as: VARIANT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_tagged_as (l_as)
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
		local
			first_printed: BOOLEAN
			l_names_heap: like names_heap
			l_id: INTEGER
			l_feature: FEATURE_I
			l_feat: E_FEATURE
		do
			if not expr_type_visiting then
				from
					l_names_heap := names_heap
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					l_id := l_as.id_list.item
					l_feature := feature_from_ancestors (source_class, l_id)
						check
							l_feature /= Void
							l_feature.rout_id_set /= Void
						end
					l_feat := feature_in_class (current_class, l_feature.rout_id_set)
					first_printed := True
					l_as.id_list.forth
				end
			end
			last_type := strip_type
		end

	process_paran_as (l_as: PARAN_AS) is
		do
			l_as.expr.process (Current)
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
		do
			reset_last_class_and_type
			l_as.call.process (Current)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
		do
			if not expr_type_visiting then
				l_as.expr.process (Current)
			end
			last_type := pointer_type
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
		local
			l_type: TYPE_A
		do
			l_type ?= current_feature.type
			create {TYPED_POINTER_A} last_type.make_typed (l_type)
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
		local
			l_type: TYPE_A
		do
			l_type ?= current_class.actual_type
			create {TYPED_POINTER_A} last_type.make_typed (l_type)
		end

	process_address_as (l_as: ADDRESS_AS) is
		local
			l_feat: E_FEATURE
		do
			reset_last_class_and_type
			if not has_error_internal then
				if l_as.is_argument then
					create {TYPED_POINTER_A} last_type.make_typed (current_feature.arguments.i_th (l_as.argument_position))
				elseif l_as.is_local then
					if locals_for_current_feature.has_key (l_as.feature_name.internal_name.name) then
						create {TYPED_POINTER_A} last_type.make_typed (locals_for_current_feature.found_item)
					end
				else
					l_feat := feature_in_class (current_class, l_as.routine_ids)
					if l_feat /= Void and then l_feat.is_attribute then
						create {TYPED_POINTER_A} last_type.make_typed (l_feat.type.actual_type)
					else
						last_type := Pointer_type
					end
				end
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
		local
			l_feat: E_FEATURE
		do
				-- No type set for this expression?
			if not expr_type_visiting then
				if l_as.target /= Void then
					l_as.target.process (Current)
				end
				if l_as.class_id /= 0 and l_as.routine_ids /= Void then
					l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_as.routine_ids)
				else
					has_error_internal := True
				end

				if l_as.operands /= Void then
					reset_last_class_and_type
					l_as.operands.process (Current)
				end
				if not has_error_internal then
					last_type := expr_type (l_as)
				end
			else
				if not has_error_internal then
					last_type := agent_type (l_as)
				end
			end
		end

	process_unary_as (l_as: UNARY_AS) is
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_name: STRING
			l_expr_type: TYPE_A
			l_last_type: TYPE_A
			l_formal: FORMAL_A
			l_feature_list: like feature_from_type_set
		do
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
			end
			if not has_error_internal then
				l_expr_type := expr_type (l_as.expr)
			end
			if not has_error_internal then
				if l_expr_type.is_formal then
					l_formal ?= l_expr_type
					if l_formal.is_multi_constrained (current_class) then
						l_feature_list := feature_from_type_set (l_formal.constrained_types (current_class), l_as.routine_ids)
						if not has_error_internal then
								-- TODO: We simply pick the first even though there could be more than one.
								-- In the future one could display them all on right click.
							l_feat := l_feature_list.first.feature_item
							l_last_type := l_feature_list.first.class_type.type
						end
					else
						l_last_type := l_formal.constrained_type (current_class)
						l_feat := feature_in_class (l_last_type.associated_class, l_as.routine_ids)
					end
				else
					l_last_type := l_expr_type.actual_type
					l_feat := feature_in_class (l_last_type.associated_class, l_as.routine_ids)
				end
			end
			if not has_error_internal then
				if l_feat.is_prefix or l_feat.has_alias_name then
					if not expr_type_visiting then
						if l_feat.is_prefix then
							l_name := l_feat.prefix_symbol
						else
							l_name := l_feat.alias_symbol
						end
					end
					l_as.expr.process (Current)
				elseif l_feat.is_infix then
					check
						is_infix: False
					end
				else
					l_as.expr.process (Current)
				end
			else
				l_as.expr.process (Current)
			end
			if not has_error_internal then
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				check last_type_not_void: last_type /= Void end
				last_class := l_last_type.associated_class
				if l_type.is_loose then
					last_type := l_type.instantiation_in (l_last_type, last_class.class_id)
				else
					last_type := l_type
				end
			end
		end

	process_un_free_as (l_as: UN_FREE_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_not_as (l_as: UN_NOT_AS) is
		do
			process_unary_as (l_as)
		end

	process_un_old_as (l_as: UN_OLD_AS) is
		do
			l_as.expr.process (Current)
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			process_unary_as (l_as)
		end

	process_binary_as (l_as: BINARY_AS) is
		local
			l_feat: E_FEATURE
			l_name: STRING
			l_formal: FORMAL_A
			l_type: TYPE_A
			l_left_type, l_right_type: TYPE_A
			l_left_class: CLASS_C
			l_left_type_set, l_right_type_set: TYPE_SET_A
			l_is_left_multi_constrained, l_is_right_multi_constrained: BOOLEAN
			l_feature_list: like feature_from_type_set
		do
			reset_last_class_and_type
			l_as.left.process (Current)
			if not has_error_internal then
				check
					last_type /= Void
				end
				last_type := last_type.actual_type
					-- Find correct left type and left class.
				l_left_type := last_type
				if l_left_type.is_formal then
					l_formal ?= l_left_type
					if l_formal.is_multi_constrained (current_class) then
						l_is_left_multi_constrained := True
						l_left_type_set := l_formal.constrained_types (current_class)
					else
						l_left_type := l_formal.constrained_type (current_class)
					end
				end
				l_right_type := expr_type (l_as.right)
				if not has_error_internal then
					check
						l_right_type_not_void: l_right_type /= Void
					end
					l_right_type := l_right_type.actual_type

					if l_right_type.is_formal then
						l_formal ?= l_right_type
						if l_formal.is_multi_constrained (current_class) then
							l_is_right_multi_constrained := True
							l_right_type_set := l_formal.constrained_types (current_class)
						else
							l_right_type := l_formal.constrained_type (current_class)
						end
					end

					if l_as.is_left_type_converted then
						l_left_type := l_right_type
						l_is_left_multi_constrained := l_is_right_multi_constrained
						l_left_type_set := l_right_type_set
					end

					if l_is_left_multi_constrained then
						check
							l_left_type_set_not_void: l_left_type_set /= Void
							l_left_type_formal: l_left_type.is_formal
						end
						l_feature_list := feature_from_type_set (l_left_type_set, l_as.routine_ids)
						if not has_error_internal then
								-- TODO: We simply pick the first even though there could be more than one.
								-- In the future one could display them all on right click.
							l_feat := l_feature_list.first.feature_item
							l_left_type := l_feature_list.first.class_type.type
						end
					else
						check
							l_left_type_set_void: l_left_type_set = Void
							l_left_type_has_associated_class: l_left_type.has_associated_class
						end
						l_feat := feature_in_class (l_left_type.associated_class, l_as.routine_ids)
					end
					check not has_error_internal implies l_left_type /= Void end
					if not has_error_internal then
						l_left_class := l_left_type.associated_class
						last_type := l_left_type
					end
				end
			end
			if not expr_type_visiting then
				if not has_error_internal then
					check l_feat_not_void: l_feat /= Void end
					if l_feat.is_infix or l_feat.has_alias_name then
						if l_feat.is_infix then
							l_name := l_feat.infix_symbol
						else
							l_name := l_feat.alias_symbol
						end
						check l_feat_is_not_procedure: not l_feat.is_procedure end
						l_as.right.process (Current)
					else
						l_name := l_feat.name
						l_as.right.process (Current)
					end
				else
					l_as.right.process (Current)
				end
			end
			if not has_error_internal then
				check l_feat_not_void: l_feat /= Void end
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				if l_type.is_loose then
					last_type := l_type.instantiation_in (l_left_type, l_left_class.class_id)
				else
					last_type := l_type
				end
			else
					-- An error occurred, we reset `last_type' to Void.
				last_type := Void
			end
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_or_as (l_as: BIN_OR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
		do
			process_binary_as (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_tilde_as (l_as: BIN_TILDE_AS) is
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bin_not_tilde_as (l_as: BIN_NOT_TILDE_AS) is
		do
			l_as.left.process (Current)
			l_as.right.process (Current)
			last_type := boolean_type
		end

	process_bracket_as (l_as: BRACKET_AS) is
		local
			l_feat: E_FEATURE
			l_type: TYPE_A
			l_last_type: TYPE_A
			l_formal: FORMAL_A
			l_last_type_set: TYPE_SET_A
			l_last_class: CLASS_C
			l_result: LIST[TUPLE[feature_item: E_FEATURE; type: RENAMED_TYPE_A [TYPE_A]]]
		do
			l_as.target.process (Current)
			check
				routine_id_is_zero: l_as.routine_ids.first /= 0
				last_type_not_void: last_type /= Void
			end
			if not has_error_internal then
				last_type := last_type.actual_type
				if last_type.is_formal then
					l_formal ?= last_type
					if l_formal.is_multi_constrained (current_class) then
						l_last_type_set := l_formal.constrained_types (current_class)
							-- Here we get back the feature and the renamed type where the feature is from (it means that it includes a possible renaming)
						l_result := l_last_type_set.e_feature_list_by_rout_id(l_as.routine_ids.first)
						last_class := l_result.first.type.associated_class
						l_feat := l_result.first.feature_item
					else
						last_class := l_formal.constrained_type (current_class).associated_class
						l_feat := feature_in_class (last_class, l_as.routine_ids)
					end
				else
					last_class := last_type.associated_class
					l_feat := feature_in_class (last_class, l_as.routine_ids)
				end
			end
			if not expr_type_visiting then
				if l_as.operands /= Void then
					l_last_type := last_type
					l_last_class := last_class
					l_as.operands.process (Current)
					last_type := l_last_type
					last_class := l_last_class
				end
			end
			if not has_error_internal then
				check
					l_feat /= Void
				end
				check l_feat_is_not_procedure: not l_feat.is_procedure end
				l_type := l_feat.type.actual_type
				if l_type.is_loose then
					last_type := l_type.instantiation_in (last_type, last_class.class_id)
				else
					last_type := l_type
				end
			end
		end

	process_object_test_as (l_as: OBJECT_TEST_AS) is
		do
			l_as.name.process (Current)
			l_as.type.process (Current)
			l_as.expression.process (Current)
			last_type := boolean_type
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.language_name.process (Current)
		end

	process_feature_as (l_as: FEATURE_AS) is
		local
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			check
				current_class /= Void
			end
			l_as.feature_names.process (Current)
			l_as.body.process (Current)
			cont := l_as.body.content
			is_const_or_att := cont = Void or else cont.is_constant
		end

	process_feature_list_as (l_as: FEATURE_LIST_AS) is
		do
			l_as.features.process (Current)
		end

	process_assign_as (l_as: ASSIGN_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable (l_as)
			end
			l_as.target.process (Current)
			reset_last_class_and_type
			l_as.source.process (Current)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS) is
		do
			if not expr_type_visiting then
				reset_last_class_and_type
				put_breakable (l_as)
			end
			l_as.target.process (Current)
			l_as.source.process (Current)
		end

	process_reverse_as (l_as: REVERSE_AS) is
		do
			if not expr_type_visiting then
				put_breakable (l_as)
			end
			l_as.target.process (Current)
			l_as.source.process (Current)
		end

	process_check_as (l_as: CHECK_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.check_list /= Void then
				l_as.check_list.process (Current)
			end
		end

	process_creation_as (l_as: CREATION_AS) is
		do
			if not expr_type_visiting then
				put_breakable (l_as)
			end
			if l_as.type /= Void then
				l_as.type.process (Current)
			end
			processing_creation_target := True
			l_as.target.process (Current)
			processing_creation_target := False
			if l_as.call /= Void then
				l_as.call.process (Current)
			end

		end

	process_debug_as (l_as: DEBUG_AS) is
		do
			if l_as.keys /= Void and then not l_as.keys.is_empty then
				l_as.keys.process (Current)
			end
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_if_as (l_as: IF_AS) is
		do
			put_breakable (l_as)
			l_as.condition.process (Current)
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
			if l_as.elsif_list /= Void then
				l_as.elsif_list.process (Current)
			end
			if l_as.else_part /= Void then
				format_compound (l_as.else_part)
			end
		end

	process_inspect_as (l_as: INSPECT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable (l_as)
			l_as.switch.process (Current)
			if l_as.case_list /= Void then
				l_as.case_list.process (Current)
			end
			if l_as.else_part /= Void then
				if not l_as.else_part.is_empty then
					format_compound (l_as.else_part)
				end
			end
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
		do
			reset_last_class_and_type
			if not expr_type_visiting then
				put_breakable (l_as)
			end
			l_as.call.process (Current)
		end

	process_loop_as (l_as: LOOP_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.from_part /= Void then
				format_compound (l_as.from_part)
			else
			end
			if l_as.invariant_part /= Void then
				l_as.invariant_part.process (Current)
			end
			if l_as.variant_part /= Void then
				l_as.variant_part.process (Current)
			end
			put_breakable (l_as)
			l_as.stop.process (Current)
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_retry_as (l_as: RETRY_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable (l_as)
		end

	process_external_as (l_as: EXTERNAL_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.language_name.process (Current)
			if l_as.alias_name_literal /= Void then
				l_as.alias_name_literal.process (Current)
			end
		end

	process_attribute_as (l_as: ATTRIBUTE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_do_as (l_as: DO_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_once_as (l_as: ONCE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		local
			l_names_heap: like names_heap
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
				l_names_heap := names_heap
			l_as.type.process (Current)
			if processing_locals and last_actual_local_type /= Void then
				from
					l_as.id_list.start
				until
					l_as.id_list.after
				loop
					locals_for_current_feature.put (last_actual_local_type, l_names_heap.item (l_as.id_list.item))
					l_as.id_list.forth
				end
			end
		end

	process_class_as (l_as: CLASS_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			share_class_processing (l_as)
		end

	share_class_processing (l_as: CLASS_AS) is
			-- Shared part of `'processing_class_as' for both normal flat views and doc.
		local
			l_creators: EIFFEL_LIST [CREATE_AS]
			l_create: CREATE_AS
			l_features: EIFFEL_LIST [FEATURE_NAME]
			l_feat: FEATURE_I
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			processing_none_feature_part := True
			safe_process (l_as.top_indexes)
			format_header (l_as)
			if l_as.obsolete_message /= Void then
				l_as.obsolete_message.process (Current)
			end
			if l_as.parents /= Void then
				processing_parents := True
				l_as.parents.process (Current)
				processing_parents := False
			end
			l_creators := l_as.creators
			if l_creators = Void and then not l_as.is_deferred and then current_class.has_feature_table then
				l_feat := current_class.default_create_feature
				if l_feat /= Void then
					create l_creators.make (1)
					create l_features.make (1)
					l_features.extend (create {FEAT_NAME_ID_AS}.initialize (create {ID_AS}.initialize_from_id (l_feat.feature_name_id)))
					create l_create.initialize (Void, l_features, Void)
					l_creators.extend (l_create)
				end
			end
			if l_creators /= Void then
				check
					class_not_deferred: not l_as.is_deferred
				end
				l_creators.process (Current)
			end
			format_convert_clause (l_as.convertors)
			processing_none_feature_part := False
			safe_process (l_as.bottom_indexes)
		end

	process_parent_as (l_as: PARENT_AS) is
		local
			end_to_print: BOOLEAN
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.type.process (Current)
			check
				last_type_not_void: last_type /= Void
			end
			last_parent := last_type.associated_class
			check
				last_parent_not_void: last_parent /= Void
			end
			if l_as.renaming /= Void then
				format_clause (ti_rename_keyword, l_as.renaming, True)
				end_to_print := True
			end
			last_parent := Void
			if l_as.exports /= Void then
				format_clause (ti_export_keyword, l_as.exports, False)
				end_to_print := True
			end
			if l_as.undefining /= Void then
				format_clause (ti_undefine_keyword, l_as.undefining, True)
				end_to_print := True
			end
			if l_as.redefining /= Void then
				format_clause (ti_redefine_keyword, l_as.redefining, True)
				end_to_print := True
			end
			if l_as.selecting /= Void then
				format_clause (ti_select_keyword, l_as.selecting, True)
				end_to_print := True
			end
		end

	process_type_as (l_as: TYPE_AS) is
			-- Process `l_as'
		require
			l_as_not_void: l_as /= Void
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
		end

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			check_type (l_as)
			if processing_locals then
				last_actual_local_type := last_type
			end
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			process_type_as (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
				not_processing_locals: not processing_locals
			end

		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
			-- Process `l_as'.
		do
			process_type_as (l_as)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			process_type_as (l_as)
		end

	process_bits_as (l_as: BITS_AS) is
		do
			process_type_as (l_as)
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			process_type_as (l_as)
		end

	process_rename_as (l_as: RENAME_AS) is
		local
			l_last_parent: like last_parent
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.old_name.process (Current)
			l_last_parent := last_parent
			last_parent := Void
			l_as.new_name.process (Current)
			last_parent := l_last_parent
		end

	process_invariant_as (l_as: INVARIANT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.assertion_list /= Void then
				invariant_format_assertions (l_as.assertion_list)
			end
		end

	process_interval_as (l_as: INTERVAL_AS) is
		do
			l_as.lower.process (Current)
			if l_as.upper /= Void then
				l_as.upper.process (Current)
			end
		end

	process_index_as (l_as: INDEX_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.index_list.process (Current)
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.clients.process (Current)
			l_as.features.process (Current)
		end

	process_elseif_as (l_as: ELSIF_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			put_breakable (l_as)
			l_as.expr.process (Current)
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_create_as (l_as: CREATE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			if l_as.clients /= Void then
				l_as.clients.process (Current)
			end
			if l_as.feature_list /= Void then
					l_as.feature_list.process (Current)
			end
		end

	process_client_as (l_as: CLIENT_AS) is
		local
			temp: STRING
			cluster: CONF_GROUP
			client_classi: CLASS_I
			l_export_status: EXPORT_I
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			cluster := system.class_of_id (current_class.class_id).group
			l_export_status := export_status_generator.export_status (system, current_class, l_as)
			from
				l_as.clients.start
			until
				l_as.clients.after
			loop
				temp := l_as.clients.item.name
				client_classi := universe.safe_class_named (temp, cluster)
				l_as.clients.forth
			end
		end

	process_case_as (l_as: CASE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.interval.process (Current)
			if l_as.compound /= Void then
				format_compound (l_as.compound)
			end
		end

	process_ensure_as (l_as: ENSURE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_keyword)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_ensure_then_keyword)
		end

	process_require_as (l_as: REQUIRE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_keyword)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			format_assert_list_as (l_as, ti_require_else_keyword)
		end

	process_convert_feat_as (l_as: CONVERT_FEAT_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.feature_name.process (Current)
			l_as.conversion_types.process (Current)
		end

	process_void_as (l_as: VOID_AS) is
		do
			last_type := none_type
		end

	process_type_list_as (l_as: TYPE_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS) is
		do
			process_eiffel_list (l_as)
		end

	process_convert_feat_list_as (l_as: CONVERT_FEAT_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_class_list_as (l_as: CLASS_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_parent_list_as (l_as: PARENT_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.locals.process (Current)
		end

	process_formal_argu_dec_list_as (l_as: FORMAL_ARGU_DEC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.arguments.process (Current)
		end

	process_debug_key_list_as (l_as: DEBUG_KEY_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.keys.process (Current)
		end

	process_delayed_actual_list_as (l_as: DELAYED_ACTUAL_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			l_as.operands.process (Current)
		end

	process_parameter_list_as (l_as: PARAMETER_LIST_AS) is
		do
			l_as.parameters.process (Current)
		end

	process_rename_clause_as (l_as: RENAME_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_export_clause_as (l_as: EXPORT_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_undefine_clause_as (l_as: UNDEFINE_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_redefine_clause_as (l_as: REDEFINE_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_select_clause_as (l_as: SELECT_CLAUSE_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			safe_process (l_as.content)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS) is
		do
			check
				not_expr_type_visiting: not expr_type_visiting
			end
			process_eiffel_list (l_as)
		end

feature -- Expression visitor

	expr_type (a_expr: EXPR_AS): TYPE_A is
			-- Type of `a_expr'
			-- `last_type' is not modified.
		local
			l_last_type: like last_type
			l_last_class: like last_class
			l_ex_visiting: BOOLEAN
		do
			l_ex_visiting := expr_type_visiting
			expr_type_visiting := True
			l_last_type := last_type
			l_last_class := last_class
			last_type := Void
			a_expr.process (Current)
			Result := last_type
			last_type := l_last_type
			last_class := l_last_class
			expr_type_visiting := l_ex_visiting
			if not has_error_internal and Result = Void then
				has_error_internal := True
				set_error_message ("Expression type evaluating failed.")
			end
		ensure
			no_error_implies_result_is_not_void: not has_error_internal implies Result /= Void
			Result_is_not_a_type_set: not has_error_internal implies (not Result.is_type_set)
		end

	expr_types (a_exprs: EIFFEL_LIST [EXPR_AS]): ARRAY [TYPE_A] is
			-- Types of `expr_types'
			-- `last_type' is not modified.
		local
			i, l_count: INTEGER
			l_last_type: like last_type
			l_last_class: like last_class
			l_expr_visiting: BOOLEAN
		do
			l_expr_visiting := expr_type_visiting
			expr_type_visiting := True
			l_last_type := last_type
			l_last_class := last_class
			last_type := Void
			create Result.make (1, a_exprs.count)
			from
				i := 1
				l_count := a_exprs.count
			until
				i > l_count
			loop
				a_exprs.i_th (i).process (Current)
				Result.put (last_type, i)
				i := i + 1
			end
			last_type := l_last_type
			last_class := l_last_class
			expr_type_visiting := l_expr_visiting
		end

feature {NONE} -- Expression visitor

	expr_type_visiting: BOOLEAN
			-- Visiting only for expression type checking.

feature {NONE} -- Implementation: helpers

	format_compound (lc: EIFFEL_LIST [INSTRUCTION_AS]) is
		require
			lc_not_void: lc /= Void
		local
		do
			from
				lc.start
			until
				lc.after
			loop
				has_error_internal := False
				reset_last_class_and_type
				lc.item.process (Current)
				lc.forth
			end
		end

	Carriage_return_char: CHARACTER is '%N'

	format_header (l_as: CLASS_AS) is
		require
			l_as_not_void: l_as /= Void
		do
			format_generics (l_as.generics)
		end

	format_generics (l_as: EIFFEL_LIST [FORMAL_DEC_AS]) is
		do
			if l_as /= Void then
				l_as.process (Current)
			end
		end

	format_convert_clause (l_as: EIFFEL_LIST [CONVERT_FEAT_AS]) is
		do
			if l_as /= Void then
				l_as.process (Current)
			end
		end

	features_simple_format (l_as: EIFFEL_LIST [FEATURE_CLAUSE_AS]) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			fc, next_fc: FEATURE_CLAUSE_AS
			feature_list: EIFFEL_LIST [FEATURE_AS]
		do
			from
				i := 1
				l_count := l_as.count
				if l_count > 0 then
					fc := l_as.i_th (1)
				end
			until
				i > l_count
			loop
				i := i + 1
				if i <= l_count then
					next_fc := l_as.i_th (i)
				end
				feature_list := fc.features
				fc.process (Current)
				fc := next_fc
			end
		end

	format_clause (a_keyword: STRING; a_clause: EIFFEL_LIST [AST_EIFFEL]; has_separator: BOOLEAN) is
		require
			a_keyword_not_void: a_keyword /= Void
			a_clause_not_void: a_clause /= Void
		do
			a_clause.process (Current)
		end

	format_tagged_as (l_as: TAGGED_AS; hide_breakable_marks: BOOLEAN) is
		require
			l_as_not_void: l_as /= Void
		do
			if not hide_breakable_marks then
				put_breakable (l_as)
			end
			l_as.expr.process (Current)
		end

	invariant_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
		end

	invariant_simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_vod: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
		end

	format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]; hide_breakable_marks: BOOLEAN) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				if hide_breakable_marks then
					format_tagged_as (l_as.i_th (i), True)
				else
					l_as.i_th (i).process (Current)
				end
				not_first := True
				i := i + 1
			end
		end

	simple_format_assertions (l_as: EIFFEL_LIST [TAGGED_AS]) is
		require
			l_as_not_void: l_as /= Void
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				i := 1
				l_count := l_as.count
			until
				i > l_count
			loop
				l_as.i_th (i).process (Current)
				not_first := True
				i := i + 1
			end
		end

	format_assert_list_as (l_as: ASSERT_LIST_AS; a_keyword: STRING) is
		require
			l_as_not_void: l_as /= Void
			a_keyword_not_void: a_keyword /= Void
		do
			if l_as.assertions /= Void then
				format_assertions (l_as.assertions, False)
			end
		end

	format_creation_features (a_list: EIFFEL_LIST [FEATURE_NAME]) is
		require
			list_not_void: a_list /= Void
		do
		end

	current_assigner_feature: E_FEATURE is
		local
			l_feature: FEATURE_I
		do
			l_feature := feature_from_ancestors (source_class, current_feature.assigner_name_id)
			Result := feature_in_class (current_class, l_feature.rout_id_set)
		end

	feature_from_ancestors (a_current_class: CLASS_C; a_name_id: INTEGER): FEATURE_I is
		require
			a_current_class_not_void: a_current_class /= Void
		do
			Result := a_current_class.feature_table.item_id (a_name_id)
		end

	feature_in_class (a_class_c: CLASS_C; a_id_set: ID_SET): E_FEATURE is
			-- Feature with `a_id_set' in `a_class_c'
		require
			a_classs_c_not_void: a_class_c /= Void
			a_id_set_not_void: a_id_set /= Void
		do
			if not has_error_internal and a_id_set.first = 0 then
				has_error_internal := True
				set_error_message ("Feature with routine id of 0!!!")
			else
				if not has_error_internal then
					Result := a_class_c.feature_with_rout_id (a_id_set.first)
				end
			end
			if not has_error_internal and Result = Void then
				has_error_internal := True
				set_error_message ("Feature with routine id " + a_id_set.first.out + " could not be found.")
			end
		ensure
			feature_in_class_not_void: not has_error_internal implies Result /= Void
		end

	feature_from_type_set (a_type_set: TYPE_SET_A;	a_id_set: ID_SET): LIST[TUPLE[feature_item: E_FEATURE; class_type: RENAMED_TYPE_A [TYPE_A]]]
			-- Feature with `a_id_set' in `a_class_c'
		require
			a_type_set_not_void: a_type_set /= Void
			a_id_set_not_void: a_id_set /= Void
		do
			if not has_error_internal and a_id_set.first = 0 then
				has_error_internal := True
				set_error_message ("Feature with routine id of 0!!!")
			else
				if not has_error_internal then
					Result := a_type_set.e_feature_list_by_rout_id (a_id_set.first)
				end
			end
			if not has_error_internal and Result.is_empty then
				has_error_internal := True
				set_error_message ("Feature with routine id " + a_id_set.first.out + " could not be found.")
			end
		ensure
			feature_in_class_not_void: not has_error_internal implies (Result /= Void and then not Result.is_empty)
		end

	type_feature_i_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_FEATURE_I is
			-- Formal constraint class from `a_ancestor'
		local
			l_type_feature_i: TYPE_FEATURE_I
		do
			l_type_feature_i := a_ancestor.formal_at_position (a_formal.position)
			Result := l_type_feature_i
		end

	type_from_ancestor (a_ancestor: CLASS_C; a_formal: FORMAL_A): TYPE_A is
			-- Type from ancestor
		local
			l_feature_i: TYPE_FEATURE_I
		do
				-- Get TYPE_FEATURE_I from ancestor.
			l_feature_i := type_feature_i_from_ancestor (a_ancestor, a_formal)
				-- Find its version in descendant.
			l_feature_i := current_class.generic_features.item (l_feature_i.rout_id_set.first)
			check
				l_feature_i_not_void: l_feature_i /= Void
			end
			Result := l_feature_i.type
		end

	formal_constraint_class (a_type_feature_i: TYPE_FEATURE_I): CLASS_C is
			-- Formal constraint class from `a_type_feature_i'.
		local
			l_type: TYPE_A
			l_formal: FORMAL_A
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			l_type := a_type_feature_i.type
			l_formal ?= l_type
			if l_formal /= Void then
				check
					current_class_has_generics: current_class.generics /= Void
				end
				l_formal_dec ?= current_class.generics.i_th (l_formal.position)
				check l_formal_dec_not_void: l_formal_dec /= Void end
				Result := l_formal_dec.constraint_type (current_class).associated_class
			else
				Result := l_type.associated_class
			end
		end

--	constraining_types (a_type: TYPE_A): TYPE_SET_A is
--			-- Constrained type of `a_type'.
--		require
--			a_type_not_void: a_type /= Void
--		local
--			l_formal_type: FORMAL_A
--		do
--			if a_type.is_formal then
--				l_formal_type ?= a_type
--				Result := current_class.constraints (l_formal_type.position)
--			else
--				Result := a_type.to_type_set
--			end
--		end

--	constrained_type (a_type: TYPE_A): TYPE_A is
--			-- Constrained type of `a_type'.
--		require
--			a_type_not_void: a_type /= Void
--		local
--			l_formal_type: FORMAL_A
--		do
--			if a_type.is_formal then
--				l_formal_type ?= a_type
--				Result := current_class.constraint (l_formal_type.position)
--			else
--				Result := a_type
--			end
--		end

	strip_type: GEN_TYPE_A is
			-- Strip type
		require
			any_compiled: system.any_class.is_compiled
			array_compiled: system.array_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
			any_type: CL_TYPE_A
		once
			create generics.make (1, 1)
			create any_type.make (system.any_id)
			generics.put (any_type, 1)
			create Result.make (system.array_id, generics)
		end

	string_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := system.string_8_class.compiled_class.actual_type
		end

	check_type (a_type: TYPE_AS) is
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		require
			a_type_not_void: a_type /= Void
		local
			l_type: TYPE_A
		do
				-- Convert TYPE_AS into TYPE_A in the context of `source_class'.
			l_type := type_a_generator.evaluate_type_if_possible (a_type, source_class)

				-- An error occurs when a class was renamed.
			if not has_error_internal and l_type = Void then
				has_error_internal := True
				set_error_message ("Type evaluating failed.")
			end

			if not has_error_internal then
				-- If `source_feature' is Void, it means that we are outside of
				-- a feature, and therefore `l_type' must be valid because it should
				-- not have any anchors or bit symbols in `a_type'.
				if source_feature /= Void then
						-- Perform simple update of TYPE_A in context of `source_class'.
					type_a_checker.init_with_feature_table (source_feature, source_class.feature_table, Void, Void)
					l_type := type_a_checker.solved (l_type, a_type)

					if source_class /= current_class then
							-- We need to update `l_type' to the context of `current_class'
						l_type := l_type.instantiation_in (current_class.actual_type, source_class.class_id)
					end
				else
					check
						l_type_is_valid: l_type.is_valid
					end
				end
			end
				-- Update `last_type' with found type.
			last_type := l_type
		end

	agent_type (l_as: ROUTINE_CREATION_AS): GEN_TYPE_A is
			-- Compute type of `l_as'.
		require
			l_as_not_void: l_as /= Void
		local
			l_target_type: TYPE_A;
			l_arg_type:TYPE_A
			l_generics: ARRAY [TYPE_A]
			l_feat_args: E_FEATURE_ARGUMENTS
			l_oargtypes, l_argtypes: ARRAY [TYPE_A]
			l_tuple: TUPLE_TYPE_A
			l_count, l_idx, l_oidx: INTEGER
			l_operand: OPERAND_AS
			l_is_open: BOOLEAN
			l_result_type: GEN_TYPE_A
			l_actual_target_type: TYPE_A
			l_feat: E_FEATURE
			l_open: OPEN_TYPE_A
		do
			l_feat := feature_in_class (system.class_of_id (l_as.class_id), l_as.routine_ids)
			if not has_error_internal then
				if l_feat.has_return_value then
						-- generics are: base_type, open_types, result_type
					create l_generics.make (1, 3)
					l_generics.put (l_feat.type.actual_type, 3)
					create l_result_type.make (System.function_class_id, l_generics)
				else
						-- generics are: base_type, open_types
					create l_generics.make (1, 2)
					create l_result_type.make (System.procedure_class_id, l_generics)
				end

				if l_as.target = Void then
						-- Target is the closed operand `Current'.
					l_target_type := current_class.actual_type
				else
					l_as.target.process (Current)
					l_target_type := last_type
					l_open ?= l_target_type
					if l_open /= Void then
							-- Target is actually an open operand.
						l_target_type := current_class.actual_type
					end
				end

				l_actual_target_type := l_target_type.actual_type
				l_generics.put (l_target_type, 1)

				l_feat_args := l_feat.arguments

					-- Compute `operands_tuple' and type of TUPLE needed to determine current
					-- ROUTINE type.

					-- Create `l_argtypes', array used to initialize type of `operands_tuple'.
					-- This array can hold all arguments of the routine plus Current.
				if l_feat_args /= Void then
					l_count := l_feat_args.count + 1
				else
					l_count := 1
				end
				create l_argtypes.make (1, l_count)

					-- Create `l_oargtypes'. But first we need to find the `l_count', number
					-- of open operands.
				if l_as.target /= Void and then l_as.target.is_open then
						-- No target is specified, or just a class type is specified.
						-- Therefore there is at least one argument
					l_count := 1
					l_oidx := 2
				else
						-- Target was specified
					l_count := 0
					l_oidx  := 1
				end

					-- Compute number of open positions.
				if l_as.operands /= Void then
					from
						l_as.operands.start
					until
						l_as.operands.after
					loop
						if l_as.operands.item.is_open then
							l_count := l_count + 1
						end
						l_as.operands.forth
					end
				else
					if l_feat_args /= Void then
						l_count := l_count + l_feat_args.count
					end
				end

					-- Create `oargytpes' with `l_count' parameters. This array
					-- is used to create current ROUTINE type.
				create l_oargtypes.make (1, l_count)

				if l_count > 0 then
					if l_oidx > 1 then
							-- Target is open, so insert it.
						l_oargtypes.put (l_target_type, 1)
					end
				end

					-- Always insert target's type in `l_argtypes' as first argument.
				l_argtypes.put (l_target_type, 1)

					-- Create argument types
				if l_feat_args /= Void then
					from
							-- `l_idx' is 2, because at position `1' we have target of call.
						l_idx := 2
						l_feat_args.start
						if l_as.operands /= Void then
							l_as.operands.start
						end
					until
						l_feat_args.after
					loop
						l_arg_type := Void

							-- Let's find out if this is really an open operand.
						if l_as.operands /= Void then
							l_operand := l_as.operands.item
							if l_operand.is_open then
								l_is_open := True
								if l_operand.class_type /= Void then
									l_operand.process (Current)
									l_arg_type := last_type
								end
							else
								l_is_open := False
							end
						else
							l_is_open := True
						end

							-- Get type of operand.
						if l_is_open then
							if l_arg_type = Void then
								l_arg_type := l_feat_args.item.actual_type
							end
						else
							l_arg_type := l_feat_args.item.actual_type
						end

							-- Evaluate type of operand in current context
						l_arg_type := l_arg_type.instantiation_in (l_actual_target_type, l_as.class_id).deep_actual_type

							-- If it is open insert it in `l_oargtypes'
						if l_is_open then
							l_oargtypes.put (l_arg_type, l_oidx)
							l_oidx := l_oidx + 1
						end

							-- Add type to `l_argtypes'.
						l_argtypes.put (l_arg_type, l_idx)

						l_idx := l_idx + 1
						l_feat_args.forth

						if l_as.operands /= Void then
							l_as.operands.forth
						end
					end
				end

					-- Create open argument type tuple
				create l_tuple.make (System.tuple_id, l_oargtypes)
					-- Insert it as second generic parameter of ROUTINE.
				l_generics.put (l_tuple, 2)

				Result := l_result_type
			end
		ensure
			agent_type_not_void_if_no_error: not has_error_internal implies Result /= Void
		end

	put_breakable (a_as: AST_EIFFEL) is
			-- Puts a breakable if needed.
		do
			debug ("debugger_trace")
				print ("put_breakable : " + a_as.start_location.line.out + "%N")
			end
			breakable_lines.force_last (a_as.start_location.line)
		end

invariant
	error_message_not_void: error_message /= Void
	has_error_implies_error_message_not_empty: has_error implies not error_message.is_empty

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
