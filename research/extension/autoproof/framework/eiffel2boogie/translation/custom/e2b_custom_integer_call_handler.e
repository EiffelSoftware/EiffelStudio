note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_CUSTOM_INTEGER_CALL_HANDLER

inherit

	E2B_CUSTOM_CALL_HANDLER

	SHARED_WORKBENCH
		export {NONE} all end

feature -- Status report

	is_handling_call (a_target_type: TYPE_A; a_feature: FEATURE_I): BOOLEAN
			-- <Precursor>
		do
			Result := a_target_type.is_numeric and not (a_feature.written_in = system.any_id)
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

feature -- Implementation

	handle_routine_call (a_translator: E2B_EXPRESSION_TRANSLATOR; a_feature: FEATURE_I; a_parameters: BYTE_LIST [PARAMETER_B])
			-- <Precursor>
		local
			l_type: TYPE_A
			l_name: STRING
			l_fname: STRING
			l_fcall: IV_FUNCTION_CALL
		do
			l_type := a_translator.current_target_type
			l_name := a_feature.feature_name
			if l_name.same_string ("truncated_to_integer") then
				l_fname := "real_to_integer_32"
			elseif l_name.same_string ("truncated_to_integer_64") then
				l_fname := "real_to_integer_64"
			elseif l_name.same_string ("to_natural_8") or l_name.same_string ("as_natural_8") then
				l_fname := "int_to_natural_8"
			elseif l_name.same_string ("to_natural_16") or l_name.same_string ("as_natural_16") then
				l_fname := "int_to_natural_16"
			elseif l_name.same_string ("to_natural_32") or l_name.same_string ("as_natural_32") then
				l_fname := "int_to_natural_32"
			elseif l_name.same_string ("to_natural_64") or l_name.same_string ("as_natural_64") then
				l_fname := "int_to_natural_64"
			elseif l_name.same_string ("to_integer_8") or l_name.same_string ("as_integer_8") then
				l_fname := "int_to_integer_8"
			elseif l_name.same_string ("to_integer_16") or l_name.same_string ("as_integer_16") then
				l_fname := "int_to_integer_16"
			elseif l_name.same_string ("to_integer_32") or l_name.same_string ("as_integer_32") then
				l_fname := "int_to_integer_32"
			elseif l_name.same_string ("to_integer_64") or l_name.same_string ("as_integer_64") then
				l_fname := "int_to_integer_64"
			elseif l_name.same_string ("to_double") or l_name.same_string ("to_real") then
				l_fname := "real"
			elseif l_name.same_string ("bit_and") then
					l_fname := "bit_and"
			elseif l_name.same_string ("bit_or") then
					l_fname := "bit_or"
			elseif l_name.same_string ("bit_xor") then
					l_fname := "bit_xor"
			elseif l_name.same_string ("bit_not") then
					l_fname := "bit_not"
			elseif l_name.same_string ("bit_shift_left") then
					l_fname := "bit_shift_left"
			elseif l_name.same_string ("bit_shift_right") then
					l_fname := "bit_shift_right"
			elseif l_name.same_string ("min") then
				if l_type.is_natural or l_type.is_integer or l_type.is_character then
					l_fname := "min"
				elseif l_type.is_real_32 or l_type.is_real_64 then
					l_fname := "min_real"
				end
			elseif l_name.same_string ("max") then
				if l_type.is_natural or l_type.is_integer or l_type.is_character then
					l_fname := "max"
				elseif l_type.is_real_32 or l_type.is_real_64 then
					l_fname := "max_real"
				end
			elseif l_name.same_string ("abs") then
				if l_type.is_natural or l_type.is_integer or l_type.is_character then
					l_fname := "abs"
				elseif l_type.is_real_32 or l_type.is_real_64 then
					l_fname := "abs_real"
				end
			elseif l_name.same_string ("sign") then
				if l_type.is_natural or l_type.is_integer or l_type.is_character then
					l_fname := "sign"
				elseif l_type.is_real_32 or l_type.is_real_64 then
					l_fname := "sign_real"
				end
			else
				l_fname := Void
			end
			if l_fname /= Void then
				-- ToDo: is this correct
				create l_fcall.make (l_fname, types.int)
				l_fcall.add_argument (a_translator.current_target)
				a_translator.process_parameters (a_parameters)
				l_fcall.arguments.append (a_translator.last_parameters)
				a_translator.set_last_expression (l_fcall)
			else
				a_translator.process_routine_call (a_feature, a_parameters, False)
			end
		end

end
