indexing
	description: "Code generator for statements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	CODE_STATEMENT_FACTORY

inherit
	CODE_FACTORY

	CODE_ASSIGNMENT_TYPES
		export
			{NONE} all
		end

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_assign_statement (a_source: SYSTEM_DLL_CODE_ASSIGN_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_property_expr: CODE_PROPERTY_REFERENCE_EXPRESSION
			l_field_expr: CODE_ATTRIBUTE_REFERENCE_EXPRESSION
			l_target: CODE_EXPRESSION
			l_assignment_type: INTEGER
		do
			if a_source.left /= Void then
				if a_source.right /= Void then
					code_dom_generator.generate_expression_from_dom (a_source.left)
					l_target := last_expression
					l_property_expr ?= l_target
					if l_property_expr /= Void then
						l_assignment_type := Property_assignment
						l_property_expr.set_is_set_reference (True)
					else
						l_field_expr ?= l_target
						if l_field_expr /= Void then
							l_assignment_type := Field_assignment
							l_field_expr.set_is_set_reference (True)
						else
							l_assignment_type := Default_assignment
						end
					end
					code_dom_generator.generate_expression_from_dom (a_source.right)			
					set_last_statement (create {CODE_ASSIGN_STATEMENT}.make (l_target, last_expression, l_assignment_type))
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_assignment_source, [current_context])
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_assignment_target, [current_context])
				set_last_statement (Void)
			end
		end

	generate_comment_statement (a_source: SYSTEM_DLL_CODE_COMMENT_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if a_source.comment /= Void and then a_source.comment.text /= Void then
				set_last_statement (create {CODE_COMMENT_STATEMENT}.make (create {CODE_COMMENT}.make (a_source.comment.text, not a_source.comment.doc_comment)))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_comment_text, [current_context])
				set_last_statement (Void)
			end
		end

	generate_condition_statement (a_source: SYSTEM_DLL_CODE_CONDITION_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_true_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
		do
			if a_source.condition /= Void then
				l_true_statements := a_source.true_statements
				code_dom_generator.generate_expression_from_dom (a_source.condition)
				set_last_statement (create {CODE_CONDITION_STATEMENT}.make (last_expression, statements_from_collection (l_true_statements), statements_from_collection (a_source.false_statements)))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_condition, [current_context])
				set_last_statement (Void)
			end
		end

	generate_expression_statement (a_source: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if a_source.expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.expression)
				set_last_statement (create {CODE_EXPRESSION_STATEMENT}.make (last_expression))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_expression, [current_context])
				set_last_statement (Void)
			end
		end

	generate_iteration_statement (a_source: SYSTEM_DLL_CODE_ITERATION_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_init_statement, l_increment_statement: CODE_STATEMENT
		do
			if a_source.test_expression /= Void then
				if a_source.init_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_source.init_statement)
					l_init_statement := last_statement
				end
				if a_source.increment_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_source.increment_statement)
					l_increment_statement := last_statement
				end
				code_dom_generator.generate_expression_from_dom (a_source.test_expression)
				set_last_statement (create {CODE_ITERATION_STATEMENT}.make (l_init_statement, last_expression, statements_from_collection (a_source.statements), l_increment_statement))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_test_expression, [current_context])
				set_last_statement (Void)
			end
		end

	generate_routine_return_statement (a_source: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if a_source.expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.expression)
				set_last_statement (create {CODE_METHOD_RETURN_STATEMENT}.make (last_expression))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_return_expression, [current_context])
				set_last_statement (Void)
			end
		end

	generate_snippet_statement (a_source: SYSTEM_DLL_CODE_SNIPPET_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_head, l_value: STRING
		do
			if a_source.value /= Void then
				l_value := a_source.value
				if l_value.count > 6 then
					l_head := l_value.substring (1, 6)
					l_head.to_lower
					if l_head.is_equal ("local ") or l_head.is_equal ("local%T") or l_head.is_equal ("local%R") or l_head.is_equal ("local%N") then
							-- find all variables declared in statement...
						initialize_local_variables (l_value)
							-- Do not generate statement inline
						set_last_statement (Void)
					else
						set_last_statement (create {CODE_SNIPPET_STATEMENT}.make (l_value))
					end
				else
					set_last_statement (create {CODE_SNIPPET_STATEMENT}.make (l_value))
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_snippet_value, [current_context])
			end
		ensure
			non_void_last_statement: last_statement /= Void
		end

	generate_variable_declaration_statement (a_source: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_variable: CODE_VARIABLE_REFERENCE
			l_init_expression: CODE_EXPRESSION
		do
			create l_variable.make (a_source.name, Type_reference_factory.type_reference_from_reference (a_source.type), Type_reference_factory.type_reference_from_code (current_type))
			if a_source.init_expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.init_expression)
				l_init_expression := last_expression
			end
			set_last_statement (create {CODE_VARIABLE_DECLARATION_STATEMENT}.make (l_variable, l_init_expression))
		ensure
			non_void_last_statement: last_statement /= Void
		end
				
feature {NONE} -- Implementation

	initialize_local_variables (a_snippet_value: STRING) is
			-- Add variables declared in `a_snippet_vallue' to local variables of `current_feature'.
		require
			non_void_snippet_value: a_snippet_value /= Void
			has_locals: a_snippet_value.substring (1, 5).as_lower.is_equal ("local")
		local
			i: INTEGER
			l_variable_name, l_variable_type: STRING
		do
			a_snippet_value.remove_head (5)
			a_snippet_value.left_adjust
			from
				i := 1
			until
				i > a_snippet_value.count
			loop
				from
					create l_variable_name.make_empty
				until
					i > a_snippet_value.count or else
					a_snippet_value.item (i).is_equal (':')
				loop
					l_variable_name.extend (a_snippet_value.item (i))
					i := i + 1				
				end
				
					-- jump the semi-colon character
				i := i + 1
				
				from
					create l_variable_type.make_empty
				until
					i > a_snippet_value.count or else a_snippet_value.item (i).is_equal (';')
				loop
					l_variable_type.extend (a_snippet_value.item (i))
					i := i + 1
				end

					-- Add local variable to current routine			
				current_routine.add_snippet_local (create {CODE_SNIPPET_VARIABLE}.make (l_variable_name, l_variable_type))

					-- jump the ';' character
				i := i + 1
			end
		end

	statements_from_collection (a_collection: SYSTEM_DLL_CODE_STATEMENT_COLLECTION): LIST [CODE_STATEMENT] is
			-- Convert `a_collection' into a list of {CODE_STATEMENT} instances
		local
			i, l_count: INTEGER
		do
			if a_collection /= Void then
				from
					l_count := a_collection.count
					create {ARRAYED_LIST [CODE_STATEMENT]} Result.make (l_count)
				until
					i = l_count
				loop
					code_dom_generator.generate_statement_from_dom (a_collection.item (i))
					Result.extend (last_statement)
					i := i + 1
				end
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_STATEMENT_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------