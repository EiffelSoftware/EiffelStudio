indexing
	description: "Code generator for statements"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECD_STATEMENT_FACTORY

inherit
	ECD_FACTORY

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_assign_statement (a_source: SYSTEM_DLL_CODE_ASSIGN_STATEMENT) is
			-- | Create instance of `EG_ASSIGN_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_assign_statement'
			-- | Set `last_statement'.
	
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_assign_statement: ECD_ASSIGN_STATEMENT
		do
			create an_assign_statement.make
			initialize_assign_statement (a_source, an_assign_statement)
			set_last_statement (an_assign_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			assign_statement_ready: last_statement.ready
		end

	generate_comment_statement (a_source: SYSTEM_DLL_CODE_COMMENT_STATEMENT) is
			-- | Create instance of `EG_COMMENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_comment_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_comment_statement: ECD_COMMENT_STATEMENT
		do
			create a_comment_statement.make
			initialize_comment_statement (a_source, a_comment_statement)
			set_last_statement (a_comment_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			comment_statement_ready: last_statement.ready
		end

	generate_condition_statement (a_source: SYSTEM_DLL_CODE_CONDITION_STATEMENT) is
			-- | Create instance of `EG_CONDITION_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_condition_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_conditon_statement: ECD_CONDITION_STATEMENT
		do
			create a_conditon_statement.make
			initialize_condition_statement (a_source, a_conditon_statement)
			set_last_statement (a_conditon_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			condition_statement_ready: last_statement.ready
		end

	generate_expression_statement (a_source: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT) is
			-- | Create instance of `EG_EXPRESSION_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_expression_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_expression_statement: ECD_EXPRESSION_STATEMENT
		do
			create an_expression_statement.make
			initialize_expression_statement (a_source, an_expression_statement)
			set_last_statement (an_expression_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			last_expression_statement: last_statement.ready
		end

	generate_iteration_statement (a_source: SYSTEM_DLL_CODE_ITERATION_STATEMENT) is
			-- | Create instance of `EG_ITERATION_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_iteration_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_iteration_statement: ECD_ITERATION_STATEMENT
		do
			create an_iteration_statement.make
			initialize_iteration_statement (a_source, an_iteration_statement)
			set_last_statement (an_iteration_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			iteration_statement_ready: last_statement.ready
		end

	generate_routine_return_statement (a_source: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT) is
			-- | Create instance of `EG_ROUTINE_RETURN_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_return_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_routine_return_statement: ECD_ROUTINE_RETURN_STATEMENT
		do
			create a_routine_return_statement.make
			initialize_routine_return_statement (a_source, a_routine_return_statement)
			set_last_statement (a_routine_return_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			routine_return_statement_ready: last_statement.ready
		end

	generate_snippet_statement (a_source: SYSTEM_DLL_CODE_SNIPPET_STATEMENT) is
			-- | Create instance of `EG_SNIPPET_STATEMENT'.
			-- | And initialize this instance with `a_source'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_snippet_statement: ECD_SNIPPET_STATEMENT
			a_value, head: STRING
		do
			create a_snippet_statement.make
			create a_value.make_from_cil (a_source.value)
			head := a_value.twin
			head.keep_head (6)
			head.to_lower
			if head.is_equal ("local ") or head.is_equal ("local%T") or head.is_equal ("local%R") or head.is_equal ("local%N") then
					-- find all variables declared in statement...
				find_and_initialize_local_variables (a_value)
			else
				a_snippet_statement.set_value (a_value)
			end
			set_last_statement (a_snippet_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			snippet_statement_ready: last_statement.ready
		end

	generate_variable_declaration_statement (a_source: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT) is
			-- | Create instance of `EG_VARIABLE_DECLARATION_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_variable_declaration_statement'
			-- | Set `last_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_variable_declaration_statement: ECD_VARIABLE_DECLARATION_STATEMENT
		do
			create a_variable_declaration_statement.make
			initialize_variable_declaration_statement (a_source, a_variable_declaration_statement)
			set_last_statement (a_variable_declaration_statement)
		ensure
			non_void_last_statement: last_statement /= Void
			variable_declaration_statement_ready: last_statement.ready
		end
				
feature {NONE} -- Implementation

	initialize_assign_statement (a_source: SYSTEM_DLL_CODE_ASSIGN_STATEMENT; an_assign_statement: ECD_ASSIGN_STATEMENT) is
			-- | Call `generate_expression_from_dom' to generate `target'.
			-- | Set `is_set_expression' if `last_expression' is `EG_PROPERTY_REFERENCE_EXPRESSION'
			-- | Call `generate_expression_from_dom' to generate `source'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_assign_statement: an_assign_statement /= Void
		local
			target: SYSTEM_DLL_CODE_EXPRESSION
			source: SYSTEM_DLL_CODE_EXPRESSION
			set_property: ECD_PROPERTY_REFERENCE_EXPRESSION
		do
			target := a_source.left
			code_dom_generator.generate_expression_from_dom (target)
			an_assign_statement.set_target (last_expression)
			set_property ?= last_expression
			if set_property /= Void then
				set_property.set_is_set_reference (true)
				an_assign_statement.set_is_property_assignement (true)
			end
			
			source := a_source.right
			code_dom_generator.generate_expression_from_dom (source)
			an_assign_statement.set_source (last_expression)
		ensure
			assign_statement_ready: an_assign_statement.ready
		end

	initialize_comment_statement (a_source: SYSTEM_DLL_CODE_COMMENT_STATEMENT; a_comment_statement: ECD_COMMENT_STATEMENT) is
			-- | Create instance of `EG_COMMENT'.
			-- | Set `text'.
			-- | Set `is_implementation_comment'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_comment_statement: a_comment_statement /= Void
		local
			a_comment: ECD_COMMENT
			a_comment_text: STRING
		do
			create a_comment
			create a_comment_text.make_from_cil (a_source.comment.text)
			a_comment.set_name (a_comment_text)
			a_comment.set_implementation_comment (TRUE)
			a_comment_statement.set_comment (a_comment)
		ensure
			comment_statement_ready: a_comment_statement.ready
		end

	initialize_condition_statement (a_source: SYSTEM_DLL_CODE_CONDITION_STATEMENT; a_conditon_statement: ECD_CONDITION_STATEMENT) is
			-- | Call `generate_expression_from_dom' to generate `condition'.
			-- | Call `generate_true_statements' if any.
			-- | Call `generate_false_statements' if any.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_conditon_statement: a_conditon_statement /= Void
		local
			condition_statement: SYSTEM_DLL_CODE_EXPRESSION
		do
			condition_statement := a_source.condition
			if condition_statement /= Void then
				code_dom_generator.generate_expression_from_dom (condition_statement)
				a_conditon_statement.set_condition (last_expression)
			end
			if a_source.true_statements /= Void then
				generate_true_statements (a_source, a_conditon_statement)	
			end
			if a_source.false_statements /= Void then
				generate_false_statements (a_source, a_conditon_statement)
			end
		ensure
			condition_statement_ready: a_conditon_statement.ready
		end

	generate_true_statements (a_source: SYSTEM_DLL_CODE_CONDITION_STATEMENT; a_conditon_statement: ECD_CONDITION_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_conditon_statement: a_conditon_statement /= Void
		local
			i: INTEGER
			true_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_true_statement: SYSTEM_DLL_CODE_STATEMENT			
		do
			true_statements := a_source.true_statements
			from
			until
				true_statements = Void or else
				i = true_statements.count
			loop
				a_true_statement := true_statements.item (i)
				if a_true_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_true_statement)
					a_conditon_statement.add_true_statement (last_statement)
				end
				i := i + 1
			end
		end

	generate_false_statements (a_source: SYSTEM_DLL_CODE_CONDITION_STATEMENT; a_conditon_statement: ECD_CONDITION_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_conditon_statement: a_conditon_statement /= Void
		local
			i: INTEGER
			false_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_false_statement: SYSTEM_DLL_CODE_STATEMENT			
		do
			false_statements := a_source.false_statements
			from
			until
				false_statements = Void or else
				i = false_statements.count
			loop
				a_false_statement := false_statements.item (i)
				if a_false_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_false_statement)
					a_conditon_statement.add_false_statement (last_statement)
				end
				i := i + 1
			end
		end
		
	initialize_expression_statement (a_source: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT; an_expression_statement: ECD_EXPRESSION_STATEMENT) is
			-- | Call `generate_expression_from_dom' to generate `expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_expression_statement: an_expression_statement /= Void
		local
			an_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			an_expression := a_source.expression
			code_dom_generator.generate_expression_from_dom (an_expression)
			an_expression_statement.set_expression (last_expression)
		ensure
			expression_statement_ready: an_expression_statement.ready
		end

	initialize_iteration_statement (a_source: SYSTEM_DLL_CODE_ITERATION_STATEMENT; an_iteration_statement: ECD_ITERATION_STATEMENT) is
			-- | Call `generate_statement_from_dom' to generate `init_statement'.
			-- | Call `generate_expression_from_dom' to generate `test_expression'.
			-- | Call `generate_loop_statements' if any.
			-- | Call `generate_statement_from_dom' to generate `increment_statement'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_iteration_statement: an_iteration_statement /= Void
		local
			init_statement: SYSTEM_DLL_CODE_STATEMENT
			test_expression: SYSTEM_DLL_CODE_EXPRESSION
			increment_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			init_statement := a_source.init_statement
			if init_statement /= Void then
				code_dom_generator.generate_statement_from_dom (init_statement)
				an_iteration_statement.set_init_statement (last_statement)
			end
			test_expression := a_source.test_expression
			if test_expression /= void then
				code_dom_generator.generate_expression_from_dom (test_expression)
				an_iteration_statement.set_test_expression (last_expression)
			end
			generate_loop_statements (a_source, an_iteration_statement)
			increment_statement := a_source.increment_statement
			if increment_statement /= Void then
				code_dom_generator.generate_statement_from_dom (increment_statement)
				an_iteration_statement.set_increment_statement (last_statement)
			end
		ensure
			iteration_statement_ready: an_iteration_statement.ready
		end

	generate_loop_statements (a_source: SYSTEM_DLL_CODE_ITERATION_STATEMENT; an_iteration_statement: ECD_ITERATION_STATEMENT) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate loop statements.
		require
			non_void_source: a_source /= Void
			non_void_iteration_statement: an_iteration_statement /= Void
		local
			i: INTEGER
			statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION
			a_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			statements := a_source.statements
			from
			until
				statements = Void or else
				i = statements.count				
			loop
				a_statement := statements.item (i)
				if a_statement /= Void then
					code_dom_generator.generate_statement_from_dom (a_statement)
					an_iteration_statement.add_loop_statement (last_statement)
				end
				i := i + 1
			end
		end
	
	initialize_routine_return_statement (a_source: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT; a_routine_return_statement: ECD_ROUTINE_RETURN_STATEMENT) is
			-- | Call `generate_expression_from_dom' to generate `expression'.			

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_routine_return_statement: a_routine_return_statement /= Void
		local
			an_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			an_expression := a_source.expression
			if an_expression /= Void then
				code_dom_generator.generate_expression_from_dom (an_expression)
				a_routine_return_statement.set_expression (last_expression)
			end
		ensure
			routine_return_statement_ready: a_routine_return_statement.ready
		end

	initialize_variable_declaration_statement (a_source: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT; a_variable_declaration: ECD_VARIABLE_DECLARATION_STATEMENT) is
			-- | Set `name'.
			-- | Set `type' by using `eg_generated_types' if built, else build `EG_TYPE'.
			-- | Call `generate_expression_from_dom' to generate `init_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_routin: current_routine /= Void
			non_void_a_variable_declaration: a_variable_declaration /= Void
		local
			variable_name: STRING
			variable_type: STRING
			init_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			create variable_name.make_from_cil (a_source.name)
			a_variable_declaration.set_name (variable_name)

			if a_source.type.array_element_type /= Void then
				a_variable_declaration.set_is_array_element (True)
			end
			create variable_type.make_from_cil (a_source.type.base_type)
			if not Resolver.is_generated_type (variable_type) then
				Resolver.add_external_type (variable_type)
			end
			a_variable_declaration.set_dotnet_type (variable_type)
			
			init_expression := a_source.init_expression
			if init_expression /= Void then
				code_dom_generator.generate_expression_from_dom (init_expression)
				a_variable_declaration.set_init_expression (last_expression)
			end
		ensure
			variable_declaration_statement_ready: a_variable_declaration.ready
		end

	find_and_initialize_local_variables (a_snippet_value: STRING) is
			-- add variables declared in `a_snippet_vallue' to local variables of `current_feature'.
		require
			non_void_a_snippet_value: a_snippet_value /= Void
			not_a_snippet_value: not a_snippet_value.is_empty
			valid_a_snippet_value: a_snippet_value.has_substring ("local")
		local
			i: INTEGER
			l_local_variable: ECD_VARIABLE_DECLARATION_STATEMENT
			l_variable_name, l_variable_type: STRING
		do
			a_snippet_value.remove_head (5)
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
				create l_local_variable.make
				l_local_variable.set_name (l_variable_name)
				l_local_variable.set_eiffel_type (l_variable_type)
				current_routine.add_local (l_local_variable)

					-- jump the ';' character
				i := i + 1
			end
		end
		
		
end -- class ECD_STATEMENT_FACTORY

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