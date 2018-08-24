note
	description: "Translator to map Eiffel names to Boogie names."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_NAME_TRANSLATOR

inherit

	SHARED_WORKBENCH
		export
			{NONE}
				all
			{ANY}
				deep_twin,
				is_deep_equal,
				standard_is_equal
		end

feature -- Access

	boogie_procedure_for_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie procedure that encodes `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_procedure_for_creator (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie procedure that encodes `a_feature' used as a creation procedure.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := "create." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_function_for_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_uninterpreted: BOOLEAN): STRING
			-- Name of the boogie function that encodes the result of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			if a_uninterpreted then
				Result := "fun0." + l_type_name + "." + l_feature_name
			else
				Result := "fun." + l_type_name + "." + l_feature_name
			end
		ensure
			result_attached: attached Result
		end

	boogie_function_for_write_frame (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie function that encodes the write frame of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := "modify." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
		end

	boogie_function_for_read_frame (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie function that encodes the read frame of the functional representation of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := "read.fun." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
		end

	boogie_procedure_for_contract_check (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie procedure that encodes the consistence check of `a_feature's contracts.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := l_type_name + "." + l_feature_name + ".check"
		ensure
			result_attached: attached Result
		end

	boogie_function_precondition (a_function_name: STRING): STRING
			-- Precondition predicate name for function named `a_function_name'.
		require
			a_function_name_attached: attached a_function_name
		do
			Result := "pre." + a_function_name
		ensure
			result_attached: attached Result
		end

--	boogie_free_function_precondition (a_function_name: STRING): STRING
--			-- Free precondition predicate name for function named `a_function_name'.
--		require
--			a_function_name_attached: attached a_function_name
--		do
--			Result := "free_pre." + a_function_name
--		ensure
--			result_attached: attached Result
--		end

	boogie_function_trigger (a_function_name: STRING): STRING
			-- Trigger predicate name for opaque function named `a_function_name'.
		require
			a_function_name_attached: attached a_function_name
		do
			Result := "trigger." + a_function_name
		ensure
			result_attached: attached Result
		end

	boogie_function_for_variant (a_index: INTEGER; a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie function that encodes `a_index'-th variant of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := a_feature.feature_name_32.as_lower
			Result := "variant." + l_type_name + "." + l_feature_name + "." + a_index.out
		ensure
			result_attached: attached Result
		end

	boogie_function_for_invariant (a_type: CL_TYPE_A): STRING
			-- Name of the boogie function that encodes the class invariant of type `a_type'.
		require
			a_type: attached a_type
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			Result := l_type_name + ".user_inv"
		ensure
			result_attached: attached Result
		end

	boogie_function_for_filtered_invariant (a_type: CL_TYPE_A; a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C): STRING
			-- Name of the boogie function that encodes the partial class invariant of type `a_type'
			-- with `a_included' clauses included and `a_excluded' clauses excluded.
		require
			a_type_exists: attached a_type
			a_ancestor_exists: attached a_ancestor
		local
			l_type_name: STRING
			l_filter_string: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			l_filter_string := ""
			if a_included /= Void then
				l_filter_string.append ("#I")
				across a_included as i loop l_filter_string.append ("#" + i.item) end
			end
			if a_excluded /= Void then
				l_filter_string.append ("#E")
				across a_excluded as i loop l_filter_string.append ("#" + i.item) end
			end
			if a_ancestor.class_id /= a_type.base_class.class_id then
				l_filter_string.append ("#A#" + a_ancestor.name_in_upper)
			end
			Result := l_type_name + l_filter_string + ".filtered_inv"
		ensure
			result_attached: attached Result
		end

	boogie_function_for_ghost_definition (a_type: CL_TYPE_A; a_name: STRING): STRING
			-- Name of the boogie function that encodes the static definition of a ghost field `a_name' of type `a_type'.
		require
			a_type: attached a_type
			a_name: attached a_name
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			Result := l_type_name + "." + a_name + ".static"
		ensure
			result_attached: attached Result
		end

	boogie_field_for_tuple_field (a_context_type: CL_TYPE_A; a_position: INTEGER): STRING
			-- Name of the boogie constant that encodes tuple field at `a_position' in the tuple type `a_context_type'.
		require
			a_context_type_attached: attached a_context_type
			is_tuple: a_context_type.is_tuple
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := "field_" + a_position.out
			Result := l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_procedure_for_tuple_creation (a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie constant that encodes tuple field at `a_position' in the tuple type `a_context_type'.
		require
			a_context_type_attached: attached a_context_type
			is_tuple: a_context_type.is_tuple
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			Result := "create." + l_type_name + ".make"
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end


	feature_for_boogie_name (a_name: STRING): TUPLE [type: TYPE_A; feature_: FEATURE_I; is_creator: BOOLEAN]
			-- For a feature named `a_name' in Boogie code,
			-- return its enclosing type (different from where it is defined if inherited), the eiffel feature and whether it is a creator.
		require
			valid_feature_name: is_valid_feature_name (a_name)
		local
			l_name: STRING
			l_list: LIST [STRING]
			l_type_name: STRING
			l_feature_name: STRING
			l_type: TYPE_A
			l_is_creator: BOOLEAN
		do
			if a_name.starts_with ("create.") then
				l_is_creator := True
				l_name := a_name.twin
				l_name.remove_head (7)
			else
				l_name := a_name
			end
			if l_name.has ('.') then
				l_list := l_name.split ('.')
				l_type_name := l_list.i_th (1)
				l_feature_name := l_list.i_th (2)
				if l_type_name.starts_with ("$") then
					l_type_name.remove (1)
				end
			else
					-- Built in features
				l_type_name := "ANY"
				l_feature_name := l_name
			end
			l_type := type_for_boogie_name (l_type_name)
			Result := [l_type, l_type.base_class.feature_named_32 (l_feature_name), l_is_creator]
		ensure
			result_attached: attached Result
		end

	boogie_name_for_type (a_type: CL_TYPE_A): STRING
			-- Name for type `a_type'.
		require
			a_type_attached: attached a_type
		local
			i: INTEGER
			l_type_name: STRING
			l_helper: E2B_HELPER
		do
			create l_helper
			if l_helper.is_agent_type (a_type) then
				Result := a_type.base_class.name_in_upper
			elseif attached {GEN_TYPE_A} a_type as l_gen_type then
				Result := l_gen_type.base_class.name_in_upper.twin
				Result.append ("^")
				from
					i := l_gen_type.generics.lower
				until
					i > l_gen_type.generics.upper
				loop
					check attached {CL_TYPE_A} l_gen_type.generics.i_th (i) as t then
						l_type_name := boogie_name_for_type (t)
					end
					Result.append (l_type_name)
					if i < l_gen_type.generics.upper then
						Result.append ("#")
					end
					i := i + 1
				end
				Result.append ("^")
			else
				Result := a_type.base_class.name_in_upper.twin
			end
		ensure
			result_attached: attached Result
			result_valid: is_valid_type_name (Result)
		end

	type_for_boogie_name (a_name: STRING): TYPE_A
			-- Type named `a_name' in Boogie code.
		require
			valid_type_name: is_valid_type_name (a_name)
		local
			l_class_name: STRING
			l_classes: LIST [CLASS_I]
		do
			if a_name.has ('^') then
				l_class_name := a_name.substring (1, a_name.index_of ('^', 1)-1)
					-- TODO: handle generic parameters
			elseif a_name.has ('#') then
				l_class_name := a_name.substring (1, a_name.index_of ('#', 1)-1)
					-- TODO: handle generic parameters
			else
				l_class_name := a_name
			end
			l_classes := universe.classes_with_name (l_class_name)
			if not l_classes.is_empty then
				Result := l_classes.first.compiled_class.actual_type
			end
		ensure
			result_attached: attached Result
		end

	postcondition_predicate_name (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Postcondition predicate name for feature `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		do
			Result := "post." + boogie_procedure_for_feature (a_feature, a_context_type)
		ensure
			result_attached: attached Result
		end

	boogie_name_for_local (i: INTEGER): STRING
			-- Name for local with index `i'.
		require
			i_valid: i > 0
		do
			Result := "local" + i.out
		ensure
			result_attached: attached Result
		end

feature -- Status report

	is_valid_feature_name (a_name: STRING): BOOLEAN
			-- Can `a_name' be mapped to an Eiffel feature?
		do
				-- TODO: implement
			Result := True
		end

	is_valid_type_name (a_name: STRING): BOOLEAN
			-- Can `a_name' be mapped to an Eiffel type?
		do
				-- TODO: implement
			Result := True
		end

	is_creator_name (a_name: STRING): BOOLEAN
			-- Is Boogie procedure `a_name' a translation of a creator?
		do
			Result := a_name.starts_with ("create.")
		end

end
