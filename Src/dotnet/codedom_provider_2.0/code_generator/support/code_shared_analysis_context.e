indexing
	description: "Shared instances during analysis phase"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_ANALYSIS_CONTEXT

inherit
	CODE_SHARED_GENERATION_STATE

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_IMPORTS
		export
			{NONE} all
		end

feature -- Access

	current_context: STRING is
			-- Current context, includes routine and type names if any
		require
			in_code_analysis: current_state = Code_analysis
		local
			l_string1, l_string2, l_string3, l_string4: STRING
		do
			if current_type = Void then
				if current_namespace /= Void then
					l_string1 := current_namespace.name
					create Result.make (l_string1.count + 10)
					Result.append ("namespace ")
					Result.append (l_string1)
				else
					Result := ""
				end
			else
				l_string1 := current_type.eiffel_name
				l_string2 := current_type.name
				if internal_current_feature = Void then
					create Result.make (8 + l_string1.count + l_string2.count)
					Result.append ("type ")
					Result.append (l_string1)
					Result.append (" (")
					Result.append (l_string2)
					Result.append_character (')')
				else
					l_string3 := current_feature.eiffel_name
					l_string4 := current_feature.name
					create Result.make (20 + l_string1.count + l_string2.count + l_string3.count + l_string4.count)
					Result.append ("routine ")
					Result.append (l_string3)
					Result.append (" (")
					Result.append (l_string4)
					Result.append (") from ")
					Result.append (l_string1)
					Result.append (" (")
					Result.append (l_string2)
					Result.append_character (')')
				end
			end
		ensure
			non_void_context: Result /= Void
		end
		
	current_namespace: CODE_NAMESPACE is
			-- Type currently examined.
		require
			in_code_analysis: current_state = Code_analysis
		do
			Result := internal_current_namespace.item
		end

	current_type: CODE_GENERATED_TYPE is
			-- Type currently examined.
		require
			in_code_analysis: current_state = Code_analysis
		do
			Result := internal_current_type.item
		end

	current_feature: CODE_FEATURE is
			-- Feature currently examined.
		require
			in_code_analysis: current_state = Code_analysis
		do
			Result := internal_current_feature.item
		end

	current_routine: CODE_ROUTINE is
			-- Routine currently examined.
		require
			in_code_analysis: current_state = Code_analysis
		do
			if current_feature /= Void then
				Result ?= current_feature
				if Result = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Failed_assignment_attempt, ["CODE_FEATURE", "CODE_ROUTINE", "access to current routine"])
				end
			end
			if Result = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_current_routine, [current_context])
			end
		end

	last_compile_unit: CODE_COMPILE_UNIT is
			-- Compile unit lastly examined.
		do
			Result := internal_last_compile_unit.item
		end

	last_namespace: CODE_NAMESPACE is
			-- Namespace lastly examined.
		do
			Result := internal_last_namespace.item
		end

	last_type: CODE_GENERATED_TYPE is
			-- Type lastly examined.
		do
			Result := internal_last_type.item
		end

	last_feature: CODE_FEATURE is
			-- Routine lastly examined.
		do
			Result := internal_last_feature.item
		end

	last_statement: CODE_STATEMENT is
			-- Statement lastly examined.
		do
			Result := internal_last_statement.item
		end

	last_expression: CODE_EXPRESSION is
			-- Expression lastly examined.
		do
			Result := internal_last_expression.item
		end

	last_catch_clause: CODE_CATCH_CLAUSE is
			-- Catch clause lastly examined.
		do
			Result := internal_last_catch_clause.item
		end

	last_custom_attribute_declaration: CODE_ATTRIBUTE_DECLARATION is
			-- Return last_custom_attribute_declaration.
		do
			Result := internal_last_custom_attribute_declaration.item
		end

	last_custom_attribute_argument: CODE_ATTRIBUTE_ARGUMENT is
			-- Return last_custom_attribute_argument.
		do
			Result := internal_last_custom_attribute_argument.item
		end

feature {NONE} -- Status Setting

	set_current_namespace (a_namespace: like current_namespace) is
			-- Set `current_namespace' with `a_namespace'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			internal_current_namespace.put (a_namespace)
		ensure
			current_namespace_set: current_namespace = a_namespace
		end

	set_current_type (a_type: like current_type) is
			-- Set `current_type' with `a_type'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			internal_current_type.put (a_type)
		ensure
			current_type_set: current_type = a_type
		end

	set_current_feature (a_feature: like current_feature) is
			-- Set `current_feature' with `a_feature'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			internal_current_feature.put (a_feature)
		ensure
			current_feature_set: current_feature = a_feature
		end

	set_last_compile_unit (a_compile_unit: like last_compile_unit) is
			-- Set `last_compile_unit' with `a_compile_unit'.
		require
			non_void_compile_unit: a_compile_unit /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_compile_unit.put (a_compile_unit)
		ensure
			last_compile_unit_set: last_compile_unit = a_compile_unit
		end

	set_last_namespace (a_namespace: like last_namespace) is
			-- Set `last_namespace' with `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_namespace.put (a_namespace)
		ensure
			last_namespace_set: last_namespace = a_namespace
		end

	set_last_type (a_type: like last_type) is
			-- Set `last_type' with `a_type'.
		require
			non_void_type: a_type /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_type.put (a_type)
		ensure
			last_type_set: last_type = a_type
		end

	set_last_feature (a_feature: like last_feature) is
			-- Set `last_feature' with `a_feature'.
		require
			non_void_routine: a_feature /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_feature.put (a_feature)
		ensure
			last_feature_set: last_feature = a_feature
		end

	set_last_statement (a_statement: like last_statement) is
			-- Set `last_statement' with `a_statement'.
		require
			non_void_statement: a_statement /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_statement.put (a_statement)
		ensure
			last_statement_set: last_statement = a_statement
		end

	set_last_expression (an_expression: like last_expression) is
			-- Set `last_expression' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_expression.put (an_expression)
		ensure
			last_expression_set: last_expression = an_expression
		end

	set_last_catch_clause (a_catch_clause: like last_catch_clause) is
			-- Set `last_catch_clause' with `a_catch_clause'.
		require
			non_void_catch_clause: a_catch_clause /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_catch_clause.put (a_catch_clause)
		ensure
			last_catch_clause_set: last_catch_clause = a_catch_clause
		end

	set_last_custom_attribute_declaration (a_custom_attribute_declaration: like last_custom_attribute_declaration) is
			-- Set `custom_attribute_declaration' with `a_custom_attribute_declaration'.
		require
			non_void_a_custom_attribute_declaration: a_custom_attribute_declaration /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_custom_attribute_declaration.put (a_custom_attribute_declaration)
		ensure
			custom_attribute_declaration_set: last_custom_attribute_declaration = a_custom_attribute_declaration
		end

	set_last_custom_attribute_argument (a_custom_attribute_argument: like last_custom_attribute_argument) is
			-- Set `custom_attribute_argument' with `a_custom_attribute'.
		require
			non_void_a_custom_attribute_argument: a_custom_attribute_argument /= Void
			in_code_analysis: current_state = Code_analysis
		do
			internal_last_custom_attribute_argument.put (a_custom_attribute_argument)
		ensure
			custom_attribute_argument_set: last_custom_attribute_argument = a_custom_attribute_argument
		end

feature {NONE} -- Private Access

	code_dom_generator: CODE_CONSUMER_FACTORY is
			-- Instance of a CODE_CONSUMER_FACTORY.
		once
			create Result
		ensure
			code_dom_source_created: Result /= Void
		end

feature {NONE} -- Implementation

	internal_current_namespace: CELL [CODE_NAMESPACE] is
			-- Internal representation of `current_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_type: CELL [CODE_GENERATED_TYPE] is
			-- Internal representation of `current_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_feature: CELL [CODE_FEATURE] is
			-- Internal representation of `current_feature'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_compile_unit: CELL [CODE_COMPILE_UNIT] is
			-- Internal representation of `last_compile_unit'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_namespace: CELL [CODE_NAMESPACE] is
			-- Internal representation of `last_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_type: CELL [CODE_GENERATED_TYPE] is
			-- Internal representation of `last_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_feature: CELL [CODE_FEATURE] is
			-- Internal representation of `last_feature'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_statement: CELL [CODE_STATEMENT] is
			-- Internal representation of `last_statement'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_expression: CELL [CODE_EXPRESSION] is
			-- Internal representation of `last_expression'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_catch_clause: CELL [CODE_CATCH_CLAUSE] is
			-- Internal representation of `last_catch_clause'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_declaration: CELL [CODE_ATTRIBUTE_DECLARATION] is
			-- Internal representation of `last_custom_attribute_declaration'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_argument: CELL [CODE_ATTRIBUTE_ARGUMENT] is
			-- Internal representation of `last_custom_attribute_argument'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
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
end -- class CODE_SHARED_ANALYSIS_CONTEXT

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