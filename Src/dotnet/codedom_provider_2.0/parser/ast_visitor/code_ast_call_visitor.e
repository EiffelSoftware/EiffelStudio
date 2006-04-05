indexing
	description: "AST call Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_CALL_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS

feature {AST_YACC} -- Implementation

	process_result_as (l_as: RESULT_AS) is
			-- Process `l_as'.
		local
			l_local_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_local_expression.make
			l_local_expression.set_value ("Result")
			set_last_element_created (l_local_expression)
		end

	process_current_as (l_as: CURRENT_AS) is
			-- Process `l_as'.
		local
			l_current_expression: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
		do
			create l_current_expression.make

			l_method_invoke_expression ?= current_element
			if l_method_invoke_expression /= Void then
				l_method_invoke_expression.method.set_target_object (l_current_expression)
			else
				set_last_element_created (l_current_expression)
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
			-- Process `l_as'.
		local
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
			l_property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
			l_event_reference_expression: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_method_reference_expression, l_method_reference_expression_2: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_method_name: STRING
			l_attribute_reference_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
			l_attribute_type: STRING
			l_method_type: STRING
			l_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
			l_attach_event_statement: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT
			l_delegate_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
			l_current_reference_expression: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION
			l_variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
			l_cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION
			l_feature_type: STRING
		do
			l_method_invoke_expression ?= current_element

			if l_method_invoke_expression /= Void then
				l_feature_type := dotnet_type_expression (l_method_invoke_expression.method.target_object)
				if l_feature_type = Void then
					-- We need to check for cast expressions
					l_cast_expression ?= last_element_created
					l_feature_type := dotnet_type_expression (l_cast_expression.expression)
				end
			else
					-- We are guessing that the method is located in the Parent implementation type.
				l_feature_type := Parent
			end
			if is_property_setter (l_as.access_name, l_feature_type) then
				create l_assign_statement.make
					-- Property setting
				l_attribute_reference_expression ?= l_method_invoke_expression.method.target_object
				if l_attribute_reference_expression /= Void  then
					l_attribute_type := dotnet_type (create {STRING}.make_from_cil (l_attribute_reference_expression.field_name))

					create l_property_reference_expression.make
					l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, l_attribute_type).to_cil)
					l_property_reference_expression.set_target_object (l_attribute_reference_expression)
				else
					l_current_reference_expression ?= l_method_invoke_expression.method.target_object
					check
						non_void_l_current_reference_expression: l_current_reference_expression /= Void
					end

					create l_property_reference_expression.make
					l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, l_feature_type).to_cil)
					l_property_reference_expression.set_target_object (l_current_reference_expression)
				end
				l_assign_statement.set_left (l_property_reference_expression)
				check
					non_void_parameter: l_as.parameters /= Void and then l_as.parameters.count = 1
				end
				l_as.parameters.first.process (Visitor)
				l_expression ?= last_element_created
				check
					non_void_l_expression: l_expression /= Void
				end
				l_assign_statement.set_right (l_expression)

				set_last_element_created (l_assign_statement)
			elseif is_event_adder (l_as.access_name, l_feature_type) then
				create l_attach_event_statement.make
					-- Event attachment
				l_attribute_reference_expression ?= l_method_invoke_expression.method.target_object
				if l_attribute_reference_expression /= Void  then
					l_attribute_type := dotnet_type (create {STRING}.make_from_cil (l_attribute_reference_expression.field_name))

					create l_event_reference_expression.make
					l_event_reference_expression.set_event_name (dotnet_feature_name (l_as.access_name, l_attribute_type).to_cil)
					l_event_reference_expression.set_target_object (l_attribute_reference_expression)
				else
					l_current_reference_expression ?= l_method_invoke_expression.method.target_object
					check
						non_void_l_current_reference_expression: l_current_reference_expression /= Void
					end

					create l_event_reference_expression.make
					l_event_reference_expression.set_event_name (dotnet_feature_name (l_as.access_name, l_feature_type).to_cil)
					l_event_reference_expression.set_target_object (l_current_reference_expression)
				end

				create l_delegate_expression.make
				set_current_element (l_delegate_expression)
				check
					non_void_parameter: l_as.parameters /= Void and then l_as.parameters.count = 1
				end
				l_as.parameters.first.process (Visitor)
				pop_current_element (l_delegate_expression)

				create l_attach_event_statement.make
				l_attach_event_statement.set_event (l_event_reference_expression)
				l_attach_event_statement.set_listener (l_delegate_expression)

				set_last_element_created (l_attach_event_statement)
			elseif l_method_invoke_expression /= Void then
				if not l_as.access_name.is_equal ("to_cil") then
					if 
						l_method_invoke_expression.method.method_name /= Void and then
						l_method_invoke_expression.method.method_name.length > 0
					then
						l_method_reference_expression := l_method_invoke_expression.method
						l_method_name := create {STRING}.make_from_cil (l_method_reference_expression.method_name)
							-- Clone l_method_reference_expression in l_method_reference_expression_2
						if 
							is_property_getter (l_method_name, Parent) or
								-- Hack
							l_method_name.is_equal ("Controls") or
							l_method_name.is_equal ("MenuItems")
						then
							create l_property_reference_expression.make
							l_property_reference_expression.set_target_object (l_method_reference_expression.target_object)
							l_property_reference_expression.set_property_name (l_method_reference_expression.method_name)

							l_method_reference_expression.set_target_object (l_property_reference_expression)
--						elseif is_event_adder (l_method_name, Parent) then
--							create l_attach_event_statement.make
--
--							l_method_reference_expression.set_target_object (l_attach_event_statement)
						else
							create l_method_reference_expression_2.make
							l_method_reference_expression_2.set_target_object (l_method_reference_expression.target_object)
							l_method_reference_expression_2.set_method_name (l_method_reference_expression.method_name)

							l_method_reference_expression.set_target_object (l_method_reference_expression_2)
						end

						if is_attribute (l_method_name) then
							l_method_type := dotnet_type (l_method_name)
						elseif is_variable (l_method_name) then
								-- This is for processing local variables
							l_method_type := dotnet_type (l_method_name)
						else
								-- should implement : dotnet_type (caller_type, feature_name)
							l_method_type := "System.Windows.Forms.Control+ControlCollection"
						end

						l_method_reference_expression.set_method_name (dotnet_feature_name (l_as.access_name, l_method_type).to_cil)
					else
						l_attribute_reference_expression ?= l_method_invoke_expression.method.target_object
						l_variable_reference_expression ?= l_method_invoke_expression.method.target_object
						if l_attribute_reference_expression /= Void then
							l_method_type := dotnet_type (create {STRING}.make_from_cil (l_attribute_reference_expression.field_name))
						elseif l_variable_reference_expression /= Void then
							l_method_type := dotnet_type (create {STRING}.make_from_cil (l_variable_reference_expression.variable_name))
						else
								-- should implement : dotnet_type (caller_type, feature_name)
							l_method_type := "System.Windows.Forms.Control+ControlCollection"
						end
						l_method_invoke_expression.method.set_method_name (dotnet_feature_name (l_as.access_name, l_method_type).to_cil)
					end
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
		end

	process_access_inv_as (l_as: ACCESS_INV_AS) is
			-- Process `l_as'.
		local
			l_delegate_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
			l_creation_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_delegate_expression ?= current_element
			if l_delegate_expression /= Void then
				check
					two_parameters: l_as.parameter_count = 2
				end
				l_as.parameters.last.process (Visitor)
			else
				l_creation_expression ?= current_element
				check
					non_void_l_creation_expression: l_creation_expression /= Void
				end
				if l_as.parameters /= Void then
					from
						l_as.parameters.start
					until
						l_as.parameters.after
					loop
						l_as.parameters.item.process (Current)
						l_expression ?= last_element_created
						check
							non_void_l_expression: l_expression /= Void
						end
						added := l_creation_expression.parameters.add (l_expression)
						l_as.parameters.forth
					end
				end
			end
		end

	process_access_id_as (l_as: ACCESS_ID_AS) is
			-- Process `l_as'.
		local
			l_cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
			l_method_reference_expression, l_method_reference_expression_2: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
			l_attribute_reference_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
			l_variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
			l_array_creation_expression: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION
		do
			l_method_invoke_expression ?= current_element
			l_array_creation_expression ?= current_element
			
			if is_cast_expression (l_as.access_name) then
				l_cast_expression ?= Cast_expressions.item (l_as.access_name.to_cil)
				check
					non_void_l_cast_expression: l_cast_expression /= Void
				end	
				set_last_element_created (l_cast_expression)
			elseif Variables.has (l_as.access_name) then
					-- Is a local variable being accessed?			
				create l_variable_reference_expression.make_from_variable_name (l_as.access_name)
				if l_method_invoke_expression /= Void then
						-- We are invoking a method on the local variable
					create l_method_reference_expression.make
					l_method_reference_expression.set_target_object (l_variable_reference_expression)
					l_method_invoke_expression.set_method (l_method_reference_expression)
				else
						-- If we are not accessing a method then we must be assigning the local
					set_last_element_created (l_variable_reference_expression)
				end
			elseif is_property_setter (l_as.access_name, Parent) then
				create l_assign_statement.make
					-- ref to a property
				create l_property_reference_expression.make
				l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, parent).to_cil)
				l_property_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
				l_assign_statement.set_left (l_property_reference_expression)
				check
					non_void_parameter: l_as.parameters /= Void and then l_as.parameters.count = 1
				end
				l_as.parameters.first.process (Visitor)
				l_expression ?= last_element_created
				check
					non_void_l_expression: l_expression /= Void
				end
				l_assign_statement.set_right (l_expression)

				set_last_element_created (l_assign_statement)
--			elseif l_attach_event_statement /= Void then
--			elseif is_event_adder (l_as.access_name, Parent) then
--				create l_event_reference_expression.make
--				l_event_reference_expression.set_event_name (dotnet_feature_name (l_as.access_name, Parent).to_cil)
--				l_event_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
--				l_attach_event_statement.set_event (l_event_reference_expression)
			elseif
				l_method_invoke_expression /= Void and then
				( l_method_invoke_expression.method.method_name.length = 0 or else is_create_array_initialization_call (l_as) )
			then
				if l_method_invoke_expression.method.method_name.length = 0 then
					if is_property_getter (l_as.access_name, Parent) then
						create l_property_reference_expression.make
						l_property_reference_expression.set_property_name (dotnet_feature_name (l_as.access_name, Parent).to_cil)
						l_property_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
	
						create l_method_reference_expression.make
						--l_method_reference_expression.set_method_name (("Will be added later").to_cil)
						l_method_reference_expression.set_target_object (l_property_reference_expression)
	
						l_method_invoke_expression.set_method (l_method_reference_expression)
					elseif is_attribute (l_as.access_name) then
						create l_attribute_reference_expression.make
						l_attribute_reference_expression.set_field_name (l_as.access_name.to_cil)
						l_attribute_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
	
						create l_method_reference_expression.make
						--l_method_reference_expression.set_method_name (("Will be added later").to_cil)
						l_method_reference_expression.set_target_object (l_attribute_reference_expression)
	
						l_method_invoke_expression.set_method (l_method_reference_expression)
					else
						if 
							l_method_invoke_expression.method.method_name /= Void and then
							l_method_invoke_expression.method.method_name.length > 0
						then
							l_method_reference_expression := l_method_invoke_expression.method
								-- Clone l_method_reference_expression in l_method_reference_expression_2
							create l_method_reference_expression_2.make
							l_method_reference_expression_2.set_target_object (l_method_reference_expression.target_object)
							l_method_reference_expression_2.set_method_name (l_method_reference_expression.method_name)
	
							l_method_reference_expression.set_target_object (l_method_reference_expression_2)
							l_method_reference_expression.set_method_name (dotnet_feature_name (l_as.access_name, Parent).to_cil)
						else
							create l_method_reference_expression.make
							l_method_reference_expression.set_method_name (dotnet_feature_name (l_as.access_name, Parent).to_cil)
							l_method_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
						end
	
						l_method_invoke_expression.set_method (l_method_reference_expression)
					end
	
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
				end
			elseif l_array_creation_expression /= Void then
				create l_attribute_reference_expression.make
				l_attribute_reference_expression.set_field_name (l_as.access_name.to_cil)
				l_attribute_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
				set_last_element_created (l_attribute_reference_expression)
			elseif is_attribute (l_as.access_name) then
				create l_attribute_reference_expression.make
				l_attribute_reference_expression.set_field_name (l_as.access_name.to_cil)
				l_attribute_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
				set_last_element_created (l_attribute_reference_expression)
			else
				create l_method_reference_expression.make
				l_method_reference_expression.set_method_name (dotnet_feature_name (l_as.access_name, Parent).to_cil)
				l_method_reference_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)

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

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
			-- Process `l_as'.
		do
		end

	process_precursor_as (l_as: PRECURSOR_AS) is
			-- Process `l_as'.
		do
		end

	process_nested_expr_as (l_as: NESTED_EXPR_AS) is
			-- Process `l_as'.
		local
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_as.target.process (Visitor)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			set_current_element (l_expression)
			l_as.message.process (Visitor)
			pop_current_element (l_expression)
		end

	process_nested_as (l_as: NESTED_AS) is
			-- Process `l_as'.
		local
			l_method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
			l_variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
		do	
			l_method_invoke_expression ?= current_element
			if l_method_invoke_expression = Void then
				create l_method_invoke_expression.make
				set_current_element (l_method_invoke_expression)
			end
			
			l_as.target.process (Visitor)
			l_as.message.process (Visitor)
			--set_last_element_created (l_method_invoke_expression)

			l_method_invoke_expression ?= current_element
			if l_method_invoke_expression /= Void then
				pop_current_element (l_method_invoke_expression)
			end
			
			l_variable_reference_expression ?= current_element
			if l_variable_reference_expression /= Void then
				pop_current_element (l_variable_reference_expression)
			end
		end

	process_creation_expr_as (l_as: CREATION_EXPR_AS) is
			-- Process `l_as'.
		local
			l_delegate_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
			l_creation_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
			l_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			create l_type_reference.make_from_type_name (dotnet_type_name (l_as.type.dump).to_cil)

			l_delegate_expression ?= current_element
			if l_delegate_expression /= Void then
				l_delegate_expression.set_delegate_type (l_type_reference)
				l_as.call.process (Visitor)
			else
				create l_creation_expression.make
				l_creation_expression.set_create_type (l_type_reference)
					-- parameters initialized in call as.
				set_current_element (l_creation_expression)
				l_as.call.process (Visitor)
				pop_current_element (l_creation_expression)
				set_last_element_created (l_creation_expression)
			end
		end

feature -- Implementation

	is_create_array_initialization_call (l_as: ACCESS_AS): BOOLEAN is
			-- is `l_as' references a feature of an array initialization?
		require
			non_void_l_as: l_as /= Void
		local
			l_access_id: ACCESS_ID_AS
			l_expression_call_as: EXPR_CALL_AS
			l_nested_expression_as: NESTED_EXPR_AS
		do
			l_access_id ?= l_as
			if l_access_id /= Void then
				if
					l_access_id.access_name.is_equal ("new_array_winforms_control") or
					l_access_id.access_name.is_equal ("new_array_winforms_menu_item")
				then
					if l_access_id.parameter_count = 1 then
						l_expression_call_as ?= l_access_id.parameters.first
						if l_expression_call_as /= Void then
							l_nested_expression_as ?= l_expression_call_as.call
							if l_nested_expression_as /= Void then
								Result := True
								l_nested_expression_as.target.process (Visitor)
							end
						end
					end
				end
			end
		end

indexing
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
end -- CODE_AST_CALL_VISITOR
