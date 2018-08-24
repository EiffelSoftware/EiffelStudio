note
	description: "[
		Handle custom translation of strings.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_STRING_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER

	SHARED_WORKBENCH

	INTERNAL_COMPILER_STRING_EXPORTER

	E2B_SHARED_CONTEXT

	IV_SHARED_FACTORY

	IV_SHARED_TYPES

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- Is this handler handling the call?
		do
			Result := a_target_type.base_class.name_in_upper ~ "V_STRING" and a_feature.feature_name ~ "make_from_string"
		end

feature -- Basic operations

	handle_routine_call_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- Handle routine call in body.
		do
			if attached {STRING_B} a_parameters.i_th (1).expression as l_string_b then
					-- TODO: the `last_expression' has already been set to a newly created local, calling this method will do that again.
--				handle_manifest_string_in_body (a_translator, l_string_b)
				add_init_call (a_translator, l_string_b, a_translator.current_target)
			end
		end

	handle_routine_call_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- Handle routine call in contract.
		do
		end

	handle_manifest_string_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_node: STRING_B)
			-- Handle manifest string in body.
		local
			l_entity: IV_ENTITY
			l_proc_call: IV_PROCEDURE_CALL
--			l_creator: FEATURE_I
			l_cl_type: CL_TYPE_A
--			l_seq_type: IV_USER_TYPE
--			l_expr: IV_EXPRESSION
--			i: INTEGER
		do
--			l_creator := v_string_class.feature_named_32 ("init")
			l_cl_type := v_string_class.actual_type

--			translation_pool.add_referenced_feature (l_creator, l_cl_type)

			a_translator.create_local (l_cl_type)
			l_entity := a_translator.last_local

				-- Allocate
			create l_proc_call.make ("allocate")
			l_proc_call.set_target (l_entity)
			l_proc_call.add_argument (factory.type_value (l_cl_type))
			a_translator.side_effect.extend (l_proc_call)

			add_init_call (a_translator, a_node, l_entity)
			a_translator.set_last_expression (l_entity)


--				-- Build sequence argument
--			create l_seq_type.make ("Seq", << types.int >>)
--			if a_node.value.is_empty then
--				l_expr := factory.function_call ("Seq#Empty", Void, l_seq_type)
--			else
--				from
--					l_expr := factory.function_call ("Seq#Singleton", << factory.int_value (a_node.value.item (1).code) >>, l_seq_type)
--					i := 2
--				until
--					i > a_node.value.count
--				loop
--					l_expr := factory.function_call ("Seq#Extended", << l_expr, factory.int_value (a_node.value.item (i).code) >>, l_seq_type)
--					i := i + 1
--				end
--			end

--				-- Call creation procedure
--			create l_proc_call.make (name_translator.boogie_procedure_for_creator (l_creator, l_cl_type))
--			l_proc_call.add_argument (l_entity)
--			l_proc_call.add_argument (l_expr)
--			a_translator.side_effect.extend (l_proc_call)

		end

	add_init_call (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_node: STRING_B; a_target: IV_EXPRESSION)
			-- Add call to `V_STRING.init' on `a_target'.
		local
			l_cl_type: CL_TYPE_A
			l_creator: FEATURE_I
			l_proc_call: IV_PROCEDURE_CALL
			l_seq_type: IV_USER_TYPE
			l_expr: IV_EXPRESSION
			i: INTEGER
		do
			l_creator := v_string_class.feature_named_32 ("init")
			l_cl_type := v_string_class.actual_type

			translation_pool.add_referenced_feature (l_creator, l_cl_type)

				-- Build sequence argument
			create l_seq_type.make ("Seq", << types.int >>)
			if a_node.value.is_empty then
				l_expr := factory.function_call ("Seq#Empty", Void, l_seq_type)
			else
				from
					l_expr := factory.function_call ("Seq#Singleton", << factory.int_value (a_node.value.item (1).code) >>, l_seq_type)
					i := 2
				until
					i > a_node.value.count
				loop
					l_expr := factory.function_call ("Seq#Extended", << l_expr, factory.int_value (a_node.value.item (i).code) >>, l_seq_type)
					i := i + 1
				end
			end

				-- Call creation procedure
			create l_proc_call.make (name_translator.boogie_procedure_for_creator (l_creator, l_cl_type))
			l_proc_call.add_argument (a_target)
			l_proc_call.add_argument (l_expr)
			a_translator.side_effect.extend (l_proc_call)
		end


	v_string_class: CLASS_C
			-- Class for V_STRING.
		do
			if v_string_class_internal = Void then
				v_string_class_internal := universe.classes_with_name ("V_STRING").first.compiled_class
			end
			Result := v_string_class_internal
		end

	v_string_class_internal: CLASS_C
			-- Cached version of `v_string_class'.

end
