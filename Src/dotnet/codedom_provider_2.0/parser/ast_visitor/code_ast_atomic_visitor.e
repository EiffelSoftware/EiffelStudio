note
	description: "AST atomic Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_ATOMIC_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS

feature {AST_YACC} -- Implementation

	process_custom_attribute_as (l_as: CUSTOM_ATTRIBUTE_AS)
			-- Process `l_as'.
		local
			l_custom_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION
			l_argument: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT
		do
			create l_custom_attribute.make
			l_custom_attribute.set_name (dotnet_type_name (l_as.creation_expr.type.dump).to_cil)
			if l_as.tuple /= Void and then l_as.tuple.expressions /= Void then
				from
					l_as.tuple.expressions.start
				until
					l_as.tuple.expressions.after
				loop
					l_as.tuple.expressions.item.process (Visitor)
					l_argument ?= last_element_created
					check
						non_void_l_argument: l_argument /= Void
					end
					added := l_custom_attribute.arguments.add (l_argument)
					l_as.tuple.expressions.forth
				end
			end
--			l_custom_attribute.user_data.add (From_eiffel_code, True)
			set_last_custom_attribute (l_custom_attribute)
		end

	process_id_as (l_as: ID_AS)
			-- Process `l_as'.
		do
		end

	process_integer_constant_as (l_as: INTEGER_AS)
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			create l_snippet_expression.make
--			l_snippet_expression.set_value (l_as.value.out.to_cil)
--			l_snippet_expression.set_value (l_as.dump.to_cil)
			l_snippet_expression.set_value (l_as.value)
			set_last_element_created (l_snippet_expression)
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
			-- Process `l_as'.
		local
			l_property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
			l_method_reference_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_field_reference_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
--			l_event_reference_expression: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_target_type: STRING
		do
			l_target_type := dotnet_type_name (l_as.class_type.dump)

			if is_property_setter (l_as.access_name, l_target_type) then
				create l_property_reference_expression.make
				l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, l_target_type).to_cil)
				l_property_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION}.make (l_target_type.to_cil))
				set_last_element_created (l_property_reference_expression)
--			elseif is_event_adder (l_as.access_name, l_target_type) then
--				create l_event_reference_expression.make
--				set_last_element_created (l_event_reference_expression)
			elseif is_property_getter (l_as.access_name, l_target_type) then
				create l_property_reference_expression.make
				l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, l_target_type).to_cil)
				l_property_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION}.make (l_target_type.to_cil))
				set_last_element_created (l_property_reference_expression)
			elseif is_field (l_as.access_name, l_target_type) then
				create l_field_reference_expression.make
				l_field_reference_expression.set_field_name (dotnet_feature_name (l_as.access_name, l_target_type).to_cil)
				l_field_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION}.make (l_target_type.to_cil))
				set_last_element_created (l_field_reference_expression)			
			else
				create l_method_reference_expression.make
				l_method_reference_expression.set_method_name (dotnet_feature_name (l_as.access_name, l_target_type).to_cil)
				l_method_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION}.make (l_target_type.to_cil))
				create l_method_invoke_expression.make
				l_method_invoke_expression.set_method (l_method_reference_expression)
				if l_as.parameters /= Void then
					from
						l_as.parameters.start
					until
						l_as.parameters.after
					loop
						l_as.parameters.item.process (Visitor)
						l_expression ?= last_element_created
						check
							non_void_l_expression: l_expression /= Void
						end
						added := l_method_invoke_expression.parameters.add (l_expression)
						l_as.parameters.forth
					end
				end
				set_last_element_created (l_method_invoke_expression)
			end
		end

	process_unique_as (l_as: UNIQUE_AS)
			-- Process `l_as'.
		do
		end

	process_tuple_as (l_as: TUPLE_AS)
			-- Process `l_as'.
		local
			l_array_creation_expression: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION
			l_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			create l_array_creation_expression.make
			--create l_create_type.make_from_type_name (("System.Windows.Forms.Control[]").to_cil)
			--create l_create_type.make_from_type_name (("System.Windows.Forms.MenuItem[]").to_cil)
			create l_create_type.make_from_type_name ("System.Windows.Forms.MenuItem")
			l_array_creation_expression.set_create_type (l_create_type)

			set_current_element (l_array_creation_expression)			
			from
				l_as.expressions.start
			until
				l_as.expressions.after
			loop
				l_as.expressions.item.process (Visitor)
				l_expression ?= last_element_created
				check
					non_void_l_expression: l_expression /= Void
				end
				added := l_array_creation_expression.initializers.add (l_expression)
				l_as.expressions.forth
			end
	
			pop_current_element (l_array_creation_expression)			
			set_last_element_created (l_array_creation_expression)
		end

	process_real_as (l_as: REAL_AS)
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.value.to_cil)
			set_last_element_created (l_snippet_expression)
		end

	process_bool_as (l_as: BOOL_AS)
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.value)
			set_last_element_created (l_snippet_expression)
		end

	process_bit_const_as (l_as: BIT_CONST_AS)
			-- Process `l_as'.
		do
		end

	process_array_as (l_as: ARRAY_AS)
			-- Process `l_as'.
		do
		end

	process_char_as (l_as: CHAR_AS)
			-- Process `l_as'.
		do
		end

	process_string_as (l_as: STRING_AS)
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.value.to_cil)
			set_last_element_created (l_snippet_expression)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
			-- Process `l_as'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- CODE_AST_ATOMIC_VISITOR
