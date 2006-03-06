indexing
	description: "Code generator for statements"
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

	CODE_SHARED_PARTIAL_TREE_STORE
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
			l_array_indexer_expr: CODE_ARRAY_INDEXER_EXPRESSION
			l_target: CODE_EXPRESSION
			l_assignment_type: INTEGER
			l_statement: CODE_ASSIGN_STATEMENT
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
							l_array_indexer_expr ?= l_target
							if l_array_indexer_expr /= Void then
								l_assignment_type := Array_assignment
								l_array_indexer_expr.set_is_set_reference (True)
							else
								l_assignment_type := Default_assignment
							end
						end
					end
					code_dom_generator.generate_expression_from_dom (a_source.right)
					create l_statement.make (l_target, last_expression, l_assignment_type)
					if a_source.line_pragma /= Void then
						l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
					end
					set_last_statement (l_statement)
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
		local
			l_statement: CODE_COMMENT_STATEMENT
		do
			if a_source.comment /= Void and then a_source.comment.text /= Void then
				create l_statement.make (create {CODE_COMMENT}.make (a_source.comment.text, not a_source.comment.doc_comment))
				if a_source.line_pragma /= Void then
					l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
				end
				set_last_statement (l_statement)
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
			l_statement: CODE_CONDITION_STATEMENT
		do
			if a_source.condition /= Void then
				l_true_statements := a_source.true_statements
				code_dom_generator.generate_expression_from_dom (a_source.condition)
				create l_statement.make (last_expression, statements_from_collection (l_true_statements), statements_from_collection (a_source.false_statements))
				if a_source.line_pragma /= Void then
					l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
				end
				set_last_statement (l_statement)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_condition, [current_context])
				set_last_statement (Void)
			end
		end

	generate_expression_statement (a_source: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_statement: CODE_EXPRESSION_STATEMENT
		do
			if a_source.expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.expression)
				create l_statement.make (last_expression)
				if a_source.line_pragma /= Void then
					l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
				end
				set_last_statement (l_statement)
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
			l_statement: CODE_ITERATION_STATEMENT
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
				create l_statement.make (l_init_statement, last_expression, statements_from_collection (a_source.statements), l_increment_statement)
				if a_source.line_pragma /= Void then
					l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
				end
				set_last_statement (l_statement)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_test_expression, [current_context])
				set_last_statement (Void)
			end
		end

	generate_routine_return_statement (a_source: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT) is
			-- Initialize `last_statement' with `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_statement: CODE_METHOD_RETURN_STATEMENT
		do
			if a_source.expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.expression)
				create l_statement.make (last_expression)
				if a_source.line_pragma /= Void then
					l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
				end
				set_last_statement (l_statement)
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
			l_statement: CODE_STATEMENT
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
					elseif partial_tree_store.is_valid_id (l_value) then
						partial_tree_store.search_statement (l_value)
						if partial_tree_store.statement_found then
							-- This statement corresponds to a statement that was stored
							-- through a call to `code_generator.generate_code_from_statement'
							code_dom_generator.generate_statement_from_dom (partial_tree_store.found_statement)
						else
							create {CODE_SNIPPET_STATEMENT} l_statement.make (l_value) 
							if a_source.line_pragma /= Void then
								l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
							end
							set_last_statement (l_statement)
						end
					else
						create {CODE_SNIPPET_STATEMENT} l_statement.make (l_value)
						if a_source.line_pragma /= Void then
							l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
						end
						set_last_statement (l_statement)
					end
				else
					create {CODE_SNIPPET_STATEMENT} l_statement.make (l_value)
					if a_source.line_pragma /= Void then
						l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
					end
					set_last_statement (l_statement)
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
			l_statement: CODE_VARIABLE_DECLARATION_STATEMENT
		do
			create l_variable.make (a_source.name, Type_reference_factory.type_reference_from_reference (a_source.type), Type_reference_factory.type_reference_from_code (current_type))
			if a_source.init_expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.init_expression)
				l_init_expression := last_expression
			end
			create l_statement.make (l_variable, l_init_expression)
			if a_source.line_pragma /= Void then
				l_statement.set_line_pragma (create {CODE_LINE_PRAGMA}.make (a_source.line_pragma))
			end
			set_last_statement (l_statement)
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
		
end -- class CODE_STATEMENT_FACTORY

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