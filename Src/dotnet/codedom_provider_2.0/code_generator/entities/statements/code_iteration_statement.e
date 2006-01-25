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

	make (a_init_statement: like init_statement; a_test_expression: like test_expression;
		a_loop_statements: like loop_statements; a_increment_statement: like increment_statement) is
			-- Initialize `init_statement', `test_expression', `loop_statements', `increment_statement'.
		require
			non_void_test_expression: a_test_expression /= Void
		do
			test_expression := a_test_expression
			init_statement := a_init_statement
			loop_statements := a_loop_statements
			increment_statement := a_increment_statement
		ensure
			test_expression_set: test_expression = a_test_expression
			init_statement_set: init_statement = a_init_statement
			loop_statements_set: loop_statements = a_loop_statements
			increment_statement_set: increment_statement = a_increment_statement
		end
		
feature -- Access

	init_statement: CODE_STATEMENT
			-- Initialization statement
			
	test_expression: CODE_EXPRESSION
			-- Test expression
	
	loop_statements: LIST [CODE_STATEMENT]
			-- Loop statements
			
	increment_statement: CODE_STATEMENT
			-- Increment statement
			
	code: STRING is
			-- | Result := "from `init_statement' until `test_expression' loop `loop_statements' `increment_statement' end
			-- Eiffel code of iteration statement
		do
			create Result.make (800)
			Result.append (Indent_string)
			Result.append ("from%N")
			increase_tabulation
			if init_statement /= Void then
				Result.append (init_statement.code)
				Result.append ("%N")
			end
			decrease_tabulation
			Result.append (Indent_string)
			Result.append ("until%N")
			increase_tabulation
			Result.append (test_expression.code)
			Result.append ("%N")
			decrease_tabulation
			Result.append ("loop%N")
			increase_tabulation
			if loop_statements /= Void then
				from
					loop_statements.start
				until
					loop_statements.after
				loop
					Result.append (loop_statements.item.code)
					loop_statements.forth
				end
			end
			if increment_statement /= Void then
				Result.append (increment_statement.code)
				Result.append ("%N")
			end
			decrease_tabulation
			Result.append (Indent_string)
			Result.append ("end%N")
		end
		
	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := init_statement.need_dummy
			from
				loop_statements.start				
			until
				Result or loop_statements.after
			loop
				Result := loop_statements.item.need_dummy
				loop_statements.forth
			end
		end
		
invariant
	non_void_test_expression: test_expression /= Void
	
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