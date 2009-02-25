note
	description: "Visitor to generate {EXPR_B} objects for AutoTest expressions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_EXPRESSION_B_VISITOR

inherit
	ITP_EXPRESSION_PROCESSOR

	AUT_BYTE_NODE_FACTORY
		export {NONE} all end

create
	make

feature{NONE} -- Initialization

	make (a_system: like system; a_load_object_feature: like load_object_feature)
			-- Initialize.
		require
			a_system_attached: a_system /= Void
			a_load_object_feature_attached: a_load_object_feature /= Void
		do
			system := a_system
			load_object_feature := a_load_object_feature
		end

feature -- Access

	expression (a_expression: ITP_EXPRESSION): EXPR_B
			-- New EXPR_B node for `a_expression'
		require
			a_expression_attached: a_expression /= Void
		do
			a_expression.process (Current)
			Result := last_expression
		ensure
			result_attached: Result /= Void
		end

feature {ITP_EXPRESSION} -- Processing

	process_constant (a_value: ITP_CONSTANT)
			-- Process `a_value'.
		local
			l_bool_ref: BOOLEAN_REF
			l_char_ref: CHARACTER_8_REF
			l_wchar_ref: CHARACTER_32_REF
			l_type: TYPE_A
		do
			if a_value.value = Void then
				create {VOID_B} last_expression
			else
				l_type := base_type (a_value.value.generating_type)
				check l_type /= Void end
				if l_type.is_integer or else l_type.is_natural then
						-- For integer and natural
					last_expression := new_integer_constant_from_constant (a_value, l_type)

				elseif l_type.is_boolean then
						-- For boolean
						l_bool_ref ?= a_value.value
						create {BOOL_CONST_B} last_expression.make (l_bool_ref.item)

				elseif l_type.is_character then
					if l_type.is_character_32 then
							-- For wide character
						l_wchar_ref ?= a_value.value
						create {CHAR_CONST_B} last_expression.make (l_wchar_ref.item, l_type)
					else
							-- For normal character
						l_char_ref ?= a_value.value
						create {CHAR_CONST_B} last_expression.make (l_char_ref.item, l_type)
					end

				elseif l_type.is_real_32 or else l_type.is_real_64 then
						-- For real/double
					create {REAL_CONST_B} last_expression.make (a_value.value.out, l_type)
				elseif l_type.is_pointer then
						-- FIXME: currently pointer values are not supported by AutoTest
					create {VOID_B} last_expression
				else
					check Should_not_be_here: False end
				end
			end
		end

	process_variable (a_value: ITP_VARIABLE)
			-- Process `a_value'.
		local
			l_parameter: PARAMETER_B
			l_parameters: BYTE_LIST [PARAMETER_B]
			l_integer: INTEGER_CONSTANT
		do
				-- Create an INTEGER_CONSTANT node.
			create l_parameter
			create l_integer.make_with_value (a_value.index)
			l_parameter.set_expression (l_integer)
			l_parameter.set_attachment_type (integer_32_type)

				-- Create a feature access node.
			create l_parameters.make (1)
			l_parameters.extend (l_parameter)
			last_expression := new_feature_b (load_object_feature, system.any_type, l_parameters)
		end

feature{NONE} -- Implementation

	last_expression: EXPR_B
			-- Last expression node

	system: SYSTEM_I
			-- System

	load_object_feature: FEATURE_I
			-- Feature to load an object from object pool

invariant
	system_attached: system /= Void
	load_object_feature_attached: load_object_feature /= Void

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
