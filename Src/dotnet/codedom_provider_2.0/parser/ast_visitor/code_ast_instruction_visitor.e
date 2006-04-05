indexing
	description: "AST instruction Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_INSTRUCTION_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS
	
feature {AST_YACC} -- Implementation

	process_assign_as (l_as: ASSIGN_AS) is
			-- Process `l_as'.
		local
			l_variable_declaration_statement: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT
			l_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			create l_assign_statement.make
			
			l_as.target.process (Visitor)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			l_assign_statement.set_left (l_expression)
			
			l_as.source.process (Visitor)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			
			--| FIXME IEK Hack needed to create 'resource' local variable as it has to be initialized in an 'init_expression'
			--| Eiffel local variables cannot be declared and initialized inline this so we have to explicitly set it ourselves.
			if l_as.target.access_name.is_equal ("resources") then
				create l_variable_declaration_statement.make
				l_variable_declaration_statement.set_name ("resources")
				create l_type_reference.make_from_type_name ("System.Resources.ResourceManager")
				l_variable_declaration_statement.set_type (l_type_reference)
				l_variable_declaration_statement.set_init_expression (l_expression)
				l_variable_declaration_statement.set_line_pragma (line_pragma (l_as.line_number))
				set_last_element_created (l_variable_declaration_statement)
			else
				l_assign_statement.set_right (l_expression)
				l_assign_statement.set_line_pragma (line_pragma (l_as.line_number))
				set_last_element_created (l_assign_statement)
			end
		end

	process_reverse_as (l_as: REVERSE_AS) is
			-- Process `l_as'.
		local
			l_cast_expression: SYSTEM_DLL_CODE_CAST_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			check
				is_variable: is_variable (l_as.target.access_name)
			end
			create l_cast_expression.make
			l_cast_expression.set_target_type (create {SYSTEM_DLL_CODE_TYPE_REFERENCE}.make_from_type_name (dotnet_type (l_as.target.access_name).to_cil))
			set_last_element_created (Void)
			l_as.source.process (Visitor)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			l_cast_expression.set_expression (l_expression)

			Cast_expressions.add (l_as.target.access_name.to_cil, l_cast_expression)
			set_last_element_created (Void)
		end

	process_check_as (l_as: CHECK_AS) is
			-- Process `l_as'.
		do
		end

	process_creation_as (l_as: CREATION_AS) is
			-- Process `l_as'.
		local
			l_assign_statement: SYSTEM_DLL_CODE_ASSIGN_STATEMENT
			l_attribute: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
			l_object_creation_expression: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION
			l_construtor_parameters: EIFFEL_LIST [EXPR_AS]
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			create l_object_creation_expression.make
			if l_as.type /= Void then
				create l_type_reference.make_from_type_name (dotnet_type_name (l_as.type.dump).to_cil)
			else
				create l_type_reference.make_from_type_name (dotnet_type (l_as.target.access_name).to_cil)
			end
			l_object_creation_expression.set_create_type (l_type_reference)

			l_construtor_parameters := l_as.call.parameters
			if l_construtor_parameters /= Void then
				from
					l_construtor_parameters.start
				until
					l_construtor_parameters.after
				loop
					l_construtor_parameters.item.process (Visitor)
					l_expression ?= last_element_created
					check
						non_void_l_expression: l_expression /= Void
					end
					added := l_object_creation_expression.parameters.add (l_expression)
					l_construtor_parameters.forth
				end
			end
			
--			if is_attribute (l_as.target.access_name) then
				create l_attribute.make
				l_attribute.set_field_name (l_as.target.access_name.to_cil)
				l_attribute.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
--			end

			create l_assign_statement.make
			l_assign_statement.set_left (l_attribute)
			l_assign_statement.set_right (l_object_creation_expression)
			set_last_element_created (l_assign_statement)
		end

	process_debug_as (l_as: DEBUG_AS) is
			-- Process `l_as'.
		local
		do
		end

	process_if_as (l_as: IF_AS) is
			-- Process `l_as'.
		local
			l_condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT
			l_elsif_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			create l_condition_statement.make
			
			l_as.condition.process (Visitor)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			l_condition_statement.set_condition (l_expression)
			
				-- True statements.
			if l_as.compound /= Void then
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
			end
			
				-- Elif statements.
			if l_as.elsif_list /= Void then
				from
					l_as.elsif_list.start
				until
					l_as.elsif_list.after
				loop
					l_as.elsif_list.item.process (Visitor)
					l_elsif_statement ?= last_element_created
					check
						valid_elsif: valid_elsif_statement (l_elsif_statement)
					end
					added := l_condition_statement.false_statements.add_code_statement (l_elsif_statement)
					l_as.elsif_list.forth
				end
			elseif l_as.else_part /= Void then
				from
					l_as.else_part.start
				until
					l_as.else_part.after
				loop
					l_as.else_part.item.process (Visitor)
					l_statement ?= last_element_created
					check
						non_void_l_statement: l_statement /= Void
					end
					added := l_condition_statement.false_statements.add_code_statement (l_statement)
					l_as.else_part.forth
				end
			end

			set_last_element_created (l_condition_statement)
		end

	process_inspect_as (l_as: INSPECT_AS) is
			-- Process `l_as'.
		do
		end

	process_instr_call_as (l_as: INSTR_CALL_AS) is
			-- Process `l_as'.
		do
			l_as.call.process (Visitor)
		end

	process_loop_as (l_as: LOOP_AS) is
			-- Process `l_as'.
		do
		end

	process_retry_as (l_as: RETRY_AS) is
			-- Process `l_as'.
		do
		end

feature {NONE} -- Implementation

	valid_elsif_statement (l_condition_statement: SYSTEM_DLL_CODE_CONDITION_STATEMENT): BOOLEAN is
			-- Is `l_condition_statement' a valid elsif statement?
		do
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
end -- CODE_AST_INSTRUCTION_VISITOR
