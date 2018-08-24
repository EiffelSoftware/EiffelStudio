note
	description: "A handler for calls where target type is a logical class."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_LOGICAL_HANDLER

inherit
	E2B_CUSTOM_CALL_HANDLER

	E2B_CUSTOM_NESTED_HANDLER

	SHARED_WORKBENCH

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result := helper.is_feature_logical (a_feature)
		end

	is_handling_nested (a_nested: NESTED_B): BOOLEAN
			-- <Precursor>
		do
			if
				not a_nested.target.type.is_like and then
				a_nested.target.type.base_class /= Void and then
				(a_nested.target.type.base_class.class_id = system.tuple_id or a_nested.target.type.base_class.class_id = system.array_id)
			then
				if attached {FEATURE_B} a_nested.message as f then
					Result := f.feature_name ~ "to_mml_set" or
						f.feature_name ~ "to_mml_sequence"
				end
			end
		end

	has_arg_current (a_feature: FEATURE_I): BOOLEAN
			-- Does the translation of `a_feature' take "current" as the first argument?
		do
			Result := a_feature.has_return_value and not a_feature.is_external
		end

feature -- Basic operations

	handle_routine_call_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		do
			handle_routine_call (a_translator, a_feature, a_parameters)
		end

	handle_routine_call_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		do
			handle_routine_call (a_translator, a_feature, a_parameters)
		end

	handle_binary (a_translator: E2B_EXPRESSION_TRANSLATOR; a_class: CLASS_C; a_left, a_right: IV_EXPRESSION; a_operator: STRING)
			-- Handle built-in (non alias) binary expression where `a_left' is of logical type.
		require
			eq_or_neq: a_operator ~ "==" or a_operator ~ "!="
		local
			l_eq: STRING
			l_expr: IV_EXPRESSION
		do
			l_eq := helper.function_for_logical (a_class.feature_named_32 ("is_equal"))
			if l_eq /= Void then
				l_expr := factory.function_call (l_eq, << a_left, a_right >>, types.bool)
			else
				l_expr := factory.equal (a_left, a_right)
			end
			if a_operator ~ "!=" then
				l_expr := factory.not_ (l_expr)
			end
			a_translator.set_last_expression (l_expr)
		end

	handle_nested_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- <Precursor>
		do
			handle_nested (a_translator, a_nested)
		end

	handle_nested_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- <Precursor>
		do
			handle_nested (a_translator, a_nested)
		end

feature {NONE} -- Implementation

	handle_routine_call (a_translator: E2B_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_fname: STRING
			l_fcall, l_pre_call: IV_FUNCTION_CALL
			l_args: ARRAY [IV_EXPRESSION]
		do
			check helper.is_feature_logical (a_feature) end
			translation_pool.add_referenced_feature (a_feature, a_translator.current_target_type)

			a_translator.process_parameters (a_parameters)

			l_fname := helper.function_for_logical (a_feature)
			if l_fname ~ "[]" then
					-- The feature maps to map access
				create l_args.make (1, a_translator.last_parameters.count)
				across
					a_translator.last_parameters as params
				loop
					l_args [params.target_index] := params.item
				end
				a_translator.set_last_expression (factory.map_access (a_translator.current_target, l_args))
			else
				if a_feature.has_return_value then
					create l_fcall.make (l_fname, types.for_class_type (a_translator.feature_class_type (a_feature)))
					if not a_feature.is_external then
							-- We use external as static, so only add the target if not external
						l_fcall.add_argument (a_translator.current_target)
					end
				else
						-- Since logical classes are immutable, this must be a creation procedure
					create l_fcall.make (l_fname, types.for_class_type (a_translator.current_target_type))
				end
				across
					a_translator.last_parameters as params
				loop
					l_fcall.add_argument (params.item)
				end
				a_translator.set_last_expression (l_fcall)
					-- Add precondition check				
				a_translator.add_function_precondition_check (a_feature, l_fcall)
			end
		end

	handle_nested (a_translator: E2B_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- Handle `a_nested'.
		local
			l_tuple: TUPLE_CONST_B
			l_array: ARRAY_CONST_B
			l_exprs: LINKED_LIST [IV_EXPRESSION]
			l_expr: IV_EXPRESSION
			l_elem_type, l_type: IV_TYPE
			l_prefix: STRING
		do
			if attached {ACCESS_EXPR_B} a_nested.target as x then
				l_tuple ?= x.expr
				l_array ?= x.expr
			end
			check l_tuple /= Void or l_array /= Void end
			create l_exprs.make
			l_elem_type := types.ref -- ToDo: wrong elem type for empty tuples/arrays
			if l_tuple /= Void then
				across l_tuple.expressions as i loop
					i.item.process (a_translator)
					l_exprs.extend (a_translator.last_expression)
					l_elem_type := a_translator.last_expression.type
				end
			else
				check l_array /= Void end
				across l_array.expressions as i loop
					i.item.process (a_translator)
					l_exprs.extend (a_translator.last_expression)
					l_elem_type := a_translator.last_expression.type
				end
			end
			check attached {FEATURE_B} a_nested.message as f then
				if f.feature_name ~ "to_mml_set" then
					l_type := types.set (l_elem_type)
					l_prefix := "Set"
				elseif f.feature_name ~ "to_mml_sequence" then
					create {IV_USER_TYPE} l_type.make ("Seq", << l_elem_type >>)
					l_prefix := "Seq"
				else
					check False end
				end
				if l_exprs.is_empty then
					a_translator.set_last_expression (
						factory.function_call (l_prefix + "#Empty", Void, l_type))
				else
					from
						l_exprs.start
						l_expr := factory.function_call (l_prefix + "#Singleton", << l_exprs.item >>, l_type)
						l_exprs.forth
					until
						l_exprs.after
					loop
						l_expr := factory.function_call (
							l_prefix + "#Extended",
							<< l_expr, l_exprs.item >>,
							l_type)
						l_exprs.forth
					end
					a_translator.set_last_expression (l_expr)
				end
			end
		end

end
