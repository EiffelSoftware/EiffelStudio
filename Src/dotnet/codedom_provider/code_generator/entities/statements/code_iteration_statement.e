indexing
	description: "Eiffel representation of a CodeDom iteration statement"
	date: "$$"
	revision: "$$"		
	
class
	CODE_ITERATION_STATEMENT

inherit
	CODE_STATEMENT
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `init_statement', `test_expression', `loop_statements', `increment_statement'.
		do
			create loop_statements.make
		ensure
			non_void_loop_statements: loop_statements /= Void
		end
		
feature -- Access

	init_statement: CODE_STATEMENT
			-- Initialization statement
			
	test_expression: CODE_EXPRESSION
			-- Test expression
	
	loop_statements: LINKED_LIST [CODE_STATEMENT]
			-- | ARRAY_LIST [CODE_STATEMENT]
			-- Loop statements
			
	increment_statement: CODE_STATEMENT
			-- Increment statement
			
	code: STRING is
			-- | Result := "from `init_statement' until `test_expression' loop `loop_statements' `increment_statement' end
			-- Eiffel code of iteration statement
		do
			check
				non_void_init_statement: init_statement /= Void
				non_void_test_expression: test_expression /= Void
				non_void_increment_statement: increment_statement /= Void
			end
			
			create Result.make (800)
			Result.append (Indent_string)
			Result.append (Dictionary.From_keyword)
			Result.append (Dictionary.New_line)
			increase_tabulation
			Result.append (init_statement.code)
			Result.append (Dictionary.New_line)
			decrease_tabulation
			Result.append (Indent_string)
			Result.append (Dictionary.Until_keyword)
			Result.append (Dictionary.New_line)
			increase_tabulation
			Result.append (test_expression.code)
			Result.append (Dictionary.New_line)
			decrease_tabulation
			Result.append (Dictionary.Loop_keyword)
			Result.append (Dictionary.New_line)
			increase_tabulation
			from
				loop_statements.start
			until
				loop_statements.after
			loop
				Result.append (loop_statements.item.code)
				loop_statements.forth
			end
			Result.append (increment_statement.code)
			Result.append (Dictionary.New_line)
			decrease_tabulation
			Result.append (Indent_string)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is iteration statement ready to be generated?
		do
			Result := init_statement.ready and test_expression.ready and increment_statement.ready and loop_statements.for_all (agent is_statement_ready)
		end

feature -- Status Setting

	set_init_statement (an_init_statement: like init_statement) is
			-- Set `init_statement' with `an_init_statement'.
		require
			non_void_init_statement: an_init_statement /= Void
		do
			init_statement := an_init_statement
		ensure
			init_statement_set: init_statement = an_init_statement
		end		

	set_test_expression (a_test_expression: like test_expression) is
			-- Set `test_expression' with `a_test_expression'.
		require
			non_void_test_expression: a_test_expression /= Void
		do
			test_expression := a_test_expression
		ensure
			test_expression_set: test_expression = a_test_expression
		end	

	add_loop_statement (a_statement: CODE_STATEMENT) is
			-- Set `loop_statements' with `a_list'.
		require
			non_void_statement: a_statement /= Void
		do
			loop_statements.extend (a_statement)
		ensure
			loop_statements_set: loop_statements.has (a_statement)
		end	

	set_increment_statement (an_increment_statement: like increment_statement) is
			-- Set `increment_statement' with `an_increment_statement'.
		require
			non_void_increment_statement: an_increment_statement /= Void
		do
			increment_statement := an_increment_statement
		ensure
			increment_statement_set: increment_statement = an_increment_statement
		end

feature {NONE} -- Implementation

	is_statement_ready (a_statement: CODE_STATEMENT): BOOLEAN is
			-- Is `a_statement' ready for code generation?
		do
			Result := a_statement.ready
		end
		
invariant
	non_void_loop_statements: loop_statements /= Void
	
end -- class CODE_ITERATION_STATEMENT

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