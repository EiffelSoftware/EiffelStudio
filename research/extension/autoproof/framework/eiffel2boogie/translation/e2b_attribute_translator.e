note
	description: "Translator for Eiffel attributes."

class
	E2B_ATTRIBUTE_TRANSLATOR

inherit

	E2B_FEATURE_TRANSLATOR

	COMPILER_EXPORTER
	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Basic operations

	translate (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Translate feature `a_feature' of type `a_context_type'.
		require
			is_attribute: a_feature.is_attribute or helper.is_built_in_attribute (a_feature)
		local
			l_attribute_name: READABLE_STRING_8
			l_class_type: CL_TYPE_A
			l_type_prop, l_context_type: IV_EXPRESSION
			l_forall: IV_FORALL
			l_heap, l_o, l_f: IV_ENTITY
			l_heap_access: IV_MAP_ACCESS
			l_boogie_type: IV_TYPE
		do
			translation_pool.add_type (a_context_type)
			set_context (a_feature, a_context_type)
			l_class_type := helper.class_type_in_context (current_feature.type, current_type.base_class, Void, current_type)

			if helper.is_built_in_attribute (current_feature) then
					-- It's a built-in redefinition: only generate the guard.
					-- TODO: check that type is unchanged
				l_attribute_name := current_feature.feature_name
				generate_guard (l_class_type, l_attribute_name, translation_mapping.ghost_access_type (l_attribute_name))
			else
				l_attribute_name := name_translator.boogie_procedure_for_feature (current_feature, current_type)
				l_boogie_type := types.for_class_type (l_class_type)
				l_context_type := factory.type_value (current_type)
				l_f := factory.entity (l_attribute_name, types.field (l_boogie_type))
				l_heap := factory.heap_entity ("heap")
				l_o := factory.ref_entity ("o")
				l_heap_access := factory.heap_access (l_heap, l_o, l_attribute_name, l_boogie_type)

					-- Add field declaration
				if boogie_universe.constant_named (l_f.name) = Void then
					boogie_universe.add_declaration (create {IV_CONSTANT}.make (l_f.name, l_f.type))
				end

					-- Add field ID
				boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
						factory.function_call ("FieldId", << l_f, l_context_type >>, types.int),
						factory.int_value (current_feature.feature_id))))

					-- Add equivalences
				generate_equivalences_for_class (current_type.base_class)

--					-- Mark field as a ghost or non-ghost
--				l_expr := factory.function_call ("IsGhostField", << l_f >>, types.bool)
--				if helper.is_ghost (current_feature) then
--					boogie_universe.add_declaration (create {IV_AXIOM}.make (l_expr))
--				else
--					boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.not_ (l_expr)))
--				end

					-- Add type properties
				l_type_prop := types.type_property (l_class_type, l_heap, l_heap_access, helper.is_type_exact (current_feature.type, l_class_type, Void),
					current_feature.type.is_attached)
				if not l_type_prop.is_true then
					l_type_prop := factory.implies_ (factory.and_ (
							factory.is_heap (l_heap),
							factory.function_call ("attached", << l_heap, l_o, l_context_type >>, types.bool)),
						l_type_prop)
					create l_forall.make (l_type_prop)
					l_forall.add_bound_variable (l_heap)
					l_forall.add_bound_variable (l_o)
					l_forall.add_trigger (l_heap_access)
					boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
				end

					-- Check if it replaces old models correctly
				check_model_replacement

					-- Add guard
				generate_guard (l_class_type, l_attribute_name, l_boogie_type)

					-- Add translation references
				translation_pool.add_type (l_class_type)
			end
		end

	generate_guard (a_type: CL_TYPE_A; a_boogie_name: READABLE_STRING_8; a_boogie_type: IV_TYPE)
			-- Generate update guard for attribute `current_feature' of type `a_type' inside `current_type',
			-- where the Boogie translation of the attribute has name `a_boogie_name' and type `a_boogie_type'.
		local
			l_h, l_cur, l_f, l_v, l_o: IV_ENTITY
			l_fcall: IV_FUNCTION_CALL
			l_def: IV_EXPRESSION
		do
			create l_h.make ("heap", types.heap)
			create l_cur.make ("current", types.ref)
			create l_f.make (a_boogie_name, types.field (a_boogie_type))
			create l_v.make ("v", a_boogie_type)
			create l_o.make ("o", types.ref)
			l_fcall := factory.function_call ("guard", << l_h, l_cur, l_f, l_v, l_o >>, types.bool)
			l_def := factory.true_
			across helper.guards_for_attribute (current_feature) as g loop
				l_def := factory.and_clean (l_def, guard_from_string (g.str, g.origin, a_type, l_h, l_cur, l_f, l_v, l_o))
			end

			factory.add_dynamic_predicate_definition (l_fcall, l_def, current_type, l_h, l_cur, <<l_v, l_o>>)
		end

	translate_tuple_field (a_context_type: CL_TYPE_A; a_position: INTEGER)
			-- Translate field at position `a_position' of tuple type `a_context_type'.
		require
			tuple_type: a_context_type.is_tuple
		local
			l_attribute_name: STRING
			l_type: TYPE_A
			l_class_type: CL_TYPE_A
			l_type_prop, l_context_type: IV_EXPRESSION
			l_forall: IV_FORALL
			l_heap, l_o, l_f: IV_ENTITY
			l_heap_access: IV_MAP_ACCESS
			l_boogie_type: IV_TYPE
		do
			set_context (Void, a_context_type)
			l_type := a_context_type.generics [a_position]
			l_class_type := helper.class_type_in_context (l_type, current_type.base_class, Void, current_type)
			l_attribute_name := name_translator.boogie_field_for_tuple_field (current_type, a_position)
			l_boogie_type := types.for_class_type (l_class_type)
			l_context_type := factory.type_value (current_type)
			l_f := factory.entity (l_attribute_name, types.field (l_boogie_type))

				-- Add field declaration
			boogie_universe.add_declaration (create {IV_CONSTANT}.make (l_f.name, l_f.type))

				-- Add field ID
			boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (
					factory.function_call ("FieldId", << l_f, l_context_type >>, types.int),
					factory.int_value (a_position))))

				-- Add type properties
			l_heap := factory.heap_entity ("heap")
			l_o := factory.ref_entity ("o")
			l_heap_access := factory.heap_access (l_heap, l_o, l_attribute_name, l_boogie_type)
			l_type_prop := types.type_property (l_class_type, l_heap, l_heap_access, helper.is_type_exact (l_type, l_class_type, Void), l_type.is_attached)
			if not l_type_prop.is_true then
				l_type_prop := factory.implies_ (factory.and_ (
						factory.is_heap (l_heap),
						factory.function_call ("attached", << l_heap, l_o, l_context_type >>, types.bool)),
					l_type_prop)
				create l_forall.make (l_type_prop)
				l_forall.add_bound_variable (l_heap)
				l_forall.add_bound_variable (l_o)
				l_forall.add_trigger (l_heap_access)
				boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
			end

				-- Add translation references
			translation_pool.add_type (l_class_type)
		end


feature {NONE} -- Implementation

	generate_equivalences_for_class (a_class: CLASS_C)
			-- Generate axioms that `current_feature' is equal to its versions from all ancestors of `a_class'.
		local
			l_feature: FEATURE_I
			l_attribute_name, l_old_name: READABLE_STRING_8
			l_parent_type: CL_TYPE_A
			l_f: IV_ENTITY
			l_boogie_type: IV_TYPE
		do
			l_boogie_type := types.for_class_type (helper.class_type_in_context (current_feature.type, current_type.base_class, Void, current_type))
			l_attribute_name := name_translator.boogie_procedure_for_feature (current_feature, current_type)
			l_f := factory.entity (l_attribute_name, types.field (l_boogie_type))
			across
				a_class.parents_classes as c
			loop
				l_feature := c.feature_of_rout_id_set (current_feature.rout_id_set)
				if attached l_feature and then l_feature.is_attribute then
						-- Check that properties match
					if helper.is_ghost (l_feature) /= helper.is_ghost (current_feature) then
						helper.add_semantic_error (current_feature, messages.invalid_ghost_status (l_feature.feature_name_32, l_feature.written_class.name_in_upper), -1)
					end

					l_parent_type := helper.class_type_from_class (c, current_type)
					l_old_name := name_translator.boogie_procedure_for_feature (l_feature, l_parent_type)
					translation_pool.add_parent_type (l_parent_type)
					if boogie_universe.constant_named (l_old_name) = Void then
						boogie_universe.add_declaration (create {IV_CONSTANT}.make (l_old_name, l_f.type))
					end
					boogie_universe.add_declaration (create {IV_AXIOM}.make (factory.equal (l_f, create {IV_ENTITY}.make (l_old_name, l_f.type))))

					generate_equivalences_for_class (c)
				end
			end
		end

--	previous_versions: LINKED_LIST [FEATURE_I]
--			-- Versions of `current_feature' from ancestors of `current_type' if inherited or redefined.
--		do
--			if current_feature.written_in /= current_type.base_class.class_id then
--					-- Inherited attribute: return the class where it is written in				
--				create Result.make
--				Result.extend (current_feature.written_class.feature_of_body_index (current_feature.body_index))
--			else
--				Result := helper.all_versions (current_feature)
--				Result.start
--				Result.remove
--			end
--		end

	guard_from_string (a_guard_string: READABLE_STRING_8; a_origin_class: CLASS_C; a_attr_type: CL_TYPE_A; a_h, a_cur, a_f, a_v, a_o: IV_EXPRESSION): IV_EXPRESSION
			-- Update guard definition encoded by `a_guard_string' coming from `a_origin_class'.
		require
			non_empty: not a_guard_string.is_empty
		local
			l_guard_feature: FEATURE_I
			l_fname: READABLE_STRING_8
		do
			if a_guard_string.is_case_insensitive_equal ("true") then
					-- The guard is trivially true
				Result := factory.true_
			elseif a_guard_string.is_case_insensitive_equal ("false") then
					-- The guard is trivially false
				Result := factory.false_
			elseif a_guard_string.is_case_insensitive_equal ("inv") then
					-- The guard is the preservation of the invariant of observers
				Result := factory.implies_ (
					factory.function_call ("user_inv", << a_h, a_o >>, types.bool),
					factory.function_call ("user_inv", << factory.map_update (a_h, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<a_cur, a_f>>), a_v), a_o >>, types.bool))
			else
				l_guard_feature := a_origin_class.feature_named (a_guard_string)
				if is_valid_guard_feature (a_guard_string, l_guard_feature, a_attr_type, a_origin_class) then
					translation_pool.add_referenced_feature (l_guard_feature, current_type)
						-- Generate guard definition from `l_guard_feature'
					l_fname := name_translator.boogie_function_for_feature (l_guard_feature, current_type, False)
					if helper.has_flat_precondition (l_guard_feature) then
						Result := factory.function_call (name_translator.boogie_function_precondition (l_fname), << a_h, a_cur, a_v, a_o >>, types.bool)
					else
						Result := factory.true_
					end
					Result := factory.and_clean (Result, factory.function_call (l_fname, << a_h, a_cur, a_v, a_o >>, types.bool))
				end
			end
		end

	is_valid_guard_feature (a_guard_name: READABLE_STRING_8; a_guard_feature: FEATURE_I; a_attr_type: CL_TYPE_A; guard_feature_class: CLASS_C): BOOLEAN
			-- Does `a_guard_feature' have a valid signature for an update guard for an attribute of type `a_attr_type'?
		do
			if a_guard_feature = Void then
				helper.add_semantic_error (current_feature, messages.unknown_feature ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_guard_name), current_type.base_class.name_in_upper), -1)
			elseif not (a_guard_feature.has_return_value and then a_guard_feature.type.is_boolean) then
				helper.add_semantic_error (a_guard_feature, messages.guard_feature_not_predicate, -1)
			elseif a_guard_feature.argument_count /= 2 then
				helper.add_semantic_error (a_guard_feature, messages.guard_feature_arg_count, -1)
			elseif types.for_class_type (helper.class_type_in_context (a_guard_feature.arguments [1], guard_feature_class, a_guard_feature, current_type))
					/~ types.for_class_type (a_attr_type) then
				helper.add_semantic_error (a_guard_feature, messages.guard_feature_arg1, -1)
			elseif not a_guard_feature.arguments [2].same_as (system.any_type) then
				helper.add_semantic_error (a_guard_feature, messages.guard_feature_arg2, -1)
			else
				Result := True
			end
		end

	check_model_replacement
			-- For an immediate attribute with a "replaces" clause,
			-- check that is didn't use to be a model query in any parent.
		local
			l_old_version, l_replaced: FEATURE_I
			found: BOOLEAN
		do
			if current_feature.written_in = current_type.base_class.class_id then
				across helper.feature_note_values (current_feature, "replaces") as f loop
					l_replaced := current_type.base_class.feature_named (f)
					if attached l_replaced then
						across current_type.base_class.parents_classes as c until found loop
							l_old_version := c.feature_of_rout_id_set (current_feature.rout_id_set)
								-- If both `current_feature' and `l_replaced' are model queries of `c.item',
								-- this will cause child's model frames to be bigger than parent's
							if attached l_old_version and then
									(helper.is_model_query (c, l_old_version) and helper.is_model_query (c, l_replaced)) then
								helper.add_semantic_error (current_feature, messages.invalid_model_replacement (current_feature.feature_name_32, c.name_in_upper), -1)
								found := True
							end
						end
					else
						helper.add_semantic_error (current_feature, messages.unknown_model ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (f), current_type.base_class.name_in_upper), -1)
					end
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
