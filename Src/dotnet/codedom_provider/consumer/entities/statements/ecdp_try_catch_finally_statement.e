indexing
	description: "Eiffel representation of a CodeDom try catch finally statement"
	date: "$$"
	revision: "$$"		
	
class
	ECDP_TRY_CATCH_FINALLY_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `try_statements', `finally_statements' and `catch_clauses'.
		do
			create try_statements.make
			create finally_statements.make
			create catch_clauses.make	
		ensure
			non_void_try_statements: try_statements /= Void
			non_void_finally_statements: finally_statements /= Void
			non_void_catch_clauses: catch_clauses /= Void
		end
		
feature -- Access

	try_statements: LINKED_LIST [ECDP_STATEMENT]
			-- Statements in try clause
			
	finally_statements: LINKED_LIST [ECDP_STATEMENT]
			-- Statements in finally clause
			
	catch_clauses: LINKED_LIST [ECDP_STATEMENT]
			-- Catch clauses
						
	code: STRING is
			-- Eiffel code of try catch finally statement
			-- TO BE FINISHED!!!
			-- | Already implemented :
			-- | 		local 
			-- |			not_first_try: BOOLEAN
			-- |		do 
			-- |		...
			-- | Result :=			if not not_first_try then
			-- |						`try_statements'
			-- |					end
			-- |					`finally_statements'
			-- |				rescue
			-- |					if exception = `catch_clauses'.item.name then
			-- |						`catch_clauses'.item	
			-- |						not_first_try := TRUE
			-- |						Retry
			-- |					end"
			-- |		...
			-- | 		end
		local
			a_event_manager: ECDP_EVENT_MANAGER
		do
			a_event_manager.raise_event (feature {ECDP_EVENTS_IDS}.Not_implemented, ["try catch finally statement"])
			create Result.make (500)
			Result.append (Indent_string) 
			Result.append ("if not not_first_try then")
			Result.append (Dictionary.New_line)
			add_tab_to_indent_string
			Result.append (statements_code)
			sub_tab_to_indent_string
			Result.append (Indent_string)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.New_line)
			Result.append (finally_statements_code)
			sub_tab_to_indent_string
			Result.append (Indent_string)
			Result.append (Dictionary.Rescue_keyword)
			Result.append (Dictionary.New_line)
			add_tab_to_indent_string
			Result.append (rescue_clause)
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is try catch finally statement ready to be generated?
		do
			Result := try_statements /= Void and finally_statements /= Void and catch_clauses /= Void
		end

feature -- Status Setting

	add_try_statement (a_statement: ECDP_STATEMENT) is
			-- add `a_statement' to `try_statements'.
		require
			non_void_list: a_statement /= Void
		do
			try_statements.extend (a_statement)
		ensure
			try_statements_set: try_statements.has (a_statement)
		end	

	add_finally_statement (a_statement: ECDP_STATEMENT) is
			-- Add `a_statement' to `finally_statements'.
		require
			non_void_list: a_statement /= Void
		do
			finally_statements.extend (a_statement)
		ensure
			finally_statements_set: finally_statements.has (a_statement)
		end	
		
	add_catch_clause (a_clause: ECDP_STATEMENT) is
			-- Add `a_clause' to `catch_clauses'.
		require
			non_void_list: a_clause /= Void
		do
			catch_clauses.extend (a_clause)
		ensure
			catch_clauses_set: catch_clauses.has (a_clause)
		end	

feature {NONE} -- Code Generation
		
	statements_code: STRING is
			-- code generation statements
		do
			create Result.make (120)
			from
				try_statements.start
			until
				try_statements.after
			loop
				Result.append (try_statements.item.code)
				try_statements.forth
			end
		ensure
			non_void_result: Result /= Void
		end

	finally_statements_code: STRING is
			-- code generation finally statements
		do
			create Result.make (120)
			from
				finally_statements.start
			until
				finally_statements.after
			loop
				Result.append (finally_statements.item.code)
				finally_statements.forth
			end
		ensure
			non_void_result: Result /= Void
		end
		
	rescue_clause: STRING is
			-- code generation rescues
		local
			first_rescue_clause: BOOLEAN
		do
			create Result.make (120)
			From
				catch_clauses.start
				first_rescue_clause := true
			until
				catch_clauses.after
			loop
				if first_rescue_clause then
					Result.append (Indent_string)
					Result.append ("if ")
					first_rescue_clause := false
				else
					Result.append (Indent_string)
					Result.append ("elseif")
				end
				Result.append (" exception = `catch_clauses'.item.name then")
				Result.append (Dictionary.New_line)
				add_tab_to_indent_string
				Result.append (catch_clauses.item.code)
				Result.append (Indent_string)
				Result.append ("not_first_try := TRUE")
				Result.append (Dictionary.New_line)
				Result.append (Indent_string)
				Result.append (Dictionary.Retry_keyword)
				Result.append (Dictionary.New_line)
				sub_tab_to_indent_string
				Result.append (Indent_string)
				Result.append (Dictionary.End_keyword)
				Result.append (Dictionary.New_line)
				catch_clauses.forth
			end
		ensure
			non_void_result: Result /= Void
		end

invariant
	non_void_try_statements: try_statements /= Void
	non_void_finally_statements: finally_statements /= Void
	non_void_catch_clauses: catch_clauses /= Void
	
end -- class ECDP_TRY_CATCH_FINALLY_STATEMENT_STATEMENT

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