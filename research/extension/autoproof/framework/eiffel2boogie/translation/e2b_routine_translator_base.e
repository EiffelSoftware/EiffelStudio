note
	description: "Base class for routine translators."

deferred class
	E2B_ROUTINE_TRANSLATOR_BASE

inherit

	E2B_FEATURE_TRANSLATOR

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Access

	current_boogie_procedure: detachable IV_PROCEDURE
			-- Currently generated Boogie procedure (if any).

feature -- Element change

	set_up_boogie_procedure (a_boogie_name: READABLE_STRING_8)
			-- Set up `current_boogie_procedure'.
		do
			current_boogie_procedure := boogie_universe.procedure_named (a_boogie_name)
			if not attached current_boogie_procedure then
				create current_boogie_procedure.make (a_boogie_name)
				boogie_universe.add_declaration (current_boogie_procedure)
			end
		ensure
			current_boogie_procedure_set: attached current_boogie_procedure
			current_boogie_procedure_named: current_boogie_procedure.name ~ a_boogie_name
			current_boogie_procedure_added: boogie_universe.procedure_named (a_boogie_name) = current_boogie_procedure
		end

feature -- Helper functions: arguments and result

	arguments_of (a_feature: FEATURE_I; a_context: CL_TYPE_A): ARRAYED_LIST [TUPLE [name: READABLE_STRING_8; orig_type: TYPE_A; type: CL_TYPE_A; boogie_type: IV_TYPE]]
			-- List of feature arguments of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_attached: attached a_context
		local
			l_type: CL_TYPE_A
		do
			create Result.make (a_feature.argument_count)
			if attached a_feature.arguments as arguments then
				across
					arguments as a
				loop
					l_type := helper.class_type_in_context (a, a_context.base_class, a_feature, a_context)
					Result.extend
						(arguments.item_name (@ a.target_index),
						a,
						l_type,
						types.for_class_type (l_type))
				end
			end
		end

	arguments_of_current_feature: like arguments_of
			-- List of arguments of `current_feature'.
		require
			current_feature_set: attached current_feature
			current_type_set: attached current_type
		do
			Result := arguments_of (current_feature, current_type)
		end

	add_argument_with_property (a_name: READABLE_STRING_8; a_orig_type: TYPE_A; a_type: CL_TYPE_A; a_boogie_type: IV_TYPE)
			-- Add argument and property to current procedure.
		require
			current_procedure_set: attached current_boogie_procedure
		local
			l_pre: IV_PRECONDITION
		do
			current_boogie_procedure.add_argument (create {IV_ENTITY}.make (a_name, a_boogie_type))
			create l_pre.make (types.type_property (a_type, factory.global_heap, factory.entity (a_name, a_boogie_type),
				helper.is_type_exact (a_orig_type, a_type, current_feature),
				a_orig_type.is_attached))
			l_pre.set_free
			l_pre.node_info.set_attribute ("info", "type property for argument " + a_name)
			current_boogie_procedure.add_contract (l_pre)
			translation_pool.add_type (a_type)
		end

	add_result_with_property
			-- Add result to current procedure.
		local
			l_type: CL_TYPE_A
			l_iv_type: IV_TYPE
		do
			if current_feature.has_return_value then
				l_type := helper.class_type_in_context (current_feature.type, current_type.base_class, current_feature, current_type)
				l_iv_type := types.for_class_type (l_type)
				translation_pool.add_type (l_type)
				current_boogie_procedure.add_result_with_property (
					"Result",
					l_iv_type,
					types.type_property (l_type, factory.global_heap, factory.entity ("Result", l_iv_type),
						helper.is_type_exact (current_feature.type, l_type, current_feature),
						current_feature.type.is_attached))
			end
		end

feature -- Helper functions: contracts

	contracts_of (a_feature: FEATURE_I; a_type: CL_TYPE_A): TUPLE [pre, post, modifies, reads, decreases: LIST [E2B_ASSERT_ORIGIN]]
			-- Contracts for feature `a_feature' of type `a_type' separated into preconditions, postconiditons, modify clauses, read clauses, and decreases clauses;
			-- with their origin class.
		local
			l_pre, l_post, l_modifies, l_reads, l_decreases: LINKED_LIST [E2B_ASSERT_ORIGIN]
			l_class: CLASS_C
			a: ASSERT_B
		do
			create l_pre.make
			create l_post.make
			create l_modifies.make
			create l_reads.make
			create l_decreases.make

			helper.set_up_byte_context (a_feature, a_type)
			if attached Context.byte_code as l_byte_code then
					-- Process pre/post-conditions
				l_class := a_feature.written_class
				if l_byte_code.precondition /= Void then
					across l_byte_code.precondition as p loop
						l_pre.extend (create {E2B_ASSERT_ORIGIN}.make (p, l_class))
					end
				end
				if l_byte_code.postcondition /= Void then
					across l_byte_code.postcondition as p loop
						l_post.extend (create {E2B_ASSERT_ORIGIN}.make (p, l_class))
					end
				end
				if a_feature.assert_id_set /= Void and not a_type.is_basic then
						-- Feature has inherited assertions
					l_byte_code.formulate_inherited_assertions (a_feature.assert_id_set)
					across Context.inherited_assertion.precondition_list as i loop
						l_class := Context.inherited_assertion.precondition_types [@ i.target_index].type.base_class
						across i as p loop
							l_pre.extend (create {E2B_ASSERT_ORIGIN}.make (p, l_class))
						end
					end

					across Context.inherited_assertion.postcondition_list as i loop
						l_class := Context.inherited_assertion.postcondition_types [@ i.target_index].type.base_class
						across i as p loop
							l_post.extend (create {E2B_ASSERT_ORIGIN}.make (p, l_class))
						end
					end
				end
			end
			from
				l_pre.start
			until
				l_pre.after
			loop
				a := l_pre.item.clause
				if helper.is_clause_reads (a) then
					l_reads.extend (l_pre.item)
					l_pre.remove
				elseif helper.is_clause_modify (a) then
					helper.add_semantic_warning (a_feature, messages.predicate_outside_of_postcondition_and_loop_invariant ("Modify"), a.line_number)
					l_modifies.extend (l_pre.item)
					l_pre.remove
				elseif helper.is_clause_decreases (a) then
					l_decreases.extend (l_pre.item)
					l_pre.remove
				else
					l_pre.forth
				end
			end
			from
				l_post.start
			until
				l_post.after
			loop
				a := l_post.item.clause
				if helper.is_clause_reads (a) then
					helper.add_semantic_warning (a_feature, messages.predicate_outside_of_precondition_and_loop_invariant ("Read"), a.line_number)
					l_post.remove
				elseif helper.is_clause_modify (a) then
					l_modifies.extend (l_post.item)
					l_post.remove
				elseif helper.is_clause_decreases (a) then
					helper.add_semantic_warning (a_feature, messages.predicate_outside_of_precondition_and_loop_invariant ("Decrease"), a.line_number)
					l_post.remove
				else
					l_post.forth
				end
			end
			Result := [l_pre, l_post, l_modifies, l_reads, l_decreases]
		end

	contracts_of_current_feature: like contracts_of
			-- Contracts for `current_feature'.
		do
			Result := contracts_of (current_feature, current_type)
		end

	pre_post_expressions_of (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_mapping: E2B_ENTITY_MAPPING): TUPLE [pre: IV_EXPRESSION; post: IV_EXPRESSION]
			-- Contracts for feature `a_feature' of type `a_type' as expressions.
		local
			l_contracts: like contracts_of
			l_pre: IV_EXPRESSION
			l_post: IV_EXPRESSION
			l_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR
		do
			l_contracts := contracts_of (a_feature, a_type)

			create l_translator.make
			l_translator.set_context (a_feature, a_type)
			l_translator.copy_entity_mapping (a_mapping)

			l_pre := factory.true_
			across l_contracts.pre as c loop
				l_translator.set_origin_class (c.origin)
				helper.set_up_byte_context (c.origin.feature_of_rout_id (a_feature.rout_id_set.first),
					helper.class_type_in_context (c.origin.actual_type, c.origin, Void, current_type))
				c.clause.process (l_translator)
				l_pre := factory.and_clean (l_pre, l_translator.last_expression)
			end
			l_post := factory.true_
			across l_contracts.post as c loop
				l_translator.set_origin_class (c.origin)
				helper.set_up_byte_context (c.origin.feature_of_rout_id (a_feature.rout_id_set.first),
					helper.class_type_in_context (c.origin.actual_type, c.origin, Void, current_type))
				c.clause.process (l_translator)
				l_post := factory.and_clean (l_post, l_translator.last_expression)
			end
			helper.set_up_byte_context (a_feature, a_type)
			Result := [l_pre, l_post]
		end

	modify_expressions_of (a_clauses: LIST [E2B_ASSERT_ORIGIN]; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR): TUPLE [full_objects: LIST [IV_EXPRESSION]; partial_objects: LIST [E2B_FRAME_ELEMENT]; model_objects: LIST [E2B_FRAME_ELEMENT]]
			-- List of fully modified and partially modified objects extracted from modifies clauses `a_clauses'.
		do
			Result := [
				frame_full_objects_of (a_clauses, "modify", a_translator),
				frame_partial_objects_of (a_clauses, "modify_field", a_translator, False),
				frame_partial_objects_of (a_clauses, "modify_model", a_translator, True)
				]
		end

	read_expressions_of (a_clauses: LIST [E2B_ASSERT_ORIGIN]; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR): TUPLE [full_objects: LIST [IV_EXPRESSION]; partial_objects: LIST [E2B_FRAME_ELEMENT]; model_objects: LIST [E2B_FRAME_ELEMENT]]
			-- List of fully modified and partially modified objects extracted from modifies clauses `a_clauses'.
		do
			Result := [
				frame_full_objects_of (a_clauses, "reads", a_translator),
				frame_partial_objects_of (a_clauses, "reads_field", a_translator, False),
				frame_partial_objects_of (a_clauses, "reads_model", a_translator, True)
			]
		end

	frame_full_objects_of (a_clauses: LIST [E2B_ASSERT_ORIGIN]; a_function: STRING; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR): LIST [IV_EXPRESSION]
			-- Full object descriptions extracted from `a_clauses' and translated with `a_translator', given as arguments to `a_function'.
		local
			l_objects_type: like translate_contained_expressions
			l_name: STRING
		do
			create {LINKED_LIST [IV_EXPRESSION]} Result.make

			across
				a_clauses as i
			loop
				if attached {FEATURE_B} i.clause.expr as l_call then
					l_name := names_heap.item (l_call.feature_name_id)
					if l_name.same_string (a_function) then
--						a_translator.set_origin_class (i.item.origin)
						l_objects_type := translate_contained_expressions (l_call.parameters.i_th (1).expression, a_translator, True)
						Result.append (l_objects_type.expressions)
					end
				end
			end
		end

	frame_partial_objects_of (a_clauses: LIST [E2B_ASSERT_ORIGIN]; a_function: STRING; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_check_model: BOOLEAN): LIST [E2B_FRAME_ELEMENT]
			-- Partial object descriptions extracted from `a_clauses' and translated with `a_translator', given as arguments to `a_function'.
		local
			l_fieldnames: LINKED_LIST [READABLE_STRING_8]
			l_fields: LINKED_LIST [IV_ENTITY]
			l_objects_type: like translate_contained_expressions
			l_name: STRING_8
			l_type: CL_TYPE_A
			l_attr, l_new_version: FEATURE_I
			l_field: IV_ENTITY
			l_origin: CLASS_C
		do
			create {LINKED_LIST [E2B_FRAME_ELEMENT]} Result.make

			across
				a_clauses as i
			loop
				if attached {FEATURE_B} i.clause.expr as l_call then
					l_name := names_heap.item (l_call.feature_name_id)
					if l_name.same_string (a_function) then
						a_translator.set_origin_class (i.origin)
						l_objects_type := translate_contained_expressions (l_call.parameters.i_th (2).expression, a_translator, True)
						create l_fields.make

						if l_objects_type.expressions.first /= Void then
							l_type := helper.class_type_in_context (l_objects_type.type, i.origin, current_feature, current_type)
							create l_fieldnames.make
							if attached {STRING_B} l_call.parameters.i_th (1).expression as l_string then
								l_fieldnames.extend (l_string.value)
							elseif attached {TUPLE_CONST_B} l_call.parameters.i_th (1).expression as l_tuple then
								across l_tuple.expressions as j loop
									if attached {STRING_B} j as l_string then
										l_fieldnames.extend (l_string.value)
									else
										helper.add_semantic_error (current_feature, messages.first_argument_string_or_tuple, i.clause.line_number)
									end
								end
							else
								helper.add_semantic_error (current_feature, messages.first_argument_string_or_tuple, i.clause.line_number)
							end

							l_origin := helper.class_type_in_context (
								l_objects_type.type,
								i.origin,
								current_feature,
								helper.class_type_from_class (i.origin, current_type)).base_class
							across l_fieldnames as f loop
								if a_check_model then
									l_attr := l_origin.feature_named (f)
									if attached l_attr and then helper.is_model_query (l_origin, l_attr) then
										l_new_version := l_type.base_class.feature_of_rout_id_set (l_attr.rout_id_set)
										l_field := helper.field_from_attribute (l_new_version, l_type)
										l_fields.extend (l_field)
											-- Add replacing model queries
										across helper.replacing_model_queries (l_attr, l_origin, l_type.base_class) as m loop
											l_field := helper.field_from_attribute (m, l_type)
											if across l_fields as fi all not fi.same_expression (l_field) end then
												l_fields.extend (l_field)
											end
												-- Add replaced model queries
											across helper.replaced_model_queries (m, l_type.base_class) as m1 loop
												l_field := helper.field_from_attribute (m1, l_type)
												if across l_fields as fi all not fi.same_expression (l_field) end then
													l_fields.extend (l_field)
												end
											end
										end
									else
										helper.add_semantic_error (current_feature, messages.unknown_model ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (f), l_origin.name_in_upper), i.clause.line_number)
									end
								else
									l_attr := helper.attribute_from_string (f, l_type, l_origin, current_feature, i.clause.line_number)
									if attached l_attr then
										l_fields.extend (helper.field_from_attribute (l_attr, l_type))
									end
								end
							end
						end
						Result.extend (create {E2B_FRAME_ELEMENT}.make (l_objects_type.expressions, l_fields, l_objects_type.type, i.origin))
					end
				else
					check internal_error: False end
				end
			end
		end

	is_pure (a_mods: like modify_expressions_of): BOOLEAN
			-- Is `a_mods' an empty frame?
		do
			Result := (a_mods.full_objects.is_empty or else a_mods.full_objects.first = Void) and
				(a_mods.partial_objects.is_empty or else a_mods.partial_objects.first.objects.first = Void) and
				(a_mods.model_objects.is_empty or else a_mods.model_objects.first.objects.first = Void)
		end

	frame_definition (a_mods: like modify_expressions_of; a_lhs: IV_EXPRESSION; a_excluded_fields: ARRAY [IV_ENTITY]): IV_FORALL
			-- Expression that claims that `a_lhs' is the frame encoded in `a_mods'
			-- (forall o, f :: a_lhs[o, f] <==> is_partially_modifiable[o, f] || is_model_modifiable[o, f] || is_fully_modifiable[o])
		local
			l_expr, l_f_conjunct: IV_EXPRESSION
			l_type_var: IV_VAR_TYPE
			l_o, l_f: IV_ENTITY
			l_access: IV_MAP_ACCESS
			l_written_type, l_type: CL_TYPE_A
			r: E2B_FRAME_ELEMENT
		do
			create l_type_var.make_fresh
			create l_o.make ("$o", types.ref)
			create l_f.make ("$f", types.field (l_type_var))
			create l_access.make (a_lhs, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<l_o, l_f>>))
			l_expr := factory.false_

				-- Axiom rhs: a big disjunction
				-- Go over partially modifiable objects
			across a_mods.partial_objects as restriction loop
				l_f_conjunct := factory.false_
				across restriction.fields as f loop
					l_f_conjunct := factory.or_clean (l_f_conjunct, factory.equal (l_f, f))
				end
				l_expr := factory.or_clean (l_expr, factory.and_ (is_object_in_frame (l_o, restriction.objects), l_f_conjunct))
			end
				-- Go over model-modifiable objects
			across a_mods.model_objects as restriction loop
				r := restriction
					-- The type of the objects as seen where the frame clause was written
				l_written_type := helper.class_type_in_context (r.type, r.origin, current_feature, helper.class_type_from_class (r.origin, current_type))
					-- The type of the objects as seen in the `current_type'
				l_type := helper.class_type_in_context (r.type, r.origin, current_feature, current_type)
					-- Either `l_f' is not a model query in `l_type'
				l_f_conjunct := factory.not_ (factory.function_call ("IsModelField", << l_f, factory.type_value (l_type) >>, types.bool))
					-- Or it is one of `r.fields'
				across r.fields as f loop
					l_f_conjunct := factory.or_ (l_f_conjunct,factory.equal (l_f, f))
				end
				l_expr := factory.or_clean (l_expr, factory.and_ (is_object_in_frame (l_o, r.objects), l_f_conjunct))
			end
				-- Go over fully modifiable objects
				-- (and exclude `a_excluded_fields')
			l_f_conjunct := factory.true_
			across a_excluded_fields as f loop
				l_f_conjunct := factory.and_clean (l_f_conjunct, factory.not_equal (l_f, f))
			end
			l_expr := factory.or_clean (l_expr,
				factory.and_clean (is_object_in_frame (l_o, a_mods.full_objects), l_f_conjunct))
				-- Finally create the quantifier				
			create Result.make (factory.equiv (l_access, l_expr))
			Result.add_type_variable (l_type_var.name)
			Result.add_bound_variable (l_o)
			Result.add_bound_variable (l_f)
			Result.add_trigger (l_access)
		end

	is_object_in_frame (a_var: IV_EXPRESSION; a_objects: LIST [IV_EXPRESSION]): IV_EXPRESSION
			-- Expression stating that `a_var' is one of `a_objects',
			-- where elements of `a_objects' can be individual objects or sets.
		local
			l_disjunct: IV_EXPRESSION
		do
			Result := factory.false_
			across a_objects as o loop
				if o = Void then
					l_disjunct := factory.false_
				elseif o.type ~ types.ref then
					l_disjunct := factory.equal (a_var, o)
				else
					check o.type ~ types.set (types.ref) end
					l_disjunct := factory.map_access (o, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<a_var>>))
				end
				Result := factory.or_clean (Result, l_disjunct)
			end
		end

	decreases_expressions_of (a_clauses: LIST [E2B_ASSERT_ORIGIN]; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR): LIST [IV_EXPRESSION]
			-- List of variants extracted from decreases clauses `a_clauses'.
		do
			create {LINKED_LIST [IV_EXPRESSION]} Result.make
			across
				a_clauses as i
			loop
				if attached {FEATURE_B} i.clause.expr as l_call then
					a_translator.set_origin_class (i.origin)
					Result.append (translate_contained_expressions (l_call.parameters.i_th (1).expression, a_translator, False).expressions)
				else
					check internal_error: False end
				end
			end
		end

	translate_contained_expressions (a_expr: EXPR_B; a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; convert_to_set: BOOLEAN): TUPLE [expressions: LINKED_LIST [IV_EXPRESSION]; type: TYPE_A]
			-- Translate expressions in `a_expr' using `a_translator'; if `convert_to_set', convert all expressions of logical types to sets.
		local
			l_expr_list: LINKED_LIST [EXPR_B]
			l_expressions: LINKED_LIST [IV_EXPRESSION]
			l_type: TYPE_A
			l_feature: FEATURE_I
			l_like_type: LIKE_FEATURE
		do
			create l_expr_list.make
			if attached {TUPLE_CONST_B} a_expr as l_tuple then
				across l_tuple.expressions as i loop
					l_expr_list.extend (i)
				end
				if l_tuple.expressions.is_empty then
					l_expr_list.extend (Void)
				end
			else
				l_expr_list.extend (a_expr)
			end
			create l_expressions.make
			across l_expr_list as k loop
				if k = Void then
					l_expressions.extend (Void)
				elseif convert_to_set and helper.is_class_logical (a_translator.class_type_in_current_context (k.type).base_class) then
					a_translator.process_as_set (k, types.ref)
					l_expressions.extend (a_translator.last_expression)
					l_type := a_translator.last_set_content_type
				else
					k.process (a_translator)
					l_expressions.extend (a_translator.last_expression)
					if attached {CALL_ACCESS_B} k as a then
--						l_feature := helper.feature_for_call_access (a, a_translator.current_target_type)
--						l_type := l_feature.type
						l_feature := helper.feature_for_call_access (a, a_translator.origin_class.actual_type)
						create l_like_type.make (l_feature, a_translator.current_target_type.base_class.class_id)
						l_like_type.set_actual_type (l_feature.type.actual_type)
						l_type := l_like_type
					else
						l_type := k.type
					end
				end
			end
			Result := [l_expressions, l_type]
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
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
