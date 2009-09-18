note
	description: "Factory to generate byte node structure"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_BYTE_NODE_FACTORY

inherit
	SHARED_TYPES

	SHARED_ARRAY_BYTE

	SHARED_BYTE_CONTEXT

	ERL_G_TYPE_ROUTINES

	AUT_SHARED_INTERPRETER_INFO

feature -- Byte node generation

	new_local_b (a_position: INTEGER): LOCAL_B
			-- New LOCAL_B instance for access to `a_position'-th local variable
		require
			a_position_positive: a_position > 0
		do
			create Result
			Result.set_position (a_position)
		ensure
			result_attached: Result /= Void
			location_correct: Result.position = a_position
		end

	new_nested_b (a_target: ACCESS_B; a_message: CALL_B): NESTED_B
			-- New NESTED_B instance for `a_target' and `a_message'
		require
			a_target_attached: a_target /= Void
			a_message_attached: a_message /= Void
		do
			create Result
			Result.set_target (a_target)
			Result.set_message (a_message)
			a_target.set_parent (Result)
			a_message.set_parent (Result)
		ensure
			result_attached: Result /= Void
		end

	new_reverse_b (a_target: ACCESS_B; a_source: EXPR_B): REVERSE_B
			-- REVERSE_B instance from `a_target' and `a_source'
		require
			a_target_attached: a_target /= Void
			a_source_attached: a_source /= Void
		do
			create Result
			Result.set_source (a_source)
			Result.set_target (a_target)
			Result.set_info (a_target.type.create_info)
		ensure
			result_attached: Result /= Void
			good_result: Result.source = a_source and then Result.target = a_target
		end

	new_assign_b (a_target: ACCESS_B; a_source: EXPR_B): ASSIGN_B
			-- ASSIGN_B instance from `a_target' and `a_source'
		require
			a_target_attached: a_target /= Void
			a_source_attached: a_source /= Void
		do
			create Result
			Result.set_source (a_source)
			Result.set_target (a_target)
		ensure
			result_attached: Result /= Void
			good_result: Result.source = a_source and then Result.target = a_target
		end

	new_feature_b (a_feature: FEATURE_I; a_return_type: TYPE_A; a_parameters: BYTE_LIST [PARAMETER_B]): CALL_ACCESS_B
			-- New FEATURE_B instance for `a_feature' with arguments `a_arguments'
			-- `a_return_type' is the return type of `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_return_type_attached: a_return_type /= Void
		do
			Result ?= new_access_b (a_feature, a_return_type, a_parameters)
		ensure
			result_attached: Result /= Void
		end

	new_access_b (a_feature: FEATURE_I; a_return_type: TYPE_A; a_parameters: BYTE_LIST [PARAMETER_B]): ACCESS_B
			-- New FEATURE_B instance for `a_feature' with arguments `a_arguments'
			-- `a_return_type' is the return type of `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_return_type_attached: a_return_type /= Void
		do
			Result ?= a_feature.access (a_return_type, True)
			if a_parameters /= Void then
				Result.set_parameters (a_parameters)
			end
		ensure
			result_attached: Result /= Void
		end

	new_integer_constant_from_constant (a_constant: ITP_CONSTANT; a_type: TYPE_A): INTEGER_CONSTANT
			-- New INTEGER_CONSTANT instance from `a_constant'
			-- `a_type' is the type of integer: INTEGER_8, INTEGER_16, INTEGER_32, INTEGER_64, NATURAL_8, NATURAL_16, NATURAL_32, NATURAL_64.
		require
			a_constant_attached: a_constant /= Void
			a_constant_valid: a_constant.value /= Void
		local
			l_str: STRING
			l_is_negative: BOOLEAN
		do
			l_str := a_constant.value.out
			l_is_negative := l_str.item (1) = '-'
			if l_is_negative then
				l_str.remove (1)
			end
			create Result.make_from_type (a_type, l_is_negative, l_str)
		ensure
			result_attached: Result /= Void
		end

	new_local_access_parameter_expressions (a_types: LIST [TYPE_A]; a_start_index: INTEGER): BYTE_LIST [PARAMETER_B]
			-- List of parameters made of local accesses.
		local
			l_local: LOCAL_B
			l_param: PARAMETER_B
			l_position: INTEGER
		do
			if a_types /= Void then
				create Result.make (a_types.count)
				from
					l_position := a_start_index
					a_types.start
				until
					a_types.after
				loop
					create l_param
					create l_local
					l_local.set_position (l_position)
					l_param.set_expression (l_local)
					l_param.set_attachment_type (a_types.item)
					Result.extend (l_param)
					l_position := l_position + 1
					a_types.forth
				end
			end
		end

	new_creation_byte_code (a_feat: FEATURE_I; a_target_type: TYPE_A; a_parameters: BYTE_LIST [PARAMETER_B]): CREATION_EXPR_B
			-- New instance of `create {a_target_type}.a_feat (a_expr1, a_expr2, ...)'
			-- `a_source_types' represents types of `a_exprs'.
		require
			a_feat_not_void: a_feat /= Void
			a_target_type_not_void: a_target_type /= Void
		local
			l_create_type: CREATE_TYPE
		do
			create Result
			create l_create_type.make (a_target_type.actual_type)

			Result.set_info (l_create_type)
			Result.set_type (a_target_type)

				-- Create call.
			Result.set_call (new_feature_b (a_feat, void_type, a_parameters))
			Result.set_creation_instruction (True)
		end

	new_instr_call_b (a_call: CALL_B): INSTR_CALL_B
			-- New instr_cal_b
		require
			a_call_attached: a_call /= Void
		do
			create Result.make (a_call, 1)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
