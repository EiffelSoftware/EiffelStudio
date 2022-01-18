note
	description: "Helper functions for Eiffel to Boogie translation."

frozen class
	E2B_HELPER

inherit

	E2B_SHARED_CONTEXT
		export
			{NONE}
				all
			{ANY}
				deep_twin,
				is_deep_equal,
				standard_is_equal
		end

	SHARED_WORKBENCH
		export {NONE} all end

	SHARED_BYTE_CONTEXT
		export {NONE} all end

	SHARED_SERVER
		export {NONE} all end

	IV_SHARED_TYPES
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

feature -- Cache control

	reset
			-- Reset cached data.
		do
			map_access_feature_cache.wipe_out
			flat_model_cache.wipe_out
			ghost_attribute_cache.wipe_out
			internal_counter.put (0)
				-- Reset invariant checks
			;(create {E2B_TYPE_TRANSLATOR}).invariant_check_cache.wipe_out
				-- Reset type varibale counter
			;(create {IV_VAR_TYPE}.reset).do_nothing
			create context_stack.make (1)
		end

feature -- General note helpers

	class_note_values (a_class: CLASS_C; a_tag: READABLE_STRING_8): ARRAYED_LIST [READABLE_STRING_8]
			-- List of note values of tag `a_tag'.
		do
			create Result.make (5)
			Result.compare_objects
			if attached a_class.ast as l_ast then
				if l_ast.top_indexes /= Void then
					Result.append (note_values (l_ast.top_indexes, a_tag))
				end
				if l_ast.bottom_indexes /= Void then
					Result.append (note_values (l_ast.bottom_indexes, a_tag))
				end
			end
		ensure
			result_attached: attached Result
		end

	feature_note_values (a_feature: FEATURE_I; a_tag: READABLE_STRING_8): ARRAYED_LIST [READABLE_STRING_8]
			-- List of note values of tag `a_tag'.
		do
			if a_feature.body /= Void and then a_feature.body.indexes /= Void then
				Result := note_values (a_feature.body.indexes, a_tag)
			else
				create Result.make (0)
			end
		ensure
			result_attached: attached Result
		end

	note_values (a_indexing_clause: INDEXING_CLAUSE_AS; a_tag: READABLE_STRING_8): ARRAYED_LIST [READABLE_STRING_8]
			-- List of note values of tag `a_tag'.
		do
			create Result.make (3)
			Result.compare_objects
			across
				a_indexing_clause as i
			loop
				if i.tag.name.same_string (a_tag) then
					across
						i.index_list as v
					loop
						Result.extend (if attached {STRING_AS} v as s then s.value else v.string_value end)
					end
				end
			end
		end

	boolean_feature_note_value (a_feature: FEATURE_I; a_tag: READABLE_STRING_8): BOOLEAN
			-- Value of a boolean feature note tag, False if not present.
		local
			l_values: like feature_note_values
		do
			l_values := feature_note_values (a_feature, a_tag)
			if not l_values.is_empty then
				Result := l_values.i_th (1).is_case_insensitive_equal ("true")
			end
		end

	boolean_class_note_value (a_class: CLASS_C; a_tag: READABLE_STRING_8): BOOLEAN
			-- Value of a boolean feature note tag, False if not present.
		local
			l_values: like class_note_values
		do
			l_values := class_note_values (a_class, a_tag)
			if not l_values.is_empty then
				Result := l_values.i_th (1).is_case_insensitive_equal ("true")
			end
		end

	integer_feature_note_value (a_feature: FEATURE_I; a_tag: READABLE_STRING_8): INTEGER
			-- Value of an integer feature note tag, -1 if not present.
		local
			l_values: like feature_note_values
		do
			Result := -1
			l_values := feature_note_values (a_feature, a_tag)
			if not l_values.is_empty and then l_values.i_th (1).is_integer then
				Result := l_values.i_th (1).to_integer
			end
		end

	string_class_note_value (a_class: CLASS_C; a_tag: READABLE_STRING_8): READABLE_STRING_8
			-- Value of a string class note tag, empty string if not present.
		local
			l_values: like class_note_values
		do
			Result := ""
			l_values := class_note_values (a_class, a_tag)
			if not l_values.is_empty then
				Result := l_values [1]
			end
		end

	string_feature_note_value (a_feature: FEATURE_I; a_tag: READABLE_STRING_8): READABLE_STRING_8
			-- Value of a string feature note tag, empty string if not present.
		local
			l_values: like feature_note_values
		do
			Result := ""
			l_values := feature_note_values (a_feature, a_tag)
			if not l_values.is_empty then
				Result := l_values [1]
			end
		end

feature -- Class status helpers

	is_class_status (a_class: CLASS_C; a_value: READABLE_STRING_8): BOOLEAN
			-- Does `a_class' has a note with a tag status that contains the value `a_value'?
		local
			l_values: like class_note_values
		do
			l_values := class_note_values (a_class, "status")
			if not l_values.is_empty then
				Result := across l_values as i some i.same_string (a_value)  end
			end
		end

	is_skipped_class (a_class: CLASS_C): BOOLEAN
			-- Is `a_class' skipped?
		do
			Result := is_class_status (a_class, "skip")
		end

	is_manual_inv_class (a_class: CLASS_C): BOOLEAN
			-- Does `a_class' have the manual inv trigger?
		do
			Result := boolean_class_note_value (a_class, "manual_inv")
		end

feature -- Feature status helpers

	is_feature_status (a_feature: FEATURE_I; a_value: READABLE_STRING_8): BOOLEAN
			-- Does `a_feature' has a feature note with a tag status that contains the value `a_value'?
		local
			l_values: like feature_note_values
		do
			l_values := feature_note_values (a_feature, "status")
			if not l_values.is_empty then
				Result := across l_values as i some i.same_string (a_value)  end
			end
		end

	is_creator (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a creator?
		do
			Result := is_feature_status (a_feature, "creator")
		end

	is_nonvariant (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' nonvariant (i.e. does not know the dynmaic type of Current)?
		do
			Result := not options.is_ignoring_nonvariant and then is_feature_status (a_feature, "nonvariant")
		end

	is_functional (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a functional feature?
		do
			Result := is_feature_status (a_feature, "functional")
		end

	is_ghost (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a ghost feature?
		do
			Result := is_feature_status (a_feature, "ghost") or is_class_status (a_feature.written_class, "ghost")
		end

	is_impure (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' impure?
		do
			Result := is_feature_status (a_feature, "impure")
		end

	is_inline_in_caller (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' inlined in caller?
		do
			Result := is_feature_status (a_feature, "inline_in_caller")
		end

	is_invariant_unfriendly (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' invariant unfriendly?
		do
			Result := is_feature_status (a_feature, "inv_unfriendly")
		end

	is_lemma (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a ghost feature?
		do
			Result := is_feature_status (a_feature, "lemma")
		end

	is_manual_inv (a_feature: FEATURE_I): BOOLEAN
			-- Does `a_feature' have the manual inv trigger?
		do
			Result := boolean_feature_note_value (a_feature, "manual_inv")
		end

	is_opaque (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' an opaque function (its definition is not automatically available)?
		do
			Result := is_feature_status (a_feature, "opaque")
		end

	is_static (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a static feature (it does not take Current as argument)?
		do
			Result := is_feature_status (a_feature, "static")
		end

	is_private (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a public feature?
		do
			Result := a_feature.export_status.is_none
		end

	is_public (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a public feature?
		do
			Result := a_feature.is_exported_for (system.any_class.compiled_class)
		end

	is_setter (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' a setter?
		do
			Result := is_feature_status (a_feature, "setter")
		end

	is_skipped (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' skipped for verification?
		do
			Result := is_feature_status (a_feature, "skip")
		end

	features_with_string_note_value (a_class: CLASS_C; a_tag, a_value: READABLE_STRING_8): LINKED_LIST [FEATURE_I]
			-- Feature of class `a_class', which has a note where `a_tag' contain `a_value'.
		local
			l_feature: FEATURE_I
		do
			from
				create Result.make
				a_class.feature_table.start
			until
				a_class.feature_table.after
			loop
				l_feature := a_class.feature_table.item_for_iteration
				if feature_note_values (l_feature, a_tag).has (a_value) then
					Result.extend (l_feature)
				end
				a_class.feature_table.forth
			end
		end

	has_functional_representation (a_feature: FEATURE_I): BOOLEAN
			-- Will a Boogie function be generated for `a_feature'?
		do
			Result := a_feature.has_return_value and not is_feature_status (a_feature, "impure")
		end

feature -- Logical helpers

	is_class_logical (a_class: CLASS_C): BOOLEAN
			-- Is `a_class' mapped to a logical type in a Boogie theory?
		do
			Result := attached type_for_logical (a_class)
		end

	is_feature_logical (a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' directly mapped to a Boogie function?
		do
			Result := is_class_logical (a_feature.written_class) and not is_lemma (a_feature)
		end

	type_for_logical (a_class: CLASS_C): detachable READABLE_STRING_8
			-- Boogie type that `a_class' maps to;
			-- Void if `a_class' is not logical.
		require
			a_class_exists: attached a_class
		local
			l_values: like class_note_values
		do
			l_values := class_note_values (a_class, "maps_to")
			if not l_values.is_empty then
				Result := l_values.first
			end
		end

	function_for_logical (a_feature: FEATURE_I): detachable READABLE_STRING_8
			-- Boogie function that `a_feature' maps to;
			-- Void if `a_feature' is not from a logical class.
		local
			l_values: like feature_note_values
		do
			if attached a_feature and then is_class_logical (a_feature.written_class) then
				l_values := feature_note_values (a_feature, "maps_to")
				if l_values.is_empty then
						-- Use standard naming scheme
					Result := type_for_logical (a_feature.written_class) + "#" + to_camel_case (a_feature.feature_name)
				else
					Result := l_values.first
				end
			end
		end

	map_access_feature (a_class: CLASS_C): FEATURE_I
			-- The feature of the logical class `a_class' that maps to map access in Boogie (if any).
		require
			logical_class: is_class_logical (a_class)
		local
			l_feature: FEATURE_I
		do
			if map_access_feature_cache.has_key (a_class.class_id) then
				Result := map_access_feature_cache.item (a_class.class_id)
			else
				from
					a_class.feature_table.start
				until
					Result /= Void or a_class.feature_table.after
				loop
					l_feature := a_class.feature_table.item_for_iteration
					if attached function_for_logical (l_feature) as n and then n.same_string ("[]") then
						Result := l_feature
					end
					a_class.feature_table.forth
				end
				map_access_feature_cache.put (Result, a_class.class_id)
			end
		end

feature -- Ownership helpers

	is_class_explicit (a_class: CLASS_C; a_type: READABLE_STRING_8): BOOLEAN
			-- Does `a_class' list `a_type' as explicit?
		do
			Result := across class_note_values (a_class, "explicit") as i some i.same_string (a_type) or i.same_string ("all") end
		end

	is_feature_explicit (a_feature: FEATURE_I; a_type: STRING): BOOLEAN
			-- Does `a_feature' or list `a_type' as explicit?
		do
			Result := across feature_note_values (a_feature, "explicit") as i some i.same_string (a_type) or i.same_string ("all") end
		end

	is_explicit (a_feature: FEATURE_I; a_type: STRING): BOOLEAN
			-- Does either of the following hold?
			-- 1. ownership defaults are disabled
			-- 2. `a_feature' list `a_type' as explicit
			-- 3. `a_feature' marks all as explicit
			-- 4. the class of `a_feature' list `a_type' as explicit
			-- 5. the class of `a_feature' marks all as explicit
		do
			Result :=
				not options.is_ownership_defaults_enabled or else
				is_feature_explicit (a_feature, a_type) or else
				is_class_explicit (a_feature.written_class, a_type)
		end

	is_clause_reads (a_clause: ASSERT_B): BOOLEAN
			-- Is contract clause `a_clause' a reads clause?
		do
			Result := attached {FEATURE_B} a_clause.expr as l_call and then (l_call.feature_name ~ "reads" or l_call.feature_name ~ "reads_field" or l_call.feature_name ~ "reads_model")
		end

	is_clause_modify (a_clause: ASSERT_B): BOOLEAN
			-- Is contract clause `a_clause' a modify clause?
		do
			Result := attached {FEATURE_B} a_clause.expr as l_call and then (l_call.feature_name ~ "modify" or l_call.feature_name ~ "modify_field" or l_call.feature_name ~ "modify_model" or l_call.feature_name ~ "modify_agent")
		end

	is_clause_decreases (a_clause: ASSERT_B): BOOLEAN
			-- Is contract clause `a_clause' a decreases clause?
		do
			Result := attached {FEATURE_B} a_clause.expr as l_call and then l_call.feature_name ~ "decreases"
		end

	is_type_exact (a_type: TYPE_A; a_class_type: CL_TYPE_A; a_context_feature: FEATURE_I): BOOLEAN
			-- Is `a_type' (which corresponds to `a_class_type')
			-- in the context of `a_context_feature' represent a fixed dynamic type?
		require
			type_exists: attached a_type
			class_type_exists: attached a_class_type
		do
				-- Yes, if the base class is frozen, or the type is "like Current" (provided we are not inside a dynamic feature)
			Result := a_class_type.base_class.is_frozen or
				(a_type.is_like_current and not (attached a_context_feature and then is_nonvariant (a_context_feature)))
		end

	boogie_name_for_attribute (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie tranlsation of `a_feature', taking special translation of built-ins into account.
		do
			Result := a_feature.feature_name
			if not translation_mapping.ghost_access.has (Result) then
				Result := name_translator.boogie_procedure_for_feature (a_feature, a_context_type)
			end
		end

	guards_for_attribute (a_feature: FEATURE_I): LINKED_LIST [TUPLE [str: READABLE_STRING_8; origin: CLASS_C]]
			-- Update guard for attribute `a_feature'.
		local
			g: READABLE_STRING_8
			c: CLASS_C
		do
			create Result.make
			Result.compare_objects
			across all_versions (a_feature) as ver loop
				g := string_feature_note_value (ver, "guard")
				c := ver.written_class
				if g.is_empty then
						-- No guard defined
					if ver.assert_id_set = Void then
							-- This is the original version: apply default
						if boolean_class_note_value (c, "false_guards") then
							Result.extend (["false", c])
						else
							Result.extend (["inv", c])
						end
					else
							-- This is a redefinition: skip (equivalent to adding true)
					end
				else
						-- Explicit guard: add to list
					Result.extend (g, c)
				end
			end
		ensure
			non_empty: not Result.is_empty
			each_non_empty: across Result as s all not s.str.is_empty end
		end

	attribute_from_string (a_name: READABLE_STRING_8; a_type: CL_TYPE_A; a_origin_class: CLASS_C; a_context_feature: FEATURE_I; a_context_line_number: INTEGER): FEATURE_I
			-- Attribute or built-in ghost access with name `a_name' defined in `a_origin_class' in type `a_type'.
		local
			l_old_version: FEATURE_I
		do
			l_old_version := a_origin_class.feature_named (a_name)
			if l_old_version = Void then
				add_semantic_error (a_context_feature, messages.unknown_attribute ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_name), a_origin_class.name_in_upper), a_context_line_number)
			else
				Result := a_type.base_class.feature_of_rout_id_set (l_old_version.rout_id_set)
				check attached Result end
				if not l_old_version.is_attribute and not translation_mapping.ghost_access.has (a_name) then
					add_semantic_error (a_context_feature, messages.unknown_attribute ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (a_name), a_origin_class.name_in_upper), a_context_line_number)
				end
			end
		end

	field_from_attribute (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): IV_ENTITY
			-- Boogie field entity that corresponds to attribute (or built-in ghost access) `a_feature' in `a_context_type'.
		local
			l_type: CL_TYPE_A
		do
			if translation_mapping.ghost_access.has (a_feature.feature_name) then
				-- Handle built-in ANY attributes separately, since they are not really attributes.
				create Result.make (a_feature.feature_name, types.field (translation_mapping.ghost_access_type (a_feature.feature_name)))
			else
				check a_feature.is_attribute end
				l_type := class_type_in_context (a_feature.type, a_context_type.base_class, Void, a_context_type)
				create Result.make (name_translator.boogie_procedure_for_feature (a_feature, a_context_type),
					types.field (types.for_class_type (l_type)))
				translation_pool.add_referenced_feature (a_feature, a_context_type)
			end
		end

	is_built_in_attribute (a_feature: FEATURE_I): BOOLEAN
			-- Does `a_feature' represent on the of the built-in attributes?
			-- (Which means that it is not actually an attribute, but should be).
		do
				-- ToDo: take possible renaming into account?
			Result := translation_mapping.ghost_access.has (a_feature.feature_name)
		end

	ghost_attributes (a_class: CLASS_C): ARRAYED_LIST [FEATURE_I]
			-- All ghost attributes of `a_class' (in the order from most immediate to most inherited).
		local
			l_feature: FEATURE_I
		do
			if ghost_attribute_cache.has_key (a_class.class_id) then
				Result := ghost_attribute_cache [a_class.class_id]
			else
				from
					create Result.make (5)
					Result.start
					a_class.feature_table.start
				until
					a_class.feature_table.after
				loop
					l_feature := a_class.feature_table.item_for_iteration
					if (l_feature.is_attribute and is_ghost (l_feature)) or is_built_in_attribute (l_feature) then
						from
							Result.start
						until
							Result.after or else is_conforming_or_non_conforming_parent_class (l_feature.written_class, Result.item.written_class)
						loop
							Result.forth
						end
						Result.put_left (l_feature)
					end
					a_class.feature_table.forth
				end
				ghost_attribute_cache.put (Result, a_class.class_id)
			end
		end

feature -- Model helpers

	model_queries (a_class: CLASS_C): like class_note_values
			-- Names of model queries declared in class `a_class'.
		do
			Result := class_note_values (a_class, "model")
		end

	flat_model_queries (a_class: CLASS_C): ARRAYED_LIST [FEATURE_I]
			-- Model queries declared in class `a_class' and all its ancestors.
		local
			l_f, l_new_version: FEATURE_I
		do
			if flat_model_cache.has_key (a_class.class_id) then
				Result := flat_model_cache [a_class.class_id]
			else
				create Result.make (5)
				if a_class.class_id = system.any_id then
--					across translation_mapping.ghost_access as m loop
--						Result.extend (a_class.feature_named_32 (m.item))
--					end
					if attached a_class.feature_named ("subjects") as f then
						Result.extend (f)
					else
						add_unsupported_error (a_class, {STRING_32} "Feature `subjects` is not found in class `ANY`.", 0)
					end
					if attached a_class.feature_named ("observers") as f then
						Result.extend (f)
					else
						add_unsupported_error (a_class, {STRING_32} "Feature `observers` is not found in class `ANY`.", 0)
					end
				else
					across model_queries (a_class) as m loop
						l_f := a_class.feature_named (m)
						if l_f /= Void then
							Result.extend (l_f)
						else
							add_semantic_warning (a_class, messages.unknown_attribute ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (m), a_class.name_in_upper), -1)
						end
					end
					across a_class.parents_classes as c loop
						across flat_model_queries (c) as q loop
							l_new_version := a_class.feature_of_rout_id_set (q.rout_id_set)
							if not Result.has (l_new_version) then
								Result.extend (l_new_version)
							end
						end
					end
				end
				flat_model_cache.put (Result, a_class.class_id)
			end
		end

	is_model_query (a_class: CLASS_C; a_feature: FEATURE_I): BOOLEAN
			-- Is `a_feature' an immediate or inherited model query of `a_class'?
		do
			Result := across flat_model_queries (a_class) as f some is_same_feature (f, a_feature)  end
		end

	replaced_model_queries (a_feature: FEATURE_I; a_descendant: CLASS_C): ARRAYED_LIST [FEATURE_I]
			-- All features replaced by all version of `a_feature' in `a_type',
			-- as seen from `a_descendant'.
		require
			a_feature_exists: attached a_feature
		local
			l_rep_clause: like feature_note_values
			l_rep_feature: FEATURE_I
		do
			create Result.make (5)
			across all_versions (a_feature) as vers loop
				l_rep_clause := feature_note_values (vers, "replaces")
				across l_rep_clause as f loop
					l_rep_feature := vers.written_class.feature_named (f)
					if attached l_rep_feature then
						Result.extend (a_descendant.feature_of_rout_id_set (l_rep_feature.rout_id_set))
						across replaced_model_queries (l_rep_feature, a_descendant) as q loop
							if not Result.has (q) then
								Result.extend (q)
							end
						end
					end
				end
			end
		end

	replacing_model_queries (a_feature: FEATURE_I; a_class, a_descendant: CLASS_C): ARRAYED_LIST [FEATURE_I]
			-- All model queries that represent `a_feature' from `a_class'
			-- in `a_class' and its descendants down to `a_descendant',
			-- as seen in `a_descendant'.
		require
			class_exists: attached a_class
			feature_exists: attached a_feature
			feature_is_model: is_model_query (a_class, a_feature)
		local
			l_new_version: FEATURE_I
			l_rep_features: LINKED_LIST [FEATURE_I]
		do
			create Result.make (5)
			Result.extend (a_descendant.feature_of_rout_id_set (a_feature.rout_id_set))
			across a_class.direct_descendants as d loop
				if a_descendant.inherits_from (d) then
					l_new_version := d.feature_of_rout_id_set (a_feature.rout_id_set)
					if model_queries (d).has (l_new_version.feature_name) then
						create l_rep_features.make
						l_rep_features.extend (l_new_version)
					else
						l_rep_features := features_with_string_note_value (d, "replaces", l_new_version.feature_name)
					end
					across l_rep_features as rep_f loop
						across replacing_model_queries (rep_f, d, a_descendant) as q loop
							if not Result.has (q) then
								Result.extend (q)
							end
						end
					end
				end
			end
		end

feature -- String helpers

	feature_of_type_as_string (a_feature: FEATURE_I; a_type: TYPE_A): STRING
		do
			Result := "{" + a_type.name + "}." + a_feature.feature_name
		end

feature -- Eiffel helpers

	constraint_type (a_class: CLASS_C): CL_TYPE_A
			-- Type based on `a_class' without formal generic parameters.
		local
			new_generics: like {CL_TYPE_A}.generics
			r: GEN_TYPE_A
		do
			Result := a_class.actual_type
			if
				attached {GEN_TYPE_A} Result as t and then
				attached t.generics as old_generics
			then
				across
					old_generics as g
				loop
					if g.is_formal then
						if not attached new_generics then
							new_generics := old_generics.twin
							r := t.twin
							r.set_generics (new_generics)
							Result := r
						end
						new_generics [@ g.target_index] := t.base_class.single_constraint (@ g.target_index)
					end
				end
			end
			a_class.update_types (Result)
		end

	is_same_class (c1, c2: CLASS_C): BOOLEAN
			-- Are `c1' and `c2' the same class?			
		do
			Result := c1 = c2 or
				((c1 /= Void and c2 /= Void) and then c1.class_id = c2.class_id)
		end

	is_same_feature (f1, f2: FEATURE_I): BOOLEAN
			-- Are `f1' and `f2' the same feature?
		do
			Result := f1 = f2 or
				((f1 /= Void and f2 /= Void) and then (f1.written_in = f2.written_in and f1.rout_id_set.first = f2.rout_id_set.first))
		end

	is_class_any (c: CLASS_C): BOOLEAN
			-- Is `c' the ANY class?
		do
			Result := c /= Void and then c.class_id = system.any_id
		end

	is_class_array (c: CLASS_C): BOOLEAN
			-- Is `c' the ARRAY class?
		do
			Result := c /= Void and then c.class_id = system.array_id
		end

	is_agent_type (t: CL_TYPE_A): BOOLEAN
			-- Is `t' an agent type?
		local
			n: like {CLASS_C}.name
		do
			n := t.base_class.name
			Result :=
				n.is_case_insensitive_equal ("ROUTINE") or else
				n.is_case_insensitive_equal ("PROCEDURE") or else
				n.is_case_insensitive_equal ("FUNCTION") or else
				n.is_case_insensitive_equal ("PREDICATE")
		ensure
			instance_free: class
		end

	is_conforming_or_non_conforming_parent_class (a_child, a_parent: CLASS_C): BOOLEAN
			-- Does `a_child' inherit conforminlgy or non-conformingly from `a_parent'?
		do
			Result := a_child.conform_to (a_parent) or else is_non_conforming_parent_class (a_child, a_parent)
		end

	is_non_conforming_parent_class (a_child, a_parent: CLASS_C): BOOLEAN
			-- Does `a_child' inherit non-conformingly from `a_parent'?
		local
			l_item: CLASS_C
		do
			if a_child.non_conforming_parents_classes /= Void then
				from
					a_child.non_conforming_parents_classes.start
				until
					a_child.non_conforming_parents_classes.after or Result
				loop
					l_item := a_child.non_conforming_parents_classes.item
					Result := l_item.class_id = a_parent.class_id or else is_conforming_or_non_conforming_parent_class (l_item, a_parent)
					a_child.non_conforming_parents_classes.forth
				end
			end
		end

	is_creator_of_class (a_feature: FEATURE_I; a_class: CLASS_C): BOOLEAN
			-- Is `a_feature' a creator of `a_class'?
		do
			Result := a_class.has_creator_of_name_id (a_feature.feature_name_id) or
				(a_class.creation_feature /= Void and then a_class.creation_feature.feature_id = a_feature.feature_id)
		end

	feature_for_call_access (a_node: CALL_ACCESS_B; a_target_type: TYPE_A): FEATURE_I
			-- Feature represented by `a_node'.
		do
			check is_conforming_or_non_conforming_parent_class (a_target_type.base_class, system.class_of_id (a_node.written_in)) end
			Result := a_target_type.base_class.feature_of_rout_id (a_node.routine_id)
			Result := Result.instantiated (a_target_type)
			check Result /= Void end
		end

	class_type_in_context (a_type: TYPE_A; an_ancestor_class: CLASS_C; a_feature: FEATURE_I; a_current_type: CL_TYPE_A): CL_TYPE_A
			-- Class type `a_type', which comes from `an_ancestor_class' (with optional `a_feature') as seen from `a_current_type'.
		require
			no_formals: not a_current_type.has_formal_generic
		local
			t: TYPE_A
		do
			if a_type.is_like_current then
				Result := a_current_type
			else
					-- `evaluated_type_in_descendant' switches to the correct feature in case of LIKE_FEATURE types
					-- `deep_actual_type' gets rid of like types
					-- `instantiated_in (a_current_type)' instantiates the generics				
				t := a_type.evaluated_type_in_descendant
					(an_ancestor_class, a_current_type.base_class, a_feature).deep_actual_type.instantiated_in
					(a_current_type)
				if attached {CL_TYPE_A} t as c then
					Result := c
				elseif
					attached {FORMAL_A} a_type as f and then
					attached {CL_TYPE_A} a_current_type.base_class.single_constraint (f.position) as c
				then
					Result := c
				else
					check class_type_constraint: False then end
				end
			end
		ensure
			no_formals: not Result.has_formal_generic
		end

	class_type_from_class (a_class: CLASS_C; a_context_type: CL_TYPE_A): CL_TYPE_A
			-- Type of ancetor `a_class' in `a_context_type'.
		do
			Result := class_type_in_context (a_class.actual_type, a_class, Void, a_context_type)
		end

	all_versions (a_feature: FEATURE_I): LINKED_LIST [FEATURE_I]
			-- All written versions of `a_feature'.
		local
			l_written_feature: FEATURE_I
			i: INTEGER
		do
			create Result.make
				-- Add the written version of the feature			
			l_written_feature := a_feature.written_class.feature_of_body_index (a_feature.body_index)
			Result.extend (l_written_feature)
			if a_feature.assert_id_set /= Void then
					-- Redefined feature: return original versions
				from
					i := 1
				until
					i > a_feature.assert_id_set.count
				loop
					l_written_feature := a_feature.assert_id_set [i].written_class.feature_of_body_index (a_feature.assert_id_set [i].body_index)
					Result.extend (l_written_feature)
					i := i + 1
				end
			end
		end

	set_any_type: detachable CL_TYPE_A
			-- Type MML_SET [ANY] (supplier of ANY).
		do
			if attached system.any_type.base_class.feature_named ("owns") as f then
				Result := {CL_TYPE_A} / f.type
			else
				add_unsupported_error (Void, {STRING_32} "Feature `owns` is not found in class `ANY`.", 0)
			end
		end

feature -- Contract helpers

	has_flat_precondition (a_feature: FEATURE_I): BOOLEAN
			-- Could `a_feature' have a precondition (immediate or inherited)?
		do
			Result := a_feature.has_precondition or a_feature.assert_id_set /= Void
		end

feature -- Byte context helpers

	set_up_byte_context (a_feature: FEATURE_I; a_type: TYPE_A)
			-- Set up byte context for `a_feature' of type `a_type'.
		do
				-- Clear byte context
			if a_feature /= Void then
				Context.clear_feature_data
			end
			Context.clear_class_type_data
			Context.inherited_assertion.wipe_out

				-- Set up class type
			if not a_type.has_associated_class_type (Void) then
				if attached {CL_TYPE_A} a_type as l_cl_type_a then
					a_type.base_class.update_types (l_cl_type_a)
				else
					check False end
				end
			end
			check a_type.has_associated_class_type (Void) end
			Context.init (a_type.associated_class_type (Void))

				-- Set up feature data
			if a_feature /= Void then
				Context.set_class_type (a_feature.written_type (a_type.associated_class_type (Void)))
				Context.set_current_feature (a_feature)
				if byte_server.has (a_feature.body_index) then
					Context.set_byte_code (byte_server.item (a_feature.body_index))
				end
			end
		end

	switch_byte_context (f: FEATURE_I; target_type: CL_TYPE_A; written_type: CL_TYPE_A)
			-- Update byte context to feature `f` written in `written_type` called on type `target_type`.
			-- Use `unswitch_byte_context` to restore original state.
		do
			context.change_class_type_context
				(target_type.associated_class_type (Void),
				target_type,
				written_type.associated_class_type (Void),
				written_type)
			context_stack.put ([context.current_feature, context.byte_code])
			if attached f then
				context.set_current_feature (f)
				if byte_server.has (f.body_index) then
					context.set_byte_code (byte_server.item (f.body_index))
				end
			else
				context.clear_feature_data
			end
		ensure
			context_stack_count: switch_count = old switch_count + 1
			context_stack_unchanged: across old context_stack as i all context_stack [@ i.target_index] = i end
		end

	unswitch_byte_context
			-- Restore byte context to the state before the call to `switch_byte_context`.
		require
			switch_count > 0
		do
			if attached context_stack.item.current_feature as f then
				context.set_current_feature (f)
			else
				context.clear_feature_data
			end
			if attached context_stack.item.byte_code as b then
				context.set_byte_code (b)
			end
			context_stack.remove
			context.restore_class_type_context
		ensure
			context_stack_count: switch_count = old switch_count - 1
			context_stack_unchanged: across context_stack as i all (old context_stack) [@ i.target_index] = i end
		end

	switch_count: NATURAL_32
			-- Number of times the byte context stack has switched.
		do
			Result := context_stack.count.as_natural_32
		ensure
			definition: Result = context_stack.count.as_natural_32
		end

feature {NONE} -- Storage

	context_stack: ARRAYED_STACK [TUPLE [current_feature: detachable FEATURE_I; byte_code: detachable BYTE_CODE]]
			-- Stack of byte contexts saved by `switch_byte_context`.

feature -- Other

	is_inlining_routine (a_routine: FEATURE_I): BOOLEAN
			-- Should routine `a_routine' be inlinied?
		do
			Result := options.is_inlining_enabled and then
				is_inline_in_caller (a_routine)
			if not Result and options.is_automatic_inlining_enabled then
				Result := not
					(a_routine.has_postcondition or else
					attached a_routine.assert_id_set as a and then a.has_postcondition)
			end
			if not Result then
				Result := options.routines_to_inline.has (a_routine.body_index)
			end
		end

	internal_counter: CELL [INTEGER]
			-- Internal shared counter.
		once
			create Result.put (0)
		end

	unique_identifier (a_name: READABLE_STRING_8): READABLE_STRING_8
			-- Unique identifier with base name `a_name'.
		do
			internal_counter.put (internal_counter.item + 1)
			check internal_counter.item >= 0 end
			Result := a_name + "_" + internal_counter.item.out
		end

	add_unsupported_error (a_class_or_feature: ANY; a_message: READABLE_STRING_32; a_line_number: INTEGER)
			-- Add AutoProof error about unsupported construct concerning `a_class_or_feature' with message `a_message'.
			-- Verification will not proceed.
		require
			class_or_feature_or_void: a_class_or_feature = Void or else (attached {CLASS_C} a_class_or_feature or attached {FEATURE_I} a_class_or_feature)
			message_set: a_message /= Void and then not a_message.is_empty
		local
			l_error: E2B_AUTOPROOF_ERROR
		do
			create l_error
			l_error.set_type ("Unsupported")
			l_error.set_message (a_message)
			if attached {FEATURE_I} a_class_or_feature as x then
				l_error.set_feature (x)
			elseif attached {CLASS_C} a_class_or_feature as x then
				l_error.set_class (x)
			end
			l_error.set_line_number (a_line_number)
			autoproof_errors.extend (l_error)
		end

	add_semantic_error (a_class_or_feature: ANY; a_message: READABLE_STRING_32; a_line_number: INTEGER)
			-- Add AutoProof validity error concerning `a_class_or_feature' with message `a_message'.
			-- Verification will not proceed.
		require
			class_or_feature_or_void: a_class_or_feature = Void or else (attached {CLASS_C} a_class_or_feature or attached {FEATURE_I} a_class_or_feature)
			message_set: a_message /= Void and then not a_message.is_empty
		local
			l_error: E2B_AUTOPROOF_ERROR
		do
			create l_error
			l_error.set_type ("Validity")
			l_error.set_message (a_message)
			if attached {FEATURE_I} a_class_or_feature as x then
				l_error.set_feature (x)
			elseif attached {CLASS_C} a_class_or_feature as x then
				l_error.set_class (x)
			end
			l_error.set_line_number (a_line_number)
			if not autoproof_errors.has (l_error) then
				autoproof_errors.extend (l_error)
			end
		end

	add_semantic_warning (a_class_or_feature: ANY; a_message: READABLE_STRING_32; a_line_number: INTEGER)
			-- Add AutoProof validity warning concerning `a_class_or_feature' with message `a_message'.
			-- Verification will proceed.
		require
			class_or_feature_or_void: a_class_or_feature = Void or else (attached {CLASS_C} a_class_or_feature or attached {FEATURE_I} a_class_or_feature)
			message_set: a_message /= Void and then not a_message.is_empty
		local
			l_error: E2B_AUTOPROOF_ERROR
		do
			create l_error
			l_error.set_type ("Validity")
			l_error.set_message (a_message)
			if attached {FEATURE_I} a_class_or_feature as x then
				l_error.set_feature (x)
			elseif attached {CLASS_C} a_class_or_feature as x then
				l_error.set_class (x)
			end
			l_error.set_line_number (a_line_number)
			l_error.set_warning (True)
			if not autoproof_errors.has (l_error) then
				autoproof_errors.extend (l_error)
			end
		end

	verify_feature_in_class (a_feature: FEATURE_I; a_class: CLASS_C): BOOLEAN
			-- Should `a_feature' be verified as part of verification of `a_class'?
		do
			Result := a_feature.is_routine and -- is routine
				not is_feature_logical (a_feature) and -- not logical
				not helper.is_skipped (a_feature) and -- not feature skipped
				not helper.is_skipped_class (a_class) and -- not class skipped
				(a_feature.written_in /= system.any_id or a_feature.rout_id_set.has (system.default_create_rout_id)) and -- is not inherited from ANY
				not (a_feature.written_in /= a_class.class_id and is_nonvariant (a_feature)) -- not an inherited nonvariant feature
		end

feature {NONE} -- Implementation

	to_camel_case (a_name: STRING): STRING
			-- Eiffel-style identifier `a_name' converted to camel case.
		local
			i: INTEGER
		do
			Result := a_name.string
			from
				i := 1
			until
				not Result.valid_index (i)
			loop
				Result.replace_substring (Result.substring (i, i).as_upper, i, i)
				i := Result.index_of ('_', i)
				if Result.valid_index (i) then
					Result.remove (i)
				end
			end
		end

	map_access_feature_cache: HASH_TABLE [FEATURE_I, INTEGER]
			-- Cache of the feature that translates to map access for each model class.
		once
			create Result.make (50)
		end

	flat_model_cache: HASH_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER]
			-- Cache of a list of all model queries for each class.
		once
			create Result.make (50)
		end

	ghost_attribute_cache: HASH_TABLE [ARRAYED_LIST [FEATURE_I], INTEGER]
			-- Cache of a list of all ghost attributes for each class.
		once
			create Result.make (50)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2015 ETH Zurich",
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
