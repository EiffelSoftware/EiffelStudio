note
	description: "Translation of Eiffel types to Boogie."

class
	E2B_TYPE_TRANSLATOR

inherit

	E2B_SHARED_CONTEXT

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	SHARED_WORKBENCH
		export {NONE} all end

	SHARED_SERVER
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

feature -- Access

	type: CL_TYPE_A
			-- Type under translation.

	last_clauses: LINKED_LIST [IV_ASSERT]
			-- Last generated invariant clauses.

	last_safety_checks: LINKED_LIST [IV_ASSERT]
			-- Last generated precondition of the invariant.

	builtin_collector: E2B_BUILTIN_CALLS_COLLECTOR
			-- Visitor that collects information about the usage of built-in ghost fields.

feature -- Basic operations

	translate_type (a_type: CL_TYPE_A)
			-- Translate `a_type' to Boogie.
		require
			no_formals: not a_type.has_formal_generic
		local
			l_class: CLASS_C
			l_boogie_type_name: STRING
			l_constant: IV_CONSTANT
			l_path: PATH
			l_attr_translator: E2B_ATTRIBUTE_TRANSLATOR
			l_routine_translator: E2B_ROUTINE_TRANSLATOR
		do
			type := a_type
			l_class := a_type.base_class
			l_boogie_type_name := name_translator.boogie_name_for_type (a_type)

				-- Add dependencies
			across
				helper.class_note_values (l_class, "theory") as deps
			loop
				create l_path.make_from_string (deps)
				boogie_universe.add_dependency
					(if l_path.is_absolute then
						create {PATH}.make_from_string (deps)
					else
						l_path.absolute_path_in (l_class.lace_class.file_name.parent).canonical_path
					end)
			end

				-- Add actual generic parameters
			if a_type.has_generics then
				across a_type.generics as params loop
					if attached {CL_TYPE_A} params as t then
						translation_pool.add_parent_type (t)
					elseif attached {CL_TYPE_A} a_type.base_class.single_constraint (@ params.target_index) as t then
						translation_pool.add_parent_type (t)
					else
						check class_type_constraint: False then end
					end
				end
			end

			if not helper.is_class_logical (l_class) then
					-- Type definition
				create l_constant.make (l_boogie_type_name, types.type)
				l_constant.set_unique
				boogie_universe.add_declaration (l_constant)

				if l_class.is_tuple then
						-- Translate fields
					create l_attr_translator
					across a_type.generics as params loop
						l_attr_translator.translate_tuple_field (a_type, @ params.target_index)
					end

						-- Tranlsate creator
					create l_routine_translator.make
					l_routine_translator.translate_tuple_creator (a_type)
				else
					if a_type.base_class.is_frozen then
						boogie_universe.add_declaration (create {IV_AXIOM}.make (
							factory.function_call ("is_frozen", << factory.entity (l_boogie_type_name, types.type) >>, types.bool)))
					end

						-- Inheritance relations
					generate_inheritance_relations
				end
				add_default_field_ids
			end
		end

	translate_model (a_type: CL_TYPE_A)
			-- Translate model of `a_type'.
		require
			a_type_exists: a_type /= Void
		local
			l_class: CLASS_C
		do
			type := a_type
			l_class := type.base_class
			if not helper.is_class_logical (l_class) and not l_class.is_tuple then
					-- Check model clause
				across
					helper.model_queries (l_class) as m
				loop
					if a_type.base_class.feature_named (m) = Void then
						helper.add_semantic_error (l_class, messages.unknown_attribute ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (m), l_class.name_in_upper), -1)
					end
				end
				generate_model_axiom
			end
		end

	translate_invariant (a_type: CL_TYPE_A)
			-- Translate invariant of `a_type'.
		require
			a_type_exists: a_type /= Void
		local
			l_class: CLASS_C
		do
			type := a_type
			l_class := type.base_class

			if not helper.is_class_logical (l_class) and not helper.is_class_array (l_class) then
				helper.set_up_byte_context (l_class.invariant_feature, a_type)
				translate_invariant_function

				-- Add guards for built-in attributes (ANY versions)
				-- (required to know the lower bound on guards of unknown types)
				translation_pool.add_referenced_feature (system.any_type.base_class.feature_named ("owns"), system.any_type)
				translation_pool.add_referenced_feature (system.any_type.base_class.feature_named ("subjects"), system.any_type)
				translation_pool.add_referenced_feature (system.any_type.base_class.feature_named ("observers"), system.any_type)

				-- Add guards for built-in attributes
				translation_pool.add_referenced_feature (l_class.feature_named ("owns"), type)
				translation_pool.add_referenced_feature (l_class.feature_named ("subjects"), type)
				translation_pool.add_referenced_feature (l_class.feature_named ("observers"), type)
			end
		end

	translate_filtered_invariant_function (a_type: CL_TYPE_A; a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C)
			-- Translate filtered invariant of `a_type'.
		require
			a_type_exists: a_type /= Void
			a_ancestor_exists: a_ancestor /= Void
			not_both: a_included = Void or a_excluded = Void
		do
			type := a_type
			generate_invariant_function (a_included, a_excluded, a_ancestor)
			generate_filtered_invariant_axiom (a_included, a_excluded, a_ancestor)
		end

	translate_inline_invariant_check (a_type: CL_TYPE_A; a_target: IV_EXPRESSION)
			-- Translate the invariant of `a_type' into assert statements and store them in `last_clauses'.
		local
			l_mapping: E2B_ENTITY_MAPPING
		do
			helper.switch_byte_context (a_type.base_class.invariant_feature, a_type, a_type)
			type := a_type
			if a_target.same_expression (factory.std_current) then
					-- Standard target: use cache
				if invariant_check_cache.has_key (type) then
					last_clauses := invariant_check_cache [type]
				else
					create l_mapping.make
					generate_invariant_clauses (Void, Void, type.base_class, l_mapping)
					invariant_check_cache.put (last_clauses, type)
				end
			else
					-- Custom target: do not use cache, customize mapping
				if boogie_universe.function_named (name_translator.boogie_function_for_invariant (type)) = Void then
						-- If the whole invariant has not yet been translated,
						-- translate it first in order to generate static model definitions
					generate_invariant_function (Void, Void, type.base_class)
				end

				create l_mapping.make
				l_mapping.set_current (a_target)
				generate_invariant_clauses (Void, Void, type.base_class, l_mapping)
			end
			helper.unswitch_byte_context
		end

feature {NONE} -- Implementation

	translate_invariant_function
			-- Translate invariant of `type'.
		require
			a_type_exists: type /= Void
		do
			generate_invariant_function (Void, Void, type.base_class)
			generate_invariant_axiom ("user_inv", name_translator.boogie_function_for_invariant (type))
		end

	generate_inheritance_relations
			-- Generate axioms
			-- "TYPE <: PARENT1", "TYPE <: PARENT2", ..., and
			-- "forall t: Type :: {TYPE <: t} TYPE <: t <==> TYPE == t || PARENT1 <: t || PARENT2 <: t || ...".
		local
			l_parents: FIXED_LIST [CL_TYPE_A]
			l_parent: CL_TYPE_A
			l_type_value: IV_VALUE
			l_parent_value: IV_VALUE
			l_rhs: IV_EXPRESSION
			l_t: IV_ENTITY
			l_forall: IV_FORALL
		do
			create l_type_value.make (name_translator.boogie_name_for_type (type), types.type)
			create l_t.make ("t", types.type)
			l_rhs := factory.equal (l_t, l_type_value)
			l_parents := type.base_class.parents
			from
				l_parents.start
			until
				l_parents.after
			loop
				l_parent := l_parents.item.instantiated_in (type)
				translation_pool.add_parent_type (l_parent)
				create l_parent_value.make (name_translator.boogie_name_for_type (l_parent), types.type)
				l_rhs := factory.or_ (l_rhs, factory.sub_type (l_parent_value, l_t))
				boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.sub_type (l_type_value, l_parent_value)))
				l_parents.forth
			end
			create l_forall.make (factory.equiv (factory.sub_type (l_type_value, l_t), l_rhs))
			l_forall.add_bound_variable (l_t)
			l_forall.add_trigger (factory.sub_type (l_type_value, l_t))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
		end

	generate_model_axiom
			-- Generate an axiom listing all model queries of `type'.
		local
			l_type_var: IV_VAR_TYPE
			l_f, l_m: IV_ENTITY
			l_def: IV_EXPRESSION
			l_fcall: IV_FUNCTION_CALL
			l_forall: IV_FORALL
		do
			create l_type_var.make_fresh
			create l_f.make ("$f", types.field (l_type_var))
			l_def := factory.false_
			across helper.flat_model_queries (type.base_class) as m loop
				if m.written_in /= system.any_id then
					translation_pool.add_referenced_feature (m, type)
				end
				create l_m.make (
					helper.boogie_name_for_attribute (m, type),
					types.field (types.for_class_type (helper.class_type_in_context (m.type, type.base_class, m, type))))
				l_def := factory.or_clean (l_def, factory.equal (l_f, l_m))
			end
			l_fcall := factory.function_call ("IsModelField", << l_f, factory.type_value (type) >>, types.bool)
			create l_forall.make (factory.equiv (l_fcall, l_def))
			l_forall.add_type_variable (l_type_var.name)
			l_forall.add_bound_variable (l_f)
			l_forall.add_trigger (l_fcall)
			boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
		end

	generate_invariant_function (a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C)
			-- Generate invariant function for `type';
			-- if `a_included /= Void', include only those clauses;
			-- if `a_excluded /= Void', exclude those clauses;
			-- restrict clauses to those inherited from `a_ancestor'.
		require
			type_exists: type /= Void
			valid_type: type.is_class_valid
			no_like_type: not type.is_like
			a_ancestor_exists: a_ancestor /= Void
			not_both: a_included = Void or a_excluded = Void
		local
			l_heap, l_current: IV_ENTITY
			l_inv_function: IV_FUNCTION
			l_mapping: E2B_ENTITY_MAPPING
		do
			l_heap := factory.entity ("heap", types.heap)
			l_current := factory.entity ("current", types.ref)

			if a_included = Void and a_excluded = Void and a_ancestor.class_id = type.base_class.class_id then
				create l_inv_function.make (name_translator.boogie_function_for_invariant (type), types.bool)
				l_inv_function.set_inline
			else
				create l_inv_function.make (name_translator.boogie_function_for_filtered_invariant (type, a_included, a_excluded, a_ancestor), types.bool)
			end

			if boogie_universe.function_named (l_inv_function.name) = Void then
				l_inv_function.add_argument (l_heap.name, l_heap.type)
				l_inv_function.add_argument (l_current.name, l_current.type)
				boogie_universe.add_declaration (l_inv_function)

				create l_mapping.make
				l_mapping.set_heap (l_heap)
				l_mapping.set_current (l_current)

				if type.base_class.is_tuple then
					generate_tuple_invariant_clauses (l_mapping)
				else
					generate_invariant_clauses (a_included, a_excluded, a_ancestor, l_mapping)
				end

				l_inv_function.set_body (factory.conjunction (last_clauses))
			end
		end

	generate_invariant_clauses (a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C; a_mapping: E2B_ENTITY_MAPPING)
			-- Translate invariant clauses for `type' using `a_mapping', add default clauses;
			-- store result in `last_clauses'.
		require
			type_exists: type /= Void
			ancestor_exists: a_ancestor /= Void
			mapping_exists: a_mapping /= Void
		local
			l_clause: IV_ASSERT
		do
			create builtin_collector
			process_invariants (a_ancestor, a_included, a_excluded, a_mapping)
				-- Add ownership defaults unless included clauses are explicitly specified
			if options.is_ownership_enabled then
				if not type.base_class.is_deferred then
						-- For an effective class: built-in ghost sets are empty by default
						-- (ToDo: the policy seems arbitrary, should it be for all non-frozen classes?)
					add_default_clause ("observers", translation_mapping.default_tags [1], a_included, a_excluded, a_mapping)
					add_default_clause ("subjects", translation_mapping.default_tags [2], a_included, a_excluded, a_mapping)
					add_default_clause ("owns", translation_mapping.default_tags [3], a_included, a_excluded, a_mapping)
				end
				if not helper.is_class_explicit (type.base_class, "invariant") and
				 is_tag_included (a_included, a_excluded, translation_mapping.default_tags [4]) then
					create l_clause.make (factory.function_call ("admissibility2", << a_mapping.heap, a_mapping.current_expression >>, types.bool))
					l_clause.node_info.set_type ("inv")
					l_clause.node_info.set_tag (translation_mapping.default_tags [4])
					last_clauses.extend (l_clause)
				end
			end
		end

	generate_tuple_invariant_clauses (a_mapping: E2B_ENTITY_MAPPING)
			-- Translate invariant clauses for `type' using `a_mapping', add default clauses;
			-- store result in `last_clauses'.
		require
			type_exists: type /= Void
		do
			create builtin_collector
			create last_clauses.make
			add_default_clause ("observers", translation_mapping.default_tags [1], Void, Void, a_mapping)
			add_default_clause ("subjects", translation_mapping.default_tags [2], Void, Void, a_mapping)
			add_default_clause ("owns", translation_mapping.default_tags [3], Void, Void, a_mapping)
		end

	add_default_clause (a_name, a_tag: READABLE_STRING_8; a_included, a_excluded: LIST [READABLE_STRING_8]; a_mapping: E2B_ENTITY_MAPPING)
			-- Add default definition for a built-in attrbute `a_name' with tag `a_tag'.
		local
			l_clause: IV_ASSERT
		do
			if not helper.is_class_explicit (type.base_class, a_name) and not builtin_collector.has_attribute (a_name) then
				if is_tag_included (a_included, a_excluded, a_tag) then
					create l_clause.make (empty_set_property (a_name, a_mapping))
					l_clause.node_info.set_type ("inv")
					l_clause.node_info.set_tag (a_tag)
					last_clauses.extend (l_clause)
				end
			elseif a_included /= Void and then a_included.has (a_tag) then
				helper.add_semantic_error (type.base_class, messages.invalid_tag ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_tag), type.base_class.name_in_upper), -1)
			end
		end

	empty_set_property (a_name: READABLE_STRING_8; a_mapping: E2B_ENTITY_MAPPING): IV_EXPRESSION
		do
			Result := factory.function_call (
				"Set#IsEmpty",
				<< factory.heap_access (a_mapping.heap, a_mapping.current_expression, a_name, types.set (types.ref)) >>,
				types.bool)
		end

	processed_classes: ARRAYED_LIST [INTEGER]
			-- List of classes already seen during the latest call to `process_invariants'.

	process_invariants (a_class: CLASS_C; a_included, a_excluded: LIST [STRING]; a_mapping: E2B_ENTITY_MAPPING)
			-- Process invariants of `a_class' and its ancestors, and store results in `last_clauses'.
		require
			a_class_exists: a_class /= Void
			a_mapping_exists: a_mapping /= Void
		do
			create last_clauses.make
			create last_safety_checks.make
			create processed_classes.make (5)
			processed_classes.extend (system.any_id)
			process_flat_invariants (a_class, a_included, a_excluded, a_mapping)
		end

	process_flat_invariants (a_class: CLASS_C; a_included, a_excluded: LIST [STRING]; a_mapping: E2B_ENTITY_MAPPING)
			-- Recursively process invariants of `a_class' and its ancestors.
		local
			l_classes: FIXED_LIST [CLASS_C]
		do
			from
				l_classes := a_class.parents_classes
				l_classes.start
			until
				l_classes.after
			loop
				if not processed_classes.has (l_classes.item.class_id) then
					process_flat_invariants (l_classes.item,a_included, a_excluded, a_mapping)
				end
				l_classes.forth
			end
			process_immediate_invariants (a_class, a_included, a_excluded, a_mapping)
			processed_classes.extend (a_class.class_id)
		end

	is_tag_included (a_included, a_excluded: LIST [READABLE_STRING_8]; a_tag: READABLE_STRING_8): BOOLEAN
			-- Should `a_tag' be included into the invariant function according `a_included' and `a_excluded'?
		do
			Result := (a_included = Void and a_excluded = Void) or else	-- Processing full invariant
				(a_included /= Void and then a_tag /= Void and then a_included.has (a_tag)) or else -- Or explicitly included
				(a_excluded /= Void and then (a_tag = Void or else not a_excluded.has (a_tag))) -- Or not expliciltly excluded
		end

	process_immediate_invariants (a_class: CLASS_C; a_included, a_excluded: LIST [STRING]; a_mapping: E2B_ENTITY_MAPPING)
			-- Process invariants written in `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			l_assert: ASSERT_B
			l_clause: IV_ASSERT
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
			l_found: BOOLEAN
			t: CL_TYPE_A
		do
			if inv_byte_server.has (a_class.class_id) then
				t := helper.class_type_in_context (a_class.actual_type, a_class, a_class.invariant_feature, type)
				helper.switch_byte_context (a_class.invariant_feature, t, t)
				across
					inv_byte_server.item (a_class.class_id).byte_list as b
				loop
					l_assert := b
					if is_tag_included (a_included, a_excluded, l_assert.tag) then
						create l_translator.make
						l_translator.set_context (a_class.invariant_feature, type)
							-- Entity mapping should be copied after setting the context
							-- because setting the context can also set a mapping for "Current".
						l_translator.copy_entity_mapping (a_mapping)
						l_translator.set_origin_class (a_class)
						l_translator.set_context_line_number (l_assert.line_number)
						l_translator.set_context_tag (l_assert.tag)
						l_translator.set_context_readable (factory.function_call ("user_inv_readable", << a_mapping.heap, a_mapping.current_expression >>, types.frame))
						l_translator.set_use_triggers (True)
						l_assert.process (l_translator)
						last_safety_checks.append (l_translator.side_effect)
						last_safety_checks.extend (create {IV_ASSERT}.make_assume (l_translator.last_expression))
						create l_clause.make (l_translator.last_expression)
						l_clause.node_info.set_type ("inv")
						l_clause.node_info.set_tag (l_assert.tag)
						l_clause.node_info.set_line (l_assert.line_number)
						l_clause.node_info.set_attribute ("cid", a_class.class_id.out)
						last_clauses.extend (l_clause)
							-- If ownership is enabled and we are processing the full invariant,
							-- check if the invariant clause defines one of the ghost attribtues
							-- and generate correspoding functions
						if options.is_ownership_enabled and a_included = Void and a_excluded = Void then
							l_found := False
							across
								helper.ghost_attributes (type.base_class) as a
							until
								l_found
							loop
								if not a.feature_name.same_string ("closed") and not a.feature_name.same_string ("owner") then
									l_found := generate_ghost_definition (l_translator.last_expression, a)
								end
							end
						end
					end
					l_assert.process (builtin_collector)
				end
				helper.unswitch_byte_context
			end
		end

	generate_invariant_axiom (a_generic_function, a_special_function: STRING)
			-- Generate axioms that connect `a_generic_function' with `a_special_function'.
		local
			l_heap, l_current: IV_ENTITY
			l_generic_call, l_special_call: IV_FUNCTION_CALL
		do
			create l_heap.make ("heap", types.heap)
			create l_current.make ("current", types.ref)
			l_generic_call := factory.function_call (a_generic_function, << l_heap, l_current >>, types.bool)
			l_special_call := factory.function_call (a_special_function, << l_heap, l_current >>, types.bool)

			factory.add_dynamic_predicate_definition (
				factory.function_call (a_generic_function, << l_heap, l_current >>, types.bool),
				factory.function_call (a_special_function, << l_heap, l_current >>, types.bool),
				type, l_heap, l_current, <<>>)
		end

	generate_ghost_definition (a_expr: IV_EXPRESSION; a_attr: FEATURE_I): BOOLEAN
			-- If `a_expr' has the form `a_name = def', create a Boogie function that defines `a_name' for `type' as `def'.
			-- (Only accepting definitions of this form to avoid cycles).
		local
			l_fname: STRING
			l_current, l_heap, l_field: IV_ENTITY
			l_def: IV_EXPRESSION
			l_function: IV_FUNCTION
		do
			create l_current.make ("current", types.ref)
			create l_heap.make ("heap", types.heap)

			l_def := definition_of (a_expr, l_heap, l_current, a_attr)
			if attached l_def and not helper.is_class_explicit (type.base_class, a_attr.feature_name) then
				l_field := helper.field_from_attribute (a_attr, type)
				l_fname := name_translator.boogie_function_for_ghost_definition (type, l_field.name)
				l_function := boogie_universe.function_named (l_fname)
				if l_function = Void then
						-- There is no definition for this model query yet
					create l_function.make (l_fname, l_def.type)
					l_function.add_argument (l_heap.name, l_heap.type)
					l_function.add_argument (l_current.name, l_current.type)
					l_function.set_body (l_def)
					boogie_universe.add_declaration (l_function)
				else
						-- There is a definition already, but we have found a new one, lower in the hierarchy
						-- so it should take precedence
					l_function.set_body (l_def)
				end
				Result := True
			end
		end

	definition_of (a_expr: IV_EXPRESSION; a_heap, a_current: IV_ENTITY; a_attr: FEATURE_I): detachable IV_EXPRESSION
			-- If `a_expr' has the form `a_name = def' return `def', otherwise `Void'.
		local
			l_type: CL_TYPE_A
			l_field: IV_ENTITY
			l_eq: READABLE_STRING_8
		do
			l_type := helper.class_type_in_context (a_attr.type, type.base_class, type.base_class.invariant_feature, type)
			l_field := helper.field_from_attribute (a_attr, type)
			if helper.is_class_logical (l_type.base_class) then
				l_eq := helper.function_for_logical (l_type.base_class.feature_named ("is_equal"))
				if
					attached {IV_FUNCTION_CALL} a_expr as fcall and then
					fcall.name.same_string (l_eq) and then
					fcall.arguments [1].same_expression (factory.heap_access (a_heap, a_current, l_field.name, types.field_content_type (l_field.type)))
				then
					Result := fcall.arguments [2]
				end
			elseif
				attached {IV_BINARY_OPERATION} a_expr as binop and then
				binop.operator.same_string ("==") and then
				binop.left.same_expression (factory.heap_access (a_heap, a_current, l_field.name, types.field_content_type (l_field.type)))
			then
				Result := binop.right
			end
		end

	generate_filtered_invariant_axiom (a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C)
			-- Generate axiom (forall o: ref :: {partial_inv(h, o)} IsHeap(h) && h[o, allocated] && h[o, closed] ==> partial_inv(h, o))
		local
			l_h, l_o: IV_ENTITY
			l_fcall: IV_FUNCTION_CALL
			l_forall: IV_FORALL
		do
			create l_h.make ("h", types.heap)
			create l_o.make ("o", types.ref)
			l_fcall := factory.function_call (name_translator.boogie_function_for_filtered_invariant (type, a_included, a_excluded, a_ancestor),
				<< l_h, l_o >>, types.bool)
			create l_forall.make (factory.implies_ (
				factory.and_ (factory.function_call ("IsHeap", << l_h >>, types.bool),
					factory.and_ (
						factory.function_call ("attached", << l_h, l_o, factory.type_value (type) >>, types.bool),
						factory.heap_access (l_h, l_o, "closed", types.bool))),
				l_fcall))
			l_forall.add_bound_variable (l_h)
			l_forall.add_bound_variable (l_o)
			l_forall.add_trigger (l_fcall)
			boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
		end

	add_default_field_ids
			-- Add FieldId axioms for default attributes
		do
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("allocated", types.field (types.bool)), factory.type_value (type) >>, types.int),
				factory.int_value (-1))))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("closed", types.field (types.bool)), factory.type_value (type) >>, types.int),
				factory.int_value (-2))))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("owner", types.field (types.ref)), factory.type_value (type) >>, types.int),
				factory.int_value (-3))))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("owns", types.field (types.set (types.ref))), factory.type_value (type) >>, types.int),
				factory.int_value (-4))))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("observers", types.field (types.set (types.ref))), factory.type_value (type) >>, types.int),
				factory.int_value (-5))))
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
				factory.function_call ("FieldId", << factory.entity ("subjects", types.field (types.set (types.ref))), factory.type_value (type) >>, types.int),
				factory.int_value (-6))))
		end

feature -- Invariant admissibility

	generate_invariant_admissability_check (a_class_type: CL_TYPE_A)
			-- Generate invariant admissability check for class `a_class'.
		local
			l_proc: IV_PROCEDURE
			l_impl: IV_IMPLEMENTATION
			l_pre: IV_PRECONDITION
			l_name: STRING
			l_goto: IV_GOTO
			l_block: IV_BLOCK
			l_assert, l_assume: IV_ASSERT
		do
			l_name := a_class_type.base_class.name_in_upper + ".invariant_admissibility_check"
			create l_proc.make (l_name)
			create l_impl.make (l_proc)
			boogie_universe.add_declaration (l_proc)
			boogie_universe.add_declaration (l_impl)
			result_handlers.extend (agent handle_class_validity_result (a_class_type.base_class, ?, ?), l_name)

				-- Set up procedure with arguments and precondition
			l_proc.add_argument (factory.std_current)
			create l_pre.make (factory.function_call ("attached_exact", << factory.global_heap, factory.std_current, factory.type_value (a_class_type) >>, types.bool))
			l_proc.add_contract (l_pre)
			create l_assume.make_assume (factory.function_call ("user_inv", << factory.global_heap, factory.std_current >>, types.bool))

			create l_goto.make_empty
			l_impl.body.add_statement (l_goto)

				-- Invariant has no precondition

			create l_block.make_name ("pre")
			l_goto.add_target (l_block)
			l_impl.body.add_statement (l_block)
			type := a_class_type
			create builtin_collector
			builtin_collector.set_any_target
			process_invariants (a_class_type.base_class, Void, Void, create {E2B_ENTITY_MAPPING}.make)
			across last_safety_checks as i loop
				l_block.add_statement (i)
			end
			l_block.add_statement (factory.return)

				-- o.inv does not mention closed and owner (static check)

			if builtin_collector.is_inv_unfriendly then
				helper.add_semantic_error (a_class_type.base_class, messages.invalid_call_in_invariant, -1)
			end

				-- A2: o.inv implies forall x: x in o.subjects implies o in x.observers

			create l_block.make_name ("a2")
			l_goto.add_target (l_block)
			l_impl.body.add_statement (l_block)
			l_block.add_statement (l_assume)
			create l_assert.make (factory.function_call ("admissibility2", << factory.global_heap, factory.std_current >>, types.bool))
			l_assert.node_info.set_type ("A2")
			l_block.add_statement (l_assert)
			l_block.add_statement (factory.return)

				-- A3: o.inv cannot be violated by updates that conform to their guards

			create l_block.make_name ("a3")
			l_goto.add_target (l_block)
			l_impl.body.add_statement (l_block)
			l_block.add_statement (l_assume)
			create l_assert.make (factory.function_call ("admissibility3", << factory.global_heap, factory.std_current >>, types.bool))
			l_assert.node_info.set_type ("A3")
			l_block.add_statement (l_assert)
			l_block.add_statement (factory.return)

		end

	handle_class_validity_result (a_class: CLASS_C; a_boogie_result: E2B_BOOGIE_PROCEDURE_RESULT; a_result_generator: E2B_RESULT_GENERATOR)
			-- Handle Boogie result `a_boogie_result'.
		local
			l_success: E2B_SUCCESSFUL_VERIFICATION
			l_failure: E2B_FAILED_VERIFICATION
			l_error: E2B_DEFAULT_VERIFICATION_ERROR
		do
			if a_result_generator.has_validity_error (Void, a_class) then
				-- Ignore results of classes with a validity error

			elseif a_boogie_result.is_successful then
				create l_success
				l_success.set_class (a_class)
				l_success.set_time (a_boogie_result.time)
				l_success.set_verification_context ("invariant admissibility")
				a_result_generator.last_result.add_result (l_success)

			elseif a_boogie_result.is_inconclusive then
					-- TODO

			elseif a_boogie_result.is_error then
				create l_failure.make
				l_failure.set_class (a_class)
				l_failure.set_verification_context ("invariant admissibility")
				across a_boogie_result.errors as i loop
					check i.is_assert_error end
					create l_error.make (l_failure)
					l_error.set_boogie_error (i)
					if i.attributes["type"] ~ "A2" then
						l_error.set_message ({STRING_32} "Some subjects might not have Current in their observers set.")
						l_failure.errors.extend (l_error)
					elseif i.attributes["type"] ~ "A3" then
						l_error.set_message ({STRING_32} "The invariant might be invalidated by a subject update that conforms to its guard.")
						l_failure.errors.extend (l_error)
					else
						a_result_generator.process_individual_error (i, l_failure)
					end
				end

				a_result_generator.last_result.add_result (l_failure)
			end
		end

	invariant_check_cache: HASH_TABLE [LINKED_LIST [IV_ASSERT], CL_TYPE_A]
			-- Cache of inline invariant checks per type.
		once
			create Result.make (5)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
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
