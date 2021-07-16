note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_ARRAY_CALL_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result :=
				a_target_type.base_class.name.is_case_insensitive_equal ("ARRAY") and then
				(array_functions.has (a_feature.feature_name) or else array_procedures.has (a_feature.feature_name))
		end

feature -- Basic operations

	handle_routine_call_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_array_type: STRING
			l_fname: STRING
		do
--			if a_feature.feature_name.same_string ("item") then
--				a_translator.process_parameters (a_parameters)
--				check a_translator.last_parameters.count = 1 end
--				a_translator.add_safety_check (factory.function_call ("fun.ARRAY.is_index", << a_translator.entity_mapping.heap, a_translator.current_target, a_translator.last_parameters.first >>, types.bool), "bounds")
--				a_translator.set_last_expression (factory.array_access (a_translator.entity_mapping.heap, a_translator.current_target, a_translator.last_parameters.first))
--			else
				l_array_type := "ARRAY"
				if array_procedures.has (a_feature.feature_name) then
					l_fname := l_array_type + "." + a_feature.feature_name
					a_translator.process_builtin_routine_call (a_feature, a_parameters, l_fname)
				elseif array_functions.has (a_feature.feature_name) then
					l_fname := "fun." + l_array_type + "." + a_feature.feature_name
					a_translator.process_builtin_function_call (a_feature, a_parameters, l_fname)
				else
					check False end
				end
--			end
		end

	handle_routine_call_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_array_type: STRING
			l_fname: STRING
		do
			l_array_type := array_type_string (a_translator.current_target_type)
			l_array_type := "ARRAY"
			if array_functions.has (a_feature.feature_name) then
				l_fname := "fun." + l_array_type + "." + a_feature.feature_name
				a_translator.process_builtin_routine_call (a_feature, a_parameters, l_fname)
			else
				check False end
			end
		end

	array_type_string (a_array_type: CL_TYPE_A): STRING
		local
			l_type: TYPE_A
		do
			check a_array_type.base_class.name_in_upper.same_string ("ARRAY") end
			check a_array_type.has_generics end
			check a_array_type.generics.count = 1 end
			l_type := a_array_type.generics.i_th (1)
			if l_type.is_boolean then
				Result := "ARRAY#bool#"
			elseif l_type.is_integer or l_type.is_natural then
				Result := "ARRAY#int#"
			elseif l_type.is_real_32 or l_type.is_real_64 then
				Result := "ARRAY#real#"
			else
				Result := "ARRAY#ref#"
			end
		end

	array_procedures: ARRAY [STRING]
			-- List of builtin array procedures.
		once
			Result := <<
				"make",
				"make_filled",
				"make_from_array",
				"item",
				"put",
				"subarray",
				"subcopy"
			>>
			Result.compare_objects
		end

	array_functions: ARRAY [STRING]
			-- List of builtin array functions.
		once
			Result := <<
				"item",
				"has",
				"count",
				"capacity",
				"subarray",
				"occurrences",
				"is_equal",
				"valid_index_set"
			>>
			Result.compare_objects
		end

end
