indexing
	description: "Eiffel representation of a CodeDom condition statement"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_CONDITION_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `condition', `true_statements' and `false_statements'.
		do
			create true_statements.make
			create false_statements.make
		ensure
			non_void_true_statements: true_statements /= Void
			non_void_false_statements: false_statements /= Void
		end
		
feature -- Access

	condition: ECDP_EXPRESSION
			-- Condition
			
	true_statements: LINKED_LIST [ECDP_STATEMENT]
			-- True statements
			
	false_statements: LINKED_LIST [ECDP_STATEMENT]
			-- False statements
			
	code: STRING is
			-- | Result := "if `condition' then 
			-- |				`true_statements'
			-- |		  [	else
			-- |				`false_statements' ]
			-- |			end"
			-- Eiffel code of condition statement
		do
			check
				non_void_condition: condition /= Void
			end
			
			create Result.make (2000)
			Result.append (Indent_string)
			Result.append (Dictionary.If_keyword)
			Result.append (Dictionary.Space)
			set_new_line (false)
			Result.append (condition.code)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Then_keyword)
			Result.append (Dictionary.New_line)
			add_tab_to_indent_string
			from
				true_statements.start
			until
				true_statements.after
			loop
				Result.append (true_statements.item.code)
				true_statements.forth
			end
			
			if false_statements.count > 0 then
				sub_tab_to_indent_string
				Result.append (indent_string)
				Result.append (Dictionary.Else_keyword)
				Result.append (Dictionary.New_line)
				add_tab_to_indent_string
			end
			from
				false_statements.start
			until
				false_statements.after
			loop
				Result.append (false_statements.item.code)
				false_statements.forth
			end
			sub_tab_to_indent_string
			Result.append (indent_string)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is condition statement ready to be generated?
		do
			Result := condition.ready and true_statements.count > 0
		end

feature -- Status Setting

	set_condition (a_condition: like condition) is
			-- Set `condition' with `a_condition'.
		require
			non_void_condition: a_condition /= Void
		do
			condition := a_condition
		ensure
			condition_set: condition = a_condition
		end		

	add_true_statement (a_statement: ECDP_STATEMENT) is
			-- Add `an_expression' to `true_statements'
		require
			non_void_list: a_statement /= Void
		do
			true_statements.extend (a_statement)
		ensure
			true_statements_set: true_statements.has (a_statement)
		end	

	add_false_statement (a_statement: ECDP_STATEMENT) is
			-- Add `an_expression' to `false_statements'.
		require
			non_void_list: a_statement /= Void
		do
			false_statements.extend (a_statement)
		ensure
			false_statements_set: false_statements.has (a_statement)
		end	
		
invariant
	non_void_true_statements: true_statements /= Void
	non_void_false_statements: false_statements /= Void
	
end -- class ECDP_CONDITION_STATEMENT

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