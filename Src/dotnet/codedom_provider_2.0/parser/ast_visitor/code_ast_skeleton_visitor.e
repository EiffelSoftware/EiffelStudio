indexing
	description: "AST skeleton Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_SKELETON_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS
	
feature {AST_YACC} -- Implementation

	process_class_as (l_as: CLASS_AS) is
			-- Process `l_as'.
			-- | Create CODE_COMPILE_UNIT in which is a CODE_NAMESPACE
			-- | in which is a CODE_TYPE_DECLARATION.
		local
			l_code_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT
			l_namespace: SYSTEM_DLL_CODE_NAMESPACE
			l_type_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION
			l_referenced_assemblies: CODE_REFERENCED_ASSEMBLIES
		do
			create l_type_declaration.make
			set_current_element (l_type_declaration)
			initialize_type_declaration (l_as, l_type_declaration)
			pop_current_element (l_type_declaration)

			create l_namespace.make_from_name ("eiffel_generated")
			added := l_namespace.types.add (l_type_declaration)
				-- Add key `From_eiffel_code' into user_data
				-- for futur generation code.
			l_namespace.user_data.add (From_eiffel_code_key, True)

			create l_code_compile_unit.make
			added := l_code_compile_unit.namespaces.add (l_namespace)
				-- Add key `From_eiffel_code' into user_data
				-- for futur generation code.
			l_code_compile_unit.user_data.add (From_eiffel_code_key, True)
			from
				create l_referenced_assemblies
				l_referenced_assemblies.Referenced_assemblies.start
			until
				l_referenced_assemblies.Referenced_assemblies.after
			loop
				added := l_code_compile_unit.referenced_assemblies.add (l_referenced_assemblies.Referenced_assemblies.item.assembly.location)
				l_referenced_assemblies.Referenced_assemblies.forth
			end

			set_last_element_created (l_code_compile_unit)
		end

	process_create_as (l_as: CREATE_AS) is
			-- Process `l_as'.
		do
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS) is
			-- Process `l_as'.
		do
		end

	process_feature_as (l_as: FEATURE_AS) is
			-- Process `l_as'.
			-- | create a CODE_MEMBER_FIELD or a CODE_MEMBER_METHOD
			-- | Add positions of member in user_data for reemission of code.
		local
			l_member_field: SYSTEM_DLL_CODE_MEMBER_FIELD
			l_member_feature: SYSTEM_DLL_CODE_MEMBER_METHOD
		do
			if l_as.is_attribute then
				l_member_field := initialize_member_field (l_as)
				set_last_element_created (l_member_field)
			else
				l_member_feature := initialize_member_feature (l_as)
				pop_current_element (l_member_feature)
				set_last_element_created (l_member_feature)
			end			
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS) is
			-- Process `l_as'.
		local
			l_member: SYSTEM_DLL_CODE_TYPE_MEMBER
			l_type_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION
		do
			from
				l_as.features.start
			until
				l_as.features.after
			loop
				l_as.features.item.process (Visitor)
				l_member ?= last_element_created
				check
					non_void_l_member: l_member /= Void
				end

				l_type_declaration ?= current_element
				check
					non_void_l_type_declaration: l_type_declaration /= Void
				end
				added := l_type_declaration.members.add (l_member)

				l_as.features.forth
			end
		end

	process_external_lang_as (l_as: EXTERNAL_LANG_AS) is
			-- Process `l_as'.
		do
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
			-- Process `l_as'.
			-- Can be a parameter or a local variable.
		local
			l_current_routine_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			l_current_routine_parameters: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION
			l_variable: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
			l_parameter: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
			l_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_local_name: STRING
		do
			create l_type_reference.make_from_type_name (dotnet_type_name (l_as.type.dump).to_cil)

			l_current_routine_statements ?= current_element
			if l_current_routine_statements /= Void then
				l_local_name := l_as.item_name (1)
				--| FIXME IEK For now InitializeComponent uses 'init_expression's for local variable declaration
				--| We have to handle this explicitly in {AST_INSTRUCTION_VISITOR}.process_assign_as
				if not l_local_name.is_equal ("resources") then
					create l_variable.make
					l_variable.set_name (l_local_name.to_cil)
					l_variable.set_type (l_type_reference)
					added := l_current_routine_statements.add_code_statement (l_variable)					
				end
			else
				l_current_routine_parameters ?= current_element
				if l_current_routine_parameters /= Void then
					create l_parameter.make
					l_parameter.set_name (l_as.item_name (1).to_cil)
					l_parameter.set_type (l_type_reference)
					added := l_current_routine_parameters.add (l_parameter)
				end
			end
			add_variable (l_as.item_name (1), dotnet_type_name (l_as.type.dump))
		end

	process_parent_as (l_as: PARENT_AS) is
			-- Process `l_as'.
		do
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
			-- Process `l_as'.
		do
		end

	process_suppliers_as (l_as: SUPPLIERS_AS) is
			-- Process `l_as'.
		do
		end

	process_rename_as (l_as: RENAME_AS) is
			-- Process `l_as'.
		do
		end

	process_invariant_as (l_as: INVARIANT_AS) is
			-- Process `l_as'.
		do
		end

	process_interval_as (l_as: INTERVAL_AS) is
			-- Process `l_as'.
		do
		end

	process_index_as (l_as: INDEX_AS) is
			-- Process `l_as'.
		do
		end

	process_export_item_as (l_as: EXPORT_ITEM_AS) is
			-- Process `l_as'.
		do
		end

	process_elseif_as (l_as: ELSIF_AS) is
			-- Process `l_as'.
		local
			l_condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			create l_condition_statement.make
			from
				l_as.compound.start
			until
				l_as.compound.after
			loop
				l_as.compound.item.process (Visitor)
				l_statement ?= last_element_created
				check
					non_void_l_statement: l_statement /= Void
				end
				added := l_condition_statement.true_statements.add_code_statement (l_statement)
				l_as.compound.forth
			end
			set_last_element_created (l_condition_statement)
		end

	process_client_as (l_as: CLIENT_AS) is
			-- Process `l_as'.
		do
		end

	process_case_as (l_as: CASE_AS) is
			-- Process `l_as'.
		do
		end

	process_assert_list_as (l_as: ASSERT_LIST_AS) is
			-- Process `l_as'.
		do
		end

	process_ensure_as (l_as: ENSURE_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.assertions /= Void then
				from
					l_as.assertions.start
				until
					l_as.assertions.after
				loop
					l_as.assertions.item.process (Visitor)
					l_statement ?= last_element_created
					check
						non_void_l_statement: l_statement /= Void
					end
					added := l_current_routine.statements.add_code_statement (l_statement)
					l_as.assertions.forth
				end
			end
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.assertions /= Void then
				from
					l_as.assertions.start
				until
					l_as.assertions.after
				loop
					l_as.assertions.item.process (Visitor)
					l_statement ?= last_element_created
					check
						non_void_l_statement: l_statement /= Void
					end
					added := l_current_routine.statements.add_code_statement (l_statement)
					l_as.assertions.forth
				end
			end
		end

	process_require_as (l_as: REQUIRE_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.assertions /= Void then
				from
					l_as.assertions.start
				until
					l_as.assertions.after
				loop
					l_as.assertions.item.process (Visitor)
					l_statement ?= last_element_created
					check
						non_void_l_statement: l_statement /= Void
					end
					added := l_current_routine.statements.add_code_statement (l_statement)
					l_as.assertions.forth
				end
			end
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.assertions /= Void then
				from
					l_as.assertions.start
				until
					l_as.assertions.after
				loop
					l_as.assertions.item.process (Visitor)
					l_statement ?= last_element_created
					check
						non_void_l_statement: l_statement /= Void
					end
					added := l_current_routine.statements.add_code_statement (l_statement)
					l_as.assertions.forth
				end
			end
		end

	process_body_as (l_as: BODY_AS) is
			-- Process `l_as'.
		do
			l_as.content.process (Visitor)
		end

feature {NONE} -- CodeDom object initialization

	initialize_type_declaration (a_class: CLASS_AS; a_type_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Initialize `a_type_declaration' with `a_class'.
		require
			non_void_a_class: a_class /= Void
			non_void_a_type_declaration: a_type_declaration /= Void
		local
			l_parent_type_name: STRING
			l_custom_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION
			l_comment: SYSTEM_DLL_CODE_COMMENT_STATEMENT
			l_ca: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
				-- Add key `From_eiffel_code' into user_data
				-- for futur generation code.
			a_type_declaration.user_data.add (From_eiffel_code_key, True)

				-- Set name of type.
			a_type_declaration.set_name (a_class.class_name.string_value.to_cil)
			
				-- Set as current type
			set_current_type (a_type_declaration)

				-- Add parents to class if any.
			if a_class.parents /= Void then
				from
					a_class.parents.start
				until
					a_class.parents.after
				loop
					l_parent_type_name := a_class.parents.item.type.class_name
					l_parent_type_name.to_upper
					if not l_parent_type_name.is_equal ("ANY") then
						a_type_declaration.base_types.add_string (dotnet_type_name (l_parent_type_name).to_cil)
						add_variable ("Current", dotnet_type_name (l_parent_type_name))
					end
					a_class.parents.forth
				end
			end
			if a_class.top_indexes /= Void then
				create l_comment.make_from_text (a_class.top_indexes.description.to_cil)
				added := a_type_declaration.comments.add (l_comment)
			end

				-- Initialize constructors.
			if a_class.creators /= Void then
				from
					a_class.creators.start
					Constructors.wipe_out
				until
					a_class.creators.after
				loop
					if a_class.creators.item.feature_list /= Void then
						from
							a_class.creators.item.feature_list.start
						until
							a_class.creators.item.feature_list.after
						loop
							Constructors.extend (a_class.creators.item.feature_list.item.associated_feature_name)
							a_class.creators.item.feature_list.forth
						end
					end
					a_class.creators.forth
				end
			end

				-- Add features to type if any.
			if a_class.features /= Void then
				from
					a_class.features.start
				until
					a_class.features.after
				loop
					a_class.features.item.process (visitor)
					a_class.features.forth
				end
			end

				-- Add custom attributes to class if any.
			l_ca := a_class.custom_attributes
			if l_ca /= Void then
				from
					l_ca.start
				until
					l_ca.after
				loop
					l_ca.item.process (Visitor)
					l_custom_attribute ?= last_custom_attribute
					check
						non_void_l_custom_attribute: l_custom_attribute /= Void
					end
					added := a_type_declaration.custom_attributes.add (l_custom_attribute)
					l_ca.forth
				end
			end
			a_type_declaration.set_is_class (True)
			a_type_declaration.set_is_enum (False)
			a_type_declaration.set_is_interface (a_class.is_deferred)
		end

	initialize_parent_clauses (a_parent: PARENT_AS): STRING is
			-- return string defining parent clauses.
		require
			non_void_a_parent: a_parent /= Void
		do
			create Result.make_empty
			if a_parent.redefining /= Void then
				Result.append ("redefine")
				Result.append (Line_return)
				Result.append ("")
			end
			if a_parent.renaming /= Void then
				Result.append ("rename")
				Result.append (Line_return)
				Result.append ("")
			end
			if a_parent.undefining /= Void then
				Result.append ("undefine")
				Result.append (Line_return)
				Result.append ("")
			end
			if a_parent.exports /= Void then
				Result.append ("export")
				Result.append (Line_return)
				Result.append ("")
			end
			if a_parent.selecting /= Void then
				Result.append ("select")
				Result.append (Line_return)
				Result.append ("")
			end
		end

	initialize_member_field (an_attribute: FEATURE_AS): SYSTEM_DLL_CODE_MEMBER_FIELD is
			-- Return the CODE_MEMBER_FIELD corresponding to `an_attribute'.
		require
			non_void_an_attribute: an_attribute /= Void
		local
			l_type_ref: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_custom_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_ca: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
		do
			create Result.make
			Result.set_name (an_attribute.feature_name.to_cil)
			create l_type_ref.make_from_type_name (dotnet_type_name (an_attribute.body.type.dump).to_cil)
			Result.set_type (l_type_ref)
				-- Custom attributes.
			l_ca := an_attribute.custom_attributes
			if l_ca /= Void then
				from
					l_ca.start
				until
					l_ca.after
				loop
					l_ca.item.process (Current)
					l_custom_attribute ?= last_custom_attribute
					check
						non_void_l_custom_attribute: l_custom_attribute /= Void
					end
					added := Result.custom_attributes.add (l_custom_attribute)
					l_ca.forth
				end
			end
			Result.set_line_pragma (line_pragma (an_attribute.line_number))

				-- Attribute initialization
			if not an_attribute.body.is_empty then
				create l_expression.make
				an_attribute.body.content.process (Visitor)
				l_expression ?= last_element_created
				check
					non_void_l_expression: l_expression /= Void
				end
				Result.set_init_expression (l_expression)
			end

				-- Add key `From_eiffel_code', `Start_position' and `End_position'
				-- into user_data for futur code generation.
			Result.user_data.add (From_eiffel_code_key, True)
			Result.user_data.add (Start_position, an_attribute.location.start_position)
			Result.user_data.add (End_position, an_attribute.location.end_position)
		end

	initialize_member_feature (a_feature: FEATURE_AS): SYSTEM_DLL_CODE_MEMBER_METHOD is
			-- Return the CODE_MEMBER_METHOD corresponding to `a_feature'.
		require
			non_void_a_feature: a_feature /= Void
		local
			l_type_ref: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_custom_attribute: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION
			l_ca: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS]
			l_returned_type: STRING
		do
			if not is_constructor (a_feature.feature_name) then
				create Result.make
				set_current_element (Result)
				if Initialize_component_eiffel_name.is_equal (a_feature.feature_name.as_lower) then
					Result.set_name (Initialize_component_dotnet_name)
				else
					Result.set_name (a_feature.feature_name.to_cil)
				end
			else
				create {SYSTEM_DLL_CODE_CONSTRUCTOR} Result.make
				set_current_element (Result)
				Result.set_name (Constructor_name.to_cil)
			end
			clear_variables

				-- Custom attributes.
			l_ca := a_feature.custom_attributes
			if l_ca /= Void then
				from
					l_ca.start
				until
					l_ca.after
				loop
					l_ca.item.process (Visitor)
					l_custom_attribute ?= last_custom_attribute
					check
						non_void_l_custom_attribute: l_custom_attribute /= Void
					end
					added := Result.custom_attributes.add (l_custom_attribute)
					l_ca.forth
				end
			end
			Result.set_line_pragma (line_pragma (a_feature.line_number))
			if a_feature.is_function then
				l_returned_type := a_feature.body.type.dump
				l_returned_type := dotnet_type_name (l_returned_type)
				create l_type_ref.make_from_type_name (l_returned_type.to_cil)
				add_variable ("Result", l_returned_type)
			else
				create l_type_ref.make_from_type_name (("System.Void").to_cil)
				add_variable ("Result", "System.Void")
			end
			Result.set_return_type (l_type_ref)

				-- feature parameters
			if a_feature.body.arguments /= Void then
				from
					a_feature.body.arguments.start
					set_current_element (Result.parameters)
				until
					a_feature.body.arguments.after
				loop
					a_feature.body.arguments.item.process (Visitor)
					a_feature.body.arguments.forth
				end
				pop_current_element (Result.parameters)
			end
			Result.set_line_pragma (line_pragma (a_feature.line_number))

			if Initialize_component_dotnet_name.is_equal (Result.name) then
				a_feature.body.process (Visitor)
			end

				-- Add key `From_eiffel_code', `Start_position' and `End_position'
				-- into user_data for futur code generation.
			Result.user_data.add (From_eiffel_code_key, True)
			Result.user_data.add (Start_position, a_feature.location.start_position)
			Result.user_data.add (End_position, a_feature.location.end_position)
		end

	initialize_clients_member (a_client: CLIENT_AS): STRING is
			-- Initialize client of `a_member'.
		local
			l_first_client: BOOLEAN
		do
			if a_client = Void then
				create Result.make_empty
			else
				from
					a_client.clients.start
					create Result.make_empty
					l_first_client := True
				until
					a_client.clients.after
				loop
					if l_first_client then
						Result.append ("{")
						l_first_client := False
					else
						Result.append (", ")
					end
					Result.append (a_client.clients.item.string_value)
					a_client.clients.forth
				end
				Result.append ("}")
			end
		end

feature {NONE} -- Implementation

	Initialize_component_dotnet_name: STRING is "InitializeComponent"
			-- Parser does keep case.
			
	Initialize_component_eiffel_name: STRING is "initialize_component"
			-- Parser does keep case.

	Constructor_name: STRING is ".ctor";
			-- Dotnet constructor name.

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
end -- CODE_AST_SKELETON_VISITOR