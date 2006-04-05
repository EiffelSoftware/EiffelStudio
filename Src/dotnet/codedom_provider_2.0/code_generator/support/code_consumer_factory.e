indexing 
	description: "Generate Eiffel code from a given CodeDom tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_CONSUMER_FACTORY

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_FACTORIES
		export
			{NONE} all
		end

feature {CODE_GENERATOR, CODE_FACTORY, CODE_ARGUMENTS_FACTORY} -- Basic Operations

	generate_compile_unit_from_dom (a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT) is
			-- Call `generate_code_dom_compile_unit'.
		require
			non_void_compile_unit: a_compile_unit /= Void
		local
			l_snippet_compile_unit: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT
		do	
			l_snippet_compile_unit ?= a_compile_unit
			if l_snippet_compile_unit /= Void then 
				Eiffel_factory.generate_snippet_compile_unit (l_snippet_compile_unit)
			else
				Eiffel_factory.generate_compile_unit (a_compile_unit)
			end
		end

	generate_namespace_from_dom (a_namespace: SYSTEM_DLL_CODE_NAMESPACE) is
			-- Call `generate_code_dom_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		do		
				-- Create `code_dom_source'.
			Eiffel_factory.generate_namespace (a_namespace)
		end

	generate_type_from_dom (a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Call `generate_code_dom_type'.
		require
			non_void_type: a_type /= Void
		local
			l_delegate: SYSTEM_DLL_CODE_TYPE_DELEGATE
		do
			l_delegate ?= a_type
			if l_delegate /= Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Not_implemented, ["delegate type generation"])
			else
				Type_factory.generate_type (a_type)
			end
		end
		
	generate_member_from_dom (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER) is
			-- Call `generate_code_dom_member'.
		require
			non_void_member: a_member /= Void
		local
			l_snippet_type_member: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER
			l_event: SYSTEM_DLL_CODE_MEMBER_EVENT
			l_field: SYSTEM_DLL_CODE_MEMBER_FIELD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_constructor: SYSTEM_DLL_CODE_CONSTRUCTOR
			l_entry_point_method: SYSTEM_DLL_CODE_ENTRY_POINT_METHOD
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_delegate: SYSTEM_DLL_CODE_TYPE_DELEGATE
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
		do
			l_snippet_type_member ?= a_member
			if l_snippet_type_member /= Void then
				Member_factory.generate_snippet_feature (l_snippet_type_member)
			else
				l_event ?= a_member
				if l_event /= Void then
					Member_factory.generate_event (l_event)
				else
					l_field ?= a_member
					if l_field /= Void then
						Member_factory.generate_attribute (l_field)
					else
						l_property ?= a_member
						if l_property /= Void then
							Routine_factory.generate_property (l_property)
						else
							l_constructor ?= a_member
							if l_constructor /= Void then
								Routine_factory.generate_creation_routine (l_constructor)
							else
								l_entry_point_method ?= a_member
								if l_entry_point_method /= Void then
									Routine_factory.generate_root_procedure (l_entry_point_method)
								else
									l_method ?= a_member
									if l_method /= Void then
										Routine_factory.generate_routine (l_method)
									else
										l_delegate ?= a_member
										if l_delegate /= Void then
											Event_manager.raise_event ({CODE_EVENTS_IDS}.Not_implemented, ["delegate type generation"])
										else
											l_type ?= a_member
											if l_type /= Void then
												Type_factory.generate_type (l_type)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		
	generate_statement_from_dom (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Call `generate_code_dom_statement'.
		require
			non_void_statement: a_statement /= Void
		local
			l_statement_type: SYSTEM_TYPE
			l_agent: PROCEDURE [CODE_CONSUMER_FACTORY, TUPLE [SYSTEM_DLL_CODE_STATEMENT]]
		do
			l_statement_type := a_statement.get_type
			check
				Statement_exists: Statements_table.contains_key (l_statement_type)
			end
			l_agent ?= Statements_table.item (l_statement_type)
			l_agent.call ([a_statement])
		end
		
	generate_expression_from_dom (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Call `generate_code_dom_expression'.
		require
			non_void_expression: an_expression /= Void
		local
			l_exp_type: SYSTEM_TYPE
			l_agent: PROCEDURE [CODE_CONSUMER_FACTORY, TUPLE [SYSTEM_DLL_CODE_EXPRESSION]]
		do
			l_exp_type := an_expression.get_type
			check
				Expression_exists: Expressions_table.contains_key (l_exp_type)
			end
			l_agent ?= Expressions_table.item (l_exp_type)
			l_agent.call ([an_expression])
		end
		
	generate_custom_attribute_declaration (an_argument: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION) is
			-- Call `initialize_custom_attribute_declaration'.
		require
			non_void_an_argument: an_argument /= Void
		do
				-- Create `code_dom_source'.
			Custom_attribute_factory.initialize_custom_attribute_declaration (an_argument)
		end

	generate_custom_attribute_argument (an_argument: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT) is
			-- Call `initialize_custom_attribute_argument'.
		require
			non_void_an_argument: an_argument /= Void
		do
				-- Create `code_dom_source'.
			Custom_attribute_factory.initialize_custom_attribute_argument (an_argument)
		end

feature {NONE} -- Agent tables.

	statements_table: HASHTABLE is
			-- key : Code DOM element Type.
			-- value : agent.
		once
			create Result.make
			Result.add ((create {SYSTEM_DLL_CODE_ASSIGN_STATEMENT}.make).get_type, agent generate_assign_statement)
			Result.add ((create {SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT}.make).get_type, agent generate_attach_event_statement)
			Result.add ((create {SYSTEM_DLL_CODE_COMMENT_STATEMENT}.make).get_type, agent generate_comment_statement)
			Result.add ((create {SYSTEM_DLL_CODE_CONDITION_STATEMENT}.make).get_type, agent generate_condition_statement)
			Result.add ((create {SYSTEM_DLL_CODE_EXPRESSION_STATEMENT}.make).get_type, agent generate_expression_statement)
			Result.add ((create {SYSTEM_DLL_CODE_ITERATION_STATEMENT}.make).get_type, agent generate_iteration_statement)
			Result.add ((create {SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT}.make).get_type, agent generate_method_return_statement)
			Result.add ((create {SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT}.make).get_type, agent generate_remove_event_statement)
			Result.add ((create {SYSTEM_DLL_CODE_SNIPPET_STATEMENT}.make).get_type, agent generate_snippet_statement)
			Result.add ((create {SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT}.make).get_type, agent generate_try_catch_statement)
			Result.add ((create {SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT}.make).get_type, agent generate_variable_declaration_statement)
		ensure
			non_void_expressions_table: Result /= Void
		end

	expressions_table: HASHTABLE is
			-- key : Code DOM element Type.
			-- value : agent.
		once
			create Result.make
			Result.add ((create {SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION}.make).get_type, agent generate_argument_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION}.make).get_type, agent generate_array_create_expression)
			Result.add ((create {SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION}.make).get_type, agent generate_array_indexer_expression)
			Result.add ((create {SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION}.make).get_type, agent generate_base_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION}.make).get_type, agent generate_binary_operator_expression)
			Result.add ((create {SYSTEM_DLL_CODE_CAST_EXPRESSION}.make).get_type, agent generate_cast_expression)
			Result.add ((create {SYSTEM_DLL_CODE_DEFAULT_VALUE_EXPRESSION}.make).get_type, agent generate_default_value_expression)
			Result.add ((create {SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION}.make).get_type, agent generate_delegate_create_expression)
			Result.add ((create {SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION}.make).get_type, agent generate_delegate_invoke_expression)
			Result.add ((create {SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION}.make).get_type, agent generate_event_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION}.make).get_type, agent generate_field_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_INDEXER_EXPRESSION}.make).get_type, agent generate_indexer_expression)
			Result.add ((create {SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION}.make).get_type, agent generate_method_invoke_expression)
			Result.add ((create {SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION}.make).get_type, agent generate_method_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION}.make).get_type, agent generate_object_create_expression)
			Result.add ((create {SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION}.make).get_type, agent generate_parameter_declaration_expression)
			Result.add ((create {SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION}.make).get_type, agent generate_primitive_expression)
			Result.add ((create {SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION}.make).get_type, agent generate_property_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION}.make).get_type, agent generate_property_set_value_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_SNIPPET_EXPRESSION}.make).get_type, agent generate_snippet_expression)
			Result.add ((create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make).get_type, agent generate_this_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION}.make).get_type, agent generate_type_of_expression)
			Result.add ((create {SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION}.make).get_type, agent generate_type_reference_expression)
			Result.add ((create {SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION}.make).get_type, agent generate_variable_reference_expression)
		ensure
			non_void_expressions_table: Result /= Void
		end

feature {NONE} -- Statements agents.

	generate_assign_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
		do
			assign_statement ?= a_statement
			check
				non_void_assign_statement: assign_statement /= Void
			end
			Statement_factory.generate_assign_statement (assign_statement)
		end

	generate_attach_event_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			attach_event_statement: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT
		do
			attach_event_statement ?= a_statement
			check
				non_void_attach_event_statement: attach_event_statement /= Void
			end
			Event_statement_factory.generate_attach_event_statement (attach_event_statement)
		end

	generate_comment_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			comment_statement: SYSTEM_DLL_CODE_COMMENT_STATEMENT
		do
			comment_statement ?= a_statement
			check
				non_void_comment_statement: comment_statement /= Void
			end
			Statement_factory.generate_comment_statement (comment_statement)
		end

	generate_condition_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT
		do
			condition_statement ?= a_statement
			check
				non_void_condition_statement: condition_statement /= Void
			end
			Statement_factory.generate_condition_statement (condition_statement)
		end

	generate_expression_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			expression_statement: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT
		do
			expression_statement ?= a_statement
			check
				non_void_expression_statement: expression_statement /= Void
			end
			Statement_factory.generate_expression_statement (expression_statement)
		end

	generate_iteration_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			iteration_statement: SYSTEM_DLL_CODE_ITERATION_STATEMENT
		do
			iteration_statement ?= a_statement
			check
				non_void_iteration_statement: iteration_statement /= Void
			end
			Statement_factory.generate_iteration_statement (iteration_statement)
		end

	generate_method_return_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			method_return_statement: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT
		do
			method_return_statement ?= a_statement
			check
				non_void_method_return_statement: method_return_statement /= Void
			end
			Statement_factory.generate_routine_return_statement (method_return_statement)
		end

	generate_remove_event_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			remove_event_statement: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT
		do
			remove_event_statement ?= a_statement
			check
				non_void_remove_event_statement: remove_event_statement /= Void
			end
			Event_statement_factory.generate_remove_event_statement (remove_event_statement)
		end

	generate_snippet_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			snippet_statement: SYSTEM_DLL_CODE_SNIPPET_STATEMENT
		do
			snippet_statement ?= a_statement
			check
				non_void_snippet_statement: snippet_statement /= Void
			end
			Statement_factory.generate_snippet_statement (snippet_statement)
		end

	generate_try_catch_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			try_catch_statement: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT
		do
			try_catch_statement ?= a_statement
			check
				non_void_try_catch_statement: try_catch_statement /= Void
			end
			Exception_statement_factory.generate_try_catch_finally_statement (try_catch_statement)
		end

	generate_variable_declaration_statement (a_statement: SYSTEM_DLL_CODE_STATEMENT) is
			-- Agent.
		local
			variable_declaration_statement: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
		do
			variable_declaration_statement ?= a_statement
			check
				non_void_variable_declaration_statement: variable_declaration_statement /= Void
			end
			Statement_factory.generate_variable_declaration_statement (variable_declaration_statement)
		end

feature {NONE} -- Expression agents.

	generate_argument_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			argument_reference_expression: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION
		do
			argument_reference_expression ?= an_expression
			check
				non_void_argument_reference_expression: argument_reference_expression /= Void
			end
			Argument_expression_factory.generate_argument_reference_expression (argument_reference_expression)
		end

	generate_array_create_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			array_create_expression: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION
		do
			array_create_expression ?= an_expression
			check
				non_void_array_create_expression: array_create_expression /= Void
			end
			Array_expression_factory.generate_array_create_expression (array_create_expression)
		end

	generate_array_indexer_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			array_indexer_expression: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION
		do
			array_indexer_expression ?= an_expression
			check
				non_void_array_indexer_expression: array_indexer_expression /= Void
			end
			Array_expression_factory.generate_array_indexer_expression (array_indexer_expression)
		end

	generate_base_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			base_reference_expression: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION
		do
			base_reference_expression ?= an_expression
			check
				non_void_base_reference_expression: base_reference_expression /= Void
			end
			Property_expression_factory.generate_base_reference_expression (base_reference_expression)
		end

	generate_binary_operator_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			binary_operator_expression: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION
		do
			binary_operator_expression ?= an_expression
			check
				non_void_binary_operator_expression: binary_operator_expression /= Void
			end
			Expression_factory.generate_binary_operator_expression (binary_operator_expression)
		end

	generate_cast_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION
		do
			cast_expression ?= an_expression
			check
				non_void_cast_expression: cast_expression /= Void
			end
			Expression_factory.generate_cast_expression (cast_expression)
		end

	generate_default_value_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			default_value_expression: SYSTEM_DLL_CODE_DEFAULT_VALUE_EXPRESSION
		do
			default_value_expression ?= an_expression
			check
				non_void_default_value_expression: default_value_expression /= Void
			end
			Expression_factory.generate_default_value_expression (default_value_expression)
		end

	generate_delegate_create_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			delegate_create_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
		do
			delegate_create_expression ?= an_expression
			check
				non_void_delegate_create_expression: delegate_create_expression /= Void
			end
			Delegate_expression_factory.generate_delegate_create_expression (delegate_create_expression)
		end

	generate_delegate_invoke_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			delegate_invoke_expression: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION
		do
			delegate_invoke_expression ?= an_expression
			check
				non_void_delegate_invoke_expression: delegate_invoke_expression /= Void
			end
			Delegate_expression_factory.generate_delegate_invoke_expression (delegate_invoke_expression)
		end

	generate_event_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			event_reference_expression: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION
		do
			event_reference_expression ?= an_expression
			check
				non_void_event_reference_expression: event_reference_expression /= Void
			end
			Expression_factory.generate_event_reference_expression (event_reference_expression)
		end

	generate_field_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			field_reference_expression: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
		do
			field_reference_expression ?= an_expression
			check
				non_void_field_reference_expression: field_reference_expression /= Void
			end
			Expression_factory.generate_attribute_reference_expression (field_reference_expression)
		end

	generate_indexer_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			indexer_expression: SYSTEM_DLL_CODE_INDEXER_EXPRESSION
		do
			indexer_expression ?= an_expression
			check
				non_void_indexer_expression: indexer_expression /= Void
			end
			Expression_factory.generate_indexer_expression (indexer_expression)
		end

	generate_method_invoke_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			method_invoke_expression: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION
		do
			method_invoke_expression ?= an_expression
			check
				non_void_method_invoke_expression: method_invoke_expression /= Void
			end
			Routine_expression_factory.generate_routine_invoke_expression (method_invoke_expression)
		end

	generate_method_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			method_reference_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
		do
			method_reference_expression ?= an_expression
			check
				non_void_method_reference_expression: method_reference_expression /= Void
			end
			Routine_expression_factory.generate_routine_reference_expression (method_reference_expression)
		end

	generate_object_create_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			object_create_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
		do
			object_create_expression ?= an_expression
			check
				non_void_object_create_expression: object_create_expression /= Void
			end
			Expression_factory.generate_object_create_expression (object_create_expression)
		end

	generate_parameter_declaration_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			parameter_declaration_expression: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION
		do
			parameter_declaration_expression ?= an_expression
			check
				non_void_parameter_declaration_expression: parameter_declaration_expression /= Void
			end
			Argument_expression_factory.generate_parameter_declaration_expression (parameter_declaration_expression)
		end

	generate_primitive_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			primitive_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			primitive_expression ?= an_expression
			check
				non_void_primitive_expression: primitive_expression /= Void
			end
			Expression_factory.generate_primitive_expression (primitive_expression)
		end

	generate_property_set_value_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			property_set_value_reference_expression: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION
		do
			property_set_value_reference_expression ?= an_expression
			check
				non_void_property_set_value_reference_expression: property_set_value_reference_expression /= Void
			end
			Property_expression_factory.generate_property_set_value_reference_expression (property_set_value_reference_expression)
		end

	generate_snippet_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			snippet_expression ?= an_expression
			check
				non_void_snippet_expression: snippet_expression /= Void
			end
			Expression_factory.generate_snippet_expression (snippet_expression)
		end

	generate_this_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			this_reference_expression: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION
		do
			this_reference_expression ?= an_expression
			check
				non_void_this_reference_expression: this_reference_expression /= Void
			end
			Expression_factory.generate_this_reference_expression (this_reference_expression)
		end

	generate_type_of_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			type_of_expression: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION
		do
			type_of_expression ?= an_expression
			check
				non_void_type_of_expression: type_of_expression /= Void
			end
			Expression_factory.generate_type_of_expression (type_of_expression)
		end

	generate_type_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			type_reference_expression: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION
		do
			type_reference_expression ?= an_expression
			check
				non_void_type_reference_expression: type_reference_expression /= Void
			end
			Expression_factory.generate_type_reference_expression (type_reference_expression)
		end

	generate_variable_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			variable_reference_expression: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
		do
			variable_reference_expression ?= an_expression
			check
				non_void_variable_reference_expression: variable_reference_expression /= Void
			end
			Expression_factory.generate_variable_reference_expression (variable_reference_expression)
		end

	generate_property_reference_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION) is
			-- Agent.
		local
			property_reference_expression: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
		do
			property_reference_expression ?= an_expression
			check
				non_void_property_reference_expression: property_reference_expression /= Void
			end
			Property_expression_factory.generate_property_reference_expression (property_reference_expression)
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
end -- class CODE_CONSUMER_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
