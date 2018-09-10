note
	description: "Summary description for {E2B_CUSTOM_ANY_CALL_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_ANY_CALL_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER

	E2B_CUSTOM_NESTED_HANDLER

	SHARED_WORKBENCH

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result := a_feature.feature_name_32 ~ "generating_type"
		end

	is_handling_nested (a_nested: NESTED_B): BOOLEAN
			-- <Precursor>
		do
			Result := has_old (a_nested) or 													-- old_
				(is_type_target (a_nested) and is_message_feature (a_nested, "default")) or		-- default
				(is_type_target (a_nested) and is_message_feature (a_nested, "adapt"))			-- adapt
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

feature -- Implementation

	handle_routine_call (a_translator: E2B_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_name: STRING
		do
			l_name := a_feature.feature_name
			if l_name.same_string ("generating_type") then
				a_translator.set_last_expression (factory.function_call ("type_of", << a_translator.current_target >>, types.type))
			else
				check False end
			end
		end

	handle_nested (a_translator: E2B_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- Handle `a_nested'.
		local
			l_name: STRING
			l_type: CL_TYPE_A
			l_target: IV_EXPRESSION
			l_target_type: CL_TYPE_A
		do
			if has_old (a_nested) then
					-- Dealing with "old_"
				if attached {FEATURE_B} a_nested.target as f and then f.feature_name.same_string ("old_") then
						-- Top-level target: skip it and process the message
						-- (unless the message is old_ as well, then don't do anything)
					if not is_message_feature (a_nested, "old_") then
						a_nested.message.process (a_translator)
					end
				elseif is_message_feature (a_nested, "old_") then
						-- It is the message: process target in the old context					
					a_translator.process_as_old (a_nested.target)
				else
						-- Further down the message: process the target in the old context,
						-- switch translator's current target to that expression,
						-- handle the message,
						-- restore translator's current target.
					a_translator.process_as_old (a_nested.target)
					l_target := a_translator.current_target
					l_target_type := a_translator.current_target_type
					a_translator.set_current_target (a_translator.last_expression)
					a_translator.set_current_target_type (a_translator.expression_class_type (a_nested.target))
					a_translator.add_void_call_check (a_nested)

					check attached {NESTED_B} a_nested.message as n then
						check has_old (n) end
						handle_nested (a_translator, n)
					end
					a_translator.set_current_target (l_target)
					a_translator.set_current_target_type (l_target_type)
				end
			elseif attached {FEATURE_B} a_nested.message as f then
				l_name := f.feature_name
				if l_name.same_string ("adapt") then
					a_translator.set_last_expression (factory.void_)
					if attached {ACCESS_EXPR_B} a_nested.target as x then
						if attached {TYPE_EXPR_B} x.expr as t then
							-- Ignore type, just follow parameters
							check f.parameters.count = 1 end
							f.parameters.first.expression.process (a_translator)
						end
					end
				elseif l_name.same_string ("default") then
					a_translator.set_last_expression (factory.void_)
					if attached {ACCESS_EXPR_B} a_nested.target as x then
						if attached {TYPE_EXPR_B} x.expr as t then
							l_type := a_translator.class_type_in_current_context (t.type_data.generics.first)
							a_translator.set_last_expression (types.for_class_type (l_type).default_value)
						end
					end
				else
					check False end
				end
			end
		end

	is_type_target (a_nested: NESTED_B): BOOLEAN
			-- Does `a_nested' have a target of type TYPE?
		do
			Result := not a_nested.target.type.is_like and then
				a_nested.target.type.base_class /= Void and then
				a_nested.target.type.base_class.name_in_upper ~ "TYPE"
		end

	is_message_feature (a_nested: NESTED_B; a_feature_name: STRING): BOOLEAN
			-- Is the message part of `a_nested' the call to `a_feature_name'?
		do
			Result := attached {FEATURE_B} a_nested.message as f and then
				f.feature_name.same_string (a_feature_name)
		end

	has_old (a_nested: NESTED_B): BOOLEAN
			-- Is there an `old_' somewhere in `a_nested'?
		do
			Result := is_message_feature (a_nested, "old_") or 												-- is it the message?
				(attached {FEATURE_B} a_nested.target as f and then f.feature_name.same_string ("old_"))	-- is it the target?
				or (attached {NESTED_B} a_nested.message as n and then has_old (n))					-- or is it inside the message?
		end

end
