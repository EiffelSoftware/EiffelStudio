class
	E2B_ROUTINE_TRANSLATOR

inherit

	E2B_ROUTINE_TRANSLATOR_BASE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize routine translator.
		do
		end

feature -- Translation: Signature

	translate_routine_signature (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		require
			not_attribute: not a_feature.is_attribute
		do
			translate_signature (a_feature, a_type, False)
		end

	translate_creator_signature (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		do
			translate_signature (a_feature, a_type, True)
		end

	translate_default_create_signature (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate signature of feature `a_feature' of type `a_type'.
		do
			translate_signature (a_feature, a_type, True)
			-- TODO: create special signature
		end

	translate_logical_signature (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate signature of a logical feature `a_feature' of type `a_type'.
		require
			feature_logical: helper.is_feature_logical (a_feature)
		do
			set_context (a_feature, a_type)

				-- Add referenced types
			translation_pool.add_type (current_type)
			across arguments_of_current_feature as i loop
				translation_pool.add_type (i.type)
			end
			if current_feature.has_return_value then
				translation_pool.add_type (helper.class_type_in_context (current_feature.type, current_feature.written_class, current_feature, current_type))
			end

				-- Add precondition
			if helper.has_flat_precondition (current_feature) then
				translation_pool.add_function_precondition_predicate (current_feature, current_type)
			end
		end

	translate_signature (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_for_creator: BOOLEAN)
			-- Translate signature of feature `a_feature' of type `a_type'.
		require
			routine: a_feature.is_routine
		local
			l_proc_name: READABLE_STRING_8
			l_contracts: like contracts_of
			l_fields: LINKED_LIST [TUPLE [o: IV_EXPRESSION; f: IV_ENTITY]]
			l_modifies: IV_MODIFIES
		do
			set_context (a_feature, a_type)
			translation_pool.add_type (current_type)

				-- Check status compatibility
			if not helper.has_functional_representation (current_feature) and helper.is_functional (current_feature) then
				helper.add_semantic_warning (current_feature, messages.functional_feature_not_function, -1)
			end
			if a_feature.has_return_value and has_functional_versions then
				helper.add_semantic_error (current_feature, messages.functional_feature_redefined, -1)
			end

				-- Set up name
			l_proc_name :=
				if a_for_creator then
					name_translator.boogie_procedure_for_creator (current_feature, current_type)
				else
					name_translator.boogie_procedure_for_feature (current_feature, current_type)
				end

				-- Initialize procedure
			set_up_boogie_procedure (l_proc_name)

				-- Arguments
			if not helper.is_static (a_feature) then
				add_argument_with_property ("Current", create {LIKE_CURRENT}.make (current_type), current_type, types.for_class_type (current_type))
			end
			across arguments_of_current_feature as i loop
				add_argument_with_property (i.name, i.orig_type, i.type, i.boogie_type)
			end

				-- Result type
			add_result_with_property

				-- Modifies
			if helper.is_lemma (current_feature) then
					-- Lemmas do not modify the heap
			else
				create l_modifies.make ("Heap")
				current_boogie_procedure.add_contract (l_modifies)
			end

				-- Pre- and postconditions
			l_contracts := contracts_of (current_feature, current_type)
			across l_contracts.pre as j loop
				process_precondition (j.clause, j.origin)
			end
			create l_fields.make
			across l_contracts.post as j loop
				process_postcondition (j.clause, j.origin, l_fields)
			end

				-- Creator: add default field initialization
			if a_for_creator then
				add_field_initialization
					-- If it is `default_create' from any, add special post
				if current_feature.written_in = system.any_id and current_feature.rout_id_set.first = system.default_create_rout_id then
					add_default_create_postcondition
				end
			end

				-- Framing
			if options.is_ownership_enabled then
				add_ownership_contracts (a_for_creator, not helper.is_lemma (current_feature))
				add_agent_modifies
			else
					-- No choice anymore!
				check False end
			end

			if options.is_postcondition_predicate_enabled and not a_for_creator then
				add_postcondition_predicate
			end

				-- Onces
			if a_feature.is_once then
				add_once_specification
			end
		end

	translate_tuple_creator (a_type: CL_TYPE_A)
			-- Translate signature of creation procedure for tuple type `a_type'.
		require
			is_tuple: a_type.is_tuple
		local
			l_proc_name: STRING
			l_arg: IV_ENTITY
			l_modifies: IV_MODIFIES
			l_type: CL_TYPE_A
			l_post: IV_POSTCONDITION
		do
			set_context (Void, a_type)
			translation_pool.add_type (current_type)

			l_proc_name := name_translator.boogie_procedure_for_tuple_creation (current_type)

				-- Initialize procedure
			set_up_boogie_procedure (l_proc_name)

				-- Arguments
			add_argument_with_property ("Current", create {LIKE_CURRENT}.make (current_type), current_type, types.ref)
			across current_type.generics as params loop
				l_type := helper.class_type_in_context (params, current_type.base_class, Void, current_type)
				create l_arg.make ("f_" + @ params.target_index.out, types.for_class_type (l_type))
				add_argument_with_property (l_arg.name, params, l_type, l_arg.type)

				create l_post.make (factory.equal (
					factory.heap_access (factory.global_heap, factory.std_current, name_translator.boogie_field_for_tuple_field (a_type, @ params.target_index), l_arg.type),
					l_arg))
				current_boogie_procedure.add_contract (l_post)
			end

			create l_modifies.make ("Heap")
			current_boogie_procedure.add_contract (l_modifies)

			add_field_initialization

				-- wrapped
			create l_post.make (factory.function_call ("is_wrapped", << factory.global_heap, factory.std_current >>, types.bool))
			current_boogie_procedure.add_contract (l_post)

				-- global
			create l_post.make (factory.function_call ("global", << factory.global_heap >>, types.bool))
			current_boogie_procedure.add_contract (l_post)

				-- frame
			create l_post.make (factory.function_call (
				"same_outside", <<
					factory.old_ (factory.global_heap),
					factory.global_heap,
					factory.function_call ("Frame#Singleton", << factory.std_current >>, types.frame)
				>>,
				types.bool))
			current_boogie_procedure.add_contract (l_post)

				-- HeapSucc
			create l_post.make (factory.function_call ("HeapSucc", <<factory.old_heap, factory.global_heap>>, types.bool))
			current_boogie_procedure.add_contract (l_post)
		end

	add_field_initialization
			-- Add precondition to `current_boogie_procedure' that all attributes except "allocated" are initialized to default values.
		local
			l_mapping: E2B_ENTITY_MAPPING
			l_t: IV_VAR_TYPE
			l_f: IV_ENTITY
			l_forall: IV_FORALL
			l_pre: IV_PRECONDITION
		do
			create l_mapping.make
			create l_t.make_fresh
			create l_f.make ("$f", types.field (l_t))
			create l_forall.make (factory.implies_ (
				factory.not_equal (l_f, factory.entity ("allocated", types.field (types.bool))),
				factory.equal (
					factory.heap_current_access (l_mapping, l_f.name, l_t),
					factory.function_call ("Default", << l_f >>, l_t))
				))
			l_forall.add_type_variable (l_t.name)
			l_forall.add_bound_variable (l_f)
			create l_pre.make (l_forall)
			current_boogie_procedure.add_contract (l_pre)
		end

	add_default_create_postcondition
			-- Add postcondition to `current_boogie_procedure' that all attributes except "allocated" and "closed" are initialized to default values.
		local
			l_mapping: E2B_ENTITY_MAPPING
			l_t: IV_VAR_TYPE
			l_f, l_a: IV_ENTITY
			l_forall: IV_FORALL
			l_post: IV_POSTCONDITION
			l_cond: IV_EXPRESSION
			l_excluded: ARRAYED_LIST [IV_ENTITY]
		do
			create l_mapping.make
			create l_t.make_fresh
			create l_f.make ("$f", types.field (l_t))

				-- Excluded fields: allocated, closed, and model fields with static initializaers
			create l_excluded.make (5)
			l_excluded.extend (factory.entity ("allocated", types.field (types.bool)))
			l_excluded.extend (factory.entity ("closed", types.field (types.bool)))
			across
				helper.ghost_attributes (current_type.base_class) as a
			loop
				l_a := helper.field_from_attribute (a, current_type)
				if attached boogie_universe.function_named (name_translator.boogie_function_for_ghost_definition (current_type, l_a.name)) then
					l_excluded.extend (l_a)
				end
			end

			l_cond := factory.true_
			across l_excluded as e loop
				l_cond := factory.and_clean (l_cond, factory.not_equal (l_f, e))
			end

			create l_forall.make (factory.implies_ (l_cond,
				factory.equal (
					factory.heap_current_access (l_mapping, l_f.name, l_t),
					factory.function_call ("Default", << l_f >>, l_t))
				))
			l_forall.add_type_variable (l_t.name)
			l_forall.add_bound_variable (l_f)
			create l_post.make (l_forall)
			current_boogie_procedure.add_contract (l_post)
		end

	add_ownership_contracts (a_for_creator: BOOLEAN; a_modifies_heap: BOOLEAN)
			-- Add ownership contracts to current feature.
		local
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
			l_mapping: E2B_ENTITY_MAPPING
		do
				-- Preserves global invariant
			create l_pre.make (factory.function_call ("global", << factory.global_heap >>, types.bool))
			l_pre.set_free
			current_boogie_procedure.add_contract (l_pre)

				-- Unless class or feature are marked with "manual_inv", bring in the invariants of all wrapped objects
			if not helper.is_manual_inv (current_feature) and not helper.is_manual_inv_class (current_type.base_class) then
				create l_pre.make (factory.function_call ("global_permissive", << >>, types.bool))
				l_pre.set_free
				current_boogie_procedure.add_contract (l_pre)
			end

				-- Only add postconditions and frame properties if the procedure modifies heap
			if a_modifies_heap then
				create l_post.make (factory.function_call ("global", << factory.global_heap >>, types.bool))
				l_post.set_free
				current_boogie_procedure.add_contract (l_post)

					-- Framing
				across write_frame (a_for_creator) as i loop
					current_boogie_procedure.add_contract (i)
				end
				if helper.has_functional_representation (current_feature) then
					across read_frame as i loop
						current_boogie_procedure.add_contract (i)
					end
				end

					-- OWNERSHIP DEFAULTS
					-- TODO: should default precondtions be enabled for lemmas?
				create l_mapping.make
				l_mapping.set_current (current_boogie_procedure.arguments.first.entity)
				across ownership_default (a_for_creator, l_mapping) as i loop
					current_boogie_procedure.add_contract (i)
				end
			end
		end

	write_frame (a_for_creator: BOOLEAN): LINKED_LIST [IV_CONTRACT]
			-- Contracts expressing the write frame of the current routine.
		local
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
			l_fcall: IV_FUNCTION_CALL
		do
			create Result.make

				-- Precondition: Modify set is writable
			create l_fcall.make (name_translator.boogie_function_for_write_frame (current_feature, current_type), types.frame)
			l_fcall.add_argument (factory.global_heap)
			across current_boogie_procedure.arguments as i loop
				l_fcall.add_argument (i.entity)
			end
			create l_pre.make (factory.function_call ("Frame#Subset", << l_fcall, factory.global_writable>>, types.bool))
			l_pre.node_info.set_type ("pre")
			l_pre.node_info.set_tag ("frame_writable")
			Result.extend (l_pre)

				-- Free precondition: Everything in the domains of writable objects is writable
			if not helper.is_setter (current_feature) then
				create l_pre.make (factory.function_call ("closed_under_domains", <<factory.global_writable, factory.global_heap>>, types.bool))
				l_pre.set_free
				Result.extend (l_pre)
			end

				-- Free postcondition: Only writes set has changed
			create l_post.make (factory.writes_routine_frame (current_feature, current_type, current_boogie_procedure))
			l_post.set_free
			Result.extend (l_post)

			translation_pool.add_write_frame_function (current_feature, current_type)

				-- Free postcondition: HeapSucc
			create l_post.make (factory.function_call ("HeapSucc", <<factory.old_heap, factory.global_heap>>, types.bool))
			l_post.set_free
			Result.extend (l_post)
		end

	read_frame: LINKED_LIST [IV_CONTRACT]
			-- Contracts expressing the read frame of the current routine.
		local
			l_pre: IV_PRECONDITION
			l_fcall: IV_FUNCTION_CALL
		do
			create Result.make

				-- Free precondition: Read set is readable
			create l_fcall.make (name_translator.boogie_function_for_read_frame (current_feature, current_type), types.frame)
			l_fcall.add_argument (factory.global_heap)
			across current_boogie_procedure.arguments as i loop
				l_fcall.add_argument (i.entity)
			end
			create l_pre.make (factory.function_call ("Frame#Subset", << l_fcall, factory.global_readable>>, types.bool))
			l_pre.set_free
			Result.extend (l_pre)

			translation_pool.add_read_frame_function (current_feature, current_type)
		end

	ownership_default (a_for_creator: BOOLEAN; a_mapping: E2B_ENTITY_MAPPING): LINKED_LIST [IV_CONTRACT]
			-- Default ownership contracts.
		local
			l_pre: IV_PRECONDITION
			l_post: IV_POSTCONDITION
			l_written_feature: FEATURE_I
		do
			create Result.make

				-- Features marked with "explicit: contracts" do not get any defaults
			if not helper.is_explicit (current_feature, "contracts") then
				if helper.has_functional_representation (current_feature) then -- Pure functions						
					if helper.is_public (current_feature) and not helper.is_functional (current_feature) then
							-- Public features with functional representation (unless they are functional)
						create l_pre.make (factory.function_call ("is_closed", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
						l_pre.node_info.set_type ("pre")
						l_pre.node_info.set_tag ("default_is_closed")
						l_pre.node_info.set_attribute ("default", "contracts")
						Result.extend (l_pre)

						l_written_feature := current_feature.written_class.feature_of_rout_id_set (current_feature.rout_id_set)
						across arguments_of_current_feature as i loop
							if i.boogie_type ~ types.ref and not l_written_feature.arguments.i_th (@ i.target_index).is_formal then
								create l_pre.make (factory.function_call ("is_closed", << a_mapping.heap, factory.entity (i.name, i.boogie_type) >>, types.bool))
								l_pre.node_info.set_type ("pre")
								l_pre.node_info.set_tag ("arg_" + i.name + "_is_closed")
								l_pre.node_info.set_attribute ("default", "contracts")
								Result.extend (l_pre)
							end
						end
					end
				else -- Procedures and impure function
					if a_mapping.current_expression.type ~ types.ref then
						if a_for_creator then
							create l_post.make (factory.function_call ("is_wrapped", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
							l_post.node_info.set_type ("post")
							l_post.node_info.set_tag ("default_is_wrapped")
							l_post.node_info.set_attribute ("default", "contracts")
							Result.extend (l_post)
						elseif helper.is_public (current_feature) then
							create l_pre.make (factory.function_call ("is_wrapped", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
							l_pre.node_info.set_type ("pre")
							l_pre.node_info.set_tag ("default_is_wrapped")
							l_pre.node_info.set_attribute ("default", "contracts")
							Result.extend (l_pre)
							create l_post.make (factory.function_call ("is_wrapped", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
							l_post.node_info.set_type ("post")
							l_post.node_info.set_tag ("default_is_wrapped")
							l_post.node_info.set_attribute ("default", "contracts")
							Result.extend (l_post)
						elseif helper.is_private (current_feature) then
							create l_pre.make (factory.function_call ("is_open", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
							l_pre.node_info.set_type ("pre")
							l_pre.node_info.set_tag ("default_is_open")
							l_pre.node_info.set_attribute ("default", "contracts")
							Result.extend (l_pre)

							create l_post.make (factory.function_call ("is_open", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
							l_post.node_info.set_type ("post")
							l_post.node_info.set_tag ("default_is_open")
							l_post.node_info.set_attribute ("default", "contracts")
							Result.extend (l_post)
						end
					end
					if a_for_creator or helper.is_public (current_feature) then
						l_written_feature := current_feature.written_class.feature_of_rout_id_set (current_feature.rout_id_set)
						across arguments_of_current_feature as i loop
							if i.boogie_type ~ types.ref and not l_written_feature.arguments.i_th (@ i.target_index).is_formal then
								create l_pre.make (factory.function_call ("is_wrapped", << a_mapping.heap, factory.entity (i.name, i.boogie_type) >>, types.bool))
								l_pre.node_info.set_type ("pre")
								l_pre.node_info.set_tag ("arg_" + i.name + "_is_wrapped")
								l_pre.node_info.set_attribute ("default", "contracts")
								Result.extend (l_pre)
								create l_post.make (factory.function_call ("is_wrapped", << a_mapping.heap, factory.entity (i.name, i.boogie_type) >>, types.bool))
								l_post.node_info.set_type ("post")
								l_post.node_info.set_tag ("arg_" + i.name + "_is_wrapped")
								l_post.node_info.set_attribute ("default", "contracts")
								Result.extend (l_post)
							end
						end
					end
				end
			end
		end

	add_agent_modifies
			-- Add frame condition if `agent_modify' is used in precondition.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_name: READABLE_STRING_8
			l_fcall: IV_FUNCTION_CALL
			l_pre: IV_PRECONDITION
		do
			across contracts_of (current_feature, current_type).modifies as l_modifies loop
				if attached {FEATURE_B} l_modifies.clause.expr as l_call then
					l_name := names_heap.item (l_call.feature_name_id)
					if l_name.same_string ("modify_agent") then
						if attached {TUPLE_CONST_B} l_call.parameters.i_th (2).expression as l_tuple then
							create l_translator.make
							l_translator.set_context (current_feature, current_type)

							create l_fcall.make ("routine.modify_" + l_tuple.expressions.count.out, types.frame)
							l_fcall.add_argument (factory.heap_entity ("Heap"))
							l_call.parameters.i_th (1).expression.process (l_translator)
							l_fcall.add_argument (l_translator.last_expression)
							across l_tuple.expressions as exprs loop
								exprs.process (l_translator)
								l_fcall.add_argument (l_translator.last_expression)
							end

							create l_pre.make (factory.function_call ("Frame#Subset", <<l_fcall, factory.entity ("writable", types.frame)>>, types.bool))
							l_pre.node_info.set_type ("pre")
							l_pre.node_info.set_tag ("agent_modifies_writable")
							current_boogie_procedure.add_contract (l_pre)
						end
					end
				end
			end
		end

	add_once_specification
			-- Add once spec.
		require
			current_feature.is_once
		local
			l_type: IV_TYPE
			l_result: IV_ENTITY
			l_fcall: IV_FUNCTION_CALL
			l_post: IV_POSTCONDITION
		do
			if current_feature.has_return_value then
				l_type := types.for_class_type (helper.class_type_in_context (current_feature.type, current_feature.written_class, current_feature, current_type))
				l_result := factory.entity ("Result", l_type)
				l_fcall := factory.function_call ("global_once_value", << factory.int_value (current_feature.rout_id_set.first) >>, l_type)
				create l_post.make (factory.equal (l_result, l_fcall))
				l_post.set_free
				current_boogie_procedure.add_contract (l_post)
			end
		end

feature -- Translation: Implementation

	translate_routine_implementation (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		require
			routine: a_feature.is_routine
		do
			translate_implementation (a_feature, a_type, False)
		end

	translate_creator_implementation (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		do
			translate_implementation (a_feature, a_type, True)
		end

	translate_implementation (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_for_creator: BOOLEAN)
			-- Translate implementation of feature `a_feature' of type `a_type'.
		local
			l_procedure: IV_PROCEDURE
			l_implementation: IV_IMPLEMENTATION
			l_translator: E2B_INSTRUCTION_TRANSLATOR
			l_type: CL_TYPE_A
			l_proc_name: READABLE_STRING_8
			l_call: IV_PROCEDURE_CALL
			l_ownership_handler: E2B_CUSTOM_OWNERSHIP_HANDLER
			l_feature: FEATURE_I
			l_expr_translator: E2B_BODY_EXPRESSION_TRANSLATOR
			l_builtin_collector: E2B_BUILTIN_CALLS_COLLECTOR
			l_loc: IV_ENTITY
		do
			set_context (a_feature, a_type)
			set_inlining_options_for_feature (a_feature)

			l_proc_name :=
				if a_for_creator then
					name_translator.boogie_procedure_for_creator (current_feature, current_type)
				else
					name_translator.boogie_procedure_for_feature (current_feature, current_type)
				end

			l_procedure := boogie_universe.procedure_named (l_proc_name)
			check l_procedure /= Void end
			current_boogie_procedure := l_procedure

			create l_implementation.make (l_procedure)
			boogie_universe.add_declaration (l_implementation)

			create l_translator.make (l_implementation, current_feature, current_type)
			if helper.has_functional_representation (a_feature) then
				l_translator.set_context_readable (factory.global_readable)
				if not helper.is_invariant_unfriendly (current_feature) then
					create l_builtin_collector
					l_builtin_collector.set_any_target
				end
			end

				-- Add initial tracing information
			l_implementation.body.add_statement (factory.trace (l_proc_name))

			create l_ownership_handler
			create l_expr_translator.make
			l_expr_translator.set_context (a_feature, a_type)
			l_expr_translator.set_context_implementation (l_implementation)

				-- OWNERSHIP: start of routine body
			if options.is_ownership_enabled then
					-- Public procedures unwrap Current in the beginning, unless lemma or marked with explicit wrapping
				if not a_for_creator and helper.is_public (current_feature) and not a_feature.has_return_value and
					not helper.is_explicit (current_feature, "wrapping") and not helper.is_lemma (a_feature) and not helper.is_nonvariant (a_feature) then
					l_feature := system.any_type.base_class.feature_named ("unwrap")
					l_expr_translator.set_context_line_number (a_feature.body.start_location.line)

					l_ownership_handler.pre_builtin_call (l_expr_translator, l_feature)
					l_implementation.body.statements.append (l_expr_translator.side_effect)
					l_expr_translator.side_effect.wipe_out

					l_call := factory.procedure_call ("unwrap", << factory.std_current >>)
					l_call.node_info.set_attribute ("default", "wrapping")
					l_call.node_info.set_attribute ("cid", system.any_id.out)
					l_call.node_info.set_attribute ("rid", l_feature.rout_id_set.first.out)
					l_call.node_info.set_line (a_feature.body.start_location.line)
					l_implementation.body.add_statement (l_call)

					l_ownership_handler.post_builtin_call (l_expr_translator, l_feature)
					l_implementation.body.statements.append (l_expr_translator.side_effect)
					l_expr_translator.side_effect.wipe_out
				end
			end

				-- Process statements (byte node tree)
			helper.set_up_byte_context (current_feature, current_type)
			if attached Context.byte_code as l_byte_code then
				if l_byte_code.compound /= Void and then not l_byte_code.compound.is_empty then
					if l_byte_code.locals /= Void then
						across l_byte_code.locals as i loop
							l_type := helper.class_type_in_context (i, current_feature.written_class, current_feature, current_type)
							create l_loc.make (name_translator.boogie_name_for_local (@ i.cursor_index), types.for_class_type (l_type))
							l_translator.entity_mapping.set_local (@ i.cursor_index, l_loc)
						end
					end
					l_translator.process_compound (l_byte_code.compound)
					if l_byte_code.locals /= Void then
						across l_byte_code.locals as i loop
							if l_translator.entity_mapping.is_local_used (@ i.cursor_index) then
								l_type := helper.class_type_in_context (i, current_feature.written_class, current_feature, current_type)
								translation_pool.add_type (l_type)
								l_loc := l_translator.entity_mapping.local_ (@ i.cursor_index)
								l_implementation.add_local_with_property (l_loc.name, l_loc.type,
									types.type_property (l_type, factory.global_heap, l_loc, helper.is_type_exact (i, l_type, current_feature), i.is_attached))
							end
						end
					end

					if l_builtin_collector /= Void then
						l_byte_code.compound.process (l_builtin_collector)
						if l_builtin_collector.is_inv_unfriendly then
							helper.add_semantic_error (a_feature, messages.invalid_call_in_friendly_function, -1)
						end
					end
				end
			end

				-- OWNERSHIP: end of routine body
			if options.is_ownership_enabled then
				if not helper.is_explicit (current_feature, "wrapping") and not helper.is_lemma (a_feature) and not helper.is_nonvariant (a_feature) then
					if a_for_creator or helper.is_public (current_feature) and not a_feature.has_return_value then
						l_feature := system.any_type.base_class.feature_named ("wrap")
						l_expr_translator.set_context_line_number (a_feature.body.end_location.line)

						l_ownership_handler.pre_builtin_call (l_expr_translator, l_feature)
						l_implementation.body.statements.append (l_expr_translator.side_effect)
						l_expr_translator.side_effect.wipe_out

						l_call := factory.procedure_call ("wrap", << factory.std_current >>)
						l_call.node_info.set_attribute ("default", "wrapping")
						l_call.node_info.set_attribute ("cid", system.any_id.out)
						l_call.node_info.set_attribute ("rid", l_feature.rout_id_set.first.out)
						l_call.node_info.set_line (a_feature.body.end_location.line)
						l_implementation.body.add_statement (l_call)

						l_ownership_handler.post_builtin_call (l_expr_translator, l_feature)
						l_implementation.body.statements.append (l_expr_translator.side_effect)
						l_expr_translator.side_effect.wipe_out
					end
				end
			end
		end

feature -- Translation: Functions

	translate_functional_representation (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Generate a Boogie function that encodes the result of Eiffel function `a_feature' and its definitional axiom.
		local
			l_function, l_function0: IV_FUNCTION
			l_proc: IV_PROCEDURE
			l_post: IV_POSTCONDITION
			l_fcall: IV_FUNCTION_CALL
			l_type: CL_TYPE_A
			l_arg: IV_ENTITY
			l_reads: LIST [IV_EXPRESSION]
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			set_context (a_feature, a_type)
			helper.set_up_byte_context (current_feature, current_type)
			translation_pool.add_type (current_type)
			translation_pool.add_function_precondition_predicate (current_feature, current_type)

				-- Function
			l_type := helper.class_type_in_context (current_feature.type, current_type.base_class, current_feature, current_type)
			create l_function.make (name_translator.boogie_function_for_feature (current_feature, current_type, False), types.for_class_type (l_type))
			create l_function0.make (name_translator.boogie_function_for_feature (current_feature, current_type, True), types.for_class_type (l_type))
			boogie_universe.add_declaration (l_function)
			if helper.is_functional (current_feature) then
				boogie_universe.add_declaration (l_function0)
			end
			create l_fcall.make (l_function.name, l_function.type)

				-- Arguments
			if not current_feature.is_once then
				l_function.add_argument ("heap", types.heap)
				l_function0.add_argument ("heap", types.heap)
				l_fcall.add_argument (factory.old_ (factory.global_heap))
				if not helper.is_static (a_feature) then
					l_function.add_argument ("current", types.ref)
					l_function0.add_argument ("current", types.ref)
					l_fcall.add_argument (factory.std_current)
				end
				across
					arguments_of_current_feature as i
				loop
					create l_arg.make (i.name, i.boogie_type)
					translation_pool.add_type (i.type)
					l_function.add_argument (i.name, i.boogie_type)
					l_function0.add_argument (i.name, i.boogie_type)
					l_fcall.add_argument (l_arg)
				end
			end

				-- Definition
			generate_definition (l_function)
			if not helper.is_functional (a_feature) then
					-- Add a postcondition to the corresponding procedure connecting it to the function
					-- (so that properties claimed about the function can be traced back to the procedure result).
				l_proc := boogie_universe.procedure_named (name_translator.boogie_procedure_for_feature (current_feature, current_type))
				check attached l_proc and then not l_proc.results.is_empty end
				create l_post.make (factory.equal (l_proc.results.first.entity, l_fcall))
				l_post.set_free
				l_proc.add_contract (l_post)
			end

				-- Generate frame axiom, unless function reads universe
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_reads := read_expressions_of (contracts_of (current_feature, current_type).reads, l_translator).full_objects
			if not current_feature.is_once and not (across l_reads as e some factory.universe.same_expression (e) end) then
				if helper.is_functional (current_feature) then
					generate_frame_axiom (l_function, l_function0)
				else
					generate_frame_axiom (l_function, l_function)
				end
			end
		end

	translate_function_precondition_predicate (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate precondition predicate of feature `a_feature' of type `a_type'.
		local
			l_fname: READABLE_STRING_8
			l_pre_function, l_trigger_function: IV_FUNCTION
			l_mapping: E2B_ENTITY_MAPPING
			l_entity: IV_ENTITY
			l_body, l_free_body: IV_EXPRESSION
			l_is_logical: BOOLEAN
		do
			set_context (a_feature, a_type)
			l_is_logical := helper.is_class_logical (a_type.base_class)
			l_fname := name_translator.boogie_function_for_feature (current_feature, current_type, False)

				-- Function declaration
			create l_pre_function.make (name_translator.boogie_function_precondition (l_fname), types.bool)
--			create l_free_pre_function.make (name_translator.boogie_free_function_precondition (l_fname), types.bool)
			create l_trigger_function.make (name_translator.boogie_function_trigger (l_fname), types.bool)
			create l_mapping.make
			l_free_body := factory.true_

				-- Arguments
			if not l_is_logical then
					-- Only non-logical features depend on the heap
				l_entity := factory.heap_entity ("heap")
				l_pre_function.add_argument (l_entity.name, l_entity.type)
--				l_free_pre_function.add_argument (l_entity.name, l_entity.type)
				l_trigger_function.add_argument (l_entity.name, l_entity.type)
				l_mapping.set_heap (l_entity)

				l_free_body := factory.and_clean (l_free_body, factory.is_heap (l_entity))
			end
			if not helper.is_static (a_feature) and (not l_is_logical or else (create {E2B_CUSTOM_LOGICAL_HANDLER}).has_arg_current (a_feature)) then
					-- Non-static, non-logical features and some logical once take "current" as the first argument
				create l_entity.make ("current", types.for_class_type (a_type))
				l_pre_function.add_argument (l_entity.name, l_entity.type)
--				l_free_pre_function.add_argument (l_entity.name, l_entity.type)
				l_trigger_function.add_argument (l_entity.name, l_entity.type)
				l_mapping.set_current (l_entity)
				if not l_is_logical then
					l_free_body := factory.and_clean (l_free_body, types.type_property (current_type, l_mapping.heap, l_entity,
						helper.is_type_exact (create {LIKE_CURRENT}.make (current_type), current_type, current_feature), True))
				end
			end
			across arguments_of_current_feature as i loop
				create l_entity.make (i.name, i.boogie_type)
				l_pre_function.add_argument (l_entity.name, l_entity.type)
--				l_free_pre_function.add_argument (l_entity.name, l_entity.type)
				l_trigger_function.add_argument (l_entity.name, l_entity.type)
				l_mapping.set_argument (@ i.target_index, l_entity)
				if not l_is_logical then
					l_free_body := factory.and_clean (
						l_free_body,
						types.type_property (i.type, l_mapping.heap, l_entity,
							helper.is_type_exact (i.orig_type, i.type, current_feature),
							i.orig_type.is_attached))
				end
			end

				-- Set a dummy result in `l_mapping': we are not using postconditions anyway
			if a_feature.has_return_value then
				l_mapping.set_result (factory.entity ("result",
					types.for_class_type (helper.class_type_in_context (current_feature.type, current_type.base_class, current_feature, current_type))))
			end
				-- Body			
			l_body := pre_post_expressions_of (a_feature, a_type, l_mapping).pre
			if not l_is_logical then
				across ownership_default (False, l_mapping) as defs loop
					l_body := factory.and_clean (l_body, defs.expression)
				end
			end
			l_pre_function.set_body (l_body)
--			l_free_pre_function.set_body (l_free_body)
			boogie_universe.add_declaration (l_pre_function)
--			if not l_is_logical then
--				boogie_universe.add_declaration (l_free_pre_function)
--			end
			boogie_universe.add_declaration (l_trigger_function)
		end

	translate_frame_function (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_read: BOOLEAN)
			-- Translate the frame function of feature `a_feature' of type `a_type';
			-- (translate the read frame for the functional representation if `a_read' and the write frame otherwise)
		require
			read_for_pure_functions: a_read implies helper.has_functional_representation (a_feature)
		local
			l_exprs: like modify_expressions_of
			l_function: IV_FUNCTION
			l_forall: IV_FORALL
			l_fcall: IV_FUNCTION_CALL
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			set_context (a_feature, a_type)
			helper.set_up_byte_context (current_feature, current_type)

				-- Frame function
			if a_read then
				create l_function.make (name_translator.boogie_function_for_read_frame (current_feature, current_type), types.frame)
			else
				create l_function.make (name_translator.boogie_function_for_write_frame (current_feature, current_type), types.frame)
			end
			boogie_universe.add_declaration (l_function)

				-- Arguments
			translation_pool.add_type (current_type)
			l_function.add_argument ("heap", types.heap)
			if not helper.is_static (a_feature) then
				l_function.add_argument ("current", types.for_class_type (current_type))
			end
			across arguments_of_current_feature as i loop
				l_function.add_argument (i.name, i.boogie_type)
			end

				-- Get the modified objects and apply defaults
			create l_translator.make
			l_translator.entity_mapping.set_heap (create {IV_ENTITY}.make ("heap", types.heap))
			l_translator.entity_mapping.set_current (create {IV_ENTITY}.make ("current", types.ref))
			l_translator.set_context (current_feature, current_type)
			if a_read then
				l_exprs := read_expressions_of (contracts_of (current_feature, current_type).reads, l_translator)

					-- Defaults and validity
				if l_exprs.full_objects.is_empty and l_exprs.partial_objects.is_empty and l_exprs.model_objects.is_empty then
					-- Missing read clause: apply defaults
					l_exprs.full_objects.extend (factory.universe)
				end
			else
				l_exprs := modify_expressions_of (contracts_of (current_feature, current_type).modifies, l_translator)

					-- Defaults and validity
				if l_exprs.full_objects.is_empty and l_exprs.partial_objects.is_empty and l_exprs.model_objects.is_empty then
					-- Missing modify clause: apply defaults
					if not a_feature.has_return_value then
						l_exprs.full_objects.extend (create {IV_ENTITY}.make ("current", types.ref))
					end
				elseif a_feature.has_return_value and not helper.is_impure (a_feature) and not is_pure (l_exprs) then
					-- Only impure functions are allowed to have modify clauses
					helper.add_semantic_error (a_feature, messages.pure_function_has_mods, -1)
				end
			end

				-- Definitional axiom
				-- (forall args :: frame_defintition (f (args)))
			create l_fcall.make (l_function.name, types.frame)
			across l_function.arguments as a loop
				l_fcall.add_argument (a.entity)
			end
			if a_read and not helper.is_invariant_unfriendly (a_feature) then
				create l_forall.make (factory.implies_ (
					factory.is_heap (l_translator.entity_mapping.heap),
					frame_definition (l_exprs, l_fcall, << factory.entity ("closed", types.field (types.bool)), factory.entity ("owner", types.field (types.ref)) >>)))
			else
				create l_forall.make (factory.implies_ (
					factory.is_heap (l_translator.entity_mapping.heap),
					frame_definition (l_exprs, l_fcall, <<>>)))
			end
			across l_function.arguments as a loop
				l_forall.add_bound_variable (a.entity)
			end
			boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
		end

	translate_variant_functions (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate the decreases of feature `a_feature' of type `a_type'.
		local
			l_decreases_list: like decreases_expressions_of
			l_entity, l_heap, l_current: IV_ENTITY
			l_function: IV_FUNCTION
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			set_context (a_feature, a_type)
			helper.set_up_byte_context (current_feature, current_type)
			create l_heap.make ("heap", types.heap)
			create l_current.make ("current", types.for_class_type (a_type))

			create l_translator.make
			l_translator.entity_mapping.set_heap (l_heap)
			l_translator.entity_mapping.set_current (l_current)
			l_translator.set_context (current_feature, current_type)
			l_decreases_list := decreases_expressions_of (contracts_of (current_feature, current_type).decreases, l_translator)
			if l_decreases_list.is_empty then
				-- No decreases clause: apply default
				if l_current.type.has_rank and l_current.type /~ types.ref then
					l_decreases_list.extend (l_current)
				end
				across arguments_of_current_feature as j loop
					if j.boogie_type.has_rank then
						create l_entity.make (j.name, j.boogie_type)
						l_decreases_list.extend (l_entity)
					end
				end
					-- If still empty, add a trivial variant
				if l_decreases_list.is_empty then
					l_decreases_list.extend (factory.int_value (0))
				end
			elseif l_decreases_list.first = Void then
				-- Decreases empty set (*): do not check termination
				l_decreases_list.wipe_out
			end

				-- Generate a function per variant
			across
				l_decreases_list as i
			loop
				if i.type.has_rank then
						-- Decreases function
					create l_function.make (name_translator.boogie_function_for_variant (@ i.target_index, current_feature, current_type), i.type)
					l_function.set_inline
					boogie_universe.add_declaration (l_function)

						-- Arguments
					translation_pool.add_type (current_type)
					l_function.add_argument (l_heap.name, l_heap.type)
					if not helper.is_static (a_feature) then
						l_function.add_argument (l_current.name, l_current.type)
					end
					across arguments_of_current_feature as j loop
						l_function.add_argument (j.name, j.boogie_type)
					end
					l_function.set_body (i)
				else
					helper.add_semantic_error (a_feature, messages.variant_bad_type (@ i.target_index), -1)
				end
			end
		end

feature {NONE} -- Translation: Functions

	generate_definition (a_function: IV_FUNCTION)
			-- Generate a definitional axiom for `a_function' from the body of the current functional feature.
		local
			l_type: CL_TYPE_A
			l_expr_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_axiom: IV_AXIOM
			l_forall: IV_FORALL
			l_post: IV_EXPRESSION
			l_fcall, l_pre_call, l_trigger_call, l_f0call: IV_FUNCTION_CALL
		do
			create l_fcall.make (a_function.name, a_function.type)
			create l_pre_call.make (name_translator.boogie_function_precondition (a_function.name), types.bool)
			create l_trigger_call.make (name_translator.boogie_function_trigger (a_function.name), types.bool)
			create l_f0call.make (name_translator.boogie_function_for_feature (current_feature, current_type, True), a_function.type)
			across a_function.arguments as args loop
				l_fcall.add_argument (args.entity)
				l_pre_call.add_argument (args.entity)
				l_trigger_call.add_argument (args.entity)
				l_f0call.add_argument (args.entity)
			end

			l_expr_translator := translator_for_function (l_fcall)

				-- Generate axiom from postcondition
			l_post := pre_post_expressions_of (current_feature, current_type, l_expr_translator.entity_mapping).post
				-- Add type property
			l_type := helper.class_type_in_context (current_feature.type, current_type.base_class, current_feature, current_type)
			l_post := factory.and_clean (l_post,
				types.type_property (l_type, l_expr_translator.entity_mapping.heap, l_fcall,
					helper.is_type_exact (current_feature.type, l_type, current_feature),
					current_feature.type.is_attached))
			if not l_post.is_true then
				if current_feature.is_once then
					create l_forall.make (l_post)
					check attached {IV_ENTITY} l_expr_translator.entity_mapping.heap as ent then
						l_forall.add_bound_variable (ent)
					end
					l_forall.add_trigger (factory.function_call ("IsHeap", <<l_expr_translator.entity_mapping.heap>>, types.bool))
				else
					create l_forall.make (factory.implies_ (l_pre_call, l_post))
					l_forall.add_trigger (l_fcall)
				end
				l_forall.bound_variables.append (a_function.arguments)
				create l_axiom.make (l_forall)
				boogie_universe.add_declaration (l_axiom)
			end


				-- If functional, generate another axiom from body
			if helper.is_functional (current_feature) then
				l_expr_translator.set_use_uninterpreted_context_function (True)
				if attached Context.byte_code and then functional_body (Context.byte_code.compound) /= Void then
					functional_body (Context.byte_code.compound).process (l_expr_translator)
					l_post := factory.equal (l_fcall, l_expr_translator.last_expression)
				else
					helper.add_semantic_error (current_feature, messages.functional_feature_not_single_assignment, -1)
					l_post := factory.true_
				end

				if helper.is_opaque (current_feature) then
					create l_forall.make (factory.implies_ (factory.and_ (l_pre_call, l_trigger_call), l_post))
					l_forall.add_trigger (l_trigger_call)
				else
					create l_forall.make (factory.implies_ (l_pre_call, l_post))
					l_forall.add_trigger (l_fcall)
					l_forall.add_trigger (l_trigger_call)
				end
				l_forall.bound_variables.append (a_function.arguments)
				create l_axiom.make (l_forall)
				boogie_universe.add_declaration (l_axiom)

					-- Add synonym axiom for the uninterpreted representation
				create l_forall.make (factory.equal (l_fcall, l_f0call))
				l_forall.bound_variables.append (a_function.arguments)
				l_forall.add_trigger (l_fcall)
				create l_axiom.make (l_forall)
				boogie_universe.add_declaration (l_axiom)
			end
		end

	functional_body (a_body: BYTE_LIST [BYTE_NODE]): detachable EXPR_B
			-- The expression of a functional feature with body `a_body',
			-- if it has the right shape, otherwise Void.
		do
			if attached a_body and then 													-- body exists
				not a_body.is_empty and then												-- body has instructions
				attached {ASSIGN_B} a_body.last as l_assign_b and then						-- last instruction is an assignment...
				attached {RESULT_B} l_assign_b.target and then								-- ... to Result
				across a_body as c all not @ c.is_last implies attached {CHECK_B} c end	-- All instructions but last are checks
			then
				Result := l_assign_b.source
			end
		end

	translator_for_function (a_fcall: IV_EXPRESSION): E2B_CONTRACT_EXPRESSION_TRANSLATOR
			-- Translator that maps `Result' to the invocation of `a_fcall'.
		do
			create Result.make
			Result.entity_mapping.set_current (create {IV_ENTITY}.make ("current", types.ref))
			Result.entity_mapping.set_heap (create {IV_ENTITY}.make ("heap", types.heap))
			Result.set_context (current_feature, current_type)
			Result.entity_mapping.set_result (a_fcall)
		end

	generate_frame_axiom (a_function, a_function0: IV_FUNCTION)
			-- Generate a frame axiom for `a_function'.
		local
			l_old_heap, l_new_heap: IV_ENTITY
			l_old_call, l_new_call, l_read_frame, l_old_pre, l_pre: IV_FUNCTION_CALL
			l_condition: IV_EXPRESSION
			l_arg: IV_ENTITY
			l_forall: IV_FORALL
			l_axiom: IV_AXIOM
		do
			create l_old_heap.make ("h", types.heap)
			create l_new_heap.make ("h'", types.heap)

			create l_read_frame.make (name_translator.boogie_function_for_read_frame (current_feature, current_type), types.frame)
			l_read_frame.add_argument (l_old_heap)
			create l_old_call.make (a_function0.name, a_function0.type)
			l_old_call.add_argument (l_old_heap)
			create l_new_call.make (a_function0.name, a_function0.type)
			l_new_call.add_argument (l_new_heap)
			create l_old_pre.make (name_translator.boogie_function_precondition (a_function.name), types.bool)
			l_old_pre.add_argument (l_old_heap)
--			create l_old_free_pre.make (name_translator.boogie_free_function_precondition (a_function.name), types.bool)
--			l_old_free_pre.add_argument (l_old_heap)
			create l_pre.make (name_translator.boogie_function_precondition (a_function.name), types.bool)
			l_pre.add_argument (l_new_heap)
--			create l_free_pre.make (name_translator.boogie_free_function_precondition (a_function.name), types.bool)
--			l_free_pre.add_argument (l_new_heap)

			l_condition := factory.function_call ("HeapSucc", <<l_old_heap, l_new_heap>>, types.bool)
--			l_condition := factory.and_ (l_condition, l_old_free_pre)
			l_condition := factory.and_ (l_condition, l_old_pre)
--			l_condition := factory.and_ (l_condition, l_free_pre)
			l_condition := factory.and_ (l_condition, l_pre)
			l_condition := factory.and_ (l_condition, factory.function_call ("same_inside", <<l_old_heap, l_new_heap, l_read_frame>>, types.bool))
			create l_forall.make (factory.implies_ (l_condition, factory.equal (l_old_call, l_new_call)))
			l_forall.add_bound_variable (l_old_heap)
			l_forall.add_bound_variable (l_new_heap)
			across
				a_function0.arguments as args
			loop
				if not @ args.is_first then
					l_arg := args.entity
					l_read_frame.add_argument (l_arg)
					l_old_call.add_argument (l_arg)
					l_new_call.add_argument (l_arg)
					l_old_pre.add_argument (l_arg)
--					l_old_free_pre.add_argument (l_arg)
					l_pre.add_argument (l_arg)
--					l_free_pre.add_argument (l_arg)
					l_forall.add_bound_variable (l_arg)
				end
			end
			l_forall.add_compound_trigger (<< factory.function_call ("HeapSucc", <<l_old_heap, l_new_heap>>, types.bool),
				l_old_call, l_new_call >>)

			create l_axiom.make (l_forall)

			boogie_universe.add_declaration (l_axiom)
		end

feature -- Translation: agents		

	translate_postcondition_predicate (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Translate postconditino predicate of feature `a_feature' of type `a_type'.
		local
			l_procedure: IV_PROCEDURE
			l_function: IV_FUNCTION
		do
			set_context (a_feature, a_type)

			l_procedure := boogie_universe.procedure_named (name_translator.boogie_procedure_for_feature (current_feature, current_type))
			check l_procedure /= Void end
			current_boogie_procedure := l_procedure

				-- Function declaration
			create l_function.make (name_translator.postcondition_predicate_name (current_feature, current_type), types.bool)
			l_function.add_argument ("heap", types.heap)
			l_function.add_argument ("old_heap", types.heap)
			across current_boogie_procedure.arguments as i loop
				l_function.add_argument (i.name, i.type)
			end
			if a_feature.has_return_value then
				l_function.add_argument ("result", types.for_class_type (helper.class_type_in_context (a_feature.type, a_feature.written_class, a_feature, a_type)))
			end
			boogie_universe.add_declaration (l_function)

				-- Axioms per redefinition.
			generate_postcondition_axiom (current_feature, current_type, current_type)
				-- TODO: generate postcondition axiom for all known subtypes with redefined contracts
			if not current_feature.written_class.name_in_upper.is_equal ("ANY") then
				across current_feature.written_class.direct_descendants as d loop
					generate_postcondition_axiom (d.feature_named (current_feature.feature_name), current_type, d.actual_type)
				end
			end
--			current_feature.written_class.direct_descendants.item.feature_of_rout_id_set (current_feature.rout_id_set)
		end

	generate_postcondition_axiom (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_postcondition_type: CL_TYPE_A)
			-- Generate postcondition axiom for `current_feature' of type `a_context_type' for subtype `a_postcondition_type'.
		local
			l_contracts: TUPLE [pre: IV_EXPRESSION; post: IV_EXPRESSION]
			l_mapping: E2B_ENTITY_MAPPING
			l_heap, l_old_heap, l_current, l_result, l_arg: IV_ENTITY
			l_args: LINKED_LIST [IV_ENTITY]
			l_forall: IV_FORALL
			l_axiom: IV_AXIOM
			l_fcall, l_typeof: IV_FUNCTION_CALL
			l_type_value: IV_VALUE
			l_binop1, l_binop2, l_binop3: IV_BINARY_OPERATION
			l_post: IV_EXPRESSION
		do
			translation_pool.add_type (a_postcondition_type)
			create l_mapping.make
			create l_fcall.make (name_translator.postcondition_predicate_name (a_feature, a_context_type), types.bool)
			l_heap := factory.heap_entity ("heap")
			l_fcall.add_argument (l_heap)
			l_mapping.set_heap (l_heap)
			l_old_heap := factory.heap_entity ("old_heap")
			l_fcall.add_argument (l_old_heap)
			l_mapping.set_old_heap (l_old_heap)
			create l_current.make ("current", types.ref)
			l_fcall.add_argument (l_current)
			l_mapping.set_current (l_current)
			create l_args.make
			across arguments_of (a_feature, a_context_type) as i loop
				create l_arg.make (i.name, i.boogie_type)
				l_fcall.add_argument (l_arg)
				l_mapping.set_argument (@ i.target_index, l_arg)
				l_args.extend (l_arg)
			end
			if a_feature.has_return_value then
				create l_result.make ("result", types.for_class_type (helper.class_type_in_context (a_feature.type, a_feature.written_class, a_feature, a_context_type)))
				l_fcall.add_argument (l_result)
				l_mapping.set_result (l_result)
			end

			l_contracts := pre_post_expressions_of (a_feature, a_postcondition_type, l_mapping)
			create l_typeof.make ("type_of", types.type)
			l_typeof.add_argument (l_current)
			create l_type_value.make (name_translator.boogie_name_for_type (a_postcondition_type), types.type)
			create l_binop1.make (l_typeof, "<:", l_type_value, types.bool)

			l_post := l_contracts.post
			across ownership_default (False, l_mapping) as defs loop
				l_post := factory.and_clean (l_post, defs.expression)
			end

			create l_binop2.make (l_fcall, "==>", l_post, types.bool)
			create l_binop3.make (l_binop1, "==>", l_binop2, types.bool)

			create l_forall.make (l_binop3)
			l_forall.add_bound_variable (l_heap)
			l_forall.add_bound_variable (l_old_heap)
			l_forall.add_bound_variable (l_current)
			across l_args as j loop
				l_forall.add_bound_variable (j)
			end
			if a_feature.has_return_value then
				l_forall.add_bound_variable (l_result)
			end
			create l_axiom.make (l_forall)
			boogie_universe.add_declaration (l_axiom)
		end

feature {NONE} -- Implementation

	set_inlining_options_for_feature (a_feature: FEATURE_I)
			-- Set inlining options for feature `a_feature'.
		do
			options.set_inlining_depth (0)
			if options.is_inlining_enabled then
				if helper.boolean_feature_note_value (a_feature, "inline") then
					options.set_inlining_depth (1)
				elseif helper.integer_feature_note_value (a_feature, "inline") > 0 then
					options.set_inlining_depth (helper.integer_feature_note_value (a_feature, "inline"))
				elseif options.routines_to_inline.has (a_feature.body_index) then
					options.set_inlining_depth (1)
				else
					options.set_inlining_depth (0)
				end
			end
		end

	process_precondition (a_assert: ASSERT_B; a_origin_class: CLASS_C)
			-- Process `a_assert' as precondition inherited from `a_origin_class'.
			-- Translate "require expr" as:
			--	require pre(expr);
			--	free require free_pre(expr);
			--	require expr; // Here should be free_pre(expr) ==> expr, but it doesn't seem to have an effect in practice
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_contract: IV_PRECONDITION
			l_free_pre: IV_EXPRESSION
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.set_origin_class (a_origin_class)
			l_translator.set_context_line_number (a_assert.line_number)
			l_translator.set_context_tag (a_assert.tag)
			helper.set_up_byte_context (a_origin_class.feature_of_rout_id (current_feature.rout_id_set.first),
				helper.class_type_in_context (a_origin_class.actual_type, a_origin_class, Void, current_type))
			a_assert.process (l_translator)
			l_free_pre := factory.true_
			across l_translator.side_effect as i loop
				create l_contract.make (i.expression)
				l_contract.node_info.load (i.node_info)
				if i.is_free then
					l_contract.set_free
					l_free_pre := factory.and_clean (l_free_pre, i.expression)
				end
				current_boogie_procedure.add_contract (l_contract)
			end
			create l_contract.make (factory.implies_clean (l_free_pre, l_translator.last_expression))
			l_contract.node_info.set_type ("pre")
			l_contract.node_info.set_tag (a_assert.tag)
			l_contract.node_info.set_line (a_assert.line_number)
			current_boogie_procedure.add_contract (l_contract)
			helper.set_up_byte_context (current_feature, current_type)
		end

	process_postcondition (a_assert: ASSERT_B; a_origin_class: CLASS_C; a_fields: LIST [TUPLE [IV_EXPRESSION, IV_ENTITY]])
			-- Process `a_assert' as postcondition.
		local
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_contract: IV_POSTCONDITION
			l_free_pre: IV_EXPRESSION
		do
			create l_translator.make
			l_translator.set_context (current_feature, current_type)
			l_translator.set_origin_class (a_origin_class)
			l_translator.set_context_line_number (a_assert.line_number)
			l_translator.set_context_tag (a_assert.tag)
			helper.set_up_byte_context (a_origin_class.feature_of_rout_id (current_feature.rout_id_set.first),
				helper.class_type_in_context (a_origin_class.actual_type, a_origin_class, Void, current_type))
			a_assert.process (l_translator)
			a_fields.append (l_translator.field_accesses)
			l_free_pre := factory.true_
			across l_translator.side_effect as i loop
				create l_contract.make (i.expression)
				l_contract.node_info.load (i.node_info)
				if i.is_free then
					l_contract.set_free
					l_free_pre := factory.and_clean (l_free_pre, i.expression)
				end
				current_boogie_procedure.add_contract (l_contract)
			end
			create l_contract.make (factory.implies_clean (l_free_pre, l_translator.last_expression))
			l_contract.node_info.set_type ("post")
			l_contract.node_info.set_tag (a_assert.tag)
			l_contract.node_info.set_line (a_assert.line_number)
			current_boogie_procedure.add_contract (l_contract)
			helper.set_up_byte_context (current_feature, current_type)
		end

	add_postcondition_predicate
			-- Add postcondition predicate to current feature.
		local
			l_call: IV_FUNCTION_CALL
			l_post: IV_POSTCONDITION
		do
			translation_pool.add_postcondition_predicate (current_feature, current_type)
			create l_call.make (name_translator.postcondition_predicate_name (current_feature, current_type), types.bool)
			l_call.add_argument (factory.global_heap)
			l_call.add_argument (factory.old_heap)
			across current_boogie_procedure.arguments as i loop
				l_call.add_argument (i.entity)
			end
			if current_feature.has_return_value then
				l_call.add_argument (create {IV_ENTITY}.make ("Result", types.for_class_type (
					helper.class_type_in_context (current_feature.type, current_feature.written_class, current_feature, current_type))))
			end
			create l_post.make (l_call)
			l_post.set_free
			current_boogie_procedure.add_contract (l_post)
		end

	has_functional_versions: BOOLEAN
			-- Are any previous versions of `current_feature' functional?
		local
			i: INTEGER
		do
			if current_feature.assert_id_set /= Void then
				from
					i := 1
				until
					Result or i > current_feature.assert_id_set.count
				loop
					Result := not helper.is_same_class (current_feature.written_class, current_feature.assert_id_set [i].written_class) and
						helper.is_functional (current_feature.assert_id_set [i].written_class.feature_of_body_index (current_feature.assert_id_set [i].body_index))
					i := i + 1
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
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
